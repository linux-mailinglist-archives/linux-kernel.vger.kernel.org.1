Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5CE2DCF9B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgLQKja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgLQKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:39:29 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7BBC06138C;
        Thu, 17 Dec 2020 02:38:49 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id o5so2856731oop.12;
        Thu, 17 Dec 2020 02:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=knEMF2sPyROQdjviejviZY0AH5zbV3C0ni9r3HNpLQU=;
        b=d06Zp4vnZGfUsi5UmAFJbHncNk3H9EoNFfGevwArhnSkNDowx2CpAS+e63ItPKbdxw
         T/8OKRH6wDcTXLTtr2sj2o0N6+GVE2ufSo6DDIVr8gsjyS6Zitc17DC+ACvI2sPg8axf
         DYztnGNMUUWTGSR/H2YKXivfiNJFRz5PKN3rgGVqpjuLMQ4Y90mV3d+/c9K2d2UxAzpp
         /g55L9MbiLyaHe/jYYzvornQSUH0wEXJ1YuW/GoVijvuzKQzjMamdhpvjLuGh14LIlO/
         wzsAbUVXOP5hv/QSG7ZSmdEmHQi/lF1+IXObVpYjxyda6PDoUsdWdpt/QNCVuSenhorl
         +dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=knEMF2sPyROQdjviejviZY0AH5zbV3C0ni9r3HNpLQU=;
        b=pfoezMflr0DDENqyzPPwM3yZWQxZO+NHbHAaUEsA5LT+p7Yh/f3C8/w7JJ1s+DwgCu
         SnOEqht1a7ixjUX/Zxe4z5MAB9lYUTeapd4fPSSUtRbg+YX3HISkrqsM3HoMKK1t1v7j
         dObDyBgHai74T1xaMxA44b4+s9tV2p00nSuXWp0iThk7s11gwdqKt+wyxLNSuvBVPFbZ
         eiI4wQ8Y+dHv7aNiS1jHGwOJZVjMgTlIvvG9RUu/F03iZX9J2ihMKwRe+HVEa4FAQfq7
         pxoYhT/wPVHVfPvyRgrQ3M86yWAmHNutaAyC83xXNu9qC0kIh9gWFXcdeNyuB7E3yj2R
         B/FQ==
X-Gm-Message-State: AOAM532LGSXVHgH8GG+R1UpYK4fe1PaMhVZChZmSv7siWCughrkVoZYj
        uFyAkhL38uzOQHRVEaMS7dP2NJJtOEfVsaHGKE0=
X-Google-Smtp-Source: ABdhPJwINgIl54/cRT1MeG+w3rj5CEFEmNKYFQQvDdYbPypjRKs4gnO3LCvi5vBSV/l3SbjHh6yx6OsEuEaXHTXYnMQ=
X-Received: by 2002:a4a:9c5:: with SMTP id 188mr19096256ooa.77.1608201528687;
 Thu, 17 Dec 2020 02:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20201122095556.21597-1-sergio.paracuellos@gmail.com>
 <20201122095556.21597-3-sergio.paracuellos@gmail.com> <160819550615.1580929.14234996916739809712@swboyd.mtv.corp.google.com>
 <CAMhs-H_EiDot_V4Qj1Q8noAf5RNi9BOyy0WmawE+70wY7=FxDg@mail.gmail.com>
 <160819962346.1580929.2348154780751858972@swboyd.mtv.corp.google.com>
 <CAMhs-H_ixfqMxVFOf+J0O-Tp0Q0ngviMm6jHrHJSgCLwZj+Tvw@mail.gmail.com> <160820116913.1580929.15821601182796836787@swboyd.mtv.corp.google.com>
In-Reply-To: <160820116913.1580929.15821601182796836787@swboyd.mtv.corp.google.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 17 Dec 2020 11:38:37 +0100
Message-ID: <CAMhs-H9SiZ90NYCGL+3ad9UR7CDUiA1gb99ZcfHp10=SZtVPpg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] dt: bindings: add mt7621-clk device tree binding documentation
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>,
        COMMON CLK FRAMEWORK <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:MIPS <linux-mips@vger.kernel.org>, open list:STAGING
        SUBSYSTEM <devel@driverdev.osuosl.org>, NeilBrown <neil@brown.name>,
        open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 11:32 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Sergio Paracuellos (2020-12-17 02:14:10)
> > On Thu, Dec 17, 2020 at 11:07 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Sergio Paracuellos (2020-12-17 02:01:39)
> > > >
> > > > On Thu, Dec 17, 2020 at 9:58 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > >
> > > > > Quoting Sergio Paracuellos (2020-11-22 01:55:52)
> > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7621-clk.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7621-clk.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..6aca4c1a4a46
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/clock/mediatek,mt7621-clk.yaml
> > > > >
> > > > > > +      compatible = "mediatek,mt7621-sysc", "syscon";
> > > > > > +      reg = <0x0 0x100>;
> > > > > > +
> > > > > > +      pll {
> > > > >
> > > > > clock-controller? Why can't the parent device be the clk provider and
> > > > > have #clock-cells?
> > > > >
> > > >
> > > > I don't get your point, sorry. Can you please explain this a bit more
> > > > or point to me to an example to understand the real meaning of this?
> > >
> > > It looks like this is a made up child node of syscon so that a driver
> > > can probe in the kernel. It would be more DT friendly to create a
> > > platform device from the parent node's driver, or just register the clks
> > > with the framework directly in that driver.
> >
> > We cannot create a platform device because we need clocks available in
> > 'plat_time_init' before setting up the timer for the GIC.
> > The only way I see to avoid this syscon and having this as a child
> > node is to use architecture operations in
> > 'arch/mips/include/asm/mach-ralink/ralink_regs.h'
> > instead of getting a phandle using the regmap is being currently used...
>
> Can that be done with
>
> CLK_OF_DECLARE_DRIVER("mediatek,mt7621-sysc", my_timer_clk_init)
>
> ? Is the syscon used anywhere besides by the clk driver?

Yes, for example all the gates use them to access SYSC_REG_CLKCFG1 in
all of their 'mt7621_gate_ops' and also in all 'recalc_rate' functions
where SYSC_REG_SYSTEM_CONFIG0, is readed.
