Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EE82445DE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 09:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHNHdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 03:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgHNHdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 03:33:22 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AD6C061383
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 00:33:21 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b16so9939816ioj.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 00:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P0QNUADYgOn/C/m3nQ6Y5G9JAzArzh2nTxmJSP8VeEc=;
        b=F02m6Db+bn1IYiEMLwRmkwBmNHsUDL69Su3uR7D6wPUjYyekdJ2OdpB5LNiRNFplCI
         N4Y06rHa5Oz0P+GDzULkqcJ8BTWxuh5DIJ/9zitlUFE14XPSWRPplKQXlAjCkkowoCQm
         xp1YMzD2Efau1+2DVcsFgGTCkfiu/z3HBRC1lNWxygPRNIZHBsS8FJBrzknX4Nl/C4cL
         C8ApAiyOEkspIrd8MTeqeollAxgrXFMaAMh2pCU+9anHjE81lYAOzXNd0tJyemg5AjtZ
         La6rs8+EfmZ+0HH5UYvpXhCrR7pdznxhZpXcnlfz/LhM9glHxr87smK2Jn3joeTR46I2
         NOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0QNUADYgOn/C/m3nQ6Y5G9JAzArzh2nTxmJSP8VeEc=;
        b=pFELjgN1W97q8ZVxMgC4Vpc9BKtuH8pzou5nrHDq9Oj+Jm1M+rdS2ZFsv1iFTaWRLP
         PAyxk3Vfq+Fd0vfQZyCXowvTyJiDICDH4866tlWC7+HdaBHSH0DacrQrdwVPUQY6LkXS
         hsTdtb8AWvs8BgRaR/k0dYPCXG6gvDIAyVQhTuk4O2ZZtZCx1TMw9FYOqqnl2N6oaEAl
         2WGzMPtWjG6UrYyPMEIU7dkSUyOwdFiN0C8Ji/flAqdChRT/P4qZRY4JcwLGrFsFsIdm
         iOp57DkCsD4b6fxJUwadUr2rIUdhfEwBVte3on9L6/EavxeRBBCpDCW+kPjM3dD43HCO
         5qLg==
X-Gm-Message-State: AOAM533kE9IItXwAa/7cMjB2TrPFf4pRwB+LBc6xrA+ivq26qITNHn6a
        hnEkYsxDBMeQ3YZ05FA6JRyLsTmXRT6zZt16+udx8w==
X-Google-Smtp-Source: ABdhPJw1TGYdJE6viPoHF/fq98yJWPlG5/W+SzRg1+zNI/JE5qYMT9Y9X6wH9ta4mk7G4xrhP4Mw7x2BUEwvhKVypEc=
X-Received: by 2002:a5d:8cce:: with SMTP id k14mr1184502iot.13.1597390401084;
 Fri, 14 Aug 2020 00:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200813075125.4949-1-cmo@melexis.com> <20200813075125.4949-4-cmo@melexis.com>
 <CAHp75VfNwb5uBp=H0295LEJjXy1+=V5yvSN1PHbtMYzgg=_EAA@mail.gmail.com>
 <CAKv63uv=b60B9RXBJF4HEhMOowu-qbGrv7LsmJVvkkERSida-A@mail.gmail.com>
 <CAHp75Vd+3SopKog6uhSKoOLn+tECsQfs7kRbJsrMZEbNRpk8bQ@mail.gmail.com>
 <CAKv63usrjEHTmYtahedqULnqu-fM3TFC8HJ=S4h+w=UTv5sd-Q@mail.gmail.com> <CAHp75VeH5SA2KeiTSN__8ndj1v_SEb7mEWPG1p2Lz-tATDWi8A@mail.gmail.com>
In-Reply-To: <CAHp75VeH5SA2KeiTSN__8ndj1v_SEb7mEWPG1p2Lz-tATDWi8A@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Fri, 14 Aug 2020 09:32:45 +0200
Message-ID: <CAKv63uvQBoD=a2ADG7XBoQd2JRt6ggK0UB-g6cSuWLE7EV+qww@mail.gmail.com>
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

