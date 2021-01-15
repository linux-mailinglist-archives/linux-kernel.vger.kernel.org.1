Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6CC2F7BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbhAONEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387742AbhAONE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:04:28 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B46C061794
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:03:48 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id g82so2961236wmg.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jOOfDKQx1+jPnbv33agbvLGtXZ2MbhOFvMWdPLPRW0k=;
        b=Dlq9uaH+pIB75P7MKmxH+aUEe4eGD10sBNXqDWp/qunB8HR5dcReV4Z2eIviWjc/P6
         Vt9jvadWbhJp0D/aZyhiP5wGE9wQUsQOTnCiPaeWNPQtfFPRCz03VlSdmi7ysHZYwIZI
         5Xl/6HCkGZ4QSXNEmK3ER8XR4fdzYRouvHBhg/CCMlMVhbhHGQ8OiXqSWNCNhiWDwY44
         tgRMA4O3D/h+Kl1w9S9GWC/D0XgVxFyq3CcgG+q4XB7UdyoFR1t7RCDatIifBKIzb2vg
         m8QhBN3U2fPqoxqC4zcLDc26MpSEyLwLG/ezS0R+ihp/jH0mtIbqNBEKqNPZiYOjtcKL
         RM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jOOfDKQx1+jPnbv33agbvLGtXZ2MbhOFvMWdPLPRW0k=;
        b=T809UibTB0r1pul1YuRPZs3nUIgVWRAEbAw4cEXAMr0Ea8ST9ONI1uOewRQgUvJikw
         junhZ8MHo1hOcWd75lQFQCqNxvANjK3E6SKWT1mHH/f28iW4DDA8l3IjcaNyzrYPrzn9
         HjX9cdZYWRZUZK/f5K3s+PGDDXY+Z6KSU8eyAT1BdlD1O4KbDSR+XFfW8SLO5U2VeCgE
         3Xqcv0vLIhXbWbqRzhRS6cfFpJHPivyTotIIQecLxEUekaNyjJIRYfeyhwo+NDO5RZTR
         FSXQBVdUvOidI39XCjEoep1Kbh8zACCPDA575SmJIcutfeY1U738pmJOHRq0LU87tNDj
         O9kw==
X-Gm-Message-State: AOAM5324PGW+EGjqSLAjS+mZvvj/nQyGcSKX0RCVsib1A0PZEVF/WCAC
        BfnDejoEERDm26i0LonQQ4tNY02iHsGkPEi3gZtHzTdGtlUEmZAorakt9OwL5or6pIa8Jv6EVSM
        7KTyzvrmAG55ZjGO0+gRLALUoXbCGGCRoHJF7IRLbR3YQLwOQ74mzv/iqLIX7ppILkuzaWQ==
X-Google-Smtp-Source: ABdhPJxlZI7UXjDHh8f5aiGTii0hBsMm1kPklYbJotEJlDg6aIGyTVeSV+JktC6XgXB8pT4mP8GUISHL+JI=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:a1c:2c89:: with SMTP id s131mr934933wms.0.1610715826432;
 Fri, 15 Jan 2021 05:03:46 -0800 (PST)
Date:   Fri, 15 Jan 2021 14:03:34 +0100
In-Reply-To: <20210115130336.2520663-1-glider@google.com>
Message-Id: <20210115130336.2520663-4-glider@google.com>
Mime-Version: 1.0
References: <20210115130336.2520663-1-glider@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 3/5] docs: ABI: add /sys/kernel/error_report/ documentation
From:   Alexander Potapenko <glider@google.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     andreyknvl@google.com, dvyukov@google.com, mingo@redhat.com,
        elver@google.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, glider@google.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ABI documentation for files in /sys/kernel/error_report/

Requested-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Marco Elver <elver@google.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: linux-mm@kvack.org
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 .../ABI/testing/sysfs-kernel-error_report     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-error_report

diff --git a/Documentation/ABI/testing/sysfs-kernel-error_report b/Documentation/ABI/testing/sysfs-kernel-error_report
new file mode 100644
index 000000000000..666d039f93a9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-error_report
@@ -0,0 +1,41 @@
+What:		/sys/kernel/error_report/
+Date:		January 2021
+Contact:	Alexander Potapenko <glider@google.com>,
+		Marco Elver <elver@google.com>
+Description:
+		/sys/kernel/error_report/ contains two files: "report_count"
+		and "last_report". These files are used to notify userspace
+		about error reports from the enrolled kernel subsystems (those
+		that use error_report_start/error_report_end tracepoints).
+
+		"report_count" contains the current number of reported errors.
+		This number is incremented every time the error_report_end
+		trace event occurs in the kernel.
+
+		"last_report" contains the most recent error report; concurrent
+		report generation results in collection of any one report
+		("last_report" may not be the last shown on the console).
+		A "report" is everything the task had printed to the console
+		between issuing the error_report_start and error_report_end
+		trace events.
+
+		Due to sysfs limitations, the report size is truncated at
+		PAGE_SIZE. To save space, the leading info in square brackets
+		printed by CONFIG_PRINTK_TIME and CONFIG_PRINTK_CALLER is
+		trimmed from the output lines.
+
+		Both files use sysfs_notify() to notify userspace about
+		changes. Userspace programs can use poll() to block until an
+		error is reported:
+
+			pfd.fd = fd;
+			pfd.events = POLLPRI;
+			while (1) {
+				lseek(pfd.fd, 0, SEEK_SET);
+				poll(&pfd, 1, -1);
+				read(pfd.fd, buffer, PAGE_SIZE);
+				/* Process the report in @buffer. */
+			}
+
+		Files in /sys/kernel/error_report/ are available when
+		CONFIG_ERROR_REPORT_NOTIFY is enabled.
-- 
2.30.0.284.gd98b1dd5eaa7-goog

