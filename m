Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41C92E0723
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 09:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgLVISO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 03:18:14 -0500
Received: from mailoutvs27.siol.net ([185.57.226.218]:49084 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725782AbgLVISO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 03:18:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id CBF74522976;
        Tue, 22 Dec 2020 09:17:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZBVoPNRPswOR; Tue, 22 Dec 2020 09:17:31 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 907D45226FB;
        Tue, 22 Dec 2020 09:17:31 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id BD2B3522996;
        Tue, 22 Dec 2020 09:17:30 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH] ARM: dts: sun8i-v3s: Add CSI0 MCLK pin definition
Date:   Tue, 22 Dec 2020 09:17:30 +0100
Message-ID: <3035881.9zrMQt1rZd@jernej-laptop>
In-Reply-To: <20201218195033.2301127-1-contact@paulk.fr>
References: <20201218195033.2301127-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne petek, 18. december 2020 ob 20:50:33 CET je Paul Kocialkowski napisal(a):
> This adds a device-tree definition for the CSI0 MCLK pin,
> which can be used for feeding MIPI CSI-2 sensors.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

Is this used anywhere? Current policy is to add pin definitions only if any 
user exists.

Best regards,
Jernej

> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi
> b/arch/arm/boot/dts/sun8i-v3s.dtsi index a9f5795d4e57..bff822b9fa01 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -337,6 +337,12 @@ pio: pinctrl@1c20800 {
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
> 
> +			/omit-if-no-ref/
> +			csi0_mclk_pin: csi0-mclk-pin {
> +				pins = "PE20";
> +				function = "csi_mipi";
> +			};
> +
>  			/omit-if-no-ref/
>  			csi1_8bit_pins: csi1-8bit-pins {
>  				pins = "PE0", "PE2", "PE3", 
"PE8", "PE9",




