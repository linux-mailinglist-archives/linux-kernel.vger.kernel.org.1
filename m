Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31802F4762
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbhAMJR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbhAMJRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:17:46 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691C0C061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 01:17:06 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id a17so823955qko.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 01:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Mr/4JAPGFDkrDog5eCdPJZ3B6Plu19ZsSHa5ZA4i3EU=;
        b=r3weQHC0gtQrR0xGzNuA/hpnNQ/b8L1qFXMEPJhDztRBSfpCKKg8aqzcD2gvweG1xX
         bhVRRJL2eW60Li5pcqm9iaDD+WCC0IOsj7yGFCIPvuZvnptjKFf+/cw/etzVChpW+Ppr
         KRi41FoNV+41QLJDpbhuvn+ysEd1uNkeETh7AfbkXK77Ge3qSG14jT1JdBCHqu0xdVBu
         p8xtQdk6SPVtaiUAznoc1udU3l13m64FFZE5iYXBv89QQ6alMEf/8pcAuFRYxI/JeXYu
         1fMKScIO7XwTzpsBSJslcdUJisVtHrkRniSvnOyXIUUgTrD+gFNoEkXfvI8GKOBBdjH+
         MtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Mr/4JAPGFDkrDog5eCdPJZ3B6Plu19ZsSHa5ZA4i3EU=;
        b=XtJTt94wOs5JDbKSVEcDAUwCgl/tK/ug/TglXUeBM1LCQ2ois+LWoS4Llh3/gSDzvB
         lREOAFs/V4EJLFErDEVB/IUMuX2x2BXe7GuhhNDGaP7/YORUX02hlGk/gdIcmKJbl1gI
         F3O4Fm7/XarV+xhB6P2/ZnFHCdHw9fpfGHGsWsiHwzLc4kQxHom9GEsCE6jPfKPUwDjy
         9XfDSLTQXSvDxKgvsJJydm60RDk58hvmKXFwumxhV2jbJ882Ll9AO0R1IQi3Um+BqkAv
         mtLgv1ayafv6TfyMU55BC6dC/+E7xVYtQPlf7elBvoJQESuAO9Dia9kw5D1Os3XFA/D/
         h+8w==
X-Gm-Message-State: AOAM531RjMtvxeGBeisqJsyqmulpHbGbAWjaU0NagdV3x3dABcN0P3Bd
        XlYawB47DEUZKMTGcCSigUP/uUpSfnc=
X-Google-Smtp-Source: ABdhPJzkORoQhiEB0AhKANZENrXtmJ5BzqQCHLq2xMZfujpA1ICxDYm2aFPTBBNZhxVx2vGpi346FOWwJrs=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:a0c:c583:: with SMTP id a3mr1230726qvj.15.1610529425627;
 Wed, 13 Jan 2021 01:17:05 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:16:55 +0100
In-Reply-To: <20210113091657.1456216-1-glider@google.com>
Message-Id: <20210113091657.1456216-3-glider@google.com>
Mime-Version: 1.0
References: <20210113091657.1456216-1-glider@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 2/4] lib: add error_report_notify to collect debugging tools' reports
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of various production error-detection tools, such as
MTE-based KASAN and KFENCE, the need arises to efficiently notify the
userspace OS components about kernel errors. Currently, no facility exists
to notify userspace about a kernel error from such bug-detection tools.
The problem is obviously not restricted to the above bug detection tools,
and applies to any error reporting mechanism that does not panic the
kernel; this series, however, will only add support for KASAN and KFENCE
reporting.

All such error reports appear in the kernel log. But, when such errors
occur, userspace would normally need to read the entire kernel log and
parse the relevant errors. This is error prone and inefficient, as
userspace needs to continuously monitor the kernel log for error messages.
On certain devices, this is unfortunately not acceptable. Therefore, we
need to revisit how reports are propagated to userspace.

The library added, error_report_notify (CONFIG_ERROR_REPORT_NOTIFY),
solves the above by using the error_report_start/error_report_end tracing
events and exposing the last report and the total report count to the
userspace via /sys/kernel/error_report/last_report and
/sys/kernel/error_report/report_count.

Userspace apps can call poll(POLLPRI) on those files to get notified about
the new reports without having to watch dmesg in a loop.

Suggested-by: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Marco Elver <elver@google.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: linux-mm@kvack.org
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 lib/Kconfig.debug         |  14 ++
 lib/Makefile              |   2 +
 lib/error_report_notify.c | 278 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 294 insertions(+)
 create mode 100644 lib/error_report_notify.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4b8f9e018f0f..c3f4aae9f19e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -209,6 +209,20 @@ config DEBUG_BUGVERBOSE
 	  of the BUG call as well as the EIP and oops trace.  This aids
 	  debugging but costs about 70-100K of memory.
 
