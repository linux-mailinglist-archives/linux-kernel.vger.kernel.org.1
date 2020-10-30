Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478712A054C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgJ3M10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgJ3M07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:26:59 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47F6C0613D2;
        Fri, 30 Oct 2020 05:26:04 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s24so448622ioj.13;
        Fri, 30 Oct 2020 05:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSviti0p1q5GMdkqTxe16VTxhYDezW8E1AdBlSV93EM=;
        b=hiGLIv+L/ZyIj2RuMnyw/7mT9OkRCfRMi/bOcvKy+/LkQyTQbFt2/90sMk4cBJB4e3
         Qj+jTJqxgORkFCtBexSmyMAq95FcYesI+4RcWI5I730oH4+yN9XU4a4duG4xJhfWG8CY
         e99aYS3zgSGy4ZVgtLRUto0CizMoJPYc0hTzX68LePCLQfrFDqX4f36KXe7+TzuifRZp
         5tWOJPNC36aH5cHl2QnxV5pqVZHY2UpdRDIe9PyQ2wQu4V+DbYi3+q50F3kmAGyc0LY+
         KVV471cFvJfgDY4wKPCq1CL8r1fO/Wcmt2x9RHnm09vZmSgd5HA0RyA9utAfV49ezCE4
         oyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSviti0p1q5GMdkqTxe16VTxhYDezW8E1AdBlSV93EM=;
        b=tlV15JNYy/Y8MeYoLN2ukM+0xA239/Jtv+Pw9JHgZpqo21voVSRRszXQ0Y5xNd4Y5B
         30quWfCxtL9VuO3LiJr2L5/ic0enKf3DfCCIIiLxsSjIfu+rHMatl9tIuD9Cr9vQKZdL
         pH5HKAeyE8zcJQ3hXUNSos7yA15i8LtcRIN6IOVF0vZMigp6wWoXatTdy4wV9CLPaoC7
         Gq5Z70SvrEtionDth+fYorbkjGr/7vMEwko96VLCMeWtNPSCeTZiuTwoCAqV4c5jDVYk
         0D58Dc7PXk7vjhMLGxCKRVNXpbm18AOyt2nFDMZUk9xoUBUDR3sEXiFJ2OkVHGtMNlbF
         49AA==
X-Gm-Message-State: AOAM531QdRu8zQ2xAFVBOxpox5eu/3CPcoDSLB8xkmlGLgbxi8T8r3Ja
        mutuiXFBDHILALuvwnJ7C2ZFnRNUmfNh6BSq9/g=
X-Google-Smtp-Source: ABdhPJybYElzUXhY4j3QkDCwC4FpefbHLBpijbk1hIMkCgZPiSOvtnDzn2bZOzC6iFKB5UZk6v4yspPOlkAmdyyuEHE=
X-Received: by 2002:a5e:de0b:: with SMTP id e11mr1495383iok.92.1604060764019;
 Fri, 30 Oct 2020 05:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200927165947.7317-1-krzk@kernel.org> <20200927165947.7317-2-krzk@kernel.org>
 <CAHCN7xL2uda0OvkSvZ3tCBGT=WU9OxMqeXvmJaeBSpwb--4=zQ@mail.gmail.com>
In-Reply-To: <CAHCN7xL2uda0OvkSvZ3tCBGT=WU9OxMqeXvmJaeBSpwb--4=zQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 30 Oct 2020 07:25:52 -0500
Message-ID: <CAHCN7xKd=ba9j2D-VSkQf=2YNEm0LR1C+nk8n4C-kCJ3e0NV4g@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: imx8mm-beacon-som: fix missing PMIC's
 interrupt line pull-up
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Peter Chen <peter.chen@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 7:51 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Sun, Sep 27, 2020 at 12:00 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > The PMIC's interrupt is level low and should be pulled up.  The PMIC's
> > device node had pinctrl-0 property but it lacked pinctrl-names which
> > is required to apply the pin configuration.
> >
>
> Thanks for the fixes!
>
> > Fixes: 5f67317bd967 ("arm64: dts: imx8mm: correct interrupt flags")
> > Fixes: 593816fa2f35 ("arm64: dts: imx: Add Beacon i.MX8m-Mini development kit")
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Tested-by: Adam Ford <aford173@gmail.com>
>

Shawn,

Any chance you can apply this series?  Without this patch, the pmic
driver throws some splat due to a previous fix.

thanks

adam
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> > index 6de86a4f0ec4..55b36bddd513 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> > @@ -72,6 +72,7 @@
> >         pmic@4b {
> >                 compatible = "rohm,bd71847";
> >                 reg = <0x4b>;
> > +               pinctrl-names = "default";
> >                 pinctrl-0 = <&pinctrl_pmic>;
> >                 interrupt-parent = <&gpio1>;
> >                 interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> > --
> > 2.17.1
> >
