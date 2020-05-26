Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089C419E88F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 04:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgDECvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Apr 2020 22:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbgDECv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 22:51:29 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B019D20842;
        Sun,  5 Apr 2020 02:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586055088;
        bh=PfUikIBTXspGc+39UOUujO6Ld9bq2yeVd1JILOFiYkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YuSeGmpBjp/c1fSbk7Q0TZwNLO1Npa80OmVBwlzh7/aPzvnP44TahOKzRBYQev36Q
         t90a1l1NBCBnayEkmkOp9w8AVk4rn5vpEJH/+5NEwHpUoeBUgL35dMGhTXZP92xUAY
         NUPPd/jlIOJG5EmNdPXZA4E8RvwUH2+wU6Q5oUmU=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 9/9] clk: Move HAVE_CLK config out of architecture layer
Date:   Sat,  4 Apr 2020 19:51:23 -0700
Message-Id: <20200405025123.154688-10-sboyd@kernel.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200405025123.154688-1-sboyd@kernel.org>
References: <20200405025123.154688-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation of 'struct clk' is not really an architectual detail
anymore now that most architectures have migrated to the common clk
framework. To sway new architecture ports away from trying to implement
their own 'struct clk', move the config next to the common clk framework
config.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/Kconfig        | 6 ------
 drivers/clk/Kconfig | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 17fe351cdde0..903ac5547ee8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -321,12 +321,6 @@ config HAVE_FUNCTION_ARG_ACCESS_API
 	  the API needed to access function arguments from pt_regs,
 	  declared in asm/ptrace.h
 
-config HAVE_CLK
-	bool
-	help
-	  The <linux/clk.h> calls support software clock gating and
-	  thus are a key power management tool on many systems.
-
 config HAVE_HW_BREAKPOINT
 	bool
 	depends on PERF_EVENTS
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 890bed62196d..6ea0631e3956 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -1,5 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
+config HAVE_CLK
+	bool
+	help
+	  The <linux/clk.h> calls support software clock gating and
+	  thus are a key power management tool on many systems.
+
 config CLKDEV_LOOKUP
 	bool
 	select HAVE_CLK
-- 
Sent by a computer, using git, on the internet

