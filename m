Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CEE2AEE6E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgKKKG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgKKKGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:06:19 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ADBC0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:06:19 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id z3so1295404pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jUzLpOLCCQxDI0oXwDQj4vn2ea5xlcrxx/Uo+2NUKPY=;
        b=GC+wCOZXigNUTzVyZoZ5sQt0B+qGYQ1rxmobkqe9PjmIvCc/rsn/BC8H3SYZc1hh7I
         ccETM+g3YzkfkhlvzwnMVXtFwOcS9ucDcp9DLB0k6R0WOAdnNzMABEvcf5WqS0Im3vSN
         Q8DKnOqwENJeRcYAZBFf2Cm/JpxjIZlkTedy2/RlgQ0hj60kJk9yTI6lvt4enmm9Rhhq
         00HHbUlbR28KDigrln9y4ub2QAB8IT1RoQdrVL8NlXWcUK/g1VPzGDK9B1xJ0dx8NrNO
         0WrqDqiHfe0ve9o60xGs5YrUO4zAbx/BYypBao5sHykIa0P47nR/r9/I5PDEpjN94jxC
         sPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jUzLpOLCCQxDI0oXwDQj4vn2ea5xlcrxx/Uo+2NUKPY=;
        b=HfqH4xQZVKdkv3gn5ejOtBsNh4+r08AegC/TnrpO9fgBmulVwhCO0Ntp67NmZNN1CW
         OXkTnnTrCeJ7kHIVMiE96o8rrPUsST6IfGGpXa26QYmxN90S3imQ47NyIsXpBLO82h2T
         rgTa6tWzZgU4K6q7U+uHSfqdmI86yONaIy9R5C2SiVdY2gEDgiwUDrZDWPSkBrsRMzoU
         EmYktRCb8XMNCyhPliDHvH8FiZvX3WZs2tw6ehm4jb13FU+kS2748RKRvMYEf0J6x5YC
         tpdRmO1uoGTp+gKG3xOLJtHDL3X3myBHMcQ1WKDNMJbM/H0bsLzmdc7XsBL72tSX8Bxb
         MN6g==
X-Gm-Message-State: AOAM531O1ncVqdoep1J8WkMeA40LqNs+HAodoLod4cXgkvtosJamVQxp
        TZDozGTnZyMeo2FJwjGbxF/YiQ==
X-Google-Smtp-Source: ABdhPJzaTSpLq60xMn+cJpFbOkkYXEhNYIOqlqrtQTK0CvD4ZUtz6woJa+U319CNjyJImvVsb89P1A==
X-Received: by 2002:a63:e650:: with SMTP id p16mr20477838pgj.295.1605089179165;
        Wed, 11 Nov 2020 02:06:19 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id u22sm1872801pgf.24.2020.11.11.02.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 02:06:18 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Pragnesh Patel <Pragnesh.patel@sifive.com>
Subject: [PATCH v4 2/4] clk: sifive: Use common name for prci configuration
Date:   Wed, 11 Nov 2020 18:06:06 +0800
Message-Id: <20201111100608.108842-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111100608.108842-1-zong.li@sifive.com>
References: <20201111100608.108842-1-zong.li@sifive.com>
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

