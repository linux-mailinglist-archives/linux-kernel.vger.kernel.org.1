Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958102AD07B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgKJH2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgKJH2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:28:12 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBDBC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 23:28:12 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so9382692pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 23:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZPFssOBFXPN+PkDtNsUiYXjW8B02NyB9bBJ4rxKfbCc=;
        b=cfjg5xRE/zlIowskP8odmXpMLZnFM//H9xPLln3yP9fzzd8+vqIOwCqkvFuIeW74yw
         1y8sppdzbM3r4b/9aPtW7qA5dVy5P8FarUGOAVoIxalcOD6bd4G3Mx8TdXQ3nk1gCI/b
         +LO5FxLVXaFhB+XBn8vTHNYAVGZlEc7pNrRmmHd0XYlS+6Yu5D84cAIVCy8pyLgADinC
         Bn5giJ6oumBWZ9pBTmyhfU/eNTWsaqSDIYIB8XPbnXU2S5fY8IewyAMnER03V9Ojr4mR
         UVRh3p70/Zs52hiUYA9ZR0iyXabFMDkZNVIlR3X6XtLgicdIjEH9raVr4HHGFk5nNTV4
         wD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZPFssOBFXPN+PkDtNsUiYXjW8B02NyB9bBJ4rxKfbCc=;
        b=n0x/VRlpn8IA5F9Jq6B4IIkCY/g0UJZMZA5aJgHW6rVBEqTl8sZWEmInG/EWicwRXI
         swkce+jBeDLfyfilyIlsWKohTu5suRTHu4kEIVPemFPh5EBVsoq8yUxWz13AYNCyL3q3
         cMX/iqkup++MEASfS2XHyuB7KVK74JoUdXpecIyf/zgPC/2x9GmLVjW0GY/gFNi0ppcl
         Pz9m7fPxpxiHZpvKJL4XlZvHd72lTEBy27d3xxznAoKxqS+YYO11qfqiIfxK2XYIq6tR
         1ctxnZUCuzWbLL8cV9OVQlBBFCsCy3LwFiYNPp7wj02qpHRFT4zIxumMtX1Tjdappe/z
         bzFg==
X-Gm-Message-State: AOAM532uASw4qLMdY93rQz/BTkDsy/acgYsTVbnS4vttmU5g8gfN9fSw
        dmLiV7tt5YtTsMk+gVL1YHJy7w==
X-Google-Smtp-Source: ABdhPJz7FLTROBwdZkxpBd8kpEQNPBaQzHio5jHPrLvZ6LyRWGn7k/jwDec7Q3C6mvNl06pSbI/FYA==
X-Received: by 2002:a63:7e09:: with SMTP id z9mr16003742pgc.150.1604993292200;
        Mon, 09 Nov 2020 23:28:12 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id w22sm12233191pge.25.2020.11.09.23.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 23:28:11 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, yash.shah@sifive.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v2 2/3] clk: sifive: Use common name for prci configuration
Date:   Tue, 10 Nov 2020 15:27:47 +0800
Message-Id: <20201110072748.46705-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110072748.46705-1-zong.li@sifive.com>
References: <20201110072748.46705-1-zong.li@sifive.com>
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

