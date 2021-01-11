Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5792F0ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 02:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbhAKBl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 20:41:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbhAKBl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 20:41:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A904C2251F;
        Mon, 11 Jan 2021 01:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610329277;
        bh=kAHJ6uYNEobDjgaOJm9STHnuZlZSHgvmiRlXkbgjj0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mi+PvlUFJ1EAsci7yG/kklI5D2/5oSgH8smxcNU/jYKKznp2K6ZteX/SfucH8EvPl
         JulPWAJ2Aync5TlJiQcSzFeQVZXYqvYFTw9F7tBtqpvnd9nvvPmI64UqqSoZbN4w0d
         6DQ9JdwkaPiSD2qqaY76VwifqcvMY7+/VoVP+ESWTCjV5fYVKC2BsbaGKdS3GupzX1
         Sl/wnATYwjtAwt25jcNVz220AXGGESYA2CZ+OewUTXeP1gFRCk5+rPDZTKJ4Es+OYF
         2BDO3QR7KHRJxtAHmqCDN/uFdOLInSed/ak/IgN3SDI8zXvBBHmQBaqN3yTDM1wGdd
         FYDsk2WoFszKg==
Date:   Mon, 11 Jan 2021 09:41:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: fix Kconfig warning for i.MX SCU clk
Message-ID: <20210111014110.GW28365@dragon>
References: <20201230155244.981757-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230155244.981757-1-arnd@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 04:52:25PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A previous patch introduced a harmless randconfig warning:
> 
> WARNING: unmet direct dependencies detected for MXC_CLK_SCU
>   Depends on [n]: COMMON_CLK [=y] && ARCH_MXC [=n] && IMX_SCU [=y] && HAVE_ARM_SMCCC [=y]
>   Selected by [m]:
>   - CLK_IMX8QXP [=m] && COMMON_CLK [=y] && (ARCH_MXC [=n] && ARM64 [=y] || COMPILE_TEST [=y]) && IMX_SCU [=y] && HAVE_ARM_SMCCC [=y]
> 
> Since the symbol is now hidden and only selected by other symbols,
> just remove the dependencies and require the other drivers to
> get it right.
> 
> Fixes: 6247e31b7530 ("clk: imx: scu: fix MXC_CLK_SCU module build break")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me.

Stephen, I assume that you will pick it up as a material for 5.11-rc.

Shawn