On Thu, 13 Aug 2020 at 21:41, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Thu, Aug 13, 2020 at 4:04 PM Crt Mori <cmo@melexis.com> wrote:
> > On Thu, 13 Aug 2020 at 13:24, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Aug 13, 2020 at 2:14 PM Crt Mori <cmo@melexis.com> wrote:
> > > > On Thu, 13 Aug 2020 at 13:03, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > On Thu, Aug 13, 2020 at 10:53 AM Crt Mori <cmo@melexis.com> wrote:
>
> ...
>
> > > > > I don't see how it prevents using iopoll.h. It uses usleep_range()
> > > > > under the hood in the same way you did here, but open coded.
> > > > >
> > > >
> > > > One loop is indeed 10ms and that is not the problem, the problem is
> > > > that timeout is at least 3 calls of this data ready (3 channels), so
> > > > that is at minimum 30ms of timeout, or it could even be 4 in worse
> > > > case scenario and that is outside of the range for usleep to measure.
> > > > So in case of the other loop, where we wait 200ms for channel refresh
> > > > it is also out of scope. Timeout should be in number of tries or in
> > > > msleep range if you ask me.
> > >
> > > I still didn't buy it. You have in both cases usleep_range(). Why in
> > > your case it's okay and in regmap_read_poll_timeout() is not?
> > >
> >
> > I tried and it did not work, so then I read the manual. Looking into
> >
> > * regmap_read_poll_timeout_atomic - Poll until a condition is met or a
> > timeout occurs
>
> Why _atomic?!

I just pasted something, it is the same as for non _atomic
>
> > ...
> >  * @delay_us: Time to udelay between reads in us (0 tight-loops).
> >  *            Should be less than ~10us since udelay is used
> >  *            (see Documentation/timers/timers-howto.rst).
> >  * @timeout_us: Timeout in us, 0 means never timeout
> >
> >
> > So I went to read Documentation/timers/timers-howto.rst
> >
> > SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms):
> > * Use usleep_range
> >
> > - Why not msleep for (1ms - 20ms)?
> > Explained originally here:
> > http://lkml.org/lkml/2007/8/3/250
> >
> > msleep(1~20) may not do what the caller intends, and
> > will often sleep longer (~20 ms actual sleep for any
> > value given in the 1~20ms range). In many cases this
> > is not the desired behavior.
> >
> > Since I am above the 20ms range, it is too much for usleep_range and
> > that proved to be a case as I got -ETIMEOUT and the desired channels
> > were not read.
> > > > > ...
> > > > >
> > > > > > -       while (tries-- > 0) {
> > > > > > +       do {
> > > > > >                 ret = regmap_read(data->regmap, MLX90632_REG_STATUS,
> > > > > >                                   &reg_status);
> > > > > >                 if (ret < 0)
> > > > > >                         return ret;
> > > > > > -               if (reg_status & MLX90632_STAT_DATA_RDY)
> > > > > > -                       break;
> > > > > >                 usleep_range(10000, 11000);
>
> You use here usleep_range(). The same is used for
> regmap_read_poll_timeout(). What's the difference?
>
> Since it uses 1/4 of the range you probably need to update tries and
> timeout_us to make it work.
>

Timeout_us here needs to be in one case 100 * 10ms (maybe not
realistic as we could live with number of around 40 * 10ms), but this
is a lot more than proposed range of usleep which Is up to 20ms. Even
in best case this timeout should be 40 ms to give enough time to
measure 2 channels for sure. So with the current timeout_us
requirement we are outside of the range of the udelay timer and that
is why I would need a macro with number of tries, not with the timeout
value (or timeout value of ms).


> > > > > > -       }
> > > > > > +       } while (!(reg_status & MLX90632_STAT_DATA_RDY) && tries--);
> > > > > >
> > > > > >         if (tries < 0) {
> > > > > >                 dev_err(&data->client->dev, "data not ready");
>
> --
> With Best Regards,
> Andy Shevchenko
