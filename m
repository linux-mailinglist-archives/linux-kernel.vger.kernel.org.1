Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9CF285F82
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgJGMvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:51:12 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A874DC061755;
        Wed,  7 Oct 2020 05:51:12 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y20so2197072iod.5;
        Wed, 07 Oct 2020 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xuyPM+5n8HvacuwfQXH2nPR1KoE4Q6Cygm65UlTUnT0=;
        b=ZhArK0B2FrVv+8U+Om519V2tR6SQH9RzvUgpDQL5agbDQKHVbnbYs2xsESze2IaRJe
         PDAZvAgAs/+lMQERxpAaMzMg/Bro5mpXNhvQwwgz++FP7A0LtjwV2hV5lZgIHRJpRtLt
         qHKPi8V8NBoYROgSU/WV0fYIO/bCUJY3L8sf1WJF3ryxvr+MKyE8Im2JcHPGABTtNlqB
         E/jGFji2Eyt6v7CDgiMrAFdQ47CMfA7GPnbndi4iiTfx/re0ka7XAb515AAeMxTNUl74
         QB7MujMj9VBQuQCxcELWhlULWqxZBC1/ypes5TcnGqavKYWSiSBdEJrpRkY+NoltJJvc
         MpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xuyPM+5n8HvacuwfQXH2nPR1KoE4Q6Cygm65UlTUnT0=;
        b=o+cvzBPuHzTMD1+RnX5WN5bA/GzEyPfFp4RBTbJkd4TXpRTNk2BjISBhG1KirjMRYI
         J2dLesENBdKA0kZ4woIzrnUGZsAEzE0qMVzRUGawzxsraOP/TjcFKgQe8G6EJZU3q7xx
         R+lUlz47X7OMyAlc43rOb5mQhyJ1jS3ynlw/WHbXyaXET33d2VXDysTSJ/oDqKyoqpY4
         2ZpHbibC6xOxvGDWM620p1mhM8mnnroL/olKHYKb0ZvOuU6DU180tLbAglJ6xFhQ7JP/
         tKTDyDAH30VyKuSN2dHiU+TEGuj4OTCmky71kJ4Zf71Ju4NiVH8qamVCYFvLfmjHd8pX
         eKBA==
X-Gm-Message-State: AOAM532qBpbhqHcHXFzyv1oUF9STtY5Zd4Y3TKl88Q6SMKiJuLnC9i3Z
        qUIykscI3n/WQjqhmgvjRcudcve6l0n6Ms/H9s8=
X-Google-Smtp-Source: ABdhPJzbTtymyK2BytkcLsYPVerJz5EfsN0MXMbm4oGq2ge0ii0q6b52cO18HufirvAxF90Wi+ZD9mAb4YI01Hc1vb0=
X-Received: by 2002:a5e:c70a:: with SMTP id f10mr2159772iop.178.1602075071583;
 Wed, 07 Oct 2020 05:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200927165947.7317-1-krzk@kernel.org> <20200927165947.7317-2-krzk@kernel.org>
In-Reply-To: <20200927165947.7317-2-krzk@kernel.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 7 Oct 2020 07:51:00 -0500
Message-ID: <CAHCN7xL2uda0OvkSvZ3tCBGT=WU9OxMqeXvmJaeBSpwb--4=zQ@mail.gmail.com>
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

On Sun, Sep 27, 2020 at 12:00 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The PMIC's interrupt is level low and should be pulled up.  The PMIC's
> device node had pinctrl-0 property but it lacked pinctrl-names which
> is required to apply the pin configuration.
>

Thanks for the fixes!

> Fixes: 5f67317bd967 ("arm64: dts: imx8mm: correct interrupt flags")
> Fixes: 593816fa2f35 ("arm64: dts: imx: Add Beacon i.MX8m-Mini development kit")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Tested-by: Adam Ford <aford173@gmail.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> index 6de86a4f0ec4..55b36bddd513 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> @@ -72,6 +72,7 @@
>         pmic@4b {
>                 compatible = "rohm,bd71847";
>                 reg = <0x4b>;
> +               pinctrl-names = "default";
>                 pinctrl-0 = <&pinctrl_pmic>;
>                 interrupt-parent = <&gpio1>;
>                 interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> --
> 2.17.1
>
