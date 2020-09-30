Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA0127EE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgI3QBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:01:13 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39529 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3QBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:01:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id q8so2795129lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ycDxrhlZbMZ3QAe5FRdISwHYI96aiWhTWEOCVCIV1mY=;
        b=q24vq3BLuwmtw4rY9ioFuyFBORNNqsm6tH2/5ws2zv8rkSaOQEqmqMlJrU0NI9YM9j
         eBNLufvdlHJ+JsSWH05LWy3VDG+eJRzOmSUc5fecJatEnhRvE8FFBzJ/xYrJtLVzfOun
         0UCxhOH+efV+Y9a5fNPFKG9YX9oqT/i+rBXIhPcdmOTQ3JL0dH3r6LUcCr+5eVhDVItv
         mdyU5U5hrxQET+Qr1rBdRurpiZ8Oes7r6BImA/x4lH0tpDq2gCpt2YfiiIXQI5H+uKn4
         uUmxiiT5i9b3Zc3RS6Hoxo6EBzHQDE4s4YQTD4nk8GBZxFwAlvAhLvo0YSzKr442LiTC
         Rc1Q==
X-Gm-Message-State: AOAM533VV8T9rcV+HpcrYjY3qXJRZTG3Uo8ppJQinYV2XpN2T8IXsY63
        nZr44Vb9T3je8vE6DMwsLxY=
X-Google-Smtp-Source: ABdhPJyxotBYkge4LIgChQyvbG7H74KmdrtQx+Ra7kF49AzbAQIBUykQKgNZodD/EQEl9gN/s+J4sw==
X-Received: by 2002:a19:614b:: with SMTP id m11mr1222865lfk.6.1601481667344;
        Wed, 30 Sep 2020 09:01:07 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id c1sm194909ljd.105.2020.09.30.09.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 09:01:06 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     julia.lawall@inria.fr
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] coccinelle: api: add kvmalloc script
Date:   Wed, 30 Sep 2020 19:00:46 +0300
Message-Id: <20200930160046.726661-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200804063245.8383-1-efremov@linux.com>
References: <20200804063245.8383-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggest kvmalloc, kvfree instead of opencoded patterns.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - binary operator cmp added
 - NULL comparisions simplified
 - "T x" case added to !patch mode
Changes in v3:
 - kvfree rules added
Changes in v4:
 - pattern updated to match only GFP_KERNEL/__GFP_NOWARN flags
   to avoid possible false-positives

All patches are sent:
[1] https://lore.kernel.org/patchwork/patch/1296428/
[2] https://lore.kernel.org/patchwork/patch/1296636/
[3] https://lore.kernel.org/patchwork/patch/1282895/
[4] https://lore.kernel.org/patchwork/patch/1296631/

 scripts/coccinelle/api/kvmalloc.cocci | 256 ++++++++++++++++++++++++++
 1 file changed, 256 insertions(+)
 create mode 100644 scripts/coccinelle/api/kvmalloc.cocci

