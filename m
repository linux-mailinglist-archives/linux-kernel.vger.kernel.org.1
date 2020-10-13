Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CFC28CD51
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgJML6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbgJMLyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:45 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B4E22453;
        Tue, 13 Oct 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=QJ6b0q+sJUuYC0ZHIuJ5wxGWoQiKEUk+4j3WRsKaRp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TN93cxhFgEiPOMF01LTwZZMMWKQxLPYiVVWLkWYalpfM7eX5XZiAOwQRclzia3fWv
         tlQfT6rBKhAK4h/zzlxOd18manGr9zoKnqjd9TSD7aPOiP7/GVIB7qHH2YBOHT8S8n
         kNwQvACeG9sgCJZ1fVsEIvQeAL0NtvnF4UNIi2Qg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt5-006CVQ-3E; Tue, 13 Oct 2020 13:54:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 49/80] docs: conf.py: fix c:function support with Sphinx 3.x
Date:   Tue, 13 Oct 2020 13:54:04 +0200
Message-Id: <5f76dabbe4840fb01de5fdd1e52478316300ccd9.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx C parser for the C domain is now more pedantic when
trying to identify the function types. That prevents scope
macros to be used as type defines.

Yet, since 3.0.2, it is possible to provide it a list of
such macros. Add them, in order to solve several Sphinx 3.x
warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 65 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 0a102d57437d..e1b16556e378 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -47,9 +47,68 @@ extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
 #
 if major >= 3:
     sys.stderr.write('''WARNING: The kernel documentation build process
-	does not work correctly with Sphinx v3.0 and above.  Expect errors
-	in the generated output.
-	''')
+        does not work correctly with Sphinx v3.0 and above.  Expect errors
+        in the generated output.
+        ''')
+    if minor > 0 or patch >= 2:
+        # Sphinx c function parser is more pedantic with regards to type
+        # checking. Due to that, having macros at c:function cause problems.
+        # Those needed to be scaped by using c_id_attributes[] array
+        c_id_attributes = [
+            # GCC Compiler types not parsed by Sphinx:
+            "__restrict__",
+
+            # include/linux/compiler_types.h:
+            "__iomem",
+            "__kernel",
+            "noinstr",
+            "notrace",
+            "__percpu",
+            "__rcu",
+            "__user",
+
+            # include/linux/compiler_attributes.h:
+            "__alias",
+            "__aligned",
+            "__aligned_largest",
+            "__always_inline",
+            "__assume_aligned",
+            "__cold",
+            "__attribute_const__",
+            "__copy",
+            "__pure",
+            "__designated_init",
+            "__visible",
+            "__printf",
+            "__scanf",
+            "__gnu_inline",
+            "__malloc",
+            "__mode",
+            "__no_caller_saved_registers",
+            "__noclone",
+            "__nonstring",
+            "__noreturn",
+            "__packed",
+            "__pure",
+            "__section",
+            "__always_unused",
+            "__maybe_unused",
+            "__used",
+            "__weak",
+            "noinline",
+
+            # include/linux/memblock.h:
+            "__init_memblock",
+            "__meminit",
+
+            # include/linux/init.h:
+            "__init",
+            "__ref",
+
+            # include/linux/linkage.h:
+            "asmlinkage",
+        ]
+
 else:
     extensions.append('cdomain')
 
-- 
2.26.2

