Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494AF296D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 13:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462701AbgJWLDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 07:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462693AbgJWLDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:03:45 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E211C0613CE;
        Fri, 23 Oct 2020 04:03:44 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j8so969560ilk.0;
        Fri, 23 Oct 2020 04:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5dK8yPMPRMHSKMYDdtQvTIuHYGLhMCef+ge82Cwkl/k=;
        b=GnoVgHgRCLG3PoJRv+wiJcnXnry2+iSyG7EULkfjXx+h7qV+J17F1aBXee0wwWb9xL
         jHfDCz7zdQLTmGxjuTKdMI/tKjtj0Huoc9gT5es8Yr+9Ip0fr2E+WAXdHkxbgISSlwpY
         FecdIQYR+ozdsM81M2JetvJD9PAw+odbI6dMxswgoOSHmGg7+He57RP2uKSsu/zYlFu1
         c2yeUB6t4DUJUfTsCirxkjQO5j9G+UnRd3+RotLVp1ol1DAVm3NgGpw+LcNPQG7V3dv+
         5xmEO2DLN1y/Be+pyCBucLDSam6CZo0L3TEAczUjvs+iZ6mmDAHz0toVnQVysNjhGh+T
         46Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dK8yPMPRMHSKMYDdtQvTIuHYGLhMCef+ge82Cwkl/k=;
        b=qtACpWUSE1FhlxBJ5lK8TkuNg2SygVyrcuhDyXxDfvklfNDsh8QJ5Voqo8r9opDJsq
         n9SA4E3xNbSp1SeqpzK9hEaSt80Msd69k7eGxoQMCHxSNTb/1BrdLK7/L1J1nwB7owuj
         QCuE3nvntgluhiiE4kzIXimT4BkSIBCK549JBD9XeiUB44SymjBquf5aMGqI8QmRPwfK
         lqtIDvrRTXFjKC7Q8sq7GVKgRtQuhdW+VLraEQj+E45E129L3nKoFV3246mjO5OKR1aF
         QRXLmffaTFnteYWg/csb/p8rq/RvZujiY/fl1YAeSImkWEjvdLKBEgNPmT81zSz5B11S
         Js2g==
X-Gm-Message-State: AOAM5316icWCcJ5lS0heDiEh2CNT6uo1vUx5LyrkXBRscOI8NtwkI0hT
        ua3IE05+apO7zzKQPbQIfghsZPMOcLibp9YWcxeC+ITfDmg=
X-Google-Smtp-Source: ABdhPJyOEAg7hBCarGbngOySLPicIXEBL9D9FTcBXHpAzmN1qcqOAGnWLk8/Vjsep01rQTAgyvAWDjbOS6RhvZfRlp8=
X-Received: by 2002:a92:180b:: with SMTP id 11mr1141706ily.89.1603451023521;
 Fri, 23 Oct 2020 04:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201022150808.763082-1-aford173@gmail.com> <20201022150808.763082-5-aford173@gmail.com>
 <20201023095518.GF42872@kozik-lap>
In-Reply-To: <20201023095518.GF42872@kozik-lap>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 23 Oct 2020 06:03:32 -0500
Message-ID: <CAHCN7xK52cRA3xHmmDQB_aYACfDpVdZvWNXTr4Hd9b3BDnSHyg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: imx8mn: Add power-domain reference in USB controller
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

On Fri, Oct 23, 2020 at 4:55 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Oct 22, 2020 at 10:08:07AM -0500, Adam Ford wrote:
> > The USB OTG controller cannot be used until the power-domain is enabled
> > unless it was started in the bootloader.
> >
> > Adding the power-domain reference to the OTG node allows the OTG
> > controller to operate.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
>
> I wonder, why your patches do not have usual Git trailer with summary of
> changes (after '---')?

I historically have just done 'git format-patch -pX'  but I haven't
seen complaints that the summary was missing.  I can add them going
forward.  Most of these individual patches have only touched single
files or created new files all together.

>
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > index 27733fbe87e9..605e6dbd2c6f 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > @@ -979,6 +979,7 @@ usbotg1: usb@32e40000 {
> >                               assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>;
> >                               fsl,usbphy = <&usbphynop1>;
> >                               fsl,usbmisc = <&usbmisc1 0>;
> > +                             power-domains = <&pgc_otg1>;
>
> I guess you need it also for the usbphynop1 and usbmisc1.

From what I can see looking at the IP blocks and the vendor's code
repo, only the usbotg IP block needs the power-domain to enable the
clocking going to it.  AFAICT, neither the usbphynop nor the usbmisc
are using clocks gated by the power-domain.
Thanks again for all your reviews.

adam
>
> Best regards,
> Krzysztof
