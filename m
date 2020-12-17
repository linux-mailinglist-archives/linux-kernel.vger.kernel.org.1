Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B0F2DCF53
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgLQKPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQKPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:15:01 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF9EC061794;
        Thu, 17 Dec 2020 02:14:21 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id i6so26761698otr.2;
        Thu, 17 Dec 2020 02:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2ZDhGi3vWqPU8yXx5v57vs6HN85EYlUIkyorqPUhOM=;
        b=mEFfk59Zl/H2JsUM/FG/31kylt3h+0U+rAHzWTLWcudz8whZb3/ylnUJ1I4f0FOCd1
         /QBqAcRD54pbOEsRli5gaxCwAQmggYp7EHNZhs8ujfyOnVmZo27vc5ZxwKnDGj+Wi0WC
         xWFMyGtxjNjCpC+tCMiGy4x1hvpsvSdujQIDKJx9a4Sv1djOF++n61fVDnGlstzj/ZvT
         ME2Tg9nuhKxAnRjMI/toVekxivUSH258czV6TJrhndImbrzqLVXZ7QmUEFYvFNpWc+IT
         LKK9KIH2ezEWFhSZlzGE3GMbmoagA3WW2m2d6+2we2YpqO9jlccu/ka08uJI1S9Nik23
         DA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2ZDhGi3vWqPU8yXx5v57vs6HN85EYlUIkyorqPUhOM=;
        b=akrI/8e7/hKvsI+A9r89WxcmnUSfDi4R6ybYyfTDd/P5kNTfWa14Fxw/KEpWJImxR1
         REOwq7VaNb/HRrNqXu5Tkwn1y1TgTx8mfbrmLgdoA/lF7S1m1Rh+06u1Bw0GJHRunyKG
         qJfHavVjRzug6J1zB47ghMmdC6SSG96RIGs1eJfsbRfcSa0hLpw0L9coUJgAMkv5J5xU
         L/vq4v5FmVFu1mFqmgGXavT5AqLRaCgC3Zjp9ObmffK73b//1727Qyq0bFYmimdS8THJ
         ZabPYUNpLg4wCH7chmNTmw21Ui/IyzbfQxOcx9UTD+qZ6xpz9i7gPDJaDCz53bUfnnyk
         awBw==
X-Gm-Message-State: AOAM533yga6hf22CRFwAOKtP8SFv6v3wRX0+xMfR8A06HfCxax/YF6C+
        cCMzJmvsEfBRYsa303K106ciAbWHRdlbE4/oCUA=
X-Google-Smtp-Source: ABdhPJyGvuo7tSATTxGNsdQ5yu1IfT+pbMxFX//DHKqkuB/okgeYGet+nUCYBDFh7Rw7GAPkZ0+eIrgsxmLGgdvF21o=
X-Received: by 2002:a9d:730e:: with SMTP id e14mr10799057otk.74.1608200061045;
 Thu, 17 Dec 2020 02:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20201122095556.21597-1-sergio.paracuellos@gmail.com>
 <20201122095556.21597-3-sergio.paracuellos@gmail.com> <160819550615.1580929.14234996916739809712@swboyd.mtv.corp.google.com>
 <CAMhs-H_EiDot_V4Qj1Q8noAf5RNi9BOyy0WmawE+70wY7=FxDg@mail.gmail.com> <160819962346.1580929.2348154780751858972@swboyd.mtv.corp.google.com>
In-Reply-To: <160819962346.1580929.2348154780751858972@swboyd.mtv.corp.google.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 17 Dec 2020 11:14:10 +0100
Message-ID: <CAMhs-H_ixfqMxVFOf+J0O-Tp0Q0ngviMm6jHrHJSgCLwZj+Tvw@mail.gmail.com>
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

On Thu, Dec 17, 2020 at 11:07 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Sergio Paracuellos (2020-12-17 02:01:39)
> >
> > On Thu, Dec 17, 2020 at 9:58 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Sergio Paracuellos (2020-11-22 01:55:52)
> > >
> > > > diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7621-clk.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7621-clk.yaml
> > > > new file mode 100644
> > > > index 000000000000..6aca4c1a4a46
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/clock/mediatek,mt7621-clk.yaml
> > >
> > > > +      compatible = "mediatek,mt7621-sysc", "syscon";
> > > > +      reg = <0x0 0x100>;
> > > > +
> > > > +      pll {
> > >
> > > clock-controller? Why can't the parent device be the clk provider and
> > > have #clock-cells?
> > >
> >
> > I don't get your point, sorry. Can you please explain this a bit more
> > or point to me to an example to understand the real meaning of this?
>
> It looks like this is a made up child node of syscon so that a driver
> can probe in the kernel. It would be more DT friendly to create a
> platform device from the parent node's driver, or just register the clks
> with the framework directly in that driver.

We cannot create a platform device because we need clocks available in
'plat_time_init' before setting up the timer for the GIC.
The only way I see to avoid this syscon and having this as a child
node is to use architecture operations in
'arch/mips/include/asm/mach-ralink/ralink_regs.h'
instead of getting a phandle using the regmap is being currently used...
