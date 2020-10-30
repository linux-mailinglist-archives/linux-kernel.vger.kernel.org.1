Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1013029FE0E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 07:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgJ3Gvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 02:51:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3Gvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 02:51:55 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BA6522202;
        Fri, 30 Oct 2020 06:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604040714;
        bh=2qaw9kBrwk/+Aznh/tyZvur+BcjW/eNHSFdltmBtDrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vTaQyV/4wxBRPWP+Ic4ow9EtmZWgjvdSVF99hbWYwWDfjoOt/KjsyklcFCQmPn5Sb
         E83YpXPguc/PeZvFXIpTjjp2iUJVK0pJEnwQXDS7SEY2V2dBoUwW9uFUa+6uvMnNJ2
         1UXtAOgVkVK6ryaQZ2UERZKYHxO/ubwPhtBixpfo=
Date:   Fri, 30 Oct 2020 14:51:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/12] ARM: dts: imx: Board compatibles cleanup
Message-ID: <20201030065146.GD28755@dragon>
References: <20200930190143.27032-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930190143.27032-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 09:01:31PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v1:
> 1. Drop applied vendor-prefix patches.
> 2. Add Reviews from Rob.
> 3. Use ABB prefix for Aristainetos boards.
> 4. Add missed compatibles for i.MX51, i.MX53 and i.MX6DL.
> 5. Fix typo (VF600 -> VF610) in VF boards.
> 6. New vendor prefixes (patches): #1 and #2.
> 
> Best regards,
> Krzysztof
> 
> 
> Krzysztof Kozlowski (12):
>   dt-bindings: vendor-prefixes: add MicroSys
>   dt-bindings: vendor-prefixes: add Revotics
>   dt-bindings: arm: fsl: document i.MX25 and i.MX27 boards

This one was applied from v1.

>   dt-bindings: arm: fsl: document i.MX51 boards
>   dt-bindings: arm: fsl: document i.MX53 boards
>   dt-bindings: arm: fsl: document VF boards
>   dt-bindings: arm: fsl: document i.MX6DL boards
>   ARM: dts: imx6dl-pico: fix board compatibles
>   dt-bindings: vendor-prefixes: add ABB
>   dt-bindings: arm: fsl: document i.MX6DL Aristainetos boards
>   ARM: dts: imx6dl: add compatibles for Aristainetos boards

Applied all above.

Shawn

>   dt-bindings: arm: fsl: document i.MX6Q boards
> 
>  .../devicetree/bindings/arm/fsl.yaml          | 223 ++++++++++++++++--
>  .../devicetree/bindings/vendor-prefixes.yaml  |   6 +
>  arch/arm/boot/dts/imx6dl-aristainetos2_4.dts  |   2 +-
>  arch/arm/boot/dts/imx6dl-aristainetos2_7.dts  |   2 +-
>  arch/arm/boot/dts/imx6dl-aristainetos_4.dts   |   2 +-
>  arch/arm/boot/dts/imx6dl-aristainetos_7.dts   |   2 +-
>  arch/arm/boot/dts/imx6dl-pico-dwarf.dts       |   2 +-
>  arch/arm/boot/dts/imx6dl-pico-hobbit.dts      |   2 +-
>  arch/arm/boot/dts/imx6dl-pico-nymph.dts       |   2 +-
>  arch/arm/boot/dts/imx6dl-pico-pi.dts          |   2 +-
>  10 files changed, 216 insertions(+), 29 deletions(-)
> 
> -- 
> 2.17.1
> 
