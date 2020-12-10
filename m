Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6EF2D60F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392194AbgLJQC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:02:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:50224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392197AbgLJQCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:02:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607616059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t2aZ9LeK4qbmwMZ5nn6HkTvPIQZLxAljGxawO4hjaJ0=;
        b=XSG7x5wiL/5KJV/jAWIejOmh18Jo/3h+Z9lFHrbSEKF1hsm2Ne9DqOxt05/50Wbtjlrdjw
        ZUOz3yC93/v3pS9NT7K2nZUuQq3Yj8OJAKvEbHN/0SSyHuQuyiW5hXi+Cv3q3iaEASswz4
        AalxNktTs7vkjvb0ndxVBzUF+CjGcDc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 338D3AF24;
        Thu, 10 Dec 2020 16:00:59 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 7/7] Test softlockup
Date:   Thu, 10 Dec 2020 17:00:38 +0100
Message-Id: <20201210160038.31441-8-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201210160038.31441-1-pmladek@suse.com>
References: <20201210160038.31441-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trigger busy loop by:
$> cat /proc/version

Stop the busy loop by:
$> cat /proc/consoles

The code also shows the first touch*watchdog() function that hides
softlockup on a "well known" location.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 fs/proc/consoles.c | 5 +++++
 fs/proc/version.c  | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index dfe6ce3505ce..213c0a209a7c 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -9,6 +9,8 @@
 #include <linux/seq_file.h>
 #include <linux/tty_driver.h>
 
+extern volatile bool proc_version_wait;
+
 /*
  * This is handler for /proc/consoles
  */
@@ -30,6 +32,9 @@ static int show_console_dev(struct seq_file *m, void *v)
 	unsigned int a;
 	dev_t dev = 0;
 
+	printk("%s: Going to break /proc/version infinite loop\n", __func__);
+	proc_version_wait = false;
+
 	if (con->device) {
 		const struct tty_driver *driver;
 		int index;
diff --git a/fs/proc/version.c b/fs/proc/version.c
index b449f186577f..15ec6a502589 100644
--- a/fs/proc/version.c
+++ b/fs/proc/version.c
@@ -6,8 +6,15 @@
 #include <linux/seq_file.h>
 #include <linux/utsname.h>
 
+volatile bool proc_version_wait;
+
 static int version_proc_show(struct seq_file *m, void *v)
 {
+	printk("%s: Going to wait until stopped\n", __func__);
+	proc_version_wait = true;
+	while (proc_version_wait)
+		cpu_relax();
+
 	seq_printf(m, linux_proc_banner,
 		utsname()->sysname,
 		utsname()->release,
-- 
2.26.2

