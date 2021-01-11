Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9288B2F0ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 02:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbhAKBVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 20:21:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbhAKBVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 20:21:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B86A2229C;
        Mon, 11 Jan 2021 01:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610328060;
        bh=wLuajw4qu5hM91XYX5n7jtoMkQuviDktjjHDTkufvsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E5vPkTa4FcWj/jaY4e5xOsBw1rU0leeGC5YYSchXYWfmvBqXknprFT/teCbhPHOSC
         OeaYI/tkk42lSEbJWOBVeLf2CPF1z8b3vjKoo/yU1oYo2oQQhu2iX+aJM60MFhMlmP
         K9lPHb6loXwYwAc5y2DS8yPVK8tFgize/gphBa7y4/+lahJH1cF9YOtzGoU0vYhvEm
         PHTpAL2tXNutM62A9DdEQDh95r1ljMK7YLhlxa80AH1rx/UxlPoEF8IkaJQypcYeh9
         pi31w+M8wXFDOtLsHvcCJliysFDtvKKlteee3CZ52/lR+RlmHIGV2ngSGjJQrzPjYO
         bbOiIHxtkVC8g==
Date:   Mon, 11 Jan 2021 09:20:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/7] arm64: dts: fsl: use the new clockgen constants
Message-ID: <20210111012052.GT28365@dragon>
References: <20201229114740.7936-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229114740.7936-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 12:47:33PM +0100, Michael Walle wrote:
> Since commit 4cb15934ba05 ("clk: qoriq: provide constants for the type")
> there are constants for better readabilty. This series will use them for
> all arm64 device trees.
> 
> This is just a mechanical change. The change was done with the following
> script:
> 
> $ sed -e 's/<&clockgen 0 \([0-9]\)>/<\&clockgen QORIQ_CLK_SYSCLK \1>/g' \
>       -e 's/<&clockgen 1 \([0-9]\)>/<\&clockgen QORIQ_CLK_CMUX \1>/g' \
>       -e 's/<&clockgen 2 \([0-9]\)>/<\&clockgen QORIQ_CLK_HWACCEL \1>/g' \
>       -e 's/<&clockgen 3 \([0-9]\)>/<\&clockgen QORIQ_CLK_FMAN \1>/g' \
>       -e 's/<&clockgen 4 0>/<\&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(1)>/g' \
>       -e 's/<&clockgen 4 1>/<\&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(2)>/g' \
>       -e 's/<&clockgen 4 3>/<\&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(4)>/g' \
>       -e 's/<&clockgen 4 7>/<\&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(8)>/g' \
>       -e 's/<&clockgen 4 15>/<\&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(16)>/g' \
>       -i \
>          arm64/boot/dts/freescale/fsl-ls1012a.dtsi \
>          arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts \
>          arm64/boot/dts/freescale/fsl-ls1028a.dtsi \
>          arm64/boot/dts/freescale/fsl-ls1043a.dtsi \
>          arm64/boot/dts/freescale/fsl-ls1046a.dtsi \
>          arm64/boot/dts/freescale/fsl-ls1088a.dtsi \
>          arm64/boot/dts/freescale/fsl-ls2080a.dtsi \
>          arm64/boot/dts/freescale/fsl-ls2088a.dtsi \
>          arm64/boot/dts/freescale/fsl-ls208xa.dtsi \
>          arm64/boot/dts/freescale/fsl-lx2160a.dtsi \
>          boot/dts/freescale/qoriq-fman3-0.dtsi
> 
> Afterwards the changes were manually clean-up for proper indendation, the
> include file was added and split into individual commits per SoC.
> 
> Michael Walle (7):
>   arm64: dts: ls1012a: use constants in the clockgen phandle
>   arm64: dts: ls1028a: use constants in the clockgen phandle
>   arm64: dts: ls1043a: use constants in the clockgen phandle
>   arm64: dts: ls1046a: use constants in the clockgen phandle
>   arm64: dts: ls1088a: use constants in the clockgen phandle
>   arm64: dts: ls208xa: use constants in the clockgen phandle
>   arm64: dts: lx2160a: use constants in the clockgen phandle

Applied all, thanks.
