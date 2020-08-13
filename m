Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B082440CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 23:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHMVh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 17:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMVh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:37:28 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D1EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:37:28 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id e24so5272241pfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kh5v9NzOgE6ZjSV8Dv7b6V8OWzZH8xNDTItLXVjb8es=;
        b=oy6ixI0nWpqN7giKuYr6MjW13jqwjAvLBP/j7/OCtuDjjn0kUeSzpRa9cdSarhC5cl
         Zjg6SVQXYx4HQ4EE/Ly6X2NhQ2icTJY1w9NS2bk/FV+Lbz8CXh62xeY70J1Kqo77tLKu
         5ZTBf5+JM3CaxyjywDpKQl+gXFhb8w37lJNITkVw5CV7ZDVeJRXDTFd/9AjVU7ChGLF6
         3FtGuOHQE19oa2p2z2pCYared8ZarcYQgZ3GlHUwXOD2Jpm+6vvmvX7L/0fuBVAotlvg
         aoTpq7Tz9ZDHv2/o00kwwPO8zljbrL1H9xKEV/7nUJXwQk8yBYEfM1wWZlb4y4jwW8qb
         zlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kh5v9NzOgE6ZjSV8Dv7b6V8OWzZH8xNDTItLXVjb8es=;
        b=KDOiBcOSaHD0GpMGeC47dqri2k9O3xIrsSWfa0x70c/F9GnsyT6O1rck2WHpE6mdnv
         eW8TjoH5YLN86ZlC0b/1Y4pmB+JSfdVWOmIJBwKGS6avBl6XISpfPEDZ2HrS7F/AAN+c
         Q/7Lr7qI9W6TDOoIPz69mMREECjhi+1LHjzi1JqPcsOPH11nxP11r5azzaTzwZjwr9Zb
         E8g4YQyoqpl/w5HNvHSfGjNF8b+DO5f6TDT6g71bUS0CWk31mtHqp3my5MKwcN1TnWyc
         dHhf0yZ8Vm/kRouIKxVFlne12Sc5kUMBA44PE5rUk8uquGARKaYsO2UbRACYE9UKvk4u
         6gyw==
X-Gm-Message-State: AOAM531ta/2CdBNOxDJAAroNxGPEDQ0+nsR7IQnuIO6pbxTa0eSxszIM
        InP7KByKyqQxNq8OO49r1p9X/EE=
X-Google-Smtp-Source: ABdhPJy4f3dCu2gDUCUxucfWtpWSb2uMlTyr9hCeCtMkBe+SywFVv0vV8XAHeu/Q12OGkfdnoQLkCVU=
X-Received: by 2002:a17:90b:164a:: with SMTP id il10mr7305894pjb.2.1597354647580;
 Thu, 13 Aug 2020 14:37:27 -0700 (PDT)
Date:   Thu, 13 Aug 2020 14:37:03 -0700
In-Reply-To: <20200813172239.18ccc4f4@oasis.local.home>
Message-Id: <20200813213703.153080-1-lpy@google.com>
Mime-Version: 1.0
References: <20200813172239.18ccc4f4@oasis.local.home>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2] Add power/gpu_frequency tracepoint.
From:   Peiyong Lin <lpy@google.com>
To:     rostedt@goodmis.org
Cc:     amit.kucheria@linaro.org, android-kernel@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        lpy@google.com, mingo@redhat.com, paul.walmsley@sifive.com,
        pavel@ucw.cz, prahladk@google.com, rafael.j.wysocki@intel.com,
        ulf.hansson@linaro.org, yamada.masahiro@socionext.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
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

Changelog since v1:
 - Use %u in TP_printk

 drivers/gpu/Makefile                    |  1 +
 drivers/gpu/trace/Kconfig               |  3 +++
 drivers/gpu/trace/Makefile              |  1 +
 drivers/gpu/trace/trace_gpu_frequency.c | 13 +++++++++++++
 include/trace/events/power.h            | 25 +++++++++++++++++++++++++
 5 files changed, 43 insertions(+)
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
index 000000000000..f5af5800b52d
--- /dev/null
+++ b/drivers/gpu/trace/trace_gpu_frequency.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPU frequency trace points
+ *
+ * Copyright (C) 2020 Google, Inc.
+ */
+
+#include <linux/module.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/power.h>
+
+EXPORT_TRACEPOINT_SYMBOL(gpu_frequency);
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index af5018aa9517..c81dd2157567 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -500,6 +500,31 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
 
 	TP_ARGS(name, type, new_value)
 );
+
+/**
+ * gpu_frequency - Reports frequency changes in GPU clock domains
+ * @state:  New frequency (in KHz)
+ * @gpu_id: GPU clock domain
+ */
+TRACE_EVENT(gpu_frequency,
+
+	TP_PROTO(unsigned int state, unsigned int gpu_id),
+
+	TP_ARGS(state, gpu_id),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, state)
+		__field(unsigned int, gpu_id)
+	),
+
+	TP_fast_assign(
+		__entry->state = state;
+		__entry->gpu_id = gpu_id;
+	),
+
+	TP_printk("state=%u gpu_id=%u",
+		__entry->state, __entry->gpu_id)
+);
 #endif /* _TRACE_POWER_H */
 
 /* This part must be outside protection */
-- 
2.28.0.220.ged08abb693-goog

