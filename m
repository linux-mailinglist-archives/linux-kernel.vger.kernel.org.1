Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A602888B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbgJIMaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:30:03 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:33705 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733148AbgJIMaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:30:03 -0400
Received: by mail-ej1-f66.google.com with SMTP id c22so12844130ejx.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 05:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fRaeoRELBpsWNQ37QNiEdS0fcyumIsipkjeRoaRk9Gg=;
        b=GoFfPNyGCTkI+KslE2epHJo6UpfJ3mSel6arj+tWGbRmEwTs9I9ImcQx1auiPpbRE+
         /dEzUo4BcRROtZ7uN9Da5QMqgpB5zT/PJ6zn1VR0NxmM/EShRqNH3Jm+gFJBd3p27LN1
         BsKd+GjfXiVFgUTM87KhoisfpOt5i4mqx9HgSFDyVWdx3wut2s5MFoDLDyzZYjsIXaT7
         uo5UWR1VWqfxyHi8zdMdFZupFbpu8eeK5AP9L9EeJyj5fhVYCNAvIkP6QtSNfxRqwgFo
         yaF4Ym6ElRpaPxbjEQar+lJvG4WOlGA8sZLpVeGzBfsbfz/2fjE0lHS5g0qcGhnLbaei
         Bchw==
X-Gm-Message-State: AOAM531KuTpf4upZX+FvO30u//unAGIQVPV1YQr0IPIJbeSmnb8tlQr/
        bt8p6KUL8d4nk0sHOx1CAGY=
X-Google-Smtp-Source: ABdhPJyaUInLbnbytUd75cljg+DtEQjZBG9b0pHBv/+1DCpKXi0CdMML5B+6U2M5PJaxWnqY/YbJfA==
X-Received: by 2002:a17:906:c1d4:: with SMTP id bw20mr13906275ejb.91.1602246601619;
        Fri, 09 Oct 2020 05:30:01 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-85-160-42-169.eurotel.cz. [85.160.42.169])
        by smtp.gmail.com with ESMTPSA id q27sm6412701ejd.74.2020.10.09.05.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 05:30:01 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH v2 5/5] kernel: drop PREEMPT_NONE compile time option
Date:   Fri,  9 Oct 2020 14:29:26 +0200
Message-Id: <20201009122926.29962-6-mhocko@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009122926.29962-1-mhocko@kernel.org>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201009122926.29962-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Now that preempt_mode command line parameter supports both preempt_none
and preempt_voluntary we do not necessarily need a config option for
this preemption mode and we can reduce the overall config space a bit.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 kernel/Kconfig.preempt | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index e142f36dd429..e19b7d3a8d3c 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -2,23 +2,10 @@
 
 choice
 	prompt "Preemption Model"
-	default PREEMPT_NONE
-
-config PREEMPT_NONE
-	bool "No Forced Preemption (Server)"
-	help
-	  This is the traditional Linux preemption model, geared towards
-	  throughput. It will still provide good latencies most of the
-	  time, but there are no guarantees and occasional longer delays
-	  are possible.
-
-	  Select this option if you are building a kernel for a server or
-	  scientific/computation system, or if you want to maximize the
-	  raw processing power of the kernel, irrespective of scheduling
-	  latencies.
+	default PREEMPT_VOLUNTARY
 
 config PREEMPT_VOLUNTARY
-	bool "Voluntary Kernel Preemption (Desktop)"
+	bool "Voluntary Kernel Preemption (Throughput oriented workloads)"
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
@@ -35,7 +22,7 @@ config PREEMPT_VOLUNTARY
 	  Select this if you are building a kernel for a desktop system.
 
 config PREEMPT
-	bool "Preemptible Kernel (Low-Latency Desktop)"
+	bool "Preemptible Kernel (Low-Latency oriented workloads)"
 	depends on !ARCH_NO_PREEMPT
 	select PREEMPTION
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
@@ -75,7 +62,7 @@ endchoice
 
 config PREEMPT_DYNAMIC
 	bool "Allow boot time preemption model selection"
-	depends on PREEMPT_NONE || PREEMPT_VOLUNTARY
+	depends on PREEMPT_VOLUNTARY
 	help
 	  This option allows to define the preemption model on the kernel
 	  command line parameter and thus override the default preemption
-- 
2.28.0

