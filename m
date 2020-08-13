Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5348D243A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 15:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHMNEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 09:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgHMNE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 09:04:26 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59708C061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 06:04:26 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h4so7201740ioe.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EyT6hXIz8JrsQFCCctkkiHVgguQyJ1gofAulsUuUyq8=;
        b=WmO83z/BitpSIuCu2kRA4IL0r0q4BCCp01aaBGq36Zl5TqGTv53D5VjB6N2cTeJxQR
         +zTO5/GPXRd34NMbmY55Dvvaz4EX1wEcrKsAxYCiVLygJ0T7dYG5MFaYwqM4hE6E7fhQ
         7k4M5SF9xD48OcMzXDwpyp6CcDjJmkgdUlNa2aw2OJMoX4CdkyVelJDrHQP6CrVVA5gm
         npXyvKpBVmSpTx6qKGLoTPbDRp5SQZ1/FJsVVh3IsjDj8fc46koKh/X4Kj2q/i0ayTbg
         85ZdehJ9O7TXMilqC3phRhc0hvOuR77rDiARxJCJ7FNYTKDk+WaaB9CAxsrsVRZyVmmB
         o3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyT6hXIz8JrsQFCCctkkiHVgguQyJ1gofAulsUuUyq8=;
        b=cWzFM+slkqpR6d6GM70/xVVMXyKwikJlIpVEQ2foqzpKyZ2Cv19jQsitB2qoC4NrSy
         C01UdFtmnviNStaFiZ9y051yk7mJEwbsgr5WJR20Hs5TneFwXga+FvAc6LTl6Y1iQ1oW
         hCuX9KkHnz+OXyVFIWCSzAYoPZhjptpk0SR+nHTm2kiHGEh115siF66zQ0GoomlDtVL/
         hrpCTbEx0HuNMAtDnSOxrXojHL4EMakEV9OPg+bjCTwq8k+QkTDPOrV0Bi+htBgZD5gg
         XzDDI9Lj7tEO5CxBCj+HEYG7Ae2AHSGXSCZfMfFuDX2fZadU+WltomrZ4siK2iQUU3ff
         beog==
X-Gm-Message-State: AOAM530wqhiwSkyl6jJQv81OpvWtT5IG477Wo2LgjG5YivqYpJEt1Soz
        jd6l/ORxKpp9OxBPi5MJThIHEg6LE8lP9uQyDHKD3w==
X-Google-Smtp-Source: ABdhPJxcJYj5jf2h4KNmEen8sLv5g1GkvODF96sNVcyCS+zBw5jWNYDrUE1VwnR0GjgyLgBD4kG20pQcBFC2UXc47V4=
X-Received: by 2002:a5e:dd4c:: with SMTP id u12mr4514913iop.93.1597323864338;
 Thu, 13 Aug 2020 06:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200813075125.4949-1-cmo@melexis.com> <20200813075125.4949-4-cmo@melexis.com>
 <CAHp75VfNwb5uBp=H0295LEJjXy1+=V5yvSN1PHbtMYzgg=_EAA@mail.gmail.com>
 <CAKv63uv=b60B9RXBJF4HEhMOowu-qbGrv7LsmJVvkkERSida-A@mail.gmail.com> <CAHp75Vd+3SopKog6uhSKoOLn+tECsQfs7kRbJsrMZEbNRpk8bQ@mail.gmail.com>
In-Reply-To: <CAHp75Vd+3SopKog6uhSKoOLn+tECsQfs7kRbJsrMZEbNRpk8bQ@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Thu, 13 Aug 2020 15:03:48 +0200
Message-ID: <CAKv63usrjEHTmYtahedqULnqu-fM3TFC8HJ=S4h+w=UTv5sd-Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iio:temperature:mlx90632: Convert polling while
 loop to do-while
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 at 13:24, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Thu, Aug 13, 2020 at 2:14 PM Crt Mori <cmo@melexis.com> wrote:
> >
> > On Thu, 13 Aug 2020 at 13:03, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Thu, Aug 13, 2020 at 10:53 AM Crt Mori <cmo@melexis.com> wrote:
> > > >
> > > > Reduce number of lines and improve readability to convert polling while
> > > > loops to do-while. The iopoll.h interface was not used, because we
> > > > require more than 20ms timeout, because time for sensor to perform a
> > > > measurement is around 10ms and it needs to perform measurements for each
> > > > channel (which currently is 3).
> > >
> > > I don't see how it prevents using iopoll.h. It uses usleep_range()
> > > under the hood in the same way you did here, but open coded.
> > >
> >
> > One loop is indeed 10ms and that is not the problem, the problem is
> > that timeout is at least 3 calls of this data ready (3 channels), so
> > that is at minimum 30ms of timeout, or it could even be 4 in worse
> > case scenario and that is outside of the range for usleep to measure.
> > So in case of the other loop, where we wait 200ms for channel refresh
> > it is also out of scope. Timeout should be in number of tries or in
> > msleep range if you ask me.
>
> I still didn't buy it. You have in both cases usleep_range(). Why in
> your case it's okay and in regmap_read_poll_timeout() is not?
>

I tried and it did not work, so then I read the manual. Looking into

* regmap_read_poll_timeout_atomic - Poll until a condition is met or a
timeout occurs
...
 * @delay_us: Time to udelay between reads in us (0 tight-loops).
 *            Should be less than ~10us since udelay is used
 *            (see Documentation/timers/timers-howto.rst).
 * @timeout_us: Timeout in us, 0 means never timeout


So I went to read Documentation/timers/timers-howto.rst

SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms):
* Use usleep_range

- Why not msleep for (1ms - 20ms)?
Explained originally here:
http://lkml.org/lkml/2007/8/3/250

msleep(1~20) may not do what the caller intends, and
will often sleep longer (~20 ms actual sleep for any
value given in the 1~20ms range). In many cases this
is not the desired behavior.

Since I am above the 20ms range, it is too much for usleep_range and
that proved to be a case as I got -ETIMEOUT and the desired channels
were not read.
> > > ...
> > >
> > > > -       while (tries-- > 0) {
> > > > +       do {
> > > >                 ret = regmap_read(data->regmap, MLX90632_REG_STATUS,
> > > >                                   &reg_status);
> > > >                 if (ret < 0)
> > > >                         return ret;
> > > > -               if (reg_status & MLX90632_STAT_DATA_RDY)
> > > > -                       break;
> > > >                 usleep_range(10000, 11000);
> > > > -       }
> > > > +       } while (!(reg_status & MLX90632_STAT_DATA_RDY) && tries--);
> > > >
> > > >         if (tries < 0) {
> > > >                 dev_err(&data->client->dev, "data not ready");
>
> --
> With Best Regards,
> Andy Shevchenko
