Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73543018F2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 00:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbhAWXis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 18:38:48 -0500
Received: from foss.arm.com ([217.140.110.172]:34256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbhAWXip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 18:38:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75776152D;
        Sat, 23 Jan 2021 15:37:59 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E9D03F719;
        Sat, 23 Jan 2021 15:37:58 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 1/2] printk: Add new pr_*_deferred_once() variants
Date:   Sat, 23 Jan 2021 23:37:40 +0000
Message-Id: <20210123233741.3614408-2-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210123233741.3614408-1-qais.yousef@arm.com>
References: <20210123233741.3614408-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow users in code where printk is not allowed.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 include/linux/printk.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index fe7eb2351610..92c0978c7b44 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -480,21 +480,45 @@ extern int kptr_restrict;
 	printk_once(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
 /* no pr_cont_once, don't do that... */
 
+#define pr_emerg_deferred_once(fmt, ...)				\
+	printk_deferred_once(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_alert_deferred_once(fmt, ...)				\
+	printk_deferred_once(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_crit_deferred_once(fmt, ...)					\
+	printk_deferred_once(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_err_deferred_once(fmt, ...)					\
+	printk_deferred_once(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_warn_deferred_once(fmt, ...)					\
+	printk_deferred_once(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_notice_deferred_once(fmt, ...)				\
+	printk_deferred_once(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_info_deferred_once(fmt, ...)					\
+	printk_deferred_once(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
+/* no pr_cont_deferred_once, don't do that... */
+
 #if defined(DEBUG)
 #define pr_devel_once(fmt, ...)					\
 	printk_once(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_devel_deferred_once(fmt, ...)			\
+	printk_deferred_once(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #else
 #define pr_devel_once(fmt, ...)					\
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_devel_deferred_once(fmt, ...)			\
+	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 /* If you are writing a driver, please use dev_dbg instead */
 #if defined(DEBUG)
 #define pr_debug_once(fmt, ...)					\
 	printk_once(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_debug_deferred_once(fmt, ...)			\
+	printk_deferred_once(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #else
 #define pr_debug_once(fmt, ...)					\
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_debug_deferred_once(fmt, ...)			\
+	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 /*
-- 
2.25.1

