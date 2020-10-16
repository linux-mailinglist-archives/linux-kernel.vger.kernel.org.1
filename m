Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25DE290041
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405233AbgJPIzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:55:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46289 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405225AbgJPIzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:55:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id v6so1876362lfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 01:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqET9rq5UxV1QJoA7trPocYpAymNdwYe4u5Sw7ENZqk=;
        b=EQ0TNBFYnvtk8GVicxOIPEX20SjufF2mh3gub6S3hKRbdlI4hwD2rv1+kZGouw3q+S
         HoADRQiCt0Kgi1IW068nq0cUqDyY9elwgp1qwwymGVDXg31lWloE1x+DHhXyCtHBnBDC
         Iav0Mf9Q2aRnFv91FeQWptig3GsE+OlPg6leAHHDATbfC8dZ5D3/dohb5+GXvAJ864x0
         GGVD7e4QZAUApMh3giB0oUS9KQcxlBSbDZ7I6RQRffFIkSVMSGGegXGi4MqfRglvp4Wp
         hyiOdg0/9eQsFNtuoBncX/WGWBQDs1IOrr6EHz75XS+sMelpuBa6X/MRwySV5/3x1qsh
         qomA==
X-Gm-Message-State: AOAM530gRQheXUyURfr8c/IE0c1ojzPrBrbZuLkloond9NfQjOGvae/D
        qP7GEhj+3faEReBXNQXrWv0=
X-Google-Smtp-Source: ABdhPJy4hfqqushixS4hdONPleRqaLq5YILjiwJg4Ho1OlUyak0TrmzOe3pOoVUh1+0Tmsq9o+sD5g==
X-Received: by 2002:ac2:4833:: with SMTP id 19mr795307lft.136.1602838512489;
        Fri, 16 Oct 2020 01:55:12 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id g9sm612889lfd.1.2020.10.16.01.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 01:55:11 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>
Subject: [PATCH v8] coccinelle: api: add kfree_mismatch script
Date:   Fri, 16 Oct 2020 11:54:42 +0300
Message-Id: <20201016085442.23299-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605204237.85055-1-efremov@linux.com>
References: <20200605204237.85055-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that alloc and free types of functions match each other.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - Lines are limited to 80 characters where possible
 - Confidence changed from High to Medium because of 
   fs/btrfs/send.c:1119 false-positive
 - __vmalloc_area_node() explicitly excluded from analysis
   instead of !(file in "mm/vmalloc.c") condition
Changes in v3:
 - prints style in org && report modes changed for python2
Changes in v4:
 - missing msg argument to print_todo fixed
Changes in v5:
 - fix position p in kfree rule
 - move @kok and @v positions in choice rule after the arguments
 - remove kvmalloc suggestions
Changes in v6:
 - more asterisks added in context mode
 - second @kok added to the choice rule
Changes in v7:
 - file renamed to kfree_mismatch.cocci
 - python function relevant() removed
 - additional rule for filtering free positions added
 - btrfs false-positive fixed
 - confidence level changed to high
 - kvfree_switch rule added
 - names for position variables changed to @a (alloc) and @f (free)
Changes in v8:
 - kzfree() replaced with kfree_sensitive()
 - "position f != free.fok;" simplified to "position f;" in patch
   and kvfree_switch rules

 scripts/coccinelle/api/kfree_mismatch.cocci | 229 ++++++++++++++++++++
 1 file changed, 229 insertions(+)
 create mode 100644 scripts/coccinelle/api/kfree_mismatch.cocci

