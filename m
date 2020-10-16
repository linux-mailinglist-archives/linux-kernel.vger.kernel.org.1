Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15662901AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405493AbgJPJSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395012AbgJPJSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:18:36 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD96CC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 02:18:36 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l18so1085272pgg.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 02:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sRaF6Mwni8+Vwf7sBaaO2gcjbQUqRqjZDqApESEWqS0=;
        b=CgtmExUWNUEU7e7SaEEmqqeZEZM11L28d+AP7kuqSmG5yFZSVxIlDqV4gUcSvKqFX7
         n3IC0WEnD1rQ5uan3+57oopZpYv0cE7nWDjW/l1BPR179a0kxYhCuPj8eFd8QpAydPY0
         LwPuHZtZPgxNAoKq8Vx5q0Db9MRQFVsx+KnLtPQvJVLzkbTMeOj8VMpg6FXOiA64x35h
         oVVXctXHgZIOM1IeIBmYaMlL+Z1+Yj7jbaqmL+4Ifzmru2nLaK0N+qn59tSXs+L+bpm/
         fNIbfqz1dwcgUfALrhMSNPE8sn6DDMwhfUM5fTK6JZZDpmoBQZdvqXk8SK2/5MHugYO7
         vCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sRaF6Mwni8+Vwf7sBaaO2gcjbQUqRqjZDqApESEWqS0=;
        b=S/rJ52w03WQXIymqMCU4zUDOZ19O7j7OJpKh8NI7lHzZNkgcJmhMsoLHEPbJlpR8Sz
         C+AS+2oTPdnSq5O1mEfjhITkfBXPj6ZDgelwGGlv2d6NeXZSmrgo3/qjuvEBE3VT86ln
         8zq7MBC4pVMm92pB35uc8LxSjMdbEgmgLgfrB7ahRKKReHv407RpflPaBCFGA5NarVYu
         NpA+bHKbn4p/UTB8R3W6j6nYp5WtU1eKeTN24kIsuNoGWVao6NEGFVlKMhPSucEZFT4S
         e1hz9ujsK8RgoFm0atJgytjpoADNUXQq5ZuiScWt9JhdwpH7nUXsFtE1rcCc+vrqfP13
         DLmA==
X-Gm-Message-State: AOAM530slGDig4Unk2tbadSsEgyksmt7RbCRRJjB0lGj5EwN1ELNTNph
        NsPhKHtWgIw1bTJ5lBUyToo9hQ==
X-Google-Smtp-Source: ABdhPJyxnrcUEp8S9lsRLnmwa+FVZoqu+DM/fPAhvhv8y9PNeFiYG6YqGB+Fq428Lw7ND66qjCBWqA==
X-Received: by 2002:a63:e057:: with SMTP id n23mr2212009pgj.87.1602839916388;
        Fri, 16 Oct 2020 02:18:36 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id h5sm2093263pfh.9.2020.10.16.02.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 02:18:35 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com, sboyd@kernel.org,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/4] clk: sifive: Use common name for prci configuration
Date:   Fri, 16 Oct 2020 17:18:24 +0800
Message-Id: <691e24d1c45a4b56b57ce1e02a04268c4253a77d.1602838910.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602838910.git.zong.li@sifive.com>
References: <cover.1602838910.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic name CLK_SIFIVE_PRCI instead of CLK_SIFIVE_FU540_PRCI. This
patch is prepared for fu740 support.

Signed-off-by: Zong Li <zong.li@sifive.com>
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
2.28.0

