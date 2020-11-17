Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7A72B569A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 03:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgKQCMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 21:12:15 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:57762 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgKQCMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 21:12:13 -0500
Date:   Tue, 17 Nov 2020 02:12:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1605579130;
        bh=UMnSTuCY+a5A80tX+uzBN07w6tNxlUDMZ0lpQ+92y2o=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=amCSGJHtH/4iSSPc6F43dAHfojR5vvNaVgfaPnVNV1dkWjbZqAWy0xqq+q3V2VN/6
         cPp8qXW6v4P+XY+knOSQyWpg1Tzf5+vVsol6maFHqD1OyuWGS+0IGNn+qw9nyIpOBX
         wknX7Rg/ryj6dDqR+IgLT/REZwdNs6oHaADSX77c=
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH v2] docs: automarkup.py: Allow automatic cross-reference inside C namespace
Message-ID: <20201117021107.214704-1-nfraprado@protonmail.com>
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

Add support for automatic cross-referencing inside C namespaces by
checking whether the corresponding source file had a C namespace Sphinx
directive, and if so, try cross-referencing inside of it before going to
the global scope.

This assumes there's only one namespace (if any) per rst file.

Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
---

To those following from v1:

I ended up doing the simplest solution possible, which is to just directly =
read
the rst source corresponding to the doc page right before doing the automar=
kup.
It's not very efficient in the sense that the source is being read
twice (first by Sphinx, then by this), but it sidesteps the "data sharing
between processes" issue, so parallel_read_safe can be reenabled, and I did=
n't
notice any performance hit from this patch (as opposed to the big hit from =
v1).
Works with both Sphinx 2 and 3.

Changes in v2:
- Get C namespace from reading the corresponding source at the time of doin=
g
  automarkup instead of storing all namespaces beforehand at the source-rea=
d
  phase
    - Add get_c_namespace()
    - Remove save_c_namespace()
- Reenabled Sphinx's parallel_read_safe

v1: https://lore.kernel.org/linux-doc/20201013231218.2750109-6-nfraprado@pr=
otonmail.com/

 Documentation/sphinx/automarkup.py | 122 ++++++++++++++++++-----------
 1 file changed, 75 insertions(+), 47 deletions(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/auto=
markup.py
index 3e81ebab26ed..953b24b6e2b4 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -53,6 +53,8 @@ RE_typedef =3D re.compile(r'\b(typedef)\s+([a-zA-Z_]\w+)'=
, flags=3Dascii_p3)
 #
 RE_doc =3D re.compile(r'\bDocumentation(/[\w\-_/]+)(\.\w+)*')
=20
+RE_namespace =3D re.compile(r'^\s*..\s*c:namespace::\s*(\S+)\s*$')
+
 #
 # Reserved C words that we should skip when cross-referencing
 #
@@ -70,6 +72,8 @@ Skipfuncs =3D [ 'open', 'close', 'read', 'write', 'fcntl'=
, 'mmap',
               'select', 'poll', 'fork', 'execve', 'clone', 'ioctl',
               'socket' ]
=20
+c_namespace =3D ''
+
 def markup_refs(docname, app, node):
     t =3D node.astext()
     done =3D 0
@@ -128,30 +132,38 @@ def markup_func_ref_sphinx3(docname, app, match):
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
+    possible_targets =3D [base_target]
+    # Check if this document has a namespace, and if so, try
+    # cross-referencing inside it first.
+    if c_namespace:
+        possible_targets.insert(0, c_namespace + "." + base_target)
=20
-            if xref:
-                return xref
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
@@ -179,34 +191,39 @@ def markup_c_ref(docname, app, match):
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
-    else:
-        return target_text
+    possible_targets =3D [base_target]
+    # Check if this document has a namespace, and if so, try
+    # cross-referencing inside it first.
+    if c_namespace:
+        possible_targets.insert(0, c_namespace + "." + base_target)
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
@@ -239,7 +256,18 @@ def markup_doc_ref(docname, app, match):
     else:
         return nodes.Text(match.group(0))
=20
+def get_c_namespace(app, docname):
+    source =3D app.env.doc2path(docname)
+    with open(source) as f:
+        for l in f:
+            match =3D RE_namespace.search(l)
+            if match:
+                return match.group(1)
+    return ''
+
 def auto_markup(app, doctree, name):
+    global c_namespace
+    c_namespace =3D get_c_namespace(app, name)
     #
     # This loop could eventually be improved on.  Someday maybe we
     # want a proper tree traversal with a lot of awareness of which
--=20
2.29.2


