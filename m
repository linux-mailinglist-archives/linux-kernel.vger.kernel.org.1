Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0C32E2C47
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgLYUVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgLYUVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:21:48 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F137C0617A4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:33 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id d9so4560718iob.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zC+Ht2zIENXV+SFFdkvZkN3YfCB+3adWEd24QuCjjvY=;
        b=NwcndUQQ1mlv5xoL/5FjUK1t9J63ERyEvAEd6U4cZDlEMKk8MQmxRKWTjtjNhZ/Exp
         F8wpdOesWda1K3lMr6f8EI0TC45jC90gENB4jYboyjxaL/o/GlfId4iuNgG9+R3PGPXp
         mv/D2u3fQyELixDR0ylpT7sFQoAsA3ztW5UJs95jip8C4E9ABl++OAxNa5VdXVU72ynd
         zS83zZ0yZhI9biWKfYD59i31FvwWvAkaNWzH1o1Qw+RWyzYpm0QcQZAQlwkbx3g9sdT6
         dUv+NubxYVYWIDV37ucV8EfOyYRZvlXW2gKpPRuL+A+EjrbxG++8CXAevffrLuLLaj4K
         KTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zC+Ht2zIENXV+SFFdkvZkN3YfCB+3adWEd24QuCjjvY=;
        b=QEcgzkWbbGn6zAu34H119Gnh6PNeoRo4ywq9zfo2w8MPIZWW+goQU2gQCrK1VinnEE
         YxRwCu79lVus3ISbHt0SzkfY8amhUTIdE7xcsAWAfN8Cq0RyGmiA7CcCjYFB9vo9kUUq
         Rcz48jpG8WOjEgL+28s/QbUGYjaHm/xVu0MeoVsAABII8gc7/p3d2awsvR4wiEBep/iI
         clE9L6+sLN+GXonxYP81KP0vkLKCX7JERS7p7b6o2ks5TRJKP3LwDFqbUQutCJO2seRv
         lGI6i2+OHbIanNeI8TSlKHEwvZ/DbKnleB6cZ/4aMp34I6jpjFTIvpfwgVcFwIN18MOn
         243A==
X-Gm-Message-State: AOAM533xWK0Ib26Ux16IkF3XWDHlXvEv/MbheVTkqakEzwwhLqjgO35f
        bmxgFCD5yTWnDdp+rwr39QE=
X-Google-Smtp-Source: ABdhPJyJNFjwDTHvA7QPi/oUC2eWRwPmF37q18ZCDcnQnFIUqhoLVKZRYoBr+rJpLyjoyvlpDJujhw==
X-Received: by 2002:a02:ce49:: with SMTP id y9mr30791232jar.59.1608927632630;
        Fri, 25 Dec 2020 12:20:32 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:31 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 19/19] dyndbg: try DEFINE_DYNAMIC_DEBUG_TABLE
Date:   Fri, 25 Dec 2020 13:19:44 -0700
Message-Id: <20201225201944.3701590-20-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test DEFINE_DYNAMIC_DEBUG_TABLE, in i915.ko, by adding an invocation
into i915_drv.c, the 1st object built in the Makefile.  This does
manually what can perhaps be done transparently in headers (hopefully).

DEFINE_DYNAMIC_DEBUG_TABLE is based on DEFINE_DYNAMIC_DEBUG_METADATA;
just like its model, it creates a pair of structs: _ddebug &
_ddebug_callsite, and inits them with format="0000", lineno=0.

This:
- identifies it clearly in control output
- appears to place it 1st in the section(s)
  it works here, at least for modprobed module
  1st-to-build might be the real reason for the sort.

drivers/gpu/drm/i915/i915_drv.c:0 [i915](null) =_ "0000"
drivers/gpu/drm/i915/gvt/gvt.c:437 [i915]intel_gvt_register_hypervisor =_ "gvt: core: Running with hypervisor %s
drivers/gpu/drm/i915/gvt/gvt.c:378 [i915]intel_gvt_init_device =_ "gvt: core: gvt device initialization is done\0

