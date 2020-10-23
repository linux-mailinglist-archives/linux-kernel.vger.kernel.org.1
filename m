Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DC5296D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462550AbgJWK4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375948AbgJWK4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:56:36 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1521BC0613CE;
        Fri, 23 Oct 2020 03:56:36 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k1so924057ilc.10;
        Fri, 23 Oct 2020 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NhXXBZvOqnnKgp8e8E44rbe9kMHuy3jw+DbuZ8kOGPI=;
        b=SdHTGWkdI8sX5d+3VNo2JuCHTz14ap27/QcCsv8uJ0Ow85NEQgiQTMS7sMARwPHVsC
         TPeIfIXwXUUq5jiiZOxk+HK/Gm7fKMadEJqLItYlBDnhctQmZHwj8bYqB3eZHykhIIw+
         nSqD/S3YiJfloeeTjMQaS47Kshr1OvJmqVrjmG/O9342rD3EcMpdh4jvVmXZYFRHuDtB
         QeduDCpWT1pMWcNt9Pu9Fw/8XgyMx2ih3zYCwyEqU6ITbbWw/ueisgO3B+Pb/uIMTN9u
         GlsVQlZJLRQc6xcxb00b+8ANN9YyxEqFzHkhoZmfG3rciXJ7XMHrbhcQXtEuB5UPsCkw
         BO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NhXXBZvOqnnKgp8e8E44rbe9kMHuy3jw+DbuZ8kOGPI=;
        b=gZHMbYD9gMHS4w2bYvRbJKd2WMjFsWxUdbt0ODq5+cqMo2zg2a5k/Thmw/K5gfgTpg
         9k4WPAClYNnDNNBk8ccegZjfH9+Ma01BfoHQxoK/eWT5bVoepUjen9FJGrT9QPzQ/iR7
         avLr1PpS9WpCp749yapg2H9Ce0+VMHPM1Iz4/soWCmLyeDyoTi7hyhl/WzrAr8jUADza
         hUbKy4k2fJ4Sm6iw+VIgqpZvFkjw1QRY3s0MjUlflJFihIiIkHdS5MKiLx94zlMK+dd6
         3Nlcc9U2+qZPMyV+Or4Ahte4tEbGCGfahNtCEoR7Hnd7lsfWdvCV/VhhKVz1+atl/xrM
         K1NQ==
X-Gm-Message-State: AOAM533yYOI8aBlzt/lQ/glJopsRfOVMdIMCkDDB3HcvgjK4aXIn3FJl
        6YKfbl6ntGl7jSZcR8hO/i68wnnqOUYcM1L2xhw=
X-Google-Smtp-Source: ABdhPJwqxD4E3yd+IWpRX89yT6cwf574xQQPBA7z0oVMhmFFmx9lD1/ATgSIGmkmjTTNisrqoQXzBDYMirVNtMt8bKE=
X-Received: by 2002:a92:cd42:: with SMTP id v2mr1048841ilq.65.1603450595274;
 Fri, 23 Oct 2020 03:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201022150808.763082-1-aford173@gmail.com> <20201022150808.763082-4-aford173@gmail.com>
 <20201023095227.GE42872@kozik-lap>
In-Reply-To: <20201023095227.GE42872@kozik-lap>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 23 Oct 2020 05:56:24 -0500
Message-ID: <CAHCN7x+ux+G2fcjsBU6mSDO_f=NEYCwy9yND2j4a2_fqJTN6eA@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: imx8mn: add GPC node and power domains
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Marek Vasut <marex@denx.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 4:52 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Oct 22, 2020 at 10:08:06AM -0500, Adam Ford wrote:
> > This adds the DT nodes to describe the power domains available on the
> > i.MX8MN. There are four power domains, but the displaymix and mipi
> > power domains need a separate clock block controller which is also
> > pending for 8MP and 8MM. Once the path for those is clear, Nano will
> > need something similar, but the registers for Nano differ.  For now,
> > the dispmix and mipi are placeholders.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > index 9b4baf7bdfb1..27733fbe87e9 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > @@ -596,6 +596,55 @@ src: reset-controller@30390000 {
> >                               interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> >                               #reset-cells = <1>;
> >                       };
> > +
> > +                     gpc: gpc@303a0000 {
> > +                             compatible = "fsl,imx8mn-gpc";
> > +                             reg = <0x303a0000 0x10000>;
> > +                             interrupt-parent = <&gic>;
> > +                             interrupt-controller;
> > +                             #interrupt-cells = <3>;
>
> Missing interrupts.
Oops.  I'll go back and review this.

>
> > +
> > +                             pgc {
> > +                                     #address-cells = <1>;
> > +                                     #size-cells = <0>;
> > +
> > +                                     pgc_hsiomix: power-domain@0 {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg = <IMX8MN_POWER_DOMAIN_HSIOMIX>;
> > +                                             clocks = <&clk IMX8MN_CLK_USB_BUS>;
> > +                                     };
> > +
> > +                                     pgc_otg1: power-domain@1 {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg = <IMX8MN_POWER_DOMAIN_OTG1>;
> > +                                             power-domains = <&pgc_hsiomix>;
> > +                                     };
> > +
> > +                                     pgc_gpumix: power-domain@2 {
> > +                                             #power-domain-cells = <0>;
> > +                                             reg = <IMX8MN_POWER_DOMAIN_GPUMIX>;
> > +                                             clocks = <&clk IMX8MN_CLK_GPU_CORE_ROOT>,
> > +                                                      <&clk IMX8MN_CLK_GPU_SHADER_DIV>,
> > +                                                      <&clk IMX8MN_CLK_GPU_BUS_ROOT>,
> > +                                                      <&clk IMX8MN_CLK_GPU_AHB>;
> > +                                             resets = <&src IMX8MQ_RESET_GPU_RESET>;
>
> Does it compile without include? Did the include come via dependencies
> of this patch?

Oops.  I cherry picked the git commits, but I forgot to include the
includes which is why it compiles for me.  I'll fix in a V2.

Thanks for all the reviews.

adam
>
> Best regards,
> Krzysztof
>
