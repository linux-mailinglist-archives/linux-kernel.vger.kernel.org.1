Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875DB28D6E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbgJMXNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:13:53 -0400
Received: from mail-02.mail-europe.com ([51.89.119.103]:43562 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388475AbgJMXNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:13:52 -0400
Date:   Tue, 13 Oct 2020 23:13:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1602630828;
        bh=J6dRsJihtPRdhE9qkvvVU8matlHIMFFLyAjWLwprVvQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ZgpDRlFhTx6jiCVKR7TkDKeTFxqyNMoAGinp7qlZ1gvfJqez25/nvTWN+qG+X4EjI
         9qkqjnaStXQmh1hHxXDDSNG1U3mbrIE9CunnAP5uBOD5XGYGAs1ROHivMa1AsYxAcF
         0ivLZEJplPf7k0FtnYsUkT07i+GkehZ8OCGoQO8o=
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH v2 5/5] docs: automarkup.py: Allow automatic cross-reference inside C namespace
Message-ID: <20201013231218.2750109-6-nfraprado@protonmail.com>
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

Sphinx 3.1 introduced namespaces for C cross-references. With this,
each C domain type/function declaration is put inside the namespace that
was active at the time of its declaration.

To support automatic cross-reference inside C namespaces:
- Save the C namespace used in each doc file (if any) at the source-read
  phase, in the beginning of the Sphinx process.
- When making the automarkup, if any namespace was used in the current
  file, try to cross-reference to the symbol inside of it before trying
  in the global namespace.

To make the first step possible, disable the parallel_read_safe option
in Sphinx, since the dictionary that maps the files to the C namespaces
can't be concurrently updated. This unfortunately increases the build
time of the documentation.

Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
---
 Documentation/sphinx/automarkup.py | 130 ++++++++++++++++++-----------
 1 file changed, 82 insertions(+), 48 deletions(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/auto=
markup.py
index 409dbc4100de..bca8cf5f519d 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -45,6 +45,8 @@ RE_typedef =3D re.compile(r'\b(typedef)\s+([a-zA-Z_]\w+)'=
, flags=3Dre.ASCII)
 #
 RE_doc =3D re.compile(r'\bDocumentation(/[\w\-_/]+)(\.\w+)*')
=20
+RE_namespace =3D re.compile(r'^\s*..\s*c:namespace::\s*(\S+)\s*$')
+
 #
 # Reserved C words that we should skip when cross-referencing
 #
@@ -62,6 +64,8 @@ Skipfuncs =3D [ 'open', 'close', 'read', 'write', 'fcntl'=
, 'mmap',
               'select', 'poll', 'fork', 'execve', 'clone', 'ioctl',
               'socket' ]
=20
+c_namespace =3D {}
+
 def markup_refs(docname, app, node):
     t =3D node.astext()
     done =3D 0
@@ -120,30 +124,42 @@ def markup_func_ref_sphinx3(docname, app, match):
     #
     # Go through the dance of getting an xref out of the C domain
     #
-    target =3D match.group(2)
+    base_target =3D match.group(2)
     target_text =3D nodes.Text(match.group(0))
     xref =3D None
-    if not (target in Skipfuncs or target in Skipnames):
-        for class_s, reftype_s in zip(class_str, reftype_str):
-            lit_text =3D nodes.literal(classes=3D['xref', 'c', class_s])
-            lit_text +=3D target_text
-            pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
-                                          reftype =3D reftype_s,
-                                          reftarget =3D target, modname =
=3D None,
-                                          classname =3D None)
-            #
-            # XXX The Latex builder will throw NoUri exceptions here,
-            # work around that by ignoring them.
-            #
-            try:
-                xref =3D cdom.resolve_xref(app.env, docname, app.builder,
-                                         reftype_s, target, pxref,
-                                         lit_text)
-            except NoUri:
-                xref =3D None
-
-            if xref:
-                return xref
+    possible_targets =3D [base_target]
+    # Check if this document has a namespace, and if so, try
+    # cross-referencing inside it first.
+    try:
+        namespace =3D c_namespace[docname]
+    except KeyError:
+        pass
+    else:
+        possible_targets.insert(0, namespace + "." + base_target)
+
+    if base_target not in Skipnames:
+        for target in possible_targets:
+            if target not in Skipfuncs:
+                for class_s, reftype_s in zip(class_str, reftype_str):
+                    lit_text =3D nodes.literal(classes=3D['xref', 'c', cla=
ss_s])
+                    lit_text +=3D target_text
+                    pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
+                                                  reftype =3D reftype_s,
+                                                  reftarget =3D target, mo=
dname =3D None,
+                                                  classname =3D None)
+                    #
+                    # XXX The Latex builder will throw NoUri exceptions he=
re,
+                    # work around that by ignoring them.
+                    #
+                    try:
+                        xref =3D cdom.resolve_xref(app.env, docname, app.b=
uilder,
+                                                 reftype_s, target, pxref,
+                                                 lit_text)
+                    except NoUri:
+                        xref =3D None
+
+                    if xref:
+                        return xref
=20
     return target_text