other big diff between DEFINE_DYNAMIC_DEBUG_TABLE/_METADATA:
- not static decls.
  removing static made the line appear in control output (below).
  (cuz it might be reffd elsewhere, so its linked).
  we want this.

  it also needs to be visible where DEFINE_DYNAMIC_DEBUG_METADATA is
  used, so it can be used to initialize .module_index, ie in many other
  objects where pr_debugs are coded.

A peek inside i915_drv.o looks about right; i915_site is expected at least.

Relocation section '.rela__dyndbg' at offset 0x6f48 contains 2 entries:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
000000000010  014c00000001 R_X86_64_64       0000000000000000 i915_site + 0
000000000018  001a00000001 R_X86_64_64       0000000000000000 .rodata.str1.1 + 548

Relocation section '.rela__dyndbg_callsites' at offset 0x6f90 contains 2 entries:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
000000000000  001a00000001 R_X86_64_64       0000000000000000 .rodata.str1.1 + d8
000000000008  000a00000001 R_X86_64_64       0000000000000000 .rodata.str1.8 + 110

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/i915/i915_drv.c |  3 +++
 include/linux/dynamic_debug.h   | 47 ++++++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index acc32066cec3..f2fae2a476db 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -88,6 +88,9 @@
 
 static struct drm_driver driver;
 
+DEFINE_DYNAMIC_DEBUG_TABLE(i915);
+// DEFINE_DYNAMIC_DEBUG_TABLE(THIS_MODULE);  // one alternative form
+
 static int i915_get_bridge_dev(struct drm_i915_private *dev_priv)
 {
 	int domain = pci_domain_nr(dev_priv->drm.pdev->bus);
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 0f4e703c97ee..2f3c0f35cea0 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -102,6 +102,36 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const struct ib_device *ibdev,
 			 const char *fmt, ...);
 
+/** DEFINE_DYNAMIC_DEBUG_TABLE(module)
+ *
+ * This is an analogue to DEFINE_DYNAMIC_DEBUG_METADATA()
+
+ * It's just a "callsite" whose primary purpose is to create or
+ * reserve the 0th element pair in our sub-vectors of __dyndbg[] &
+ * __dyndbg_callsites[].  The format & lineno are set to sort 1st,
+ * though I suspect our good order is more about linkage.  Either way,
+ * the TABLE is appearing 1st in control's i915 output.
+
+ * We want to use it to initialize .module_index, but I was unable to
+ * ref &module##_base by any construct I thought to try;
+ * KBUILD_MODNAME in particular didnt work.
+
+ */
+
+#define DEFINE_DYNAMIC_DEBUG_TABLE(module)		       	\
+	struct _ddebug_callsite  __aligned(8)		\
+	__section("__dyndbg_callsites") module##_site = {	\
+		.modname = KBUILD_MODNAME,			\
+		.filename = __FILE__,				\
+		.function = NULL,				\
+	};							\
+	struct _ddebug  __aligned(8)			\
+	__section("__dyndbg") module##_base = {			\
+		.site = &module##_site,				\
+		.format = "0000",			       	\
+		.lineno = 0, /* sort on mod, line */		\
+	}
+
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
 	static struct _ddebug_callsite  __aligned(8)		\
 	__section("__dyndbg_callsites") name##_site = {		\
@@ -115,23 +145,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
-		_DPRINTK_KEY_INIT				\
+		_DPRINTK_KEY_INIT,				\
+		.module_index = 0 /* want offset from _base */	\
 	}
 
-/** DEFINE_DYNAMIC_DEBUG_TABLE(module) 
-
- * It's just a "callsite" we expect not to use, except as a 0th
- * element we can use to initialize each ddebug.module_index.
- * 
- * Later, this will be adapted to initialize a pair of alternate
- * structures; analogous to structs _ddebug & _ddebug_callsite, and
- * implemented as structs unionized with them.  This pair of
- * alt-structs could supplant most or all of the function and purpose
- * of the linked list of ddebug_tables built by ddebug_add_module.
- */
-#define DEFINE_DYNAMIC_DEBUG_TABLE(module) \
-	DEFINE_DYNAMIC_DEBUG_METADATA(module, "00-1st-in-subsection")
-
 #ifdef CONFIG_JUMP_LABEL
 
 #ifdef DEBUG
-- 
2.29.2