diff --git a/scripts/coccinelle/api/kfree_mismatch.cocci b/scripts/coccinelle/api/kfree_mismatch.cocci
new file mode 100644
index 000000000000..843b794fac7b
--- /dev/null
+++ b/scripts/coccinelle/api/kfree_mismatch.cocci
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Check that kvmalloc'ed memory is freed by kfree functions,
+/// vmalloc'ed by vfree functions and kvmalloc'ed by kvfree
+/// functions.
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+
+virtual patch
+virtual report
+virtual org
+virtual context
+
+@alloc@
+expression E, E1;
+position kok, vok;
+@@
+
+(
+  if (...) {
+    ...
+    E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|
+          kmalloc_node\|kzalloc_node\|kmalloc_array\|
+          kmalloc_array_node\|kcalloc_node\)(...)@kok
+    ...
+  } else {
+    ...
+    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|
+          vzalloc_node\|vmalloc_exec\|vmalloc_32\|
+          vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|
+          __vmalloc_node\)(...)@vok
+    ...
+  }
+|
+  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+        kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(...)@kok
+  ... when != E = E1
+      when any
+  if (E == NULL) {
+    ...
+    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|
+          vzalloc_node\|vmalloc_exec\|vmalloc_32\|
+          vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|
+          __vmalloc_node\)(...)@vok
+    ...
+  }
+)
+
+@free@
+expression E;
+position fok;
+@@
+
+  E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
+        kvmalloc_array\)(...)
+  ...
+  kvfree(E)@fok
+
+@vfree depends on !patch@
+expression E;
+position a != alloc.kok;
+position f != free.fok;
+@@
+
+* E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
+*       kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
+*       kcalloc_node\)(...)@a
+  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
+      when != is_vmalloc_addr(E)
+      when any
+* \(vfree\|vfree_atomic\|kvfree\)(E)@f
+
+@depends on patch exists@
+expression E;
+position a != alloc.kok;
+position f != free.fok;
+@@
+
+  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
+        kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
+        kcalloc_node\)(...)@a
+  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
+      when != is_vmalloc_addr(E)
+      when any
+- \(vfree\|vfree_atomic\|kvfree\)(E)@f
++ kfree(E)
+
+@kfree depends on !patch@
+expression E;
+position a != alloc.vok;
+position f != free.fok;
+@@
+
+* E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
+*       vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
+*       __vmalloc_node_range\|__vmalloc_node\)(...)@a
+  ... when != is_vmalloc_addr(E)
+      when any
+* \(kfree\|kfree_sensitive\|kvfree\)(E)@f
+
+@depends on patch exists@
+expression E;
+position a != alloc.vok;
+position f != free.fok;
+@@
+
+  E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
+        vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
+        __vmalloc_node_range\|__vmalloc_node\)(...)@a
+  ... when != is_vmalloc_addr(E)
+      when any
+- \(kfree\|kvfree\)(E)@f
++ vfree(E)
+
+@kvfree depends on !patch@
+expression E;
+position a, f;
+@@
+
+* E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
+*       kvmalloc_array\)(...)@a
+  ... when != is_vmalloc_addr(E)
+      when any
+* \(kfree\|kfree_sensitive\|vfree\|vfree_atomic\)(E)@f
+
+@depends on patch exists@
+expression E;
+@@
+
+  E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
+        kvmalloc_array\)(...)
+  ... when != is_vmalloc_addr(E)
+      when any
+- \(kfree\|vfree\)(E)
++ kvfree(E)
+
+@kvfree_switch depends on !patch@
+expression alloc.E;
+position f;
+@@
+
+  ... when != is_vmalloc_addr(E)
+      when any
+* \(kfree\|kfree_sensitive\|vfree\|vfree_atomic\)(E)@f
+
+@depends on patch exists@
+expression alloc.E;
+position f;
+@@
+
+  ... when != is_vmalloc_addr(E)
+      when any
+(
+- \(kfree\|vfree\)(E)@f
++ kvfree(E)
+|
+- kfree_sensitive(E)@f
++ kvfree_sensitive(E)
+)
+
+@script: python depends on report@
+a << vfree.a;
+f << vfree.f;
+@@
+
+msg = "WARNING kmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.report.print_report(f[0], msg)
+
+@script: python depends on org@
+a << vfree.a;
+f << vfree.f;
+@@
+
+msg = "WARNING kmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.org.print_todo(f[0], msg)
+
+@script: python depends on report@
+a << kfree.a;
+f << kfree.f;
+@@
+
+msg = "WARNING vmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.report.print_report(f[0], msg)
+
+@script: python depends on org@
+a << kfree.a;
+f << kfree.f;
+@@
+
+msg = "WARNING vmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.org.print_todo(f[0], msg)
+
+@script: python depends on report@
+a << kvfree.a;
+f << kvfree.f;
+@@
+
+msg = "WARNING kvmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.report.print_report(f[0], msg)
+
+@script: python depends on org@
+a << kvfree.a;
+f << kvfree.f;
+@@
+
+msg = "WARNING kvmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.org.print_todo(f[0], msg)
+
+@script: python depends on report@
+ka << alloc.kok;
+va << alloc.vok;
+f << kvfree_switch.f;
+@@
+
+msg = "WARNING kmalloc (line %s) && vmalloc (line %s) are used to allocate this memory" % (ka[0].line, va[0].line)
+coccilib.report.print_report(f[0], msg)
+
+@script: python depends on org@
+ka << alloc.kok;
+va << alloc.vok;
+f << kvfree_switch.f;
+@@
+
+msg = "WARNING kmalloc (line %s) && vmalloc (line %s) are used to allocate this memory" % (ka[0].line, va[0].line)
+coccilib.org.print_todo(f[0], msg)
+
-- 
2.26.2

