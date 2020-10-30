Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3402A2A0061
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJ3Iuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgJ3Iuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:50:37 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B15120704;
        Fri, 30 Oct 2020 08:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604047836;
        bh=Q3xH7hudUvNja+v+7AwRUOAon6v7ksEpEbBYTZuoyeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JypjtsyCxIU6VauqD4UpHdH8DMgOlkXpcUQEaX/5bjS8Bn/XqC/4992xr2jJ06Dvw
         EMj8BJrmJDpcqIxuA3F6209SHe6K7ILVp0ZYyt6sfYlKnae41NJudE1Af7CEL+GK34
         IEizxvskY1zlBNX6JK5WBL1Nd0/pbdKm9yHqiukI=
Date:   Fri, 30 Oct 2020 16:50:30 +0800
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
Subject: Re: [PATCH v1] ARM: dts: protonic prti6q: fix PHY address
Message-ID: <20201030085029.GO28755@dragon>
References: <20201012071816.22434-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012071816.22434-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 09:18:16AM +0200, Oleksij Rempel wrote:
> Due to bug in the bootloader, the PHY has floating address and may
> randomly change on each PHY reset. To avoid it, the updated bootloader
> with the following patch[0] should be used:
> 
> | ARM: protonic: disable on-die termination to fix PHY bootstrapping
> |
> | If on-die termination is enabled, the RXC pin of iMX6 will be pulled
> | high. Since we already have an 10K pull-down on board, the RXC level on
> | PHY reset will be ~800mV, which is mostly interpreted as 1. On some
> | reboots we get 0 instead and kernel can't detect the PHY properly.
> |
> | Since the default 0x020e07ac value is 0, it is sufficient to remove this
> | entry from the affected imxcfg files.
> |
> | Since we get stable 0 on pin PHYADDR[2], the PHY address is changed from
> | 4 to 0.
> 
> With latest bootloader update, the PHY address will be fixed to "0".
> 
> [0] https://git.pengutronix.de/cgit/barebox/commit/?id=93f7dcf631edfcda19e7757b28d66017ea274b81
> 
> Fixes: 0d446a50559 ("ARM: dts: add Protonic PRTI6Q board")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Changed subject prefix to 'ARM: dts: imx6q-prti6q: ' and applied the
patch.

Shawn
