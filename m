Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658962E2C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgLYUWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbgLYUWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:22:02 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424E7C0617A3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:32 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id 75so4570028ilv.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xAnZPGVZmjf0DighUoB86UBwoTmxs6bZGyJB94RIe3A=;
        b=BbhXmcaGkrLAqAcedFXDVgyYGbSo5knWgMO96x5UFhYufqEzppITFP1dzy8mjeAYV0
         Xe0szJKlWpfurEIV2guzAP1zX8ER1T7qZYl9ywYYjvoTjBu9NWatrNBYSYJGKTq+mOLG
         IiA/cFPjNpGshXB/61l+bjUYvZpuic2OG9I2i+Me9eWdAdQmXINKJjGG1IxRvxy2lwEU
         0ygYX+IO85j3KsyxWGsCpFigqtNSshxRvo/rzVXVekPTeruyuAh61iDKet5B95j/M6bZ
         4mMPCDu5GHllLLB2v9kQO1AxQ5hAzy1HQjwS3/8lMvTdZwPPELnlnL35gYGbP1c5Z4tK
         AsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xAnZPGVZmjf0DighUoB86UBwoTmxs6bZGyJB94RIe3A=;
        b=iPbiqJ7n67giAVV0SasVF+8dOmCk6ta+IwUXhEVCVq9zlA4ICjRra48wWSv5DxFtTu
         JFq2QOjnwmc2w5/uWXklu8WlTxYcrzMjgWM9v2CR1oBOG7+hi3Y839xoTu3dJJBV8YvZ
         +mAK2T0Xvhx1vnrALRkJdRbW8HBip+DJn5Hh6LkbMfMjhGr5SRM77VfdkKM3zISC1pR5
         hH17ftWMUb7VsdBNJedEk4CPbD0DOsflUX641BvpDDCQuBnWYghNziRmcqVx5mYQ3D5l
         jm66zykwCHIhZKnbZuXju43BCCU/5KgnRrBWqjM2i3av72NeY+BBuCwgHPxpad5825P2
         05Bw==
X-Gm-Message-State: AOAM532KyoNSO5Fu5QJOPhY5ZotzwY/JJWrmdP5WbYB9yiI56ZDAlCdn
        gtDXA1pfS/ltRI325iK7zo4=
X-Google-Smtp-Source: ABdhPJyRWj4Sr4AqRmspAeOJP9V6xUitL3mKT1nhyyadE1TdzNicp16nN1ww4Z//EkJ2zLqIx2te/w==
X-Received: by 2002:a05:6e02:20cc:: with SMTP id 12mr35631170ilq.91.1608927631502;
        Fri, 25 Dec 2020 12:20:31 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:30 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 18/19] dyndbg: add module_index to struct _ddebug
Date:   Fri, 25 Dec 2020 13:19:43 -0700
Message-Id: <20201225201944.3701590-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We seek to drop the pointer added when we split struct _ddebug.  This
would restore our footprint to parity worst case, with all the upsides
of callsite overhead management.

we will rely upon existing structure (and modify it):

__dyndbg[], __dyndbg_callsites[] are parallel arrays, packed in order
by the linker [*].  Together the pairs compose each prdebug's state.
Each _ddebug[].site points at the corresponding _ddebug_callsite[],
visually like a ladder.

At init we (already) iterate over __dyndbg[] & __dyndbg_callsites[],
and parse them into sub-vectors reffered/owned by ddebug_table's that
we create and collect in a list.  We also prove via BUG_ON(site_iter
!= iter->site) that the ladder is straight.

IFF we can recreate site_iter, we can drop the .site pointer.  But
site_iter is really just &__dyndbg_callsites[module_index], so we add
module_index here and now.

This doesn't finish the job.

With module_index, we can find the vector root.  Now we need a
backlink up to the sponsor/owner ddebug_table record.
This has a few steps:

1 claim space in the linkage, for a module header.
  DECLARE_DYNAMIC_DEBUG_TABLE
  a special variety of DECLARE_DYNAMIC_DEBUG_METADATA,
  sounds like it fits.
  ideally its transparent, registers with module somehow.
  linker needs to put this 1st in module's sub-vector

2 define that header - maybe something like:

  union ddebug_table_header {
  	struct ddebug_table *owner;
	struct _ddebug item;
  }
  OR
  struct ddebug_table_vector {
  	 struct ddebug_table *owner;
	 struct _ddebug vector[];
  }

So with module_index, we can go from our _ddebug element in our
sub-vector to the root, and container_of() to get the backlink up to
the ddebug_table, then down to the sites[N]

The backlink is sort-of a poor-mans list, so why not just use one ?
- we only have 2 vectors in the list
- they never change size
- we only go up one leg, and down other
- list rotation would just confuse.

