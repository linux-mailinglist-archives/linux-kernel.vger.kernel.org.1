Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A082E2C45
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgLYUVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgLYUVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:21:42 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60712C06179F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:28 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id y5so4560356iow.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1T/pb/+tgIr9fcZvonDHD2VRZ4yj0/1e6p0yebFdnng=;
        b=rx5MUChtw0QssTMMO/6NXBkRhdHFLEdYh6I9oes5btq6MeO7lraComTZuZYScs9qQ8
         laZD7u6op1dEZe///vqV/YKsTBo463Zh26eZamNWDhw9RCCMPokt/5ynxK8lQdp7gjdN
         sab3Rw0ulrdVmC8COrAfLGffSIha8JuRabv0pPUHSEOk+Tf4rQjvHMCQYBTutJr7eEN0
         OQjxiBLRh5AEXGcwi8ysIULsnHo8x4M2BBl367Q2ZN35sygUP7JDVjZlqeiJgS8Bh31U
         29APC++YIbMuUTx4F/oWjZ8QVsAmL0GuCs8IYA9o8n1E7okUnIf0bWVcrjB0BNMNncDO
         ORQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1T/pb/+tgIr9fcZvonDHD2VRZ4yj0/1e6p0yebFdnng=;
        b=ME+KsJvM0mS3c7nAQUsjNHCK7OrOqQ2syhURvyxdUa1qJ5NcxMb2leDWI+XYchMK6U
         2OarcyS1wVAG50Tz31V1eZJ5bJ8UqYKg6Z/bnG6xrVOpwuCuA2Syu2EYFS3Ex34fEuRg
         6MycChtNxwT2sDatzp5qjQjPyX6jK9VFIakS9raO2zLfYQc2U9/39WTP3SvUOO3549lc
         QPV2gtSxtGUQ8bGZYM6J0UNfSUHv3KbRsNH3UoHkE6R8GWJV6t0KiPxcnaxY8nA0pnxQ
         hgrx1tLQoUdq4AoIlqgDJEY2mAMLqGVb2AVT8fgW37QVUwWAEWv9E1ZpTDFpYC2SPmu3
         FVRQ==
X-Gm-Message-State: AOAM533gCwgLkDglF6Pq9qB8790dGds5GV+irv90mjq59xTvXGXiictj
        mMoyhS3HM3GYWh3kCTA/LmXpFx0HDmpTKw==
X-Google-Smtp-Source: ABdhPJyphXzY5eD+8Lw8l6G6rhBf/rffRJbimkh2kFBCjLXAIw6gesYEQu2FDdqTQtseuNUFgIeINQ==
X-Received: by 2002:a05:6638:3006:: with SMTP id r6mr31182510jak.72.1608927627781;
        Fri, 25 Dec 2020 12:20:27 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:27 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 14/19] dyndbg+module: expose ddebug_callsites to modules
Date:   Fri, 25 Dec 2020 13:19:39 -0700
Message-Id: <20201225201944.3701590-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to drop the pointer connecting _ddebug records to _callsites,
we need to elevate the latter; we need to track it in (internal)
ddebug_tables, and set it in ddebug_add_module.  That last part
exposes it by interface to module.c, so we add a field to load_info,
and adjust load_module to initialize it from the elf section.

Its possible that this closes a hole created when __dyndbg_callsites
section was added, and wasnt handled by module load-info.  I never saw
any misbehavior loading i915.ko into a vm, but still..

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  4 ++--
 kernel/module-internal.h      |  1 +
 kernel/module.c               |  9 ++++++---
 lib/dynamic_debug.c           | 12 ++++++++----
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 49fa1390d1f8..0fcbe96736f3 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -70,8 +70,8 @@ struct _ddebug {
 /* exported for module authors to exercise >control */
 int dynamic_debug_exec_queries(const char *query, const char *modname);
 
-int ddebug_add_module(struct _ddebug *tab, unsigned int n,
-				const char *modname);
+int ddebug_add_module(struct _ddebug *tab, struct _ddebug_callsite *sites,
+		      unsigned int n, const char *modname);
 extern int ddebug_remove_module(const char *mod_name);
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
diff --git a/kernel/module-internal.h b/kernel/module-internal.h
index 33783abc377b..920b085d2a1b 100644
--- a/kernel/module-internal.h
+++ b/kernel/module-internal.h
@@ -18,6 +18,7 @@ struct load_info {
 	char *secstrings, *strtab;
 	unsigned long symoffs, stroffs, init_typeoffs, core_typeoffs;
 	struct _ddebug *debug;
+	struct _ddebug_callsite *sites;
 	unsigned int num_debug;
 	bool sig_ok;
 #ifdef CONFIG_KALLSYMS
diff --git a/kernel/module.c b/kernel/module.c
index a4fa44a652a7..876765bc666a 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2820,11 +2820,12 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 }
 #endif /* CONFIG_KALLSYMS */
 
-static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug, unsigned int num)
+static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug,
+				struct _ddebug_callsite *sites, unsigned int num)
 {
 	if (!debug)
 		return;
-	ddebug_add_module(debug, num, mod->name);
+	ddebug_add_module(debug, sites, num, mod->name);
 }
 
 static void dynamic_debug_remove(struct module *mod, struct _ddebug *debug)
@@ -3299,6 +3300,8 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 
 	info->debug = section_objs(info, "__dyndbg",
 				   sizeof(*info->debug), &info->num_debug);
+	info->sites = section_objs(info, "__dyndbg_callsites",
+				   sizeof(*info->sites), &info->num_debug);
 
 	return 0;
 }
@@ -3937,7 +3940,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		goto free_arch_cleanup;
 	}
 
-	dynamic_debug_setup(mod, info->debug, info->num_debug);
+	dynamic_debug_setup(mod, info->debug, info->sites, info->num_debug);
 
 	/* Ftrace init must be called in the MODULE_STATE_UNFORMED state */
 	ftrace_module_init(mod);
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c1a113460637..8ad9be28f38e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -49,6 +49,7 @@ struct ddebug_table {
 	const char *mod_name;
 	unsigned int num_ddebugs;
 	struct _ddebug *ddebugs;
+	struct _ddebug_callsite *sites;
 };
 
 struct ddebug_query {
@@ -1014,8 +1015,8 @@ static const struct proc_ops proc_fops = {
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
  */
-int ddebug_add_module(struct _ddebug *tab, unsigned int n,
-			     const char *name)
+int ddebug_add_module(struct _ddebug *tab, struct _ddebug_callsite *sites,
+		      unsigned int n, const char *name)
 {
 	struct ddebug_table *dt;
 
@@ -1033,6 +1034,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	dt->mod_name = name;
 	dt->num_ddebugs = n;
 	dt->ddebugs = tab;
+	dt->sites = sites;
 
 	mutex_lock(&ddebug_lock);
 	list_add(&dt->link, &ddebug_tables);
@@ -1182,7 +1184,9 @@ static int __init dynamic_debug_init(void)
 
 		if (strcmp(modname, iter->site->modname)) {
 			modct++;
-			ret = ddebug_add_module(iter_mod_start, n, modname);
+
+			ret = ddebug_add_module(iter_mod_start, site_mod_start,
+						n, modname);
 			if (ret)
 				goto out_err;
 			n = 0;
@@ -1192,7 +1196,7 @@ static int __init dynamic_debug_init(void)
 		}
 		n++;
 	}
-	ret = ddebug_add_module(iter_mod_start, n, modname);
+	ret = ddebug_add_module(iter_mod_start, site_mod_start, n, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.29.2

