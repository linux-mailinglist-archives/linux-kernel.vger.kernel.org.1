Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3FD286B61
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 01:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgJGXMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 19:12:41 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:27238 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbgJGXMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 19:12:41 -0400
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id EC8CB200376D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 23:12:38 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="DsmYwPxb"
Date:   Wed, 07 Oct 2020 23:12:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1602112355;
        bh=xFWHtRQUX5S239mP/ot0kFUFeIwV67GIZDgFaqML8/I=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=DsmYwPxbn9DZGa4HcdHjZf3B4/29375/SQgHJh147suuFnQGjolWG4x3O09aVu40L
         KYkOpO5vcvkla4W8DAwATGVu7z/pKU1f0OH49i4c7Kp27wzipgLIIDbMxULgU0sYSQ
         fqF+0WBWECCBOTyRMSCGVPUZG9nyheL936nNXtM0=
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH] docs: Make automarkup ready for Sphinx 3.1+
Message-ID: <20201007231214.326456-1-nfraprado@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While Sphinx 2 used a single c:type role for struct, union, enum and
typedef, Sphinx 3 uses a specific role for each one.
To keep backward compatibility, detect the Sphinx version and use the
correct roles for that version.

Also, Sphinx 3 is more strict with its C domain and generated warnings,
exposing issues in the parsing.
To fix the warnings, make the C regexes use ASCII, ensure the
expressions only match the beginning of words and skip trying to
cross-reference C reserved words.

Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
---

Hi,

after Mauro's series making everything ready for Sphinx 3.1, only the autom=
arkup
was left to be ported.
This patch makes the needed changes to automarkup so that we can soon flip =
the
switch to Sphinx 3.1.

This change was tested both with Sphinx 2.4.4 and Sphinx 3.1.

This change doesn't add any warnings to the Documentation build.
I tested it with Mauro's series but later rebased it to docs-next, and it c=
an be
accepted independently of that series.

I ended up doing more than one thing in this single patch, but since it was=
 all
changing the same lines and for the same purpose, I felt it would be better=
 to
keep it as a single commit.

Mauro,
if this patch is ok, the 3rd patch in your series, which disables automarku=
p for
sphinx 3, should be dropped.
Although I'm not sure what the implications of your patches adding namespac=
es
and using the c:macro for functions are.
All I did here was use the specific roles for sphinx 3 and fix the warnings=
, but
that was enough to get correct cross-references even after your series.

Thanks,
N=C3=ADcolas


 Documentation/sphinx/automarkup.py | 69 ++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/auto=
markup.py
index a1b0f554cd82..fd1e927408ad 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -22,13 +22,34 @@ from itertools import chain
 # :c:func: block (i.e. ":c:func:`mmap()`s" flakes out), so the last
 # bit tries to restrict matches to things that won't create trouble.
 #
-RE_function =3D re.compile(r'(([\w_][\w\d_]+)\(\))')
-RE_type =3D re.compile(r'(struct|union|enum|typedef)\s+([\w_][\w\d_]+)')
+RE_function =3D re.compile(r'\b(([a-zA-Z_]\w+)\(\))', flags=3Dre.ASCII)
+
+#
+# Sphinx 2 uses the same :c:type role for struct, union, enum and typedef
+#
+RE_generic_type =3D re.compile(r'\b(struct|union|enum|typedef)\s+([a-zA-Z_=
]\w+)',
+                             flags=3Dre.ASCII)
+
+#
+# Sphinx 3 uses a different C role for each one of struct, union, enum and
+# typedef
+#
+RE_struct =3D re.compile(r'\b(struct)\s+([a-zA-Z_]\w+)', flags=3Dre.ASCII)
+RE_union =3D re.compile(r'\b(union)\s+([a-zA-Z_]\w+)', flags=3Dre.ASCII)
+RE_enum =3D re.compile(r'\b(enum)\s+([a-zA-Z_]\w+)', flags=3Dre.ASCII)
+RE_typedef =3D re.compile(r'\b(typedef)\s+([a-zA-Z_]\w+)', flags=3Dre.ASCI=
I)
+
 #
 # Detects a reference to a documentation page of the form Documentation/..=
. with
 # an optional extension
 #
-RE_doc =3D re.compile(r'Documentation(/[\w\-_/]+)(\.\w+)*')
+RE_doc =3D re.compile(r'\bDocumentation(/[\w\-_/]+)(\.\w+)*')
+
+#
+# Reserved C words that we should skip when cross-referencing
+#
+Skipnames =3D [ 'for', 'if', 'register', 'sizeof', 'struct', 'unsigned' ]
+
=20
 #
 # Many places in the docs refer to common system calls.  It is
@@ -48,9 +69,22 @@ def markup_refs(docname, app, node):
     #
     # Associate each regex with the function that will markup its matches
     #
-    markup_func =3D {RE_type: markup_c_ref,
-                   RE_function: markup_c_ref,
-                   RE_doc: markup_doc_ref}
+    markup_func_sphinx2 =3D {RE_doc: markup_doc_ref,
+                           RE_function: markup_c_ref,
+                           RE_generic_type: markup_c_ref}
+
+    markup_func_sphinx3 =3D {RE_doc: markup_doc_ref,
+                           RE_function: markup_c_ref,
+                           RE_struct: markup_c_ref,
+                           RE_union: markup_c_ref,
+                           RE_enum: markup_c_ref,
+                           RE_typedef: markup_c_ref}
+
+    if sphinx.__version__[0] =3D=3D '3':
+        markup_func =3D markup_func_sphinx3
+    else:
+        markup_func =3D markup_func_sphinx2
+
     match_iterators =3D [regex.finditer(t) for regex in markup_func]
     #
     # Sort all references by the starting position in text
@@ -79,8 +113,24 @@ def markup_refs(docname, app, node):
 # type_name) with an appropriate cross reference.
 #
 def markup_c_ref(docname, app, match):
-    class_str =3D {RE_function: 'c-func', RE_type: 'c-type'}
-    reftype_str =3D {RE_function: 'function', RE_type: 'type'}
+    class_str =3D {RE_function: 'c-func',
+                 # Sphinx 2 only
+                 RE_generic_type: 'c-type',
+                 # Sphinx 3+ only
+                 RE_struct: 'c-struct',
+                 RE_union: 'c-union',
+                 RE_enum: 'c-enum',
+                 RE_typedef: 'c-type',
+                 }
+    reftype_str =3D {RE_function: 'function',
+                   # Sphinx 2 only
+                   RE_generic_type: 'type',
+                   # Sphinx 3+ only
+                   RE_struct: 'struct',
+                   RE_union: 'union',
+                   RE_enum: 'enum',
+                   RE_typedef: 'type',
+                   }
=20
     cdom =3D app.env.domains['c']
     #
@@ -89,7 +139,8 @@ def markup_c_ref(docname, app, match):
     target =3D match.group(2)
     target_text =3D nodes.Text(match.group(0))
     xref =3D None
-    if not (match.re =3D=3D RE_function and target in Skipfuncs):
+    if not ((match.re =3D=3D RE_function and target in Skipfuncs)
+            or (target in Skipnames)):
         lit_text =3D nodes.literal(classes=3D['xref', 'c', class_str[match=
.re]])
         lit_text +=3D target_text
         pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
--=20
2.28.0