Given the amount of space in a struct _ddebug (40 bytes), we might be
able to pack part or all of ddebug_table into it, share it in a union,
and avoid kmalloc'g them at all.

if DECLARE_DYNAMIC_DEBUG_TABLE can be forced into the linkage at
the front of each modules sub-section, we can probably initialize
module_index statically, and not have to do it during _init().

add DEFINE_DYNAMIC_DEBUG_TABLE(module) as a special case of:
    DEFINE_DYNAMIC_DEBUG_METADATA(module, "00-1st-in-subsection")

It's just a "callsite" we expect not to use, except as a 0th element
we can compute an offset from, to initialize each ddebug.module_index.

The next step is to get one into a module by brute force, see if it
compiles, and places this header record where we need it.
If that doesnt work, we need to fix it.

Later, this macro will be adapted to initialize a pair of alternate
structures; analogous to structs _ddebug & _ddebug_callsite, equal or
smaller in size, and implemented as structs unionized with them.  This
pair of alt-structs is big enough to contain all of ddebug_table's
fields.  For reference, the respective sizes:

A: struct _ddebug_callsite {
        /* size: 24, cachelines: 1, members: 3 */
        /* last cacheline: 24 bytes */

B: struct _ddebug {
        /* XXX 6 bits hole, try to pack */
	/* size: 40, cachelines: 1, members: 6 */
	/* sum members: 36 */
	/* sum bitfield members: 26 bits, bit holes: 1, sum bit holes: 6 bits */
	/* last cacheline: 40 bytes */

C: struct ddebug_table {
        struct list_head           link;                 /*     0    16 */
        const char  *              mod_name;             /*    16     8 */
        unsigned int               num_ddebugs;          /*    24     4 */

        /* XXX 4 bytes hole, try to pack */

        struct _ddebug *           ddebugs;              /*    32     8 */
        struct _ddebug_callsite *  sites;                /*    40     8 */

        /* size: 48, cachelines: 1, members: 5 */
        /* sum members: 44, holes: 1, sum holes: 4 */
        /* last cacheline: 48 bytes */

Clearly theres enough room in A + B to hold the contents of C.  We
will keep the pointer in A" -> B", it will get us to all the contents
there, most importantly the sites vector.

It will be interesting to see just how much can be done by linker and
static initialization.  Id be tickled if the linked list init could be
done statically, but it hardly matters; __ro_after_init (however its
spelled) would probably suffice for a solid security guarantee.

I presume its ok to have a list which is partly of items in RO memory,
but is extended at runtime, in our case when modules are (un)loaded.
If not, we can keep 2 lists, for builtin and dynamic-loaded modules
respectively.

[1] DECLARE_DYNAMIC_DEBUG_METADATA may be why 2 linker sections are
in-order; it links head->body as it "allocates" them.  If we drop the
pointer, we lose the constraint on the relative ordering.  I hope not.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 16 ++++++++++++++++
 lib/dynamic_debug.c           |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index e7b5e7664e51..0f4e703c97ee 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -63,6 +63,8 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
 	unsigned int flags:8;
+
+	unsigned module_index; /* offset from 1st in this module */
 } __aligned(8);
 
 
@@ -116,6 +118,20 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		_DPRINTK_KEY_INIT				\
 	}
 
+/** DEFINE_DYNAMIC_DEBUG_TABLE(module) 
+
+ * It's just a "callsite" we expect not to use, except as a 0th
+ * element we can use to initialize each ddebug.module_index.
+ * 
+ * Later, this will be adapted to initialize a pair of alternate
+ * structures; analogous to structs _ddebug & _ddebug_callsite, and
+ * implemented as structs unionized with them.  This pair of
+ * alt-structs could supplant most or all of the function and purpose
+ * of the linked list of ddebug_tables built by ddebug_add_module.
+ */
+#define DEFINE_DYNAMIC_DEBUG_TABLE(module) \
+	DEFINE_DYNAMIC_DEBUG_METADATA(module, "00-1st-in-subsection")
+
 #ifdef CONFIG_JUMP_LABEL
 
 #ifdef DEBUG
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ec28c113a361..90bea4909720 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1036,6 +1036,7 @@ int ddebug_add_module(struct _ddebug *tab, struct _ddebug_callsite *sites,
 		      unsigned int n, const char *name)
 {
 	struct ddebug_table *dt;
+	int i;
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
@@ -1053,6 +1054,9 @@ int ddebug_add_module(struct _ddebug *tab, struct _ddebug_callsite *sites,
 	dt->ddebugs = tab;
 	dt->sites = sites;
 
+	for (i = 0; i < n; i++)
+		tab[i].module_index = i;
+
 	mutex_lock(&ddebug_lock);
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
-- 
2.29.2

