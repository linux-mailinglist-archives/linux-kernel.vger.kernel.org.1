Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F4E2F0726
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 13:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbhAJMR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 07:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbhAJMR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 07:17:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CECD1206C1;
        Sun, 10 Jan 2021 12:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610281037;
        bh=UlriINonqSCn/Nr9LA6HR3UnVDfNn8cDxzpAgz6jrVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AogRLxZBMIDXg/yVR6w+0u+XNlOpJdqc7LXV2KDjzPXW6BjfegtPeEh+Luhir+HKr
         cWwzsbpB3Qkx7IH63sWXE7vECC2nAt35X7Ym6kJgkyzMNyUUWBCxj+Ks09Q1uD8Cax
         qFxilGheJRixSjTSs2umfgJWUFu3J0cMxtGWLhdnQ+GeNNB/w2Fp0dn883KAWtWxYw
         NYB6F1tmMciV+5tPJ4OBty5pIPS/CW9TMlho1jR9VGDnMWADakscJli8XLWshofjnt
         y6vXUnJMLcZnKm+teUcrfh7HdypUR98d9JclBtYLLpse/mQGPDu8gZ5uqZfEsHIdzc
         O7a7mhEMPrwjw==
Date:   Sun, 10 Jan 2021 20:17:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     kernel@pengutronix.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM AND ARM64 SoC SUB-ARCHITECTURES (COMMON PARTS)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 0/3] Mainline Webasto ccbv2 board
Message-ID: <20210110121711.GI28365@dragon>
References: <20201216162433.9138-1-r.czerwinski@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216162433.9138-1-r.czerwinski@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 05:24:29PM +0100, Rouven Czerwinski wrote:
> Add Webasto ccbv2 device tree.
> 
> v2:
> - add correct mailing lists to cc
> - add commit message for vendor-prefix and dt-bindings
> 
> Rouven Czerwinski (3):
>   dt-bindings: vendor-prefixes: add Webasto SE

I did not receive this one.

Shawn

>   ARM: dts: add Webasto ccbv2
>   dt-bindings: arm: fsl: add Webasto ccbv2
> 
>  .../devicetree/bindings/arm/fsl.yaml          |   1 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/imx6ul-webasto-ccbv2.dts    | 472 ++++++++++++++++++
>  4 files changed, 476 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-webasto-ccbv2.dts
> 
> 
> base-commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
> -- 
> 2.29.2
> 