+config ERROR_REPORT_NOTIFY
+	bool "Expose memory error reports to the userspace"
+	depends on TRACING
+	help
+	  When enabled, captures error reports from debugging tools (such as
+	  KFENCE or KASAN) using console tracing, and exposes reports in
+	  /sys/kernel/error_report/: the file last_report contains the last
+	  report (with maximum report length of PAGE_SIZE), and report_count,
+	  the total report count.
+
+	  Userspace programs can call poll(POLLPRI) on those files to get
+	  notified about the new reports without having to watch dmesg in a
+	  loop.
+
 endmenu # "printk and dmesg options"
 
 menu "Compile-time checks and compiler options"
diff --git a/lib/Makefile b/lib/Makefile
index afeff05fa8c5..96ed8bc0cc5b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -240,6 +240,8 @@ obj-$(CONFIG_CPU_RMAP) += cpu_rmap.o
 
 obj-$(CONFIG_DQL) += dynamic_queue_limits.o
 
+obj-$(CONFIG_ERROR_REPORT_NOTIFY) += error_report_notify.o
+
 obj-$(CONFIG_GLOB) += glob.o
 obj-$(CONFIG_GLOB_SELFTEST) += globtest.o
 
diff --git a/lib/error_report_notify.c b/lib/error_report_notify.c
new file mode 100644
index 000000000000..b0633f36ce6d
--- /dev/null
+++ b/lib/error_report_notify.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Userspace notification interface for debugging tools.
+ *
+ * Provide two sysfs files:
+ *  - /sys/kernel/error_report/last_report
+ *  - /sys/kernel/error_report/report_count
+ * that contain the last debugging tool report (taken from dmesg, delimited by
+ * the error_report_start/error_report_end tracing events) and the total report
+ * count.
+ */
+
+#include <linux/atomic.h>
+#include <linux/fs.h>
+#include <linux/kobject.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/tracepoint.h>
+#include <linux/workqueue.h>
+#include <trace/events/error_report.h>
+#include <trace/events/printk.h>
+
+static struct kobject *error_report_kobj;
+
+/* sysfs files are capped at PAGE_SIZE. */
+#define BUF_SIZE PAGE_SIZE
+/* Two buffers to store the finished report and the report being recorded. */
+static char report_buffer[2][BUF_SIZE];
+/*
+ * Total report count. Also serves as a latch for report_buffer:
+ * report_buffer[num_reports % 2] is the currently available report,
+ * report_buffer[(num_reports + 1) % 2] is the report being recorded.
+ */
+static atomic_t num_reports;
+
+/*
+ * PID of the task currently recording the report, as returned by
+ * get_encoded_pid(), or -1. Used as a writer lock for report_buffer.
+ * A regular spinlock couldn't be used here, as probe_console() can be called
+ * from any thread, and it needs to know whether that thread is holding the
+ * lock.
+ */
+static atomic_t current_pid = ATOMIC_INIT(-1);
+
+static size_t current_pos;
+static bool truncated;
+static const char TRUNC_MSG[] = "<truncated>\n";
+
+static struct delayed_work reporting_done;
+
+static void error_report_notify(struct work_struct *work)
+{
+	sysfs_notify(error_report_kobj, NULL, "last_report");
+	sysfs_notify(error_report_kobj, NULL, "report_count");
+}
+static DECLARE_DELAYED_WORK(reporting_done, error_report_notify);
+
+/*
+ * Return the current PID combined together with in_task(). This lets us
+ * distinguish between normal task context and IRQ context.
+ */
+static int get_encoded_pid(void)
+{
+	return (current->pid << 1) | (!!in_task());
+}
+
+/*
+ * Trace hook for the error_report_start event. In an unlikely case of another
+ * task already printing a report bail out, otherwise save the current pid
+ * together with in_task() return value.
+ *
+ * Because reporting code can be called from low-level routines (e.g. locking
+ * primitives or allocator guts), report recording is implemented using a
+ * seqlock lock-free algorithm.
+ */
+static void probe_report_start(void *ignore, const char *tool_name,
+			       unsigned long id)
+{
+	/*
+	 * Acquire the writer lock. Any racing probe_report_start will not
+	 * record anything. Pairs with the release in probe_report_end().
+	 */
+	if (atomic_cmpxchg_acquire(&current_pid, -1, get_encoded_pid()) != -1)
+		return;
+	current_pos = 0;
+	truncated = false;
+}
+
+/*
+ * Trace hook for the error_report_end event. If an event from the mismatching
+ * error_report_start is received, it is ignored. Otherwise, null-terminate the
+ * buffer, increase the report count (effectively releasing the report to
+ * last_report_show() and schedule a notification about a new report.
+ */
+static void probe_report_end(void *ignore, const char *tool_name,
+			     unsigned long id)
+{
+	pid_t pid = atomic_read(&current_pid);
+	int idx;
+
+	if (pid != get_encoded_pid())
+		return;
+
+	idx = (atomic_read(&num_reports) + 1) % 2;
+	if (current_pos == BUF_SIZE)
+		report_buffer[idx][current_pos - 1] = 0;
+	else
+		report_buffer[idx][current_pos] = 0;
+
+	/* Pairs with acquire in last_report_show(). */
+	atomic_inc_return_release(&num_reports);
+	schedule_delayed_work(&reporting_done, 0);
+	/*
+	 * Release the writer lock. Pairs with the acquire in
+	 * probe_report_start().
+	 */
+	atomic_set_release(&current_pid, -1);
+}
+
+/*
+ * Skip one or two leading pair of brackets containing the log timestamp and
+ * the task/CPU ID, plus the leading space, from the report line, e.g.:
+ *   [    0.698431][    T7] BUG: KFENCE: use-after-free ...
+ * becomes:
+ *   BUG: KFENCE: use-after-free ...
+ *
+ * Report size is only 4K, and this boilerplate can easily account for half of
+ * that amount.
+ */
+static void skip_extra_info(const char **buf, size_t *len)
+{
+	int num_brackets = IS_ENABLED(CONFIG_PRINTK_TIME) +
+			   IS_ENABLED(CONFIG_PRINTK_CALLER);
+	const char *found;
+
+	if (!buf || !len)
+		return;
+
+	while (num_brackets--) {
+		if (!*len || *buf[0] != '[')
+			return;
+		found = strnchr(*buf, *len, ']');
+		if (!found)
+			return;
+		*len -= found - *buf + 1;
+		*buf = found + 1;
+	}
+	if (*len && *buf[0] == ' ') {
+		++*buf;
+		--*len;
+	}
+}
+
+/*
+ * Trace hook for the console event. If a line comes from a task/CPU that did
+ * not send the error_report_start event, that line is ignored. Otherwise, it
+ * is stored in the report_buffer[(num_reports + 1) % 2].
+ *
+ * To save space, the leading timestamps and (when enabled) CPU/task info is
+ * stripped away. The buffer may contain newlines, so this procedure is
+ * repeated for every line.
+ */
+static void probe_console(void *ignore, const char *buf, size_t len)
+{
+	int pid = atomic_read(&current_pid);
+	size_t to_copy, cur_len;
+	char *newline;
+	int idx;
+
+	if (pid != get_encoded_pid() || truncated)
+		return;
+
+	idx = (atomic_read(&num_reports) + 1) % 2;
+	while (len) {
+		newline = strnchr(buf, len, '\n');
+		if (newline)
+			cur_len = newline - buf + 1;
+		else
+			cur_len = len;
+		/* Adjust len now, because skip_extra_info() may change cur_len. */
+		len -= cur_len;
+		skip_extra_info(&buf, &cur_len);
+		to_copy = min(cur_len, BUF_SIZE - current_pos);
+		memcpy(report_buffer[idx] + current_pos, buf, to_copy);
+		current_pos += to_copy;
+		if (cur_len > to_copy) {
+			truncated = true;
+			memcpy(report_buffer[idx] + current_pos - sizeof(TRUNC_MSG),
+			       TRUNC_MSG, sizeof(TRUNC_MSG));
+			break;
+		}
+		buf += cur_len;
+	}
+}
+
+static void register_tracepoints(void)
+{
+	register_trace_console(probe_console, NULL);
+	register_trace_error_report_start(probe_report_start, NULL);
+	register_trace_error_report_end(probe_report_end, NULL);
+}
+
+/*
+ * read() handler for /sys/kernel/error_report/last_report.
+ * Because the number of reports can change under our feet, check it again
+ * after copying the report, and retry if the numbers mismatch.
+ */
+static ssize_t last_report_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	ssize_t ret;
+	int index;
+
+	do {
+		/* Pairs with release in probe_report_end(). */
+		index = atomic_read_acquire(&num_reports);
+		/*
+		 * If index and old_index mismatch, we might be accessing
+		 * report_buffer concurrently with a writer thread. In that
+		 * case the read data will be discarded.
+		 */
+		ret = data_race(strscpy(buf, report_buffer[index % 2], BUF_SIZE));
+		/*
+		 * Prevent reordering between the memcpy above and the atomic
+		 * read below.
+		 * See the comments in include/linux/seqlock.h for more
+		 * details.
+		 */
+		smp_rmb();
+	} while (index != atomic_read(&num_reports));
+	return ret;
+}
+
+/*
+ * read() handler for /sys/kernel/error_report/report_count.
+ */
+static ssize_t report_count_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&num_reports));
+}
+
+static struct kobj_attribute last_report_attr = __ATTR_RO(last_report);
+static struct kobj_attribute report_count_attr = __ATTR_RO(report_count);
+static struct attribute *error_report_sysfs_attrs[] = {
+	&last_report_attr.attr,
+	&report_count_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group error_report_sysfs_attr_group = {
+	.attrs = error_report_sysfs_attrs,
+};
+
+/*
+ * Set up report notification: register tracepoints and create
+ * /sys/kernel/error_report/.
+ */
+static void error_report_notify_setup(void)
+{
+	int err;
+
+	register_tracepoints();
+	error_report_kobj = kobject_create_and_add("error_report", kernel_kobj);
+	if (!error_report_kobj)
+		goto error;
+	err = sysfs_create_group(error_report_kobj,
+				 &error_report_sysfs_attr_group);
+	if (err)
+		goto error;
+	return;
+
+error:
+	if (error_report_kobj)
+		kobject_del(error_report_kobj);
+}
+late_initcall(error_report_notify_setup);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

