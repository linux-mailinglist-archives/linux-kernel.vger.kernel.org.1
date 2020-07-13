Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7098021C483
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 15:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgGKNxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 09:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbgGKNxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 09:53:02 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F3612075F;
        Sat, 11 Jul 2020 13:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594475581;
        bh=s/7gnYxbL8MGJCdRA8lVq8/Fs0I4KXG/wBbbmOccA8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VVxcVMgcqwkiplyk7Ep7Dv309WWAJdZ5Mz8P1lw6Nk+XKNhd7bn7ImReEehA5Ez10
         SWfDY7FcDqOxdwpz6vW7hSLGhVWjeLew7FG/yB0R3p/yJJbIFCHE3M1mQZZbCLw4QF
         JYVSUK89ZR8OgN5hRqANEpJX2afHG1q/IWvu9jVk=
Date:   Sat, 11 Jul 2020 21:52:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] Add audio support for imx6sx platform
Message-ID: <20200711135253.GE21277@dragon>
References: <cover.1592460381.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1592460381.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 02:03:44PM +0800, Shengjiu Wang wrote:
> Add audio support for imx6sx platform.
> Enable ASRC, ESAI, SPDIF, MQS.
> 
> Shengjiu Wang (5):
>   ARM: dts: imx6sx: Enable ASRC device
>   ARM: dts: imx6sx-sdb: Add MQS support

Applied the series, except this one which doesn't apply to my branch.

Shawn

>   ARM: dts: imx6sx-sdb: Add SPDIF support
>   ARM: dts: imx6sx-sabreauto: Add SPDIF support
>   ARM: dts: imx6sx-sabreauto: Add cs42888 sound card support
> 
>  arch/arm/boot/dts/Makefile             |  1 +
>  arch/arm/boot/dts/imx6sx-sabreauto.dts | 96 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6sx-sdb-mqs.dts   | 48 +++++++++++++
>  arch/arm/boot/dts/imx6sx-sdb.dtsi      | 30 ++++++++
>  arch/arm/boot/dts/imx6sx.dtsi          | 36 +++++++---
>  5 files changed, 203 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6sx-sdb-mqs.dts
> 
> -- 
> 2.21.0
> 
