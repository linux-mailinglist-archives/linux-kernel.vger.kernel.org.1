Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3D8273123
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgIURti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:49:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41115 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgIURti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:49:38 -0400
Received: by mail-lj1-f193.google.com with SMTP id y4so11845880ljk.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 10:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYVL6vVhxxsHwQqcaJ+Y/Dyr3s/BHvLdogiat9zzOMY=;
        b=W3ZDVAxtgxgzLtBKVV7zieKrkpsoWZ5wtekVTtdb4ZqWatJMyJbNtjafRv7Ga9HGsW
         FQ2E/YadgrIC2dJbASKHWSbrC2OaREoOBRS3zsJFWNIwUaih80Y9gjsIzwjQa2npxsjC
         yitO4+AJ9I22Vh7ksNqazjJ3roM5W0VXnsp0d1n/ZjxGPoSo6FjCkyu/14/bxDd7lXCP
         a3323KJ/GpNGKmDPqrwfBGJVD7jNMSBORWNsbqcPQcCobpQtNAUBk8l7WYlrjklX86AW
         b8hXjcA1TmE7OU0egifSm7X2PQiU8rcUucTklIu3RPrEmqd3+uuX1J9d42Z515jiD+iJ
         1E9g==
X-Gm-Message-State: AOAM5339YXp3i7C7GfOQFkHQx9xyvzF3UtRT2gC/ThBsC6xGUJnyLdG1
        uQToCeT+Y44zN+bTYADfHbs=
X-Google-Smtp-Source: ABdhPJyuIwK4gStrZns8fCO6n/pBDKraTe1BTnTEwKWkDnih4NCMna1EpOuzxJwnULIkwuD7H5324g==
X-Received: by 2002:a2e:3203:: with SMTP id y3mr269898ljy.261.1600710575899;
        Mon, 21 Sep 2020 10:49:35 -0700 (PDT)
Received: from green.intra.ispras.ru (winnie.ispras.ru. [83.149.199.91])
        by smtp.googlemail.com with ESMTPSA id q24sm2773353lfo.149.2020.09.21.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 10:49:35 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH v3] coccinelle: misc: add flexible_array.cocci script
Date:   Mon, 21 Sep 2020 20:49:20 +0300
Message-Id: <20200921174920.87241-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200806220342.25426-1-efremov@linux.com>
References: <20200806220342.25426-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element and zero-length arrays are deprecated [1]. Kernel
code should always use "flexible array members" instead, except
for existing uapi definitions.

The script warns about one-element and zero-length arrays in structs.

[1] commit 68e4cd17e218 ("docs: deprecated.rst: Add zero-length and
    one-element arrays")

Cc: Kees Cook <keescook@chromium.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - all uapi headers are now filtered-out. Unfortunately, coccinelle
   doesn't provide structure names in Location.current_element.
   For structures the field is always "something_else". Thus, there is
   no easy way to create a list of existing structures in uapi headers
   and suppress the warning only for them, but not for the newly added
   uapi structures.
 - The pattern doesn't require 2+ fields in a structure/union anymore.
   Now it also checks single field structures/unions.
 - The pattern simplified and now uses disjuction in array elements
   (Thanks, Markus)
 - Unions are removed from patch mode
 - one-element arrays are removed from patch mode. Correct patch may
   involve turning the array to a simple field instead of a flexible
   array.
Changes in v3:
 - exists removed from "depends on patch"
 - position argument fixed in org mode
 - link to the online documentation added to the warning message

 scripts/coccinelle/misc/flexible_array.cocci | 88 ++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 scripts/coccinelle/misc/flexible_array.cocci

diff --git a/scripts/coccinelle/misc/flexible_array.cocci b/scripts/coccinelle/misc/flexible_array.cocci
new file mode 100644
index 000000000000..947fbaff82a9
--- /dev/null
+++ b/scripts/coccinelle/misc/flexible_array.cocci
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Zero-length and one-element arrays are deprecated, see
+/// Documentation/process/deprecated.rst
+/// Flexible-array members should be used instead.
+///
+//
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS.
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual context
+virtual report
+virtual org
+virtual patch
+
+@initialize:python@
+@@
+def relevant(positions):
+    for p in positions:
+        if "uapi" in p.file:
+             return False
+    return True
+
+@r depends on !patch@
+identifier name, array;
+type T;
+position p : script:python() { relevant(p) };
+@@
+
+(
+  struct name {
+    ...
+*   T array@p[\(0\|1\)];
+  };
+|
+  struct {
+    ...
+*   T array@p[\(0\|1\)];
+  };
+|
+  union name {
+    ...
+*   T array@p[\(0\|1\)];
+  };
+|
+  union {
+    ...
+*   T array@p[\(0\|1\)];
+  };
+)
+
+@depends on patch@
+identifier name, array;
+type T;
+position p : script:python() { relevant(p) };
+@@
+
+(
+  struct name {
+    ...
+    T array@p[
+-       0
+    ];
+  };
+|
+  struct {
+    ...
+    T array@p[
+-       0
+    ];
+  };
+)
+
+@script: python depends on report@
+p << r.p;
+@@
+
+msg = "WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)"
+coccilib.report.print_report(p[0], msg)
+
+@script: python depends on org@
+p << r.p;
+@@
+
+msg = "WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)"
+coccilib.org.print_todo(p[0], msg)
-- 
2.26.2

