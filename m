Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7886F1F8A23
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jun 2020 20:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgFNSgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 14:36:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34641 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNSgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 14:36:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id x18so16504824lji.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 11:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PuL2FnMQtUgOnBYBYj6Dnsh3Wx6NbJgus28c4ibq+M4=;
        b=uTD6dsRoZayMesN9F3BEYvvRYLFwRS10crmJvjIBzT0ER2keUgLTvlArzWbOkFTtfZ
         kyixDqXrGK4TDSBvgn1YVY2f7x2LO4TYbb3Ph/sHtk8WkVSk3S9VU1vgwtt0eFnxgr3p
         TEgJAS3HOBdrp4cSDriTFtgnYxR7dbAg7SfkJ7hfy7qGWej7D0fP8IRjv9qUML3HHe2A
         wnjh8QvyA2sNFd4S/9u0yRN8ACDnT9cgTGYJg8OczCMM+z6HXftqGvx0EfKuV0B/waj4
         TT9nIq9t9oT33ogR4vDCiRltvIAOAcjtAcrPDionZA+ENIG6JUw19JmMnyj2GZ7LgYnJ
         1Xwg==
X-Gm-Message-State: AOAM533d/oUuH1Eo4g8chrx+2rBXoKLOusC6M/cxQ4zeQ2tK6CppQ/MG
        JxH5T+HWmNEZcakc7QxkzqAQFFOyCvo=
X-Google-Smtp-Source: ABdhPJwSq4zNCaT5obvu+nz2FCNapkDx+1CyrKUf7CG+iiw1MrXrE9OGr/0EGQjCcqOsF5I27fazmQ==
X-Received: by 2002:a2e:9a05:: with SMTP id o5mr11024809lji.60.1592159789030;
        Sun, 14 Jun 2020 11:36:29 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id e9sm3399938ljn.61.2020.06.14.11.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 11:36:28 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] coccinelle: api: add kvfree script
Date:   Sun, 14 Jun 2020 21:36:32 +0300
Message-Id: <20200614183632.13236-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605204237.85055-1-efremov@linux.com>
References: <20200605204237.85055-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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

 scripts/coccinelle/api/kvfree.cocci | 227 ++++++++++++++++++++++++++++
 1 file changed, 227 insertions(+)
 create mode 100644 scripts/coccinelle/api/kvfree.cocci

