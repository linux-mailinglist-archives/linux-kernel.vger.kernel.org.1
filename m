Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F072A6CC6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbgKDSgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732412AbgKDSgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:36:48 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA66EC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:36:47 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id g12so23120811wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=selpDVExPrV+IgPEKGIlRfie/i9lgMV2qEZhs31ItAo=;
        b=h5c/xuFDGxhQNOOJxFYmZXPnLJyC4mt4eevQqa2BS/KDBE+R4+ZWYl3fiVp6+6GKml
         rdXluqt6BqUFOHQomC+HPz2nWSen/qcJZ0oTOtl2BKcUfsVXlAZy5wrHtufxBkAIWslB
         HCw8iLlb8kPY1W0YDvNIq7lH1izzFXSlNt9V7Ci06lt/x6qUvsjzXw6RN2ieTU+6G5qV
         /cCFrPXpeltx/hzuo9u7iu6TM54yUhX2W4sCEQjs+fR0UKJfMcmM+WiVu0qBnhnPuGND
         9WjCSGx4PewL3YT53jbPkiQxHS63x1gGFZWbB7kh0Qe68aFM4yJTGc8g1TYn/PldTPi0
         9YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=selpDVExPrV+IgPEKGIlRfie/i9lgMV2qEZhs31ItAo=;
        b=DZVU3iJjDV0K4zwFTH8c8zDFCQLGv6kgLB36tfVSeoFEw0M5zy/Tb+KKlBYapdtb2b
         I+9QXJVU5URybUW1HomtetnNsnVl8dmJN9982CSm/+F4+DQ9xszvYYImuQ0HL87Fro3E
         7qwjDsHtDZt4k1Z60Y1Yx32V98OshGaNNsGFv+ciUfsRuLYO21zjdyLbIHLZ5wOs8zwq
         TuZHQYhKtSj6qBWLExpbh9nGZ9dK4V/Xok4B7HxrXbUalRODFhhZTduW0lRw1DKICGqM
         +bfo6t3Sg4FmSu04PhPsx7T/r5GkRzq5bEo5t2YdIDJYhxoYTelHqTRtW74I6VUlXcDQ
         kMWw==
X-Gm-Message-State: AOAM533v2gHifyZp8iyre7gfHz3NzmhVp/OzHqBPZBjnbmIHKodFr2J4
        azCtQAAe2Hh/c35CKMGtjF29kp9bOvjRzySu
X-Google-Smtp-Source: ABdhPJyfkHHLx4wrmP7Kl9DrEZuORHnz2YFNiH75/raVrsXNU+mtkObCRVRsUfShJ+nawpNDAnF/uA==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr31926989wro.291.1604515006429;
        Wed, 04 Nov 2020 10:36:46 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id u15sm3719292wrm.77.2020.11.04.10.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:36:45 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [RFC PATCH 04/26] arm64: Move MAIR_EL1_SET to asm/memory.h
Date:   Wed,  4 Nov 2020 18:36:08 +0000
Message-Id: <20201104183630.27513-5-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM currently initializes MAIR_EL2 to the value of MAIR_EL1. In
preparation for initializing MAIR_EL2 before MAIR_EL1, move the constant
into a shared header file.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/memory.h | 13 +++++++++++++
 arch/arm64/mm/proc.S            | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index cd61239bae8c..aca00737e771 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -152,6 +152,19 @@
 #define MT_S2_FWB_NORMAL	6
 #define MT_S2_FWB_DEVICE_nGnRE	1
 
+/*
+ * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory and
+ * changed during __cpu_setup to Normal Tagged if the system supports MTE.
+ */
+#define MAIR_EL1_SET							\
+	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
+	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
+	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
+
 #ifdef CONFIG_ARM64_4K_PAGES
 #define IOREMAP_MAX_ORDER	(PUD_SHIFT)
 #else
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 23c326a06b2d..25ff21b3a1c6 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -45,19 +45,6 @@
 #define TCR_KASAN_FLAGS 0
 #endif
 
-/*
- * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory and
- * changed during __cpu_setup to Normal Tagged if the system supports MTE.
- */
-#define MAIR_EL1_SET							\
-	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
-	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
-	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
-	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
-	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
-	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
-	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
-
 #ifdef CONFIG_CPU_PM
 /**
  * cpu_do_suspend - save CPU registers context
-- 
2.29.1.341.ge80a0c044ae-goog