=20
@@ -171,34 +187,43 @@ def markup_c_ref(docname, app, match):
     #
     # Go through the dance of getting an xref out of the C domain
     #
-    target =3D match.group(2)
+    base_target =3D match.group(2)
     target_text =3D nodes.Text(match.group(0))
     xref =3D None
-    if not ((match.re =3D=3D RE_function and target in Skipfuncs)
-            or (target in Skipnames)):
-        lit_text =3D nodes.literal(classes=3D['xref', 'c', class_str[match=
.re]])
-        lit_text +=3D target_text
-        pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
-                                      reftype =3D reftype_str[match.re],
-                                      reftarget =3D target, modname =3D No=
ne,
-                                      classname =3D None)
-        #
-        # XXX The Latex builder will throw NoUri exceptions here,
-        # work around that by ignoring them.
-        #
-        try:
-            xref =3D cdom.resolve_xref(app.env, docname, app.builder,
-                                     reftype_str[match.re], target, pxref,
-                                     lit_text)
-        except NoUri:
-            xref =3D None
-    #
-    # Return the xref if we got it; otherwise just return the plain text.
-    #
-    if xref:
-        return xref
+    possible_targets =3D [base_target]
+    # Check if this document has a namespace, and if so, try
+    # cross-referencing inside it first.
+    try:
+        namespace =3D c_namespace[docname]
+    except KeyError:
+        pass
     else:
-        return target_text
+        possible_targets.insert(0, namespace + "." + base_target)
+
+    if base_target not in Skipnames:
+        for target in possible_targets:
+            if not (match.re =3D=3D RE_function and target in Skipfuncs):
+                lit_text =3D nodes.literal(classes=3D['xref', 'c', class_s=
tr[match.re]])
+                lit_text +=3D target_text
+                pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
+                                              reftype =3D reftype_str[matc=
h.re],
+                                              reftarget =3D target, modnam=
e =3D None,
+                                              classname =3D None)
+                #
+                # XXX The Latex builder will throw NoUri exceptions here,
+                # work around that by ignoring them.
+                #
+                try:
+                    xref =3D cdom.resolve_xref(app.env, docname, app.build=
er,
+                                             reftype_str[match.re], target=
, pxref,
+                                             lit_text)
+                except NoUri:
+                    xref =3D None
+
+                if xref:
+                    return xref
+
+    return target_text
=20
 #
 # Try to replace a documentation reference of the form Documentation/... w=
ith a
@@ -246,9 +271,18 @@ def auto_markup(app, doctree, name):
             if not isinstance(node.parent, nodes.literal):
                 node.parent.replace(node, markup_refs(name, app, node))
=20
+def save_c_namespace(app, docname, source):
+    lines =3D iter(source[0].splitlines(True))
+    for l in lines:
+        match =3D RE_namespace.search(l)
+        if match:
+            c_namespace[docname] =3D match.group(1)
+            return
+
 def setup(app):
+    app.connect('source-read', save_c_namespace)
     app.connect('doctree-resolved', auto_markup)
     return {
-        'parallel_read_safe': True,
+        'parallel_read_safe': False,
         'parallel_write_safe': True,
         }
--=20
2.28.0


