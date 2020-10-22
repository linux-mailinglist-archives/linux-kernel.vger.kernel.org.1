Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97166296334
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 19:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902187AbgJVRAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2902176AbgJVQ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:59:58 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C237C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:59:57 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id w16so1290693ply.15
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wxOHue2BkzYY1LLb53+foSFWS+cuHJ2IStm1xjmkKr8=;
        b=XorHEg2YEluDRvjavJ1TN4k3tP4Wkp33EJippmVydIZGAY9YVEIw8ysV6fmRHwI3Uv
         VJ5kRay0ONmWvSdAzk/bPopkf8u+gJdb2jAKQeIAPLRQj8bHhYNX2MbABv6f3WGGpx7h
         wXNfYXqaMiG0WVfRRgcjQsqJFj52k43nWo+o8sK+/fIwAcea4HwwPGljCoPHX4TEn4Vg
         avujbvm9hfTpWwTab5+rqt2x2kqCj31TgIluF7EN2eher9yO6ycdzT775XzK5KXzizb+
         Xz9KR+nJepA5nopRUX5ilzxDZZIv5T9uNs+MpNd7/TI1UlWvnqSWlV6+O5eMlWozcIcj
         mg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wxOHue2BkzYY1LLb53+foSFWS+cuHJ2IStm1xjmkKr8=;
        b=sOHayWXelbFxr9DVXdRSLU0K3xl3ceO1Qv/2lv400nFE22OHUgTij7Kcl2V9KUoslz
         ua7OOFh2Vd5MIbMzK1zNddk75DjeHlwHgRLC7mwUCOtaTDXZT14M1X+HPM8sNPbYEsGm
         jlQbJvXs8PKBHUJP+LjaqKqnBT76z7M/zFq6gOyQ22XfRY8MAzNBJNp1kLQgh+vcOnBW
         04n6ONv/JkLt/Lg1l2NBM4Y2y8q9Rafn6kZdwmuN9G56gHCb5PJoSBOHOBJpKQ3JsmaY
         t7mEq/5RbnOMX4zHcfA3yOVW2GtcgfzRqqk1a14n5J/5fHgHY/LyIv1+3cgsVz6wJadD
         0xGg==
X-Gm-Message-State: AOAM530mZHKCQ/fhUkGIxKxsfUcR3d3YEP3s9a49n8pADpEaIqhAyMSN
        UkOUkGlsy4hoEMGvvddeDZVws2U=
X-Google-Smtp-Source: ABdhPJzbv2VAboaZicZQhOumjvmbxTeJ+Ay/Cwd/3P9WfCzy/VJ+JFHokK5N47V/bBrzfQSfQhHU7CM=
Sender: "lpy via sendgmr" <lpy@lpy-goobuntu.mtv.corp.google.com>
X-Received: from lpy-goobuntu.mtv.corp.google.com ([2620:15c:211:2:5265:f3ff:fe23:c8be])
 (user=lpy job=sendgmr) by 2002:a63:5005:: with SMTP id e5mr3151310pgb.236.1603385996862;
 Thu, 22 Oct 2020 09:59:56 -0700 (PDT)
Date:   Thu, 22 Oct 2020 09:59:40 -0700
In-Reply-To: <20200820162738.33053904@oasis.local.home>
Message-Id: <20201022165940.892305-1-lpy@google.com>
Mime-Version: 1.0
References: <20200820162738.33053904@oasis.local.home>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] Add power/gpu_frequency tracepoint.
From:   Peiyong Lin <lpy@google.com>
To:     rostedt@goodmis.org
Cc:     amit.kucheria@linaro.org, android-kernel@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        lpy@google.com, mingo@redhat.com, paul.walmsley@sifive.com,
        pavel@ucw.cz, prahladk@google.com, rafael.j.wysocki@intel.com,
        ulf.hansson@linaro.org, yamada.masahiro@socionext.com,
        zzyiwei@android.com, sidaths@google.com
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

Changelog since v3:
 - Correct copyright title.

Changelog since v2:
 - Add more comments to indicate when the event should be emitted.
 - Change state to frequency.

Changelog since v1:
 - Use %u in TP_printk

 drivers/gpu/Makefile                    |  1 +
 drivers/gpu/trace/Kconfig               |  3 +++
 drivers/gpu/trace/Makefile              |  1 +
 drivers/gpu/trace/trace_gpu_frequency.c | 13 ++++++++++
 include/trace/events/power.h            | 33 +++++++++++++++++++++++++
 5 files changed, 51 insertions(+)
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
index af5018aa9517..343825a76953 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -500,6 +500,39 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
 
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
+ * @gpu_id: Id for each GPU clock domain
+ */
+TRACE_EVENT(gpu_frequency,
+
+	TP_PROTO(unsigned int frequency, unsigned int gpu_id),
+
+	TP_ARGS(frequency, gpu_id),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, frequency)
+		__field(unsigned int, gpu_id)
+	),
+
+	TP_fast_assign(
+		__entry->frequency = frequency;
+		__entry->gpu_id = gpu_id;
+	),
+
+	TP_printk("frequency=%u gpu_id=%u",
+		__entry->frequency, __entry->gpu_id)
+);
 #endif /* _TRACE_POWER_H */
 
 /* This part must be outside protection */
-- 
2.29.0.rc1.297.gfa9743e501-goog

