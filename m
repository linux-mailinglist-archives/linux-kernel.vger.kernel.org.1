Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBF22C4882
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgKYTh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgKYTh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:37:26 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E13AC061A52
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:37:26 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id a19so3202558ilm.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O86fXQJwZF3Z+lAQ2ys/l1etmQM9sjCYa656aScxsN0=;
        b=Y91cU2HnzlV3IyUacvWUcd0DHPYVMQWRzlk1esFdADVkLbaYHZ97fDXOcljKMgVr27
         RZxMckKMtiM6tjkKW+0sTfdMca7Tg89NkrBpHM5fniRhO8OH3BJ3e6JMbuFQUz5+sg94
         +tP1AStwaiMz1rb5C+n+r9301TE2Xz/7Pjh9iRsyrYE9g8s5oFRgpLCLHpGYKminYEza
         bxS1XvSDnxcd4hzmqo+qyfNEfXbn2oASIQx9X+8BwZBsAmnCiCXOWWCxybabYdA9euAs
         Pz8OWVwP77WoDK5QM0nD8fotO3X10VMaUC6u4oY6wFT3BSkUSo9hryJhqnvekRyv9NkC
         vnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O86fXQJwZF3Z+lAQ2ys/l1etmQM9sjCYa656aScxsN0=;
        b=Q2vn6a6rGp4v6+DADcymSrEOWKVQqRaGrqNQwUXUC96PZn3aEvrM5AZDJJ+t8doysR
         RbdBGkyKYReeSUoWQanDR54rTsCOXCWTT4lfylFDXh7q9xp7FFUVyyXRIw6woHwaa7yz
         izRFloyQvf/PPXYxCCdgTVmv7WHYVy2K7R2zhWw6u9R6A1fhIHrqayCQD70lQHtNOEe/
         Up0djZAbzaK1SLpe5gS0lyd4TiZBKWsygQ0py/C2O2c6UUzr4cb9OFEYIVOur2U3TftI
         FIUsq/yWYoYwXhhr5fAKHdYAiCsMnaqTNSIfGR0b+WYZCm6AHIf6XY5MeipYZmgkEoeM
         myhg==
X-Gm-Message-State: AOAM532bC3HgwdqAHZ5hatjX+1FiULg//R2i7qMGEd31YwQ0f3Sq/5+6
        fVdnyFLYGiFDJP9WdsvCTIU=
X-Google-Smtp-Source: ABdhPJy9PEplra9k8ZumVveJR4DUeZ/krWOQkRZfKMvo4oJ9kcB2vkUA/M+WbmR42jeixgC5zdJIkw==
X-Received: by 2002:a92:d03:: with SMTP id 3mr4568592iln.197.1606333045518;
        Wed, 25 Nov 2020 11:37:25 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id f8sm1435548ioc.24.2020.11.25.11.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 11:37:25 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-mm@kvack.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] dyndbg: replace __dyndbg_callsite section with a zs-pool copy.
Date:   Wed, 25 Nov 2020 12:36:24 -0700
Message-Id: <20201125193626.2266995-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201125193626.2266995-1-jim.cromie@gmail.com>
References: <20201125193626.2266995-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous commit split struct _ddebugs into heads & bodies, linked
across 2 ELF sections.  Lets now copy the bodies into a zs_pool, and
relink the head to the new body.  This should allow recycling the
__dyndbg_callsite section soon.

The goal is to let a compression algo handle the repetition, and map
individual records in when needed.  I have seen 3:1 page/zspage
compression (in /sys/kernel/debug/zsmalloc/callsites)

Since dynamic_debug is nice to have but rarely used, paying more for
active logging to save in-kernel memory might be a worthwhile tradeoff.

This is how:

New ddebug_zpool_init(), at late_initcall time, creates the zpool.
Per dmesg, this is shortly after zswap is ready.

ddebug_add_module() now also calls new ddebug_zpool_add(1) foreach
callsite in the module. (1) copies the _ddebug_callsite record into
the zpool, once the zpool is ready.  For builtin modules, added in
early-boot, that zpool was not ready yet.  So ddebug_zpool_init() also
calls ddebug_zpool_add() for all those builtin modules already added
by ddebug_add_module().

New ddebug_zpool_add() does, foreach _ddebug:
 - zs_mallocs a zrec, saves handle to .zhandle,
 - zs_maps and copies callsite to it
 - zs_unmaps it, triggering write to zram
 - .site=0, detaching __dyndbg_callsites[item]
   which later triggers zs_map (.zhandle)

So we leave late-init with a full zram copy of __dyndbg_callsites
section, which is thus ready to reclaim.

ddebug_zpool_remove() undoes ddebug_zpool_add().
We call it from ddebug_remove_module().

The 3 existing users of struct _ddebug get the site ref entirely via 2
helpers, which manage the zs-mapping;

- ddebug_getsite() returns .site 1st, or maps zrec to it
  and returns it.

- ddebug_putsite() always unmaps, minimizing online ram.
  (see 1 below)

