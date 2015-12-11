function N =sval(distype,xi)
% evaluates shapefunction at certain positions
% currentl just for undistorted elements
% distype={'tet10','hex27'}
N=[];

switch lower(distype)
    case 'quad4'
      r=xi(1);
      s=xi(2);
      rp = 1.0 + r;
      rm = 1.0 - r;
      sp = 1.0 + s;
      sm = 1.0 - s;
      N=[...
        0.25 * rm * sm
        0.25 * rp * sm
        0.25 * rp * sp
        0.25 * rm * sp];
  case 'quad9'
      r=xi(1);
      s=xi(2);
      rp = 1.0 + r;
      rm = 1.0 - r;
      sp = 1.0 + s;
      sm = 1.0 - s;
      r2 = 1.0 - r * r;
      s2 = 1.0 - s * s;
      rh = 0.5 * r;
      sh = 0.5 * s;
      rs = rh * sh;
      N=[...
         rs * rm * sm
        -rs * rp * sm
         rs * rp * sp
        -rs * rm * sp
        -sh * sm * r2
         rh * rp * s2
         sh * sp * r2
        -rh * rm * s2
         r2 * s2];
    case 'tet10'
      r=xi(1);
      s=xi(2);
      t=xi(3);
      u = 1 - r - s - t;
      N=[...
        u * (2 * u - 1)
        r * (2 * r - 1)
        s * (2 * s - 1)
        t * (2 * t - 1)
        4 * r * u
        4 * r * s
        4 * s * u
        4 * t * u
        4 * r * t
        4 * s * t];
    case 'hex27'
      r=xi(1);
      s=xi(2);
      t=xi(3);
        rm1 = 0.5 * r * (r - 1.0);
        r00 = (1.0 - r * r);
        rp1 = 0.5 * r * (r + 1.0);
        sm1 = 0.5 * s * (s - 1.0);
        s00 = (1.0 - s * s);
        sp1 = 0.5 * s * (s + 1.0);
        tm1 = 0.5 * t * (t - 1.0);
        t00 = (1.0 - t * t);
        tp1 = 0.5 * t * (t + 1.0);

        N=[...
        rm1 * sm1 * tm1
        rp1 * sm1 * tm1
        rp1 * sp1 * tm1
        rm1 * sp1 * tm1
        rm1 * sm1 * tp1
        rp1 * sm1 * tp1
        rp1 * sp1 * tp1
        rm1 * sp1 * tp1
        r00 * sm1 * tm1
        s00 * tm1 * rp1
        r00 * tm1 * sp1
        s00 * rm1 * tm1
        t00 * rm1 * sm1
        t00 * sm1 * rp1
        t00 * rp1 * sp1
        t00 * rm1 * sp1
        r00 * sm1 * tp1
        s00 * rp1 * tp1
        r00 * sp1 * tp1
        s00 * rm1 * tp1
        r00 * s00 * tm1
        r00 * t00 * sm1
        s00 * t00 * rp1
        r00 * t00 * sp1
        s00 * t00 * rm1
        r00 * s00 * tp1
        r00 * s00 * t00];
    case 'hex20'
        r=xi(1);
        s=xi(2);
        t=xi(3);
        rp = 1.0 + r;
        rm = 1.0 - r;
        sp = 1.0 + s;
        sm = 1.0 - s;
        tp = 1.0 + t;
        tm = 1.0 - t;
        rrm = 1.0 - r * r;
        ssm = 1.0 - s * s;
        ttm = 1.0 - t * t;
        Q18=1/8;

        N=[...
        Q18  * rm * sm * tm * (rm + sm + tm - 5.0)
        Q18  * rp * sm * tm * (rp + sm + tm - 5.0)
        Q18  * rp * sp * tm * (rp + sp + tm - 5.0)
        Q18  * rm * sp * tm * (rm + sp + tm - 5.0)
        Q18  * rm * sm * tp * (rm + sm + tp - 5.0)
        Q18  * rp * sm * tp * (rp + sm + tp - 5.0)
        Q18  * rp * sp * tp * (rp + sp + tp - 5.0)
        Q18  * rm * sp * tp * (rm + sp + tp - 5.0)
        0.25 * rrm * sm * tm
        0.25 * rp * ssm * tm
        0.25 * rrm * sp * tm
        0.25 * rm * ssm * tm
        0.25 * rm * sm * ttm
        0.25 * rp * sm * ttm
        0.25 * rp * sp * ttm
        0.25 * rm * sp * ttm
        0.25 * rrm * sm * tp
        0.25 * rp * ssm * tp
        0.25 * rrm * sp * tp
        0.25 * rm * ssm * tp];
    otherwise
        error('unsupported distype');
end


end