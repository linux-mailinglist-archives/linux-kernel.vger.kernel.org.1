Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBDC2F99E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbhARG2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:28:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbhARG1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:27:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE38122512;
        Mon, 18 Jan 2021 06:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610951217;
        bh=K2lbHwzdDMu3Kr/dXSxYY0vnoR/vcNJ3QB9jn7n7oSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WtXgUJAfEEiPjqx2XBlrBEBM5szGP/0YdZWzuYPRoTB95tpqr43z6CzwxUgREzZjZ
         t3vCbushCOG+K32ZU7zZQI7eKvs0wcWoqV5oarbaW8kbELZ8CPjC7Rn1ko6B4bsPHN
         20mwqk25fhzCJqKVMc20X1oRIJ0k2auT/7QJ3Ycl9+I/mEf4x7IdZ/SIDZVJu10Kc7
         FzKDlEt0ImzQRFxtgXlrSNfnmRWFE9xTgJAkxEvPfBG7Mwm0UNOqDOZt1NQ7/IACVk
         1L3rQs3rzJRT+p/OykMYMjyhelrA5zu1x9035ofRZ1AkUyHjbqa0oPWt4P95C35Miq
         PEGhRq/Ymc6vA==
Date:   Mon, 18 Jan 2021 14:26:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v7 0/5] mainline Kverneland boards
Message-ID: <20210118062650.GH28365@dragon>
References: <20210111101855.3121-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111101855.3121-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:18:50AM +0100, Oleksij Rempel wrote:
> changes v7:
> - add Acked-by: Rob Herring to the firs patch
> - imx6qdl-vicut1.dtsi: add missing KEY_POWER
> - imx6dl-victgo.dts: add missing gpio flags to rotary-encoder 
> - imx6dl-victgo.dts: rename video@5c to video-decoder@5c 
> - imx6dl-victgo.dts: sort out some spaces 
> 
> changes v6:
> - move startup-delay-us close to gpio property
> - imx6qdl-vicut1.dtsi: rename video@5c to video-decoder@5c
> - imx6qdl-vicut1.dtsi: sort out some spaces
> - use defines for linux,code and linux,axis
> 
> changes v5:
> - reorder kvg prefix
> - add Acked-by: Rob Herring.. 
> 
> changes v4:
> - fix active level of SPI CS GPIOs
> 
> changes v3:
> - add vicutp board
> - change tvnorm to sdtv-standards
> - change linux,default-trigger "mmc" to  "disk-activity";
> - add power-supply property to the panel node
> 
> changes v2:
> - add victgo board
> - diff fixes for vicut1.dtsi
> 
> Oleksij Rempel (5):
>   dt-bindings: vendor-prefixes: Add an entry for Kverneland Group
>   dt-bindings: arm: fsl: add Kverneland UT1, UT1Q and UI1P boards
>   ARM: dts: add Kverneland UT1, UT1Q and UT1P
>   dt-bindings: arm: fsl: add Kverneland TGO board
>   ARM: dts: add Kverneland TGO board

Applied all, thanks.
