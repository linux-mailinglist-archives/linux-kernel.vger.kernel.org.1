Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF9B2F0AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 02:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbhAKBhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 20:37:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbhAKBhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 20:37:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C1B5224B8;
        Mon, 11 Jan 2021 01:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610328990;
        bh=Khq5EFM7aNR6newsfEbYR9JdAZHlMzU7L0U/U2aH/Zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PVsmRM3hAtVCr4QwIpz6xG5lRy7EOAsELBFK2V6OOMbnmsXeiony02d7F4xL1OBiT
         eu+DSvvhKMsGYevFn1EkQ8GK4/c0RmfsNnRH02f3fHL566QQ2ztvA72f/Ie4sEabqh
         iSj2NbKwjDTjvq23S6IV1ZHdtbo5H9OSXgkUCFEwdlG7BunKs1abxbOKf24b4n8LL1
         NfnjNFldX/fU47svDDF6AtMxRuBSgVTfLCAB5H4aL7CEAWf6ojWySLWnw+BmWqIWcr
         P7nQ5ZJ0HTehzKUYYCh/APuPtF6JDmNUMd5uEdu1GWTBWn2xuu2XhWbOPVBqUqupnt
         k7xy+EsnGidVg==
Date:   Mon, 11 Jan 2021 09:36:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: fix imx8m dependencies
Message-ID: <20210111013624.GV28365@dragon>
References: <20201230151804.3862447-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230151804.3862447-1-arnd@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 04:17:51PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Selecting ARM_GIC_V3 on non-CP15 processors leads to build failures
> like
> 
> arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP1R3_EL1':
> arch/arm/include/asm/arch_gicv3.h:36:40: error: 'c12' undeclared (first use in this function)
>    36 | #define __ICC_AP1Rx(x)   __ACCESS_CP15(c12, 0, c9, x)
>       |                                        ^~~
> 
> Add a dependency to only enable the gic driver when building for
> at an ARMv7 target, which is the closes approximation to the ARMv8
> processor that is actually in this chip.
> 
> Fixes: fc40200ebf82 ("soc: imx: increase build coverage for imx8m soc driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