diff --git a/scripts/coccinelle/api/kvmalloc.cocci b/scripts/coccinelle/api/kvmalloc.cocci
new file mode 100644
index 000000000000..c30dab718a49
--- /dev/null
+++ b/scripts/coccinelle/api/kvmalloc.cocci
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Find if/else condition with kmalloc/vmalloc calls.
+/// Suggest to use kvmalloc instead. Same for kvfree.
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
+@initialize:python@
+@@
+filter = frozenset(['kvfree'])
+
+def relevant(p):
+    return not (filter & {el.current_element for el in p})
+
+@kvmalloc depends on !patch@
+expression E, E1, size;
+identifier flags;
+binary operator cmp = {<=, <, ==, >, >=};
+identifier x;
+type T;
+position p;
+@@
+
+(
+* if (size cmp E1 || ...)@p {
+    ...
+*    E = \(kmalloc\|kzalloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+*          kmalloc_array\|kmalloc_array_node\|kcalloc_node\)
+*          (..., size, \(flags\|GFP_KERNEL\|\(GFP_KERNEL\|flags\)|__GFP_NOWARN\), ...)
+    ...
+  } else {
+    ...
+*    E = \(vmalloc\|vzalloc\|vmalloc_node\|vzalloc_node\)(..., size, ...)
+    ...
+  }
+|
+* E = \(kmalloc\|kzalloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+*       kmalloc_array\|kmalloc_array_node\|kcalloc_node\)
+*       (..., size, \(flags\|GFP_KERNEL\|\(GFP_KERNEL\|flags\)|__GFP_NOWARN\), ...)
+  ... when != E = E1
+      when != size = E1
+      when any
+* if (E == NULL)@p {
+    ...
+*   E = \(vmalloc\|vzalloc\|vmalloc_node\|vzalloc_node\)(..., size, ...)
+    ...
+  }
+|
+* T x = \(kmalloc\|kzalloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+*         kmalloc_array\|kmalloc_array_node\|kcalloc_node\)
+*         (..., size, \(flags\|GFP_KERNEL\|\(GFP_KERNEL\|flags\)|__GFP_NOWARN\), ...);
+  ... when != x = E1
+      when != size = E1
+      when any
+* if (x == NULL)@p {
+    ...
+*   x = \(vmalloc\|vzalloc\|vmalloc_node\|vzalloc_node\)(..., size, ...)
+    ...
+  }
+)
+
+@kvfree depends on !patch@
+expression E;
+position p : script:python() { relevant(p) };
+@@
+
+* if (is_vmalloc_addr(E))@p {
+    ...
+*   vfree(E)
+    ...
+  } else {
+    ... when != krealloc(E, ...)
+        when any
+*   \(kfree\|kzfree\)(E)
+    ...
+  }
+
+@depends on patch@
+expression E, E1, size, node;
+binary operator cmp = {<=, <, ==, >, >=};
+identifier flags, x;
+type T;
+@@
+
+(
+- if (size cmp E1)
+-    E = kmalloc(size, flags);
+- else
+-    E = vmalloc(size);
++ E = kvmalloc(size, flags);
+|
+- if (size cmp E1)
+-    E = kmalloc(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\));
+- else
+-    E = vmalloc(size);
++ E = kvmalloc(size, GFP_KERNEL);
+|
+- E = kmalloc(size, flags | __GFP_NOWARN);
+- if (E == NULL)
+-   E = vmalloc(size);
++ E = kvmalloc(size, flags);
+|
+- E = kmalloc(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\));
+- if (E == NULL)
+-   E = vmalloc(size);
++ E = kvmalloc(size, GFP_KERNEL);
+|
+- T x = kmalloc(size, flags | __GFP_NOWARN);
+- if (x == NULL)
+-   x = vmalloc(size);
++ T x = kvmalloc(size, flags);
+|
+- T x = kmalloc(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\));
+- if (x == NULL)
+-   x = vmalloc(size);
++ T x = kvmalloc(size, GFP_KERNEL);
+|
+- if (size cmp E1)
+-    E = kzalloc(size, flags);
+- else
+-    E = vzalloc(size);
++ E = kvzalloc(size, flags);
+|
+- if (size cmp E1)
+-    E = kzalloc(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\));
+- else
+-    E = vzalloc(size);
++ E = kvzalloc(size, GFP_KERNEL);
+|
+- E = kzalloc(size, flags | __GFP_NOWARN);
+- if (E == NULL)
+-   E = vzalloc(size);
++ E = kvzalloc(size, flags);
+|
+- E = kzalloc(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\));
+- if (E == NULL)
+-   E = vzalloc(size);
++ E = kvzalloc(size, GFP_KERNEL);
+|
+- T x = kzalloc(size, flags | __GFP_NOWARN);
+- if (x == NULL)
+-   x = vzalloc(size);
++ T x = kvzalloc(size, flags);
+|
+- T x = kzalloc(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\));
+- if (x == NULL)
+-   x = vzalloc(size);
++ T x = kvzalloc(size, GFP_KERNEL);
+|
+- if (size cmp E1)
+-    E = kmalloc_node(size, flags, node);
+- else
+-    E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, flags, node);
+|
+- if (size cmp E1)
+-    E = kmalloc_node(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\), node);
+- else
+-    E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, GFP_KERNEL, node);
+|
+- E = kmalloc_node(size, flags | __GFP_NOWARN, node);
+- if (E == NULL)
+-   E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, flags, node);
+|
+- E = kmalloc_node(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\), node);
+- if (E == NULL)
+-   E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, GFP_KERNEL, node);
+|
+- T x = kmalloc_node(size, flags | __GFP_NOWARN, node);
+- if (x == NULL)
+-   x = vmalloc_node(size, node);
++ T x = kvmalloc_node(size, flags, node);
+|
+- T x = kmalloc_node(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\), node);
+- if (x == NULL)
+-   x = vmalloc_node(size, node);
++ T x = kvmalloc_node(size, GFP_KERNEL, node);
+|
+- if (size cmp E1)
+-    E = kvzalloc_node(size, flags, node);
+- else
+-    E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, flags, node);
+|
+- if (size cmp E1)
+-    E = kvzalloc_node(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\), node);
+- else
+-    E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, GFP_KERNEL, node);
+|
+- E = kvzalloc_node(size, flags | __GFP_NOWARN, node);
+- if (E == NULL)
+-   E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, flags, node);
+|
+- E = kvzalloc_node(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\), node);
+- if (E == NULL)
+-   E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, GFP_KERNEL, node);
+|
+- T x = kvzalloc_node(size, flags | __GFP_NOWARN, node);
+- if (x == NULL)
+-   x = vzalloc_node(size, node);
++ T x = kvzalloc_node(size, flags, node);
+|
+- T x = kvzalloc_node(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\), node);
+- if (x == NULL)
+-   x = vzalloc_node(size, node);
++ T x = kvzalloc_node(size, GFP_KERNEL, node);
+)
+
+@depends on patch@
+expression E;
+position p : script:python() { relevant(p) };
+@@
+
+- if (is_vmalloc_addr(E))@p
+-   vfree(E);
+- else
+-   kfree(E);
++ kvfree(E);
+
+@script: python depends on report@
+p << kvmalloc.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for kvmalloc")
+
+@script: python depends on org@
+p << kvmalloc.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for kvmalloc")
+
+@script: python depends on report@
+p << kvfree.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for kvfree")
+
+@script: python depends on org@
+p << kvfree.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for kvfree")
-- 
2.26.2

