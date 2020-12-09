Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C742D3F25
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgLIJup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgLIJuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:50:44 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4369C0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 01:49:30 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id n7so869327pgg.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 01:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=swTJaeBCJSJ85jvGpvCNTGLd9zLi8EeqF0Ic677rVpg=;
        b=RxFi9/p86xNpYk+bgvT10A5D8Q5O4kxMzyz75yKU8o4khbCrIEWDcrKszYL97lxjj8
         qwxW4xuV0N1nn2pxp6Fu6TEnHrVA/00qzvN2jqVTVxFe02M0j+sI1+zO9bUvZylpgWsl
         6LbFuO0YAI5n0F0SrC9I1j3nYS/lNjlQZHWRDvAiqOaNieugsUFobG1kjNGj7Y6BSjBk
         cacQjbk9m9WuyhQPl/uJmJ+oyR1FPxtbRkLa84Gd4O8GELdBROCX6bbQYjlLz80fiss9
         zXqr4IEkBA4FTgM4oO6jtiWz1rn1KKVNYxMDsUOOftukQ+3a/7oh6heI9uwAC83KvmGb
         xfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=swTJaeBCJSJ85jvGpvCNTGLd9zLi8EeqF0Ic677rVpg=;
        b=MWvN3hgTYSNDFI7WIPCeaSK0J7Ilj8r6A33rAlEHvFUuUneEq1f4wbcTcnSrV1lu5g
         fIzJfL5MFnnddKvGJi6Mf6UI+0v5tUoT7BCj9ptg8+6e5Kf8prxDdkUBpkXeBkk8Ao06
         kwEGI9AJdouxT67aDIhzB46BEwTgHtuqsdwSpsaLhL4jvCwuyI9AvuC6YWqinelKRF6e
         Y6CSO6T/sobDon9H8tiyqW1C8DRV78XYdmxwvzCJmWgqCERQhuWF9MZVfaNZ1/hPRdJD
         2+ItVqIHfIBzRDUdKDH1vBJJIwOPIykt38D5hkUMCfsHtFWWtiBHkwjjwwXGgLbVXsYQ
         4o4g==
X-Gm-Message-State: AOAM530B6vwuPktdcdWTxrymq03pOmP+Q7sWQeGYNZi4uWscIlzWU1f+
        zMA7xfOwijuG4beqyPXCTUtnaA==
X-Google-Smtp-Source: ABdhPJxxFa9Co8dth0Y5535n/HOB9tOdSNShGd/e9jPuwNVWTmIZqj1EQu6nnWEdPn7oky+hRlUOPQ==
X-Received: by 2002:a62:145:0:b029:19e:a395:bd3d with SMTP id 66-20020a6201450000b029019ea395bd3dmr133559pfb.13.1607507370226;
        Wed, 09 Dec 2020 01:49:30 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 129sm1890354pfw.86.2020.12.09.01.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 01:49:29 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Pragnesh Patel <Pragnesh.patel@sifive.com>
Subject: [PATCH v7 2/5] clk: sifive: Use common name for prci configuration
Date:   Wed,  9 Dec 2020 17:49:13 +0800
Message-Id: <20201209094916.17383-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209094916.17383-1-zong.li@sifive.com>
References: <20201209094916.17383-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic name CLK_SIFIVE_PRCI instead of CLK_SIFIVE_FU540_PRCI. This
patch is prepared for fu740 support.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
Reviewed-by: Pragnesh Patel <Pragnesh.patel@sifive.com>
---
 arch/riscv/Kconfig.socs     | 2 +-
 drivers/clk/sifive/Kconfig  | 6 +++---
 drivers/clk/sifive/Makefile | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 8a55f6156661..3284d5c291be 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -5,7 +5,7 @@ config SOC_SIFIVE
 	select SERIAL_SIFIVE if TTY
 	select SERIAL_SIFIVE_CONSOLE if TTY
 	select CLK_SIFIVE
-	select CLK_SIFIVE_FU540_PRCI
+	select CLK_SIFIVE_PRCI
 	select SIFIVE_PLIC
 	help
 	  This enables support for SiFive SoC platform hardware.
diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
index f3b4eb9cb0f5..ab48cf7e0105 100644
--- a/drivers/clk/sifive/Kconfig
+++ b/drivers/clk/sifive/Kconfig
@@ -8,12 +8,12 @@ menuconfig CLK_SIFIVE
 
 if CLK_SIFIVE
 
-config CLK_SIFIVE_FU540_PRCI
-	bool "PRCI driver for SiFive FU540 SoCs"
+config CLK_SIFIVE_PRCI
+	bool "PRCI driver for SiFive SoCs"
 	select CLK_ANALOGBITS_WRPLL_CLN28HPC
 	help
 	  Supports the Power Reset Clock interface (PRCI) IP block found in
-	  FU540 SoCs.  If this kernel is meant to run on a SiFive FU540 SoC,
+	  FU540 SoCs. If this kernel is meant to run on a SiFive FU540 SoC,
 	  enable this driver.
 
 endif
diff --git a/drivers/clk/sifive/Makefile b/drivers/clk/sifive/Makefile
index 51b6ebc359e4..3074cdbc6009 100644
--- a/drivers/clk/sifive/Makefile
+++ b/drivers/clk/sifive/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_CLK_SIFIVE_FU540_PRCI)	+= sifive-prci.o fu540-prci.o
+obj-$(CONFIG_CLK_SIFIVE_PRCI)	+= sifive-prci.o fu540-prci.o
-- 
2.29.2