diff --git a/scripts/coccinelle/api/kvfree.cocci b/scripts/coccinelle/api/kvfree.cocci
new file mode 100644
index 000000000000..9455f9866ad8
--- /dev/null
+++ b/scripts/coccinelle/api/kvfree.cocci
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Check that kvmalloc'ed memory is freed by kfree functions,
+/// vmalloc'ed by vfree functions and kvmalloc'ed by kvfree
+/// functions.
+///
+// Confidence: Medium
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+
+virtual patch
+virtual report
+virtual org
+virtual context
+
+@initialize:python@
+@@
+# low-level memory api
+filter = frozenset(['__vmalloc_area_node'])
+
+def relevant(p):
+    return not (filter & {el.current_element for el in p})
+
+@choice@
+expression E, E1;
+position kok, vok;
+@@
+
+(
+  if (...) {
+    ...
+    E = \(kmalloc@kok\|kzalloc@kok\|krealloc@kok\|kcalloc@kok\|
+          kmalloc_node@kok\|kzalloc_node@kok\|kmalloc_array@kok\|
+          kmalloc_array_node@kok\|kcalloc_node@kok\)(...)
+    ...
+  } else {
+    ...
+    E = \(vmalloc@vok\|vzalloc@vok\|vmalloc_user@vok\|vmalloc_node@vok\|
+          vzalloc_node@vok\|vmalloc_exec@vok\|vmalloc_32@vok\|
+          vmalloc_32_user@vok\|__vmalloc@vok\|__vmalloc_node_range@vok\|
+          __vmalloc_node@vok\)(...)
+    ...
+  }
+|
+  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+        kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(...)
+  ... when != E = E1
+      when any
+  if (\(!E\|E == NULL\)) {
+    ...
+    E = \(vmalloc@vok\|vzalloc@vok\|vmalloc_user@vok\|vmalloc_node@vok\|
+          vzalloc_node@vok\|vmalloc_exec@vok\|vmalloc_32@vok\|
+          vmalloc_32_user@vok\|__vmalloc@vok\|__vmalloc_node_range@vok\|
+          __vmalloc_node@vok\)(...)
+    ...
+  }
+)
+
+@opportunity depends on !patch@
+expression E, E1, size;
+position p : script:python() { relevant(p) };
+@@
+
+(
+* if (\(size <= E1\|size < E1\|size = E1\|size > E1\) || ...)@p {
+    ...
+    E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+          kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...)
+    ...
+  } else {
+    ...
+    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
+          vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
+          __vmalloc_node_range\|__vmalloc_node\)(..., size, ...)
+    ...
+  }
+|
+  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+        kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...)
+  ... when != E = E1
+      when != size = E1
+      when any
+* if (\(!E\|E == NULL\))@p {
+    ...
+    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
+          vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
+          __vmalloc_node_range\|__vmalloc_node\)(..., size, ...)
+    ...
+  }
+)
+
+@vfree depends on !patch@
+expression E;
+position k != choice.kok;
+position p;
+@@
+
+* E = \(kmalloc@k\|kzalloc@k\|krealloc@k\|kcalloc@k\|kmalloc_node@k\|
+        kzalloc_node@k\|kmalloc_array@k\|kmalloc_array_node@k\|
+        kcalloc_node@k\)(...)
+  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
+      when != is_vmalloc_addr(E)
+      when any
+* \(vfree\|vfree_atomic\|kvfree\)(E)@p
+
+@pvfree depends on patch exists@
+expression E;
+position k != choice.kok;
+@@
+
+  E = \(kmalloc@k\|kzalloc@k\|krealloc@k\|kcalloc@k\|kmalloc_node@k\|
+        kzalloc_node@k\|kmalloc_array@k\|kmalloc_array_node@k\|
+        kcalloc_node@k\)(...)
+  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
+      when != is_vmalloc_addr(E)
+      when any
+- \(vfree\|vfree_atomic\|kvfree\)(E)
++ kfree(E)
+
+@kfree depends on !patch@
+expression E;
+position v != choice.vok;
+position p;
+@@
+
+* E = \(vmalloc@v\|vzalloc@v\|vmalloc_user@v\|vmalloc_node@v\|vzalloc_node@v\|
+        vmalloc_exec@v\|vmalloc_32@v\|vmalloc_32_user@v\|__vmalloc@v\|
+        __vmalloc_node_range@v\|__vmalloc_node@v\)(...)
+  ... when != !is_vmalloc_addr(E)
+      when any
+* \(kfree\|kzfree\|kvfree\)(E)
+
+@pkfree depends on patch exists@
+expression E;
+position v != choice.vok;
+@@
+
+  E = \(vmalloc@v\|vzalloc@v\|vmalloc_user@v\|vmalloc_node@v\|vzalloc_node@v\|
+        vmalloc_exec@v\|vmalloc_32@v\|vmalloc_32_user@v\|__vmalloc@v\|
+        __vmalloc_node_range@v\|__vmalloc_node@v\)(...)
+  ... when != !is_vmalloc_addr(E)
+      when any
+- \(kfree\|kvfree\)(E)
++ vfree(E)
+
+@kvfree depends on !patch@
+expression E;
+position p, k;
+@@
+
+* E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
+        kvmalloc_array\)(...)@k
+  ... when != is_vmalloc_addr(E)
+      when any
+* \(kfree\|kzfree\|vfree\|vfree_atomic\)(E)@p
+
+@pkvfree depends on patch exists@
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
+@script: python depends on report@
+k << vfree.k;
+p << vfree.p;
+@@
+
+coccilib.report.print_report(p[0],
+  f"WARNING: kmalloc is used to allocate this memory at line {k[0].line}")
+
+@script: python depends on org@
+k << vfree.k;
+p << vfree.p;
+@@
+
+coccilib.org.print_todo(p[0],
+  f"WARNING: kmalloc is used to allocate this memory at line {k[0].line}")
+
+@script: python depends on report@
+v << kfree.v;
+p << kfree.p;
+@@
+
+coccilib.report.print_report(p[0],
+  f"WARNING: vmalloc is used to allocate this memory at line {v[0].line}")
+
+@script: python depends on org@
+v << kfree.v;
+p << kfree.p;
+@@
+
+coccilib.org.print_todo(p[0],
+  f"WARNING: vmalloc is used to allocate this memory at line {v[0].line}")
+
+@script: python depends on report@
+k << kvfree.k;
+p << kvfree.p;
+@@
+
+coccilib.report.print_report(p[0],
+  f"WARNING: kvmalloc is used to allocate this memory at line {k[0].line}")
+
+@script: python depends on org@
+k << kvfree.k;
+p << kvfree.p;
+@@
+
+coccilib.org.print_todo(p[0],
+  f"WARNING: kvmalloc is used to allocate this memory at line {k[0].line}")
+
+@script: python depends on report@
+p << opportunity.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: opportunity for kvmalloc")
+
+@script: python depends on org@
+p << opportunity.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING: opportunity for kvmalloc")
-- 
2.26.2