Those 3 users each take ddebug_lock around the get/puts, either
directly, or via ddebug_proc_(start|end).

ddebug_change() also gets s/continue/goto skipsite/g to cleanly unmap
the record at the bottom of the loop.

Im seeing 3:1 pages_per_zspage:

 # cut -c1-12,40-77,85-90 $SKD/zsmalloc/dyndbg_callsites/classes | head -n3
 class  sizebj_allocated   obj_used pages_used pagzspage
     0    32           0          0          0         1
     1    48        2816       2605         33         3

This much works.

Next steps:

1. dont always unmap in _put(), leave enabled pr_debugs mapped.

this is sticking point atm.

This would make the set of zs_mapped recs work like a cache, reducing
zs_mappings to a trickle, and only for <>control.

2. move key from struct _ddebug into _ddebug_callsite

key doesnt exactly fit semantically (and its not RO), but its use is
super rare, and is never needed without also needing all the other
callsite data.  Getting it out of head would save on-line ram.

But it broke in HEAD~1 when I tried it, with asm goto errors.
`grep arch_static_branch` suggests my argument to it was uniquely
complicated and dereferencing.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |   1 +
 lib/dynamic_debug.c           | 148 +++++++++++++++++++++++++++++++---
 2 files changed, 137 insertions(+), 12 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 0bf7036bcdb2..a8336b9cc011 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -34,6 +34,7 @@ struct _ddebug {
 	} key;
 #endif
 	struct _ddebug_callsite *site;
+	long unsigned int zhandle;
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c84efb4e036b..473406b069a7 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/netdevice.h>
+#include <linux/zsmalloc.h>
 
 #include <rdma/ib_verbs.h>
 
@@ -72,6 +73,8 @@ static LIST_HEAD(ddebug_tables);
 static int verbose;
 module_param(verbose, int, 0644);
 
+static struct zs_pool *dd_callsite_zpool;
+
 /* Return the path relative to source root */
 static inline const char *trim_prefix(const char *path)
 {
@@ -139,6 +142,34 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		 query->first_lineno, query->last_lineno);
 }
 
+/*
+ * ddebug_getsite - returns site, or maps it then returns it.
+ */
+static struct _ddebug_callsite* ddebug_getsite(struct _ddebug *dp)
+{
+	if (dp->site)
+		return dp->site;
+
+	dp->site = (struct _ddebug_callsite*)
+		zs_map_object(dd_callsite_zpool, dp->zhandle, ZS_MM_RO);
+
+	return dp->site;
+}
+
+/*
+ * ddebug_putsite - unmaps site, implements policy choice
+ */
+static void ddebug_putsite(struct _ddebug *dp)
+{
+	if (!dp->zhandle)
+		/* need to keep site until zmap backing exists */
+		return;
+
+	/* always unmap for now. if !pr-debug has locking issues */
+	zs_unmap_object(dd_callsite_zpool, dp->zhandle);
+	dp->site = NULL;
+}
+
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -165,7 +196,8 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
-			struct _ddebug_callsite *dc = dp->site;
+			struct _ddebug_callsite *dc;
+			dc = ddebug_getsite(dp);
 
 			/* match against the source filename */
 			if (query->filename &&
@@ -174,12 +206,12 @@ static int ddebug_change(const struct ddebug_query *query,
 					   kbasename(dc->filename)) &&
 			    !match_wildcard(query->filename,
 					   trim_prefix(dc->filename)))
-				continue;
+				goto skipsite;
 
 			/* match against the function */
 			if (query->function &&
 			    !match_wildcard(query->function, dc->function))
-				continue;
+				goto skipsite;
 
 			/* match against the format */
 			if (query->format) {
@@ -188,24 +220,24 @@ static int ddebug_change(const struct ddebug_query *query,
 					/* anchored search. match must be at beginning */
 					p = strstr(dc->format, query->format+1);
 					if (p != dc->format)
-						continue;
+						goto skipsite;
 				} else if (!strstr(dc->format, query->format))
-					continue;
+					goto skipsite;
 			}
 
 			/* match against the line number range */
 			if (query->first_lineno &&
 			    dc->lineno < query->first_lineno)
-				continue;
+				goto skipsite;
 			if (query->last_lineno &&
 			    dc->lineno > query->last_lineno)
-				continue;
+				goto skipsite;
 
 			nfound++;
 
 			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
 			if (newflags == dp->flags)
-				continue;
+				goto skipsite;
 #ifdef CONFIG_JUMP_LABEL
 			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
 				if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
@@ -218,6 +250,9 @@ static int ddebug_change(const struct ddebug_query *query,
 				 trim_prefix(dc->filename), dc->lineno,
 				 dt->mod_name, dc->function,
 				 ddebug_describe_flags(dp->flags, &fbuf));
+
+		skipsite:
+			ddebug_putsite(dp);
 		}
 	}
 	mutex_unlock(&ddebug_lock);
