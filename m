Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5AC28CDB3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgJMMCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbgJMLyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:41 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8122B214D8;
        Tue, 13 Oct 2020 11:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590079;
        bh=vHS+ePnyHlRO2q/RxlwyLxA1ZO8h9xom1OUrU/UZSEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GlahXMjvV3K4D7uP82ldKjQcw3Mx+JrdMm910AwkOHBH0UEsFCYuZIUsVc8RbIQ+j
         s4Xch/jOqawdW1hF/Ky47WJgXuqMi+5b+kJbNdGBy8GdlwElj55Z9nrJdn9GdrTLkc
         ZuLeRNb6GL0yUfoBaeO9LavcnArFDgKesbdKhZzQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt3-006CTe-Ew; Tue, 13 Oct 2020 13:54:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/80] docs: automarkup.py: make it ready for Sphinx 3.1+
Date:   Tue, 13 Oct 2020 13:53:28 +0200
Message-Id: <57010ba2cb9e313270c6ff56702803c017cb168d.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nícolas F. R. A. Prado <nfraprado@protonmail.com>

While Sphinx 2 used a single c:type role for struct, union, enum and
typedef, Sphinx 3 uses a specific role for each one.
To keep backward compatibility, detect the Sphinx version and use the
correct roles for that version.

Also, Sphinx 3 is more strict with its C domain and generated warnings,
exposing issues in the parsing.
To fix the warnings, make the C regexes use ASCII, ensure the
expressions only match the beginning of words and skip trying to
cross-reference C reserved words.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@protonmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/automarkup.py | 69 ++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
index a1b0f554cd82..fd1e927408ad 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -22,13 +22,34 @@ from itertools import chain
 # :c:func: block (i.e. ":c:func:`mmap()`s" flakes out), so the last
 # bit tries to restrict matches to things that won't create trouble.
 #
-RE_function = re.compile(r'(([\w_][\w\d_]+)\(\))')
-RE_type = re.compile(r'(struct|union|enum|typedef)\s+([\w_][\w\d_]+)')
+RE_function = re.compile(r'\b(([a-zA-Z_]\w+)\(\))', flags=re.ASCII)
+
+#
+# Sphinx 2 uses the same :c:type role for struct, union, enum and typedef
+#
+RE_generic_type = re.compile(r'\b(struct|union|enum|typedef)\s+([a-zA-Z_]\w+)',
+                             flags=re.ASCII)
+
+#
+# Sphinx 3 uses a different C role for each one of struct, union, enum and
+# typedef
+#
+RE_struct = re.compile(r'\b(struct)\s+([a-zA-Z_]\w+)', flags=re.ASCII)
+RE_union = re.compile(r'\b(union)\s+([a-zA-Z_]\w+)', flags=re.ASCII)
+RE_enum = re.compile(r'\b(enum)\s+([a-zA-Z_]\w+)', flags=re.ASCII)
+RE_typedef = re.compile(r'\b(typedef)\s+([a-zA-Z_]\w+)', flags=re.ASCII)
+
 #
 # Detects a reference to a documentation page of the form Documentation/... with
 # an optional extension
 #
-RE_doc = re.compile(r'Documentation(/[\w\-_/]+)(\.\w+)*')
+RE_doc = re.compile(r'\bDocumentation(/[\w\-_/]+)(\.\w+)*')
+
+#
+# Reserved C words that we should skip when cross-referencing
+#
+Skipnames = [ 'for', 'if', 'register', 'sizeof', 'struct', 'unsigned' ]
+
 
 #
 # Many places in the docs refer to common system calls.  It is
@@ -48,9 +69,22 @@ def markup_refs(docname, app, node):
     #
     # Associate each regex with the function that will markup its matches
     #
-    markup_func = {RE_type: markup_c_ref,
-                   RE_function: markup_c_ref,
-                   RE_doc: markup_doc_ref}
+    markup_func_sphinx2 = {RE_doc: markup_doc_ref,
+                           RE_function: markup_c_ref,
+                           RE_generic_type: markup_c_ref}
+
+    markup_func_sphinx3 = {RE_doc: markup_doc_ref,
+                           RE_function: markup_c_ref,
+                           RE_struct: markup_c_ref,
+                           RE_union: markup_c_ref,
+                           RE_enum: markup_c_ref,
+                           RE_typedef: markup_c_ref}
+
+    if sphinx.__version__[0] == '3':
+        markup_func = markup_func_sphinx3
+    else:
+        markup_func = markup_func_sphinx2
+
     match_iterators = [regex.finditer(t) for regex in markup_func]
     #
     # Sort all references by the starting position in text
@@ -79,8 +113,24 @@ def markup_refs(docname, app, node):
 # type_name) with an appropriate cross reference.
 #
 def markup_c_ref(docname, app, match):
-    class_str = {RE_function: 'c-func', RE_type: 'c-type'}
-    reftype_str = {RE_function: 'function', RE_type: 'type'}
+    class_str = {RE_function: 'c-func',
+                 # Sphinx 2 only
+                 RE_generic_type: 'c-type',
+                 # Sphinx 3+ only
+                 RE_struct: 'c-struct',
+                 RE_union: 'c-union',
+                 RE_enum: 'c-enum',
+                 RE_typedef: 'c-type',
+                 }
+    reftype_str = {RE_function: 'function',
+                   # Sphinx 2 only
+                   RE_generic_type: 'type',
+                   # Sphinx 3+ only
+                   RE_struct: 'struct',
+                   RE_union: 'union',
+                   RE_enum: 'enum',
+                   RE_typedef: 'type',
+                   }
 
     cdom = app.env.domains['c']
     #
@@ -89,7 +139,8 @@ def markup_c_ref(docname, app, match):
     target = match.group(2)
     target_text = nodes.Text(match.group(0))
     xref = None
-    if not (match.re == RE_function and target in Skipfuncs):
+    if not ((match.re == RE_function and target in Skipfuncs)
+            or (target in Skipnames)):
         lit_text = nodes.literal(classes=['xref', 'c', class_str[match.re]])
         lit_text += target_text
         pxref = addnodes.pending_xref('', refdomain = 'c',
-- 
2.26.2

