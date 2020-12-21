Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF3A2E016E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 21:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgLUULS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 15:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgLUULS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 15:11:18 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C53C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:10:37 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id a11so8628394qto.16
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ieaeMyCrk00dcucJz23SXmslO5kX5HWEa7JTBymav94=;
        b=nG02DRXatEl0T+ObNAeKHpzprM5RZUiynJ3nlSXAgVe7ejHfMmVCfiypzfc/S6+CIR
         Ag7h8JxZodkMPqbBAg8Ax9ANpTtB6HspKv+7Jv3gSKKC8e5oEBHVirMmhIdEVyJ3N8OB
         vpGi38KQ8KIaSiVLl8dLKVamqqDr3+lAhNtocQv9tgHQ8DLK+Qh7n21QGXOMntdP+L6B
         O931aqE2/RCoePDL8HE+s0xEzYDMFpfecJUXvPIgiuHep4g0iiPw6ICdqXkh8BEVeaev
         lTtsD3hO8CCAkp/KuJFz81MfyfhChuwOAUYBvVL/HiZkIJgZXVCTTV7w0kti99TVOLhQ
         v9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ieaeMyCrk00dcucJz23SXmslO5kX5HWEa7JTBymav94=;
        b=fjS2KOBDhg9hrJRDmTWuO1cMQYEq5XEvdy31DCyDREIjqMybvC/3eJQ3L5V0GP2swl
         jUGUtxhy1XucyXywVRhVCdG/ktXb4Wk0MBADRhz/Jar0fAdss6WgHLlMREOZZYT6llpB
         ZeqWAOslv/lC4vF1Ujdu3Q9WG5XblooQDvliVVYS3zbsAoqNydfWACf+YdtetY82J28S
         G1U0IWeriW+AV5WNMaFUPevqPHW+TGPNsHhipWipvI/rhr93xXjd1yLvWb+6hU2KaF32
         B0Y/CSYUqRclpUSwuKf+9uYBKhxxeGSwo3Emx0rcWAGYP8c+rfsBSnWXtUor5qaa6ELM
         fNJA==
X-Gm-Message-State: AOAM533afBhr/8rsHAkMcg+TokMHt9/6vvq1Nl5+RxzoIphRtY24IJpR
        Fdb1nAaukVa7CeTdpCgHbzp1KNQ=
X-Google-Smtp-Source: ABdhPJwDi4F39nO8IpSpSY+yD9ueX70Bhb48bu4T3j+rgayrwo628LEqcH2Ohc/hvQ8yzulCsHAmgdc=
Sender: "lpy via sendgmr" <lpy@lpy-goobuntu.mtv.corp.google.com>
X-Received: from lpy-goobuntu.mtv.corp.google.com ([2620:15c:211:2:5265:f3ff:fe23:c8be])
 (user=lpy job=sendgmr) by 2002:a0c:f005:: with SMTP id z5mr19352054qvk.9.1608581436781;
 Mon, 21 Dec 2020 12:10:36 -0800 (PST)
Date:   Mon, 21 Dec 2020 12:10:19 -0800
In-Reply-To: <20201202123420.g3ivr5le4imcrdsa@DESKTOP-E1NTVVP.localdomain>
Message-Id: <20201221201019.2897731-1-lpy@google.com>
Mime-Version: 1.0
References: <20201202123420.g3ivr5le4imcrdsa@DESKTOP-E1NTVVP.localdomain>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v5] Add power/gpu_frequency tracepoint.
From:   Peiyong Lin <lpy@google.com>
To:     brian.starkey@arm.com
Cc:     alexdeucher@gmail.com, android-kernel@google.com,
        dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, lpy@google.com, mingo@redhat.com,
        nd@arm.com, paul.walmsley@sifive.com, pavel@ucw.cz,
        prahladk@google.com, rafael.j.wysocki@intel.com,
        rostedt@goodmis.org, sidaths@google.com, ulf.hansson@linaro.org,
        yamada.masahiro@socionext.com, zzyiwei@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically there is no common trace event for GPU frequency, in
downstream Android each different hardware vendor implements their own
way to expose GPU frequency, for example as a debugfs node.  This patch
standardize it as a common trace event in upstream linux kernel to help
the ecosystem have a common implementation across hardware vendors.
Toolings in the Linux ecosystem will benefit from this especially in the
downstream Android, where this information is critical to graphics
developers.

Signed-off-by: Peiyong Lin <lpy@google.com>
---

