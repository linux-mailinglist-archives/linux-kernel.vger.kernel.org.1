Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD492E0725
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 09:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgLVIVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 03:21:47 -0500
Received: from mailoutvs16.siol.net ([185.57.226.207]:46716 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725300AbgLVIVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 03:21:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id EC04E5214DE;
        Tue, 22 Dec 2020 09:21:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LyxO0tTR1YJW; Tue, 22 Dec 2020 09:21:04 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id AA6275213E3;
        Tue, 22 Dec 2020 09:21:04 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 657DF52134B;
        Tue, 22 Dec 2020 09:21:04 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: allwinner: Add V3s compatible description
Date:   Tue, 22 Dec 2020 09:21:04 +0100
Message-ID: <2475548.3AtxBWxPV6@jernej-laptop>
In-Reply-To: <20201218205436.2326872-1-contact@paulk.fr>
References: <20201218205436.2326872-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne petek, 18. december 2020 ob 21:54:35 CET je Paul Kocialkowski napisal(a):
> Introduce bindings description for the V3s PWM, which is
> register-compatible with the A20 PWM.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

This is meant to be used together with V3s PWM patch you recently send? Can 
you please resend them together, with fixed compatible in DT node? Currently 
it's not clear why this patch is needed and PWM patch will need fix anyway.

Best regards,
Jernej

> ---
>  .../devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml index
> 7dcab2bf8128..04ff708fdc86 100644
> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> @@ -24,6 +24,9 @@ properties:
>        - items:
>            - const: allwinner,sun8i-a83t-pwm
>            - const: allwinner,sun8i-h3-pwm
> +      - items:
> +          - const: allwinner,sun8i-v3s-pwm
> +          - const: allwinner,sun7i-a20-pwm
>        - items:
>            - const: allwinner,sun50i-a64-pwm
>            - const: allwinner,sun5i-a13-pwm




