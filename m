Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDD5296D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 13:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462776AbgJWLI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 07:08:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44470 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462587AbgJWLI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:08:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id t20so1122231edr.11;
        Fri, 23 Oct 2020 04:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y2vpKPxhmwelF3MsVDfZZeRPwKr78dCwggVY3DuvCGU=;
        b=ed8Wl7eeIGT+dBS5GgOcceADzjHY+jKaT/lBOf0TG37frHEGbDZm8oYDPGEbl/ME5t
         lrkvf3+n5BU4Y2BkHk+7pbT77rp4L/3K5fmU2SNwE1xfKRGGCZtlPc5EK/VBa23qMN9T
         vEHKlsmgJJiElUKJWLmH8UjYmaGU9lsJaRVTWAJHWdTsFY9ndawvEZhEcbmOHc4jyiqf
         rmGGGWPTTXcrrisU76ISkyGk0mIjXgOjSOdiTwJboyHydRHJKAKWXJs0/2XKV+1NY5Dr
         mpFslUFqQ5nPSo7cu9H1DcDjQ18tjI5RZrac8sC5UEiF8E1tVOdBfNpV5OZmlVPnM197
         7S/w==
X-Gm-Message-State: AOAM533gHGZs+jL3TrTk5neEQHZ6T0a6o6/mV3DRMQYZshD+kaSqInKC
        DC/+ZCYusnlgJzKgCZT0aDE=
X-Google-Smtp-Source: ABdhPJz2CPrp1rxXN84/WklOzCcpaQV91ekIZAOzbOGw3tsPlRawVKASz4NbbpELicciI3QZgD9IlA==
X-Received: by 2002:a05:6402:1d2c:: with SMTP id dh12mr1552246edb.256.1603451306893;
        Fri, 23 Oct 2020 04:08:26 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id h26sm587188edr.71.2020.10.23.04.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 04:08:25 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:08:23 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
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
Subject: Re: [PATCH 4/4] arm64: dts: imx8mn: Add power-domain reference in
 USB controller
Message-ID: <20201023110823.GA48162@kozik-lap>
References: <20201022150808.763082-1-aford173@gmail.com>
 <20201022150808.763082-5-aford173@gmail.com>
 <20201023095518.GF42872@kozik-lap>
 <CAHCN7xK52cRA3xHmmDQB_aYACfDpVdZvWNXTr4Hd9b3BDnSHyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHCN7xK52cRA3xHmmDQB_aYACfDpVdZvWNXTr4Hd9b3BDnSHyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 06:03:32AM -0500, Adam Ford wrote:
> On Fri, Oct 23, 2020 at 4:55 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Thu, Oct 22, 2020 at 10:08:07AM -0500, Adam Ford wrote:
> > > The USB OTG controller cannot be used until the power-domain is enabled
> > > unless it was started in the bootloader.
> > >
> > > Adding the power-domain reference to the OTG node allows the OTG
> > > controller to operate.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > >
> >
> > I wonder, why your patches do not have usual Git trailer with summary of
> > changes (after '---')?
> 
> I historically have just done 'git format-patch -pX'  but I haven't
> seen complaints that the summary was missing.  I can add them going
> forward.  Most of these individual patches have only touched single
> files or created new files all together.

The patch stat is useful, especially if it touches multiple
files/subsystems. However it's not needed, so I was just wondering :)

> 
> >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > index 27733fbe87e9..605e6dbd2c6f 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > @@ -979,6 +979,7 @@ usbotg1: usb@32e40000 {
> > >                               assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>;
> > >                               fsl,usbphy = <&usbphynop1>;
> > >                               fsl,usbmisc = <&usbmisc1 0>;
> > > +                             power-domains = <&pgc_otg1>;
> >
> > I guess you need it also for the usbphynop1 and usbmisc1.
> 
> From what I can see looking at the IP blocks and the vendor's code
> repo, only the usbotg IP block needs the power-domain to enable the
> clocking going to it.  AFAICT, neither the usbphynop nor the usbmisc
> are using clocks gated by the power-domain.
> Thanks again for all your reviews.

Mhm, ok then.  Thanks for checking.

Best regards,
Krzysztof