Changelog since v4:
 - Explicitly use class id and instance id to identify a GPU instance.
 - Change gpu_id to clock_id to call out its the clock domain in
   the GPU instance.

Changelog since v3:
 - Correct copyright title.

Changelog since v2:
 - Add more comments to indicate when the event should be emitted.
 - Change state to frequency.

Changelog since v1:
 - Use %u in TP_printk

 drivers/gpu/Makefile                    |  1 +
 drivers/gpu/trace/Kconfig               |  3 ++
 drivers/gpu/trace/Makefile              |  1 +
 drivers/gpu/trace/trace_gpu_frequency.c | 13 ++++++++
 include/trace/events/power.h            | 41 +++++++++++++++++++++++++
 5 files changed, 59 insertions(+)
 create mode 100644 drivers/gpu/trace/trace_gpu_frequency.c

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index 835c88318cec..f289a47eb031 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
 obj-y			+= drm/ vga/
 obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
 obj-$(CONFIG_TRACE_GPU_MEM)		+= trace/
+obj-$(CONFIG_TRACE_GPU_FREQUENCY)		+= trace/
diff --git a/drivers/gpu/trace/Kconfig b/drivers/gpu/trace/Kconfig
index c24e9edd022e..ac4aec8d5845 100644
--- a/drivers/gpu/trace/Kconfig
+++ b/drivers/gpu/trace/Kconfig
@@ -2,3 +2,6 @@
 
 config TRACE_GPU_MEM
 	bool
+
+config TRACE_GPU_FREQUENCY
+	bool
diff --git a/drivers/gpu/trace/Makefile b/drivers/gpu/trace/Makefile
index b70fbdc5847f..2b7ae69327d6 100644
--- a/drivers/gpu/trace/Makefile
+++ b/drivers/gpu/trace/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_TRACE_GPU_MEM) += trace_gpu_mem.o
+obj-$(CONFIG_TRACE_GPU_FREQUENCY) += trace_gpu_frequency.o
diff --git a/drivers/gpu/trace/trace_gpu_frequency.c b/drivers/gpu/trace/trace_gpu_frequency.c
new file mode 100644
index 000000000000..668fabd6b77a
--- /dev/null
+++ b/drivers/gpu/trace/trace_gpu_frequency.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPU frequency trace points
+ *
+ * Copyright (C) 2020 Google LLC
+ */
+
+#include <linux/module.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/power.h>
+
+EXPORT_TRACEPOINT_SYMBOL(gpu_frequency);
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index af5018aa9517..590e16169dd1 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -500,6 +500,47 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
 
 	TP_ARGS(name, type, new_value)
 );
+
+/**
+ * gpu_frequency - Reports the GPU frequency in GPU clock domains.
+ *
+ * This event should be emitted whenever there's a GPU frequency change happens,
+ * or a GPU goes from idle state to active state, or vice versa.
+ *
+ * When the GPU goes from idle state to active state, this event should report
+ * the GPU frequency of the active state. When the GPU goes from active state to
+ * idle state, this event should report a zero frequency value.
+ *
+ * @frequency:  New frequency (in KHz)
+ * @gpu_class_id: Id representing the class of the GPU
+ * @gpu_instance_id: Id representing the instance of class &gpu_class_id
+ * @clock_id: Id for the clock domain in &gpu_instance_id running at &frequency
+ */
+TRACE_EVENT(gpu_frequency,
+
+	TP_PROTO(unsigned int frequency, unsigned int gpu_class_id,
+		 unsigned int gpu_instance_id, unsigned int clock_id),
+
+	TP_ARGS(frequency, gpu_class_id, gpu_instance_id, clock_id),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, frequency)
+		__field(unsigned int, gpu_class_id)
+		__field(unsigned int, gpu_instance_id)
+		__field(unsigned int, clock_id)
+	),
+
+	TP_fast_assign(
+		__entry->frequency = frequency;
+		__entry->gpu_class_id = gpu_class_id;
+		__entry->gpu_instance_id = gpu_instance_id;
+		__entry->clock_id = clock_id;
+	),
+
+	TP_printk("frequency=%u gpu_class_id=%u gpu_instance_id=%u clock_id=%u",
+		__entry->frequency, __entry->gpu_class_id,
+		__entry->gpu_instance_id, __entry->clock_id)
+);
 #endif /* _TRACE_POWER_H */
 
 /* This part must be outside protection */
-- 
2.29.2.684.gfbc64c5ab5-goog

