Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59FB28D6DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbgJMXNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:13:17 -0400
Received: from mail-03.mail-europe.com ([91.134.188.129]:38548 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729677AbgJMXNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:13:17 -0400
Date:   Tue, 13 Oct 2020 23:13:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1602630792;
        bh=ZGVveLBSaEcJdSVGE0S5ZpuqOTafDMvhOGrHn+UDqnY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=DH+F14PCibCY9v/+Rf2aH5sYnfCq/f8W0ku15NxWZ1qGNuf9x+0iJ5ly2RTbkyB6n
         KNq18I+ZmoPZ99bGs7ZD9hjt3C5BpPp9s/tvyv0HDeO1R1xnC/RlnY57DYHB5zkbUE
         pyMrewpeelsBBDNKSbTHgkNl5h0wjjG3dw+tIBHQ=
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH v2 1/5] docs: automarkup.py: Use new C roles in Sphinx 3
Message-ID: <20201013231218.2750109-2-nfraprado@protonmail.com>
In-Reply-To: <20201013231218.2750109-1-nfraprado@protonmail.com>
References: <20201013231218.2750109-1-nfraprado@protonmail.com>
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

Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
---
 Documentation/sphinx/automarkup.py | 55 ++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/auto=
markup.py
index a1b0f554cd82..db13fb15cedc 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -23,7 +23,21 @@ from itertools import chain
 # bit tries to restrict matches to things that won't create trouble.
 #
 RE_function =3D re.compile(r'(([\w_][\w\d_]+)\(\))')
-RE_type =3D re.compile(r'(struct|union|enum|typedef)\s+([\w_][\w\d_]+)')
+
+#
+# Sphinx 2 uses the same :c:type role for struct, union, enum and typedef
+#
+RE_generic_type =3D re.compile(r'(struct|union|enum|typedef)\s+([\w_][\w\d=
_]+)')
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
@@ -48,9 +62,22 @@ def markup_refs(docname, app, node):
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
+    if sphinx.version_info[0] >=3D 3:
+        markup_func =3D markup_func_sphinx3
+    else:
+        markup_func =3D markup_func_sphinx2
+
     match_iterators =3D [regex.finditer(t) for regex in markup_func]
     #
     # Sort all references by the starting position in text
@@ -79,8 +106,24 @@ def markup_refs(docname, app, node):
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
--=20
2.28.0


