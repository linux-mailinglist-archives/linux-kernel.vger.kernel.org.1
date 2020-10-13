Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD0628D6E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388448AbgJMXNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:13:41 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:62673 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388349AbgJMXNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:13:41 -0400
Date:   Tue, 13 Oct 2020 23:13:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1602630819;
        bh=0xx6wEgMhOpiHy1otbVV92rK/bRDlJxAs24CLtmfgVc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=rIIBU/S9D4t0kbJ7GD8JMXHt3XFmMatMVBgT0eQ7L2wmwp2xMkwEipEMei6Z85t8q
         UlaLQjFb/6xyfrIcmElrfGs9KOY+k/SiHCGiNVBs0I7eJ4EqorBH6LEgO76HwE/Uof
         qR+A6KgXlLoYSpipuQCASMLMqfNR9jvNMjq9wces=
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH v2 4/5] docs: automarkup.py: Add cross-reference for parametrized C macros
Message-ID: <20201013231218.2750109-5-nfraprado@protonmail.com>
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

Sphinx 3 added support for declaring C macros with parameters using the
:c:macro role.

To support automarkup for both functions and parametrized macros using
the same regex (words ending in ()), try to cross-reference to both, and
only fall back to regular text if neither exist.

Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
---
 Documentation/sphinx/automarkup.py | 49 +++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/auto=
markup.py
index 1cc3a2cf2a88..409dbc4100de 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -74,7 +74,7 @@ def markup_refs(docname, app, node):
                            RE_generic_type: markup_c_ref}
=20
     markup_func_sphinx3 =3D {RE_doc: markup_doc_ref,
-                           RE_function: markup_c_ref,
+                           RE_function: markup_func_ref_sphinx3,
                            RE_struct: markup_c_ref,
                            RE_union: markup_c_ref,
                            RE_enum: markup_c_ref,
@@ -109,12 +109,47 @@ def markup_refs(docname, app, node):
     return repl
=20
 #
-# Try to replace a C reference (function() or struct/union/enum/typedef
-# type_name) with an appropriate cross reference.
+# In sphinx3 we can cross-reference to C macro and function, each one with=
 its
+# own C role, but both match the same regex, so we try both.
 #
+def markup_func_ref_sphinx3(docname, app, match):
+    class_str =3D ['c-func', 'c-macro']
+    reftype_str =3D ['function', 'macro']
+
+    cdom =3D app.env.domains['c']
+    #
+    # Go through the dance of getting an xref out of the C domain
+    #
+    target =3D match.group(2)
+    target_text =3D nodes.Text(match.group(0))
+    xref =3D None
+    if not (target in Skipfuncs or target in Skipnames):
+        for class_s, reftype_s in zip(class_str, reftype_str):
+            lit_text =3D nodes.literal(classes=3D['xref', 'c', class_s])
+            lit_text +=3D target_text
+            pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
+                                          reftype =3D reftype_s,
+                                          reftarget =3D target, modname =
=3D None,
+                                          classname =3D None)
+            #
+            # XXX The Latex builder will throw NoUri exceptions here,
+            # work around that by ignoring them.
+            #
+            try:
+                xref =3D cdom.resolve_xref(app.env, docname, app.builder,
+                                         reftype_s, target, pxref,
+                                         lit_text)
+            except NoUri:
+                xref =3D None
+
+            if xref:
+                return xref
+
+    return target_text
+
 def markup_c_ref(docname, app, match):
-    class_str =3D {RE_function: 'c-func',
-                 # Sphinx 2 only
+    class_str =3D {# Sphinx 2 only
+                 RE_function: 'c-func',
                  RE_generic_type: 'c-type',
                  # Sphinx 3+ only
                  RE_struct: 'c-struct',
@@ -122,8 +157,8 @@ def markup_c_ref(docname, app, match):
                  RE_enum: 'c-enum',
                  RE_typedef: 'c-type',
                  }
-    reftype_str =3D {RE_function: 'function',
-                   # Sphinx 2 only
+    reftype_str =3D {# Sphinx 2 only
+                   RE_function: 'function',
                    RE_generic_type: 'type',
                    # Sphinx 3+ only
                    RE_struct: 'struct',
--=20
2.28.0


