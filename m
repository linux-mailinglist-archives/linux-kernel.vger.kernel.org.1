Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA172D6BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394366AbgLJXZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgLJXZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:25:38 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39C9C0613CF;
        Thu, 10 Dec 2020 15:24:57 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id r9so7564620ioo.7;
        Thu, 10 Dec 2020 15:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/LFEJxN+y9atuUh2I6JGG7R8Sn2KE2ON0GObfP+qI0=;
        b=nCSZf3v9Ju3JnlXSqOOHaHEnYtbG81gWsxenvNMhmFMmQQtny6NEL927rs7RvwJoBT
         fjF1weC2UeqTnzot4hgdP04HtUBt59B0H/r923IfSVvPmmPjZ8uHyAFMQtePe2a3P0fJ
         RVJCN6U7WbVuh5sku6B42oiO0iYAlF8OSf+ZgTqNRwoFliL3uBZ7lkLIN9JIp/MyD+Lu
         JKm6V4mDXFcTxxIUQcPMMCh/3uWFi5zDLA/2gWIDCM4j/4Q6uK+Jau+DK+rkfqlYrkgr
         9leTIMSJgG3IKTviJWh/5E++A9cSObIJTqVtSaW59Re08tqdTuNvB7kGVezycjdBDw1y
         nKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/LFEJxN+y9atuUh2I6JGG7R8Sn2KE2ON0GObfP+qI0=;
        b=YpRZL7E77S0T/E4EUr3jLRm0p+WH4vWSM1SmVSOFUYrn2jViCYJfQ48GOczcIPiItc
         8MBm8xrqrI7ZPfzYFLJL0s50WjpiRwwlLPKjEN3FJTH/7vsQxxiP6RaKJ5KYZ9Luu5lZ
         hxqvx3gmPEsXsMadkPmVFFBmPSJkqVC91Ai7UeJJJ0sWvk1opyEfC/LX18uCEj69b0g5
         3wABrLmUnyvXd8/FAOtl6ymth8W4DOut6QZVXoPQXRDYzWzWTDB2xzzwzmtFBXEcMVXQ
         ldiKfeIi4L18apfClOpdDUE/2maac/aICM5YhA432QQgLVL9CCP6LxFiJiVdutW7FHTz
         LKfQ==
X-Gm-Message-State: AOAM530pjg7PBUf7ZxDsSITdCKF0KzENduULFISDRK4z9c0RZTDYV9lB
        zOPKZdDd/6tn4yvygOzY5bV4UjlHoZi8r8gm9AU=
X-Google-Smtp-Source: ABdhPJyWCW+/SgIqqLPV2BSYP1U5EoAYFZW3FW6a2YGtXOOpbaX6k+lcONwSD1HzHR2Rg59RovBDh7yeh5XbUjzX/lw=
X-Received: by 2002:a6b:7501:: with SMTP id l1mr11166527ioh.92.1607642696883;
 Thu, 10 Dec 2020 15:24:56 -0800 (PST)
MIME-Version: 1.0
References: <1607324004-12960-1-git-send-email-shengjiu.wang@nxp.com>
 <20201207132140.GA31982@kozik-lap> <20201207133221.GA32877@kozik-lap>
In-Reply-To: <20201207133221.GA32877@kozik-lap>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 10 Dec 2020 17:24:45 -0600
Message-ID: <CAHCN7x+uMFU0jRYKAdLfFY4uyFBsNFvxaCF9rKE4sR=nYq5etA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mn: Fix duplicate node name
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 7:36 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Dec 07, 2020 at 02:21:40PM +0100, Krzysztof Kozlowski wrote:
> > On Mon, Dec 07, 2020 at 02:53:24PM +0800, Shengjiu Wang wrote:
> > > Error log:
> > > sysfs: cannot create duplicate filename '/bus/platform/devices/30000000.bus'
> > >
> > > The spba bus name is duplicate with aips bus name.
> > > Refine spba bus name to fix this issue.
> > >
> > > Fixes: 970406eaef3a ("arm64: dts: imx8mn: Enable Asynchronous Sample Rate Converter")
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > index fd669c0f3fe5..30762eb4f0a7 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > @@ -246,7 +246,7 @@ aips1: bus@30000000 {
> > >                     #size-cells = <1>;
> > >                     ranges;
> > >
> > > -                   spba: bus@30000000 {
> > > +                   spba: spba-bus@30000000 {

I originally attempted to call it spba-bus@30000000, but I was told to
switch it to 'bus' but all my testing was with the spba-bus name, so I
didn't even notice the conflict.

> >
> > The proper node name is "bus" so basically you introduce wrong name to
> > other problem.  Introducing wrong names at least requires a comment.
>
> I just noticed that my message was barely understandable... so let me
> fix it:
>
> The proper node name is "bus" so basically you introduce wrong name to
> _fix_ other problem.  Introducing wrong names at least requires a comment.
>
> > However the actual problem here is not in node names but in addresses:
> >
> >       aips1: bus@30000000 {
> >               spba: bus@30000000 {
> >
> > You have to devices with the same unit address. How do you share the
> > address space?
> >
> > I think this should be rather fixed.
>
> And again, hungry keyboard ate a letter, so:
>
> You have _two_ devices with the same unit address. How do you share the
> address space?
> I think this should be rather fixed.

I am no expert on this driver, but from what I can tell, the SDMA
driver searches for the memory range assigned to the bus associated
with the spba so the DMA has an idea of which peripheral memory ranges
are shared.
from drivers/dma/imx-sdma.c:

    spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
    ret = of_address_to_resource(spba_bus, 0, &spba_res);
    if (!ret) {
        sdma->spba_start_addr = spba_res.start;
        sdma->spba_end_addr = spba_res.end;
    }

Table 2-3 of the reference manual for the i.MX8M Nano shows the memory
range from 3000_0000 - 300F_FFFF is defined as AIPS-1 (s_b_1, via
SPBA) Glob. Module Enable which implies to me that the SPBA needs to
start at the same place as the AIPS1, but AIPS1 goes from 3000_0000 to
303F_FFFF, so the spba-bus is a subset of the AIPS1.

NXP/Freescale has a variety of SoC's that use the SPBA and in every
instance, they do it this way.  Having the spba-bus with the same
starting address of its parent aips bus isn't unique to this SoC:

imx6q.dtsi
imx6sl.dtsi
imx31.dtsi
imx7s.dtsi
imx6sll.dtsi
imx51.dtsi
imx6qdl.dtsi
imx35.dtsi
imx50.dtsi
imx25.dtsi
imx6sx.dtsi
imx6ul.dtsi
imx53.dtsi

However, in each instance, the bus associated to the SPBA is called
spba-bus and not just 'bus'

adam
>
> Best regards,
> Krzysztof
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
