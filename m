Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5E126B892
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgIPAqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIOM6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:58:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7004EC061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:58:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z19so1872785pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7G2CzOYqiH9ibUColb5tVhNMevQLWkjnQ9SIdmc0AU=;
        b=bd1YdxZZomrEmxn/plX06V/cZuYuZAA+EkG5aXcyoXsX4PS9BCuGp3EjMmbgX9uEyQ
         ITNfIiYiyR8/V7qtGzLmbiYIkbhd19hK6XNVK+GyD7VQHYlS5uhz9bCTwp52aDeyTcXG
         CGQTqRLc3xfX0MZ2esmJAGooRl4Mar7tTboQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7G2CzOYqiH9ibUColb5tVhNMevQLWkjnQ9SIdmc0AU=;
        b=fQS25HCncq+f8jBwbHqEH4dMXXGESGbja1MjttnLVUtcOHXGbciTXNVEKvWITacev0
         pJKP0zTCsRybpFhInw4ffVvS6kJz+sqIHqk0t+KUQA+9EIwlRT8g2/ttDC653SiguGqL
         xV7l9U1SOHZIYgP0RU/6gG7+cGvWelb+Bj4TkaaKthG6bEPK75RfSKcr8a7mnWSnyOVP
         8jh9RfOOCnJoh27wFeSAIlfftUYxDcdDFIbVNLxFhsCzECY3pdjR30yrcEzDuu4A9XXj
         qYJ+XRrIzc88ZYqb8+T09647hYhjMw2aq6R7gzTJ+oHkaqLi0piiuzQN3c+ni7nU45+G
         Ta6w==
X-Gm-Message-State: AOAM533Ots1IYdNUpWKin6wa7yRofScDCbKcruGKl0cilCk/bMb0FfAE
        DF+UUePYe4ri3BepPfpdyfT0XlhdT+QwTc7vQUEAGA==
X-Google-Smtp-Source: ABdhPJze8e//GhCZuhvxKjphXB1Pvoi+mg7wGBazyHURu7t47g/o6713ZFFjPMbSdxMoGyr1OqPX6Vgp1G/RiekKwC8=
X-Received: by 2002:aa7:956d:0:b029:142:2501:35d2 with SMTP id
 x13-20020aa7956d0000b0290142250135d2mr1682052pfq.50.1600174700627; Tue, 15
 Sep 2020 05:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200812143324.2394375-0-mholenko@antmicro.com>
 <20200812143324.2394375-3-mholenko@antmicro.com> <20200911005740.GN3562056@lianli.shorne-pla.net>
 <CAPk366Tvb9g960e3ZLv3+_H8FZJRRe0Jqa4q7tejE+svMcQvLA@mail.gmail.com> <20200914132433.GB2512402@lianli.shorne-pla.net>
In-Reply-To: <20200914132433.GB2512402@lianli.shorne-pla.net>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Tue, 15 Sep 2020 14:58:08 +0200
Message-ID: <CAPk366QvUdK1EVpUEVBkgb4me5aMfx6GBWSVNy8OKb8reT0Xvw@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] drivers/soc/litex: add LiteX SoC Controller driver
To:     Stafford Horne <shorne@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gabriel L. Somlo" <gsomlo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 3:24 PM Stafford Horne <shorne@gmail.com> wrote:
>
> On Mon, Sep 14, 2020 at 12:33:11PM +0200, Mateusz Holenko wrote:
> > On Fri, Sep 11, 2020 at 2:57 AM Stafford Horne <shorne@gmail.com> wrote:
> > >
> > > On Wed, Aug 12, 2020 at 02:34:34PM +0200, Mateusz Holenko wrote:
> > > > From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> > > >
> > > > This commit adds driver for the FPGA-based LiteX SoC
> > > > Controller from LiteX SoC builder.
> > > >
> > > > Co-developed-by: Mateusz Holenko <mholenko@antmicro.com>
> > > > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > > > Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> > > > ---
> > > > +     node = dev->of_node;
> > > > +     if (!node)
> > > > +             return -ENODEV;
>
> We return here without BUG() if the setup fails.
>
> > > > +
> > > > +     soc_ctrl_dev = devm_kzalloc(dev, sizeof(*soc_ctrl_dev), GFP_KERNEL);
> > > > +     if (!soc_ctrl_dev)
> > > > +             return -ENOMEM;
>
> We return here without BUG() if we are out of memory.
>
> > > > +
> > > > +     soc_ctrl_dev->base = devm_platform_ioremap_resource(pdev, 0);
> > > > +     if (IS_ERR(soc_ctrl_dev->base))
> > > > +             return PTR_ERR(soc_ctrl_dev->base);
>
> Etc.

You are totally right - this is not consistent.
We should probably either trigger BUG() in each case or don't bother at all.

>
> > > > +
> > > > +     result = litex_check_csr_access(soc_ctrl_dev->base);
> > > > +     if (result) {
> > > > +             // LiteX CSRs access is broken which means that
> > > > +             // none of LiteX drivers will most probably
> > > > +             // operate correctly
> > > The comment format here with // is not usually used in the kernel, but its not
> > > forbidded.  Could you use the /* */ multiline style?
> >
> > Sure, I'll change the commenting style here.
> >
> > >
> > > > +             BUG();
> > > Instead of stopping the system with BUG, could we just do:
> > >
> > >         return litex_check_csr_access(soc_ctrl_dev->base);
> > >
> > > We already have failure for NODEV/NOMEM so might as well not call BUG() here
> > > too.
> >
> > It's true that litex_check_csr_accessors() already generates error
> > codes that could be
> > returned directly.
> > The point of using BUG() macro here, however, is to stop booting the
> > system so that it's visible
> > (and impossible to miss for the user) that an unresolvable HW issue
> > was encountered.
> >
> > CSR-accessors - the litex_{g,s}et_reg() functions - are intended to be
> > used by other LiteX drivers
> > and it's very unlikely that those drivers would work properly after
> > the fail of litex_check_csr_accessors().
> > Since in such case the UART driver will be affected too (no boot logs
> > and error messages visible to the user),
> > I thought it'll be easier to spot and debug the problem if the system
> > stopped in the BUG loop.
> > Perhaps there are other, more linux-friendly, ways of achieving a
> > similar goal - I'm open for suggestions.
>
> I see your point, but I thought if failed with an exit status above, we could do
> the same here.  But I guess failing here means that something is really wrong as
> validation failed.
>
> Some points:
>  - If we return here, the system will still boot but there will be no UART
>  - If we bail with BUG(), here the system stops, and there is no UART
>  - Both cases the user can connect with a debugger and read "dmesg", to see what
>    is wrong, but BUG() does not print an error message on all architectures.
>
> We could also use:
>
>  - WARN(1, "Failed to validate CSR registers, the system is probably broken.");
>
> If you want to keep BUG() it may be fine.
>
> I am not an expert on handling these type of bailout's so other input is
> appreciated.

I don't have a strong opinion about using BUG() here - I just thought
it would be easier for the user.
If this is, however, not how linux typically works, I'm ok with
reworking this part.

> -Stafford

Best,
Mateusz

--
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
