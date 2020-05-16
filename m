Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351E81D60E8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 14:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgEPMuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 08:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726206AbgEPMuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:50:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE3EC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:50:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t11so2371260pgg.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Z6dDEgJ8JOKztYXxydgUej7Z//VJ8spR5lsEGk0ThA=;
        b=Wfmkk6YLVQyys3v12FMJyKSckjTTVNq2Ei/+qQ9hyv9vpR/RMpkRz/hBkEe2dapNid
         IVsTNI1hHNfkQLlg1NxoxI1q+Z51znwv+LyW1iO/OOFMr7xFIbVRNI+brXpKPjX5MENB
         ajGEQcanj1mDwOiASbV84kEpQjOwAAWYtEwcYciYO5lXsEnQl++umR+MXOwihDIY/ZPy
         nkXdGJfLwLcoiVY1YMp6m1DpPyYz3WDPDd3kwAfpdjwBaxvLfP5rejq4Se/XSGj21P/c
         5uHmd2WrY5io8clRne5suBQYEIwgcAK1+r5ZTClo6qiArJfMJSWRlr1rmwwPVMTlYqW+
         WwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Z6dDEgJ8JOKztYXxydgUej7Z//VJ8spR5lsEGk0ThA=;
        b=aFDClgh8WFRJoUNef7f7Wy+cc6XatPhZpitLOZCZuyRF71hgwv8NsFpe8QfUTvSzZF
         c+47yJ/o+kikL5OMV5gBYi39ZlfxpajnOpUizkGWrnXunIlzTvirT1tO87Eo3krMkzUP
         kxBdOy/SN9q1EzUrn6Yb6fZsFVruhfaK+Eu6w0CO2b6QNRYWZhgoVooogx13La5CRJ2G
         6oRGZW38RZek9+SV4VEH0tSnPwOUnh2hXvihAqT9Hmsk2ecrYHevSxXEs5xMbSnvhbXG
         CBeOLqAEaFcNFTrhD5jq+98OyYNXmDdpqS22wBMdrLEe+PH21mvlne3gEuOpkTx+7A25
         oFYA==
X-Gm-Message-State: AOAM532EQSu9cf0nyB4Vuuj/1LvWRCo4jRKjnDYo4mbqxpmrTKe9ED+E
        F4dMQa1EOh0gyJlXexjDQHpA+Brk
X-Google-Smtp-Source: ABdhPJwTurwJxVNlU96gRcq5LNsYIbq02ALyV5Dcv7PzRcjk9FXAX24fNayH3a4igWL0noCY6Oz53w==
X-Received: by 2002:a62:e402:: with SMTP id r2mr8634666pfh.300.1589633410908;
        Sat, 16 May 2020 05:50:10 -0700 (PDT)
Received: from localhost.localdomain (61-228-240-171.dynamic-ip.hinet.net. [61.228.240.171])
        by smtp.gmail.com with ESMTPSA id k27sm3768323pgb.30.2020.05.16.05.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 05:50:10 -0700 (PDT)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     lecopzer.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
        matthias.bgg@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, acme@kernel.org,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-mediatek@lists.infradead.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        yj.chiang@mediatek.com, Lecopzer Chen <lecopzer@gmail.com>
Subject: [PATCH 2/3] arm64: perf: Support NMI context for perf event ISR
Date:   Sat, 16 May 2020 20:48:56 +0800
Message-Id: <20200516124857.75004-3-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200516124857.75004-1-lecopzer@gmail.com>
References: <20200516124857.75004-1-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf ISR doesn't support for NMI context, thus add some necessary
condition-if to handle NMI context:

- We should not hold pmu_lock since it may have already been acquired
before NMI triggered.
- irq_work should not run at NMI context.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 arch/arm64/kernel/perf_event.c | 36 +++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 4d7879484cec..94b404509f02 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -313,6 +313,23 @@ static inline bool armv8pmu_event_is_chained(struct perf_event *event)
 	       (idx != ARMV8_IDX_CYCLE_COUNTER);
 }
 
+/*
+ * NMI Perf interrupts may be triggered during kernel holding
+ * same lock.
+ * Avoid acquiring lock again in NMI context.
+ */
+#define armv8pmu_lock(lock, flags)				\
+	do {							\
+		if (!in_nmi())					\
+			raw_spin_lock_irqsave(lock, flags);	\
+	} while (0)
+
+#define armv8pmu_unlock(lock, flags)				\
+	do {							\
+		if (!in_nmi())					\
+			raw_spin_unlock_irqrestore(lock, flags);\
+	} while (0)
+
 /*
  * ARMv8 low level PMU access
  */
@@ -589,7 +606,7 @@ static void armv8pmu_enable_event(struct perf_event *event)
 	 * Enable counter and interrupt, and set the counter to count
 	 * the event that we're interested in.
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+	armv8pmu_lock(&events->pmu_lock, flags);
 
 	/*
 	 * Disable counter
@@ -611,7 +628,7 @@ static void armv8pmu_enable_event(struct perf_event *event)
 	 */
 	armv8pmu_enable_event_counter(event);
 
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+	armv8pmu_unlock(&events->pmu_lock, flags);
 }
 
 static void armv8pmu_disable_event(struct perf_event *event)
@@ -623,7 +640,7 @@ static void armv8pmu_disable_event(struct perf_event *event)
 	/*
 	 * Disable counter and interrupt
 	 */
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+	armv8pmu_lock(&events->pmu_lock, flags);
 
 	/*
 	 * Disable counter
@@ -635,7 +652,7 @@ static void armv8pmu_disable_event(struct perf_event *event)
 	 */
 	armv8pmu_disable_event_irq(event);
 
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+	armv8pmu_unlock(&events->pmu_lock, flags);
 }
 
 static void armv8pmu_start(struct arm_pmu *cpu_pmu)
@@ -643,10 +660,10 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 	unsigned long flags;
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+	armv8pmu_lock(&events->pmu_lock, flags);
 	/* Enable all counters */
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+	armv8pmu_unlock(&events->pmu_lock, flags);
 }
 
 static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
@@ -654,10 +671,10 @@ static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
 	unsigned long flags;
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+	armv8pmu_lock(&events->pmu_lock, flags);
 	/* Disable all counters */
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+	armv8pmu_unlock(&events->pmu_lock, flags);
 }
 
 static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
@@ -722,7 +739,8 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	 * platforms that can have the PMU interrupts raised as an NMI, this
 	 * will not work.
 	 */
-	irq_work_run();
+	if (!armpmu_support_nmi())
+		irq_work_run();
 
 	return IRQ_HANDLED;
 }
-- 
2.25.1