@@ -588,14 +623,16 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
+static char *dynamic_emit_prefix(struct _ddebug *dp, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
-	const struct _ddebug_callsite *desc = dp->site;
+	const struct _ddebug_callsite *desc;
 
 	*buf = '\0';
 
+	desc = ddebug_getsite(dp);
+
 	if (dp->flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
 			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
@@ -618,6 +655,8 @@ static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 	if (pos >= PREFIX_SIZE)
 		buf[PREFIX_SIZE - 1] = '\0';
 
+	ddebug_putsite(dp);
+
 	return buf;
 }
 
@@ -882,7 +921,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
-	struct _ddebug_callsite *dc = dp->site;
+	struct _ddebug_callsite *dc;
 	struct flagsbuf flags;
 
 	if (p == SEQ_START_TOKEN) {
@@ -891,6 +930,8 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		return 0;
 	}
 
+	dc = ddebug_getsite(dp);
+
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dc->filename), dc->lineno,
 		   iter->table->mod_name, dc->function,
@@ -898,6 +939,8 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_escape(m, dc->format, "\t\r\n\"");
 	seq_puts(m, "\"\n");
 
+	ddebug_putsite(dp);
+
 	return 0;
 }
 
@@ -941,6 +984,50 @@ static const struct proc_ops proc_fops = {
 	.proc_write = ddebug_proc_write
 };
 
+/*
+ * ddebug_zpool_add() copies the callsite into zram, saves ref in
+ * .zhandle, and forgets .site, allowing recycling of the
+ * __dyndbg_callsite[] section.
+ */
+static void ddebug_zpool_add(struct _ddebug *dp)
+{
+	unsigned long handle;
+	struct _ddebug_callsite *site;
+
+	handle = zs_malloc(dd_callsite_zpool, sizeof(struct _ddebug_callsite),
+			   GFP_KERNEL);
+	if (!handle) {
+		pr_err("pool malloc failed on %s\n", dp->site->function);
+		return;
+	}
+	dp->zhandle = handle;
+
+	site = (struct _ddebug_callsite *)
+		zs_map_object(dd_callsite_zpool, handle, ZS_MM_WO);
+
+	if (!site) {
+		pr_err("zs-map failed\n");
+		return;
+	}
+	memcpy(site, dp->site, sizeof(struct _ddebug_callsite));
+
+	/* forget __dyndbg_callsites[] so we can reclaim it */
+	dp->site = NULL;
+	zs_unmap_object(dd_callsite_zpool, handle);
+}
+
+static void ddebug_zpool_remove(struct _ddebug *dp)
+{
+	if (dp->site) {
+		pr_warn("zhandle shouldnt be mapped now\n");
+		zs_unmap_object(dd_callsite_zpool, dp->zhandle);
+	}
+	if (!dp->zhandle)
+		pr_err("zhandle already cleared !\n");
+	else
+		zs_free(dd_callsite_zpool, dp->zhandle);
+}
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -966,10 +1053,15 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	dt->ddebugs = tab;
 
 	mutex_lock(&ddebug_lock);
+	if (dd_callsite_zpool)
+		/* zpool is ready for filling late */
+		for (; n; n--, tab++)
+			ddebug_zpool_add(tab);
+
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	v2pr_info("%3u debug prints in module %s\n", n, dt->mod_name);
+	v2pr_info("%3u debug prints in module %s\n", dt->num_ddebugs, dt->mod_name);
 	return 0;
 }
 
@@ -1033,6 +1125,13 @@ int ddebug_remove_module(const char *mod_name)
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
 		if (dt->mod_name == mod_name) {
+
+			unsigned int n = dt->num_ddebugs;
+			struct _ddebug *dp = dt->ddebugs;
+
+			for (; n; n--, dp++)
+				ddebug_zpool_remove(dp);
+
 			ddebug_table_free(dt);
 			ret = 0;
 			break;
@@ -1079,6 +1178,31 @@ static int __init dynamic_debug_init_control(void)
 	return 0;
 }
 
+/*
+ * at lateinit, initialize the zpool, and fill it with copies of
+ * struct _ddebug_callsite records, in __dyndbg_callsites linker
+ * section, for the builtin modules.
+ */
+static void __init ddebug_zpool_init(void)
+{
+	struct _ddebug *iter;
+
+	/* tbd- no corresponding destroy */
+	dd_callsite_zpool = zs_create_pool("dyndbg_callsites");
+	if (!dd_callsite_zpool) {
+		pr_err("create pool failed\n");
+		return;
+	}
+
+	/* add-module normally does this, but not in time for builtins */
+	for (iter = __start___dyndbg; iter < __stop___dyndbg; iter++)
+		ddebug_zpool_add(iter);
+
+	v2pr_info("total pages: %lu compaction: %lu\n",
+		  zs_get_total_pages(dd_callsite_zpool),
+		  zs_compact(dd_callsite_zpool));
+}
+late_initcall(ddebug_zpool_init);
 
 static __initdata int alignments[4][8];
 static void bump_ct(int i, const char *p)
-- 
2.28.0

