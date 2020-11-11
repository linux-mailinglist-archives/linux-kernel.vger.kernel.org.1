Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E3A2AEDEB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgKKJfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbgKKJf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:35:27 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B632CC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 01:35:25 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c66so1279384pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 01:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jUzLpOLCCQxDI0oXwDQj4vn2ea5xlcrxx/Uo+2NUKPY=;
        b=UGyq1yTV49UYRiRLph02TaWZro1hVWIiT4Tk4DywL+OB71P7AOMoiNF8zcyQ4B25bg
         3aevqT98TpiAp5+XwIV1UyN7wJzO+nZikqOAlNP2B1WMvWvtqaiS8M0l2752qHJW25kN
         GWcamTWVT4wVb2fxk+gzwIe1zGK7vFnXs/tynF9G2BWlW4onBuzZzxOT4L7pX5no+767
         edU1A2k8rjNqsdPpPZyk5CTVUhDm26tTAPvWqhmlxu7sxHDmftzcXRITdsflnIv+DyAc
         o+JpWydN4tLC5jfYMR0R+MfgcdlanDbglfujs7nKqijoShFbuUhX1Ih2nd5yLgmX71BO
         6HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jUzLpOLCCQxDI0oXwDQj4vn2ea5xlcrxx/Uo+2NUKPY=;
        b=qMu+v+DibYudciBscucrHq4J/86cZNxjnTRWxmsYbHYpB4Md7njh6l+m8GTHEGvwkP
         2/KtPrW8VNrXhX0//2FhwMw//OayqycZePueXUPtyd3BFJqJSFDnF+InGxVOCwrZmwOr
         O83nm5qpbVFQxKi2JQjxJN1LuAyGSyT4tAUFHQGY/q/HAG2V2kFDx69pZai/KfLJRNq9
         q71lKEacnbV9c3ojtN5zvi7mJaciHDS42Iq2F4I39j3r6csMQDn9wpspaa2kllpJIdb6
         fZ63iVW0S1UDZ5ZkYPWF1fkE1fySabpN6x31WFQQEcvdF38E+L9a4E7it960cDvbTM07
         u9YA==
X-Gm-Message-State: AOAM531x5MmqsNPqAFeSktUReJOKCuwaFMhfrWewnxpnyUIhMluKMkmF
        4Vii02s+i83Fa8adeSjqlewejA==
X-Google-Smtp-Source: ABdhPJy1xLIajCcPrYI2GaBfqupBdYzvJLKKc4OlehU0OlQNjTpGwUNXC6B+xFGagGogFdDpTC8BKg==
X-Received: by 2002:a63:3c5b:: with SMTP id i27mr18893262pgn.268.1605087325273;
        Wed, 11 Nov 2020 01:35:25 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id m6sm1862424pfa.61.2020.11.11.01.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 01:35:24 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Pragnesh Patel <Pragnesh.patel@sifive.com>
Subject: [PATCH v3 2/3] clk: sifive: Use common name for prci configuration
Date:   Wed, 11 Nov 2020 17:35:13 +0800
Message-Id: <20201111093514.103155-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111093514.103155-1-zong.li@sifive.com>
References: <20201111093514.103155-1-zong.li@sifive.com>
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
index 627effe2ece1..fe3e2cb4c4d8 100644
--- a/drivers/clk/sifive/Makefile
+++ b/drivers/clk/sifive/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += sifive-prci.o
 
-obj-$(CONFIG_CLK_SIFIVE_FU540_PRCI)	+= fu540-prci.o
+obj-$(CONFIG_CLK_SIFIVE_PRCI)	+= fu540-prci.o
-- 
2.29.2

