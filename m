Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798402E2C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgLYUU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgLYUU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:20:58 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87057C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:18 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id u12so4615586ilv.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6c+UKorNZjjREXl/5jOCfV8OMvt6QRQ1mMXkC8Ndh8=;
        b=CqFtroX1dqQJOMpjR383qhgntsFqxanqZlxa7/WLXhbLAK2o1rXAkk2MmhB2msNT4L
         cQUYytYrWISbG8ETqqkmHNpk1AXNdJyeNQS0N6xN0w8Y6juVDlrhCN4SLeenh6emge4r
         yf4uFFr3Wn2n8NEcAalVWnxC6AKesd2wa9LwBqBKlAwzdh9ETr2HEfZN5HCNjn/BOmZd
         XSF6SbMlsrbMRZStKkgehNDg8pPKmjTS3oXo5v2utxXrp3nvCeyEAQa+Xk4IougW7+B4
         WkpvL/Fny7q5ywX01JKu6JLUEx5zCj0oL6fpXyQya1S55CyhU2KZh6+NPc9J57oZjDld
         bFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6c+UKorNZjjREXl/5jOCfV8OMvt6QRQ1mMXkC8Ndh8=;
        b=PQVka7rXsqdmu26k/B1xOJrYLOxD4Nb9HG4yk1RX8Amh9xBlXAvla1JQCNWAkGvPuH
         lI/Oo1ezD7Vkq13js41F1cDxmJSGeBQ1gNG++G38bTMecZtfbf/xu/RyOKnEVbzXij73
         Hu6lPNOO7nmJGgo8iurOUQjNSYnWIDE8CE6FHVY7fuU4yIFPbzYhXX8XuaFokscvRW/U
         ppmX/yp46U9xX8a2AYZEnz5fZG3jz/1qmvTZ+T5HpZ+3qyugA+6XKPwi9vUrOpFzi8hG
         T4LyF04vU/t9btRulL3fAvtOai8laqUoCRB67yOhaxjkXcFP0LJrszeIGjNyCoHXvTz3
         vNbw==
X-Gm-Message-State: AOAM531PJA6xEBbvXDMbGPwntAYY7g4XLIv8sWmyd0rrQbkfYpJEknb9
        udwCpGVtmrfWQdNw8tE/sJE=
X-Google-Smtp-Source: ABdhPJyRte9ITMgxz5E+kD9axlPpvKWZr/YR7MtzdfszASchkvuhRKgsp8t3PZWR/FDutwz5T4CXhg==
X-Received: by 2002:a05:6e02:124e:: with SMTP id j14mr34001785ilq.284.1608927617838;
        Fri, 25 Dec 2020 12:20:17 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:17 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 02/19] dyndbg: split struct _ddebug, move display fields to new _ddebug_callsite
Date:   Fri, 25 Dec 2020 13:19:27 -0700
Message-Id: <20201225201944.3701590-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct _ddebug has 5 fields used to select/display pr_debug callsites;
move 3 of them: module, function, file to new struct _ddebug_callsite,
and add pointer from 1st to 2nd (head to body).

The format field is excluded from the move because it is always needed
for an enabled site, the others are just optional decorations, at
least from the logging perspective.  While lineno is also optional, it
can share space with flags, so it stays for density reasons.

While this increases memory footprint by 1 ptr per pr_debug, the
indirection gives several advantages:

- we can drop callsites and their storage opportunistically.

  Subsystems may not want "module:func:line:" in their logs.
  If they use format-prefixes, they can select on them,
  and don't need the site info.
  forex:
  #> echo module drm format "^drm:kms: " +p >control
  ie: dynamic_debug_exec_queries("format '^drm:kms: '", "drm");

- the moved display fields are inherently hierarchical, and the linker
  section is ordered; so (module, file, function) have repeating
  values (90%, 85%, 45%).  This is readily compressible, even with a
  simple field-wise run length encoding.  Since I'm touching this so
  deeply, I reordered the fields to match the hierarchy.

- the separate linker section sets up nice for block compression.
  we could even provide as a kernel associated 'blob', like initrd, DT

- we can allocate uncompressed storage only for enabled callsites.
  could deallocate sites on memory pressure.

- if we can rely on the linker to fill the 2 __dyndbg* sections in the
  same order, we could treat them as parallel vectors, drop the
  pointer, and store each element's index into _ddebug's padding to
  get the _callsite[N].  Do same for flags.

Whats actually done here is rather mechanical.

dynamic_debug.h:

I cut struct _ddebug in half, renamed top-half (body), dropped
__align(8) on the body (its a no-op with 8 byte pointers), and kept
the __align(8) on the head (I suspect its there for the static_key
member).  I added a forward decl for a unified comment for both head &
body, and added head.site to point at body.

DECLARE_DYNAMIC_DEBUG_METADATA does the core of the work; it declares
and initializes both static struct vars together, and refs one to the
other.

dynamic_debug.c:

dynamic_debug_init() mem-usage now also counts callsites.

dynamic_emit_prefix() & ddebug_change() use those moved fields; they
get a new initialized auto-var, and the field refs get adjusted as
needed to follow the move from one struct to the other.

   struct _ddebug_callsite *dc = dp->site;

ddebug_proc_show() differs slightly; it assigns to (not initializes)
the autovar, to avoid a panic when p == SEQ_START_TOKEN.

vmlinux.lds.h:

add __ddebug_callsites section, with the same align(8) and KEEP as
used in the __ddebug section.  RFC this is slightly out of sync with
METADATA code, and dropping align(8) on the struct itself.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |  4 +++
 include/linux/dynamic_debug.h     | 37 +++++++++++++++++---------
 lib/dynamic_debug.c               | 44 ++++++++++++++++++-------------
 3 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2b3d81b1535..1ef1efc73d20 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -340,6 +340,10 @@
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
 	. = ALIGN(8);							\
