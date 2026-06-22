#include "epix.h"
using namespace ePiX;

void cme_bold()
{
  bbold();
}

void cme_dashed()
{
  dashed();
  bold();
}

void cme_solid()
{
  solid();
  cme_bold();
}

void cme_init()
{
  degrees();
  arrow_inset(0.75);
  arrow_ratio(1.5);
  arrow_width(5);
  cme_bold();
}

void drawbrace(const P& right, const P& left,
	       const std::string& msg, const P& offset, // userspace parameters
	       double ht, // height in pt
	       double cusp, // cusp/ht = slope of stroke at center
	       double doff, // default perpendicular offset in pt
	       double sc, // (sc - 1) determines the thickness of the stroke
	       double ret, // cotan(ret) = angle at ends of brace
	       double dy,  // brace offset from tip line
	       double shr, // "horizontal" padding at the tips, in pt
	       double asp = 1) // aspect ratio, in case drawing not to scale
{
  const double len(pt_to_screen(1));

  P md(0.5*(right + left)),
    horiz((len/norm(right - left))*(right - left)),
    vert(J(horiz)), tip1(md + ht*vert), tip2(md + 0.95*ht*vert);

  // outside curve
  path bd(right + dy*vert - (shr/asp)*horiz,
	  right + ht*(vert - (ret/asp)*horiz),
	  md + (cusp/asp)*horiz,
	  tip1);

  bd += path(tip1,
	     md - (cusp/asp)*horiz,
	     left + ht*(vert + (ret/asp)*horiz),
	     left + dy*vert + (shr/asp)*horiz);

  // inside curve
  path bd2(right + dy*vert - (shr/asp)*horiz,
	   right + ht*sc*(vert - (ret/asp)*horiz),
	   md + (cusp/asp)*horiz,
	   tip2);

  bd2 += path(tip2,
	      md - (cusp/asp)*horiz,
	      left + ht*sc*(vert + (ret/asp)*horiz),
	      left + dy*vert + (shr/asp)*horiz);

  bd -= bd2;
  plain();
  fill(Black());
  bd.close().fill();

  masklabel(tip1 + doff*vert + len*offset, msg);
  bd.draw();

  cme_bold(); // default line style
  fill(Neutral());
}

void brace(const P& right, const P& left,
	   const std::string& msg, const P& offset = P(0,0))
{
  drawbrace(right, left, msg, offset, 12, 9.6, 4, 4.0/3, 0.5, 2, 2);
}

void squeezebrace(const P& right, const P& left,
	   const std::string& msg, double s, const P& offset = P(0,0))
{
  drawbrace(right, left, msg, offset, 12, 9.6, 4, 4.0/3, 0.5, 2, 2, s);
}

void smallbrace(const P& right, const P& left,
		const std::string& msg, const P& offset = P(0,0))
{
  drawbrace(right, left, msg, offset, 6, 4.8, 4, 6.0/5, 0.5, 2, 1);
}

void caption(const std::string& msg, const P& offset = P(0,0))
{
  font_face("sc");
  font_size("normalsize");
  label(P(0.5*(xmin() + xmax()), ymin()), P(0,-24) + offset, msg, b);
}

P midpt(const P& tail, const P& head, double u = 0.5)
{
  return tail + u*(head - tail);
}

void H_axis(double str = 0.2)
{
  line(P(xmin() - str, 0), P(xmax(),0));
}

void V_axis(double str = 0.2)
{
  line(P(0, ymin() - str), P(0,ymax()));
}

void axes(double str = 0.2)
{
  H_axis(str);
  V_axis(str);
}

void axis_labels(const std::string mo = "$O$",
		 const std::string mx = "$X$",
		 const std::string my = "$Y$")
{
  if (mo != "")
    masklabel(P(0,0), P(0,0), mo, bl);

  if (mx != "")
    masklabel(P(xmax(),0), P(-2,-0), mx, b);

  if (my != "")
    masklabel(P(0,ymax()), P(0,-2), my, l);
}

