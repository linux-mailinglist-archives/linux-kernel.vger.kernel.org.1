Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831DB2E7AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgL3Pxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:53:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgL3Pxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:53:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 702A420575;
        Wed, 30 Dec 2020 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609343570;
        bh=If92lNgtxrjJpLldr1ujm+H+dKa3tY7Be8vdNbpnWlI=;
        h=From:To:Cc:Subject:Date:From;
        b=kvc8KJK+NuLIYACrPNCNh26V7lhz6CX6jV8raDd65Z6mMaP6qVnNjBNos9r5CLyPg
         C66vtjGFOWNcrCvWi1Cb/7830Yae6XGztAUBLP68FkAw8s+8enKKZIfpAAtv1BuETO
         E6XhGL3uRBS5KuoKbz/T79r6diEbfdpYEijNH+lpim2kkUa5pXwbq364Ij/2kSQqOM
         X/OEEaljLCCQhg2Q6547K1KqzkzZVJr+81dxMib7lUjmCAMrbUsT9j7frms1nKB2JN
         WFtR4jehNhPsdLkdu/MuPrpEXHSvC7TaHxmPCUWVz3+SgWVfb5NqEHxF1dNHrqb0Au
         dlRYby8I5Bb6w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: fix Kconfig warning for i.MX SCU clk
Date:   Wed, 30 Dec 2020 16:52:25 +0100
Message-Id: <20201230155244.981757-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A previous patch introduced a harmless randconfig warning:

WARNING: unmet direct dependencies detected for MXC_CLK_SCU
  Depends on [n]: COMMON_CLK [=y] && ARCH_MXC [=n] && IMX_SCU [=y] && HAVE_ARM_SMCCC [=y]
  Selected by [m]:
  - CLK_IMX8QXP [=m] && COMMON_CLK [=y] && (ARCH_MXC [=n] && ARM64 [=y] || COMPILE_TEST [=y]) && IMX_SCU [=y] && HAVE_ARM_SMCCC [=y]

Since the symbol is now hidden and only selected by other symbols,
just remove the dependencies and require the other drivers to
get it right.

Fixes: 6247e31b7530 ("clk: imx: scu: fix MXC_CLK_SCU module build break")
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/imx/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 3061896503f3..47d9ec3abd2f 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -6,8 +6,6 @@ config MXC_CLK
 
 config MXC_CLK_SCU
 	tristate
-	depends on ARCH_MXC
-	depends on IMX_SCU && HAVE_ARM_SMCCC
 
 config CLK_IMX1
 	def_bool SOC_IMX1
-- 
2.29.2