+	__start___dyndbg_callsites = .;					\
+	KEEP(*(__dyndbg_callsites))					\
+	__stop___dyndbg_callsites = .;					\
+	. = ALIGN(8);							\
 	__start___dyndbg = .;						\
 	KEEP(*(__dyndbg))						\
 	__stop___dyndbg = .;						\
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a57ee75342cf..e155dfafc4d9 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -7,20 +7,28 @@
 #endif
 
 /*
- * An instance of this structure is created in a special
- * ELF section at every dynamic debug callsite.  At runtime,
- * the special section is treated as an array of these.
+ * A pair of these structs are created in 2 special ELF sections
+ * (__dyndbg, __dyndbg_callsites) for every dynamic debug callsite.
+ * At runtime, the sections are treated as arrays.
  */
-struct _ddebug {
+struct _ddebug;
+struct _ddebug_callsite {
 	/*
-	 * These fields are used to drive the user interface
-	 * for selecting and displaying debug callsites.
+	 * These fields (and lineno) are used to:
+	 * - decorate log messages per site flags
+	 * - select callsites for modification via >control
+	 * - display callsites & settings in `cat control`
 	 */
 	const char *modname;
-	const char *function;
 	const char *filename;
+	const char *function;
+};
+
+struct _ddebug {
+	struct _ddebug_callsite *site;
+	/* format is always needed, lineno shares word with flags */
 	const char *format;
-	unsigned int lineno:18;
+	const unsigned lineno:18;
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -44,8 +52,7 @@ struct _ddebug {
 		struct static_key_false dd_key_false;
 	} key;
 #endif
-} __attribute__((aligned(8)));
-
+} __aligned(8);
 
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
@@ -83,11 +90,15 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const char *fmt, ...);
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
-	static struct _ddebug  __aligned(8)			\
-	__section("__dyndbg") name = {				\
+	static struct _ddebug_callsite  __aligned(8)		\
+	__section("__dyndbg_callsites") name##_site = {		\
 		.modname = KBUILD_MODNAME,			\
-		.function = __func__,				\
 		.filename = __FILE__,				\
+		.function = __func__,				\
+	};							\
+	static struct _ddebug  __aligned(8)			\
+	__section("__dyndbg") name = {				\
+		.site = &name##_site,				\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c70d6347afa2..fb8e0b288f89 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -165,19 +165,20 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
+			struct _ddebug_callsite *dc = dp->site;
 
 			/* match against the source filename */
 			if (query->filename &&
-			    !match_wildcard(query->filename, dp->filename) &&
+			    !match_wildcard(query->filename, dc->filename) &&
 			    !match_wildcard(query->filename,
-					   kbasename(dp->filename)) &&
+					   kbasename(dc->filename)) &&
 			    !match_wildcard(query->filename,
-					   trim_prefix(dp->filename)))
+					   trim_prefix(dc->filename)))
 				continue;
 
 			/* match against the function */
 			if (query->function &&
-			    !match_wildcard(query->function, dp->function))
+			    !match_wildcard(query->function, dc->function))
 				continue;
 
 			/* match against the format */
@@ -214,8 +215,8 @@ static int ddebug_change(const struct ddebug_query *query,
 #endif
 			dp->flags = newflags;
 			v2pr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dp->filename), dp->lineno,
-				 dt->mod_name, dp->function,
+				 trim_prefix(dc->filename), dp->lineno,
+				 dt->mod_name, dc->function,
 				 ddebug_describe_flags(dp->flags, &fbuf));
 		}
 	}
@@ -586,14 +587,15 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
+static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
+	const struct _ddebug_callsite *desc = dp->site;
 
 	*buf = '\0';
 
-	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
+	if (dp->flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
 			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
 		else
@@ -601,15 +603,15 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 					task_pid_vnr(current));
 	}
 	pos_after_tid = pos;
-	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
+	if (dp->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->modname);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
+	if (dp->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->function);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
+	if (dp->flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
-				desc->lineno);
+				dp->lineno);
 	if (pos - pos_after_tid)
 		pos += snprintf(buf + pos, remaining(pos), " ");
 	if (pos >= PREFIX_SIZE)
@@ -879,6 +881,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
+	struct _ddebug_callsite *dc;
 	struct flagsbuf flags;
 
 	if (p == SEQ_START_TOKEN) {
@@ -887,9 +890,11 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		return 0;
 	}
 
+	dc = dp->site;
+
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
-		   trim_prefix(dp->filename), dp->lineno,
-		   iter->table->mod_name, dp->function,
+		   trim_prefix(dc->filename), dp->lineno,
+		   iter->table->mod_name, dc->function,
 		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape(m, dp->format, "\t\r\n\"");
 	seq_puts(m, "\"\n");
@@ -1093,17 +1098,17 @@ static int __init dynamic_debug_init(void)
 		return 0;
 	}
 	iter = __start___dyndbg;
-	modname = iter->modname;
+	modname = iter->site->modname;
 	iter_start = iter;
 	for (; iter < __stop___dyndbg; iter++) {
 		entries++;
-		if (strcmp(modname, iter->modname)) {
+		if (strcmp(modname, iter->site->modname)) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
 			if (ret)
 				goto out_err;
 			n = 0;
-			modname = iter->modname;
+			modname = iter->site->modname;
 			iter_start = iter;
 		}
 		n++;
@@ -1113,9 +1118,10 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section\n",
+	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section, %d bytes in __dyndbg_callsites section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 (int)(entries * sizeof(struct _ddebug)));
+		 (int)(entries * sizeof(struct _ddebug)),
+		 (int)(entries * sizeof(struct _ddebug_callsite)));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.29.2

