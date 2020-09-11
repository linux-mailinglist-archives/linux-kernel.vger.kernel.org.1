Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368282662E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgIKQGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:06:50 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:55031 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgIKQDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:03:45 -0400
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com [91.134.188.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 9C869200BEC7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:36:46 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="EzHYERF4"
Date:   Fri, 11 Sep 2020 13:34:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1599831283;
        bh=puRnjJJ0pVdsS+YaDQi74T5xKKIASL4aTb6A1nwnGn4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=EzHYERF4CqT2tURrO0+BtheujleMRklclMlQrKMAw8l+/XsW9hpXrJ4I0m9De2jFp
         6XTbqleqRxacETfJsAVUx2rAYlXK/o0xCpGdduUQv7XjiCyiXIJD+emDWuR4pE2S5Z
         0TWCbrlPR3lPUx9tmG9ULVBrxsFCU+R9Yea0dDhQ=
To:     Jonathan Corbet <corbet@lwn.net>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH 1/3] docs: Allow multiple automarkup functions
Message-ID: <20200911133339.327721-2-nfraprado@protonmail.com>
In-Reply-To: <20200911133339.327721-1-nfraprado@protonmail.com>
References: <20200911133339.327721-1-nfraprado@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The automarkup script previously matched expressions and substituted
them with markup to enable automatic cross-reference all in the same
function.

Split the expression matching iteration and the markup substitution into
different functions to make it easier to add new regular expressions and
functions to treat each of them.

Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
---
 Documentation/sphinx/automarkup.py | 97 +++++++++++++++++-------------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/auto=
markup.py
index 272eb2bdfab1..6c8e8475eddb 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -36,65 +36,78 @@ Skipfuncs =3D [ 'open', 'close', 'read', 'write', 'fcnt=
l', 'mmap',
               'select', 'poll', 'fork', 'execve', 'clone', 'ioctl',
               'socket' ]
=20
-#
-# Find all occurrences of C references (function() and struct/union/enum/t=
ypedef
-# type_name) and try to replace them with appropriate cross references.
-#
-def markup_c_refs(docname, app, node):
-    class_str =3D {RE_function: 'c-func', RE_type: 'c-type'}
-    reftype_str =3D {RE_function: 'function', RE_type: 'type'}
-
-    cdom =3D app.env.domains['c']
+def markup_refs(docname, app, node):
     t =3D node.astext()
     done =3D 0
     repl =3D [ ]
     #
-    # Sort all C references by the starting position in text
+    # Associate each regex with the function that will markup its matches
+    #
+    markup_func =3D {RE_type: markup_c_ref,
+                   RE_function: markup_c_ref}
+    match_iterators =3D [regex.finditer(t) for regex in markup_func]
     #
-    sorted_matches =3D sorted(chain(RE_type.finditer(t), RE_function.findi=
ter(t)),
-                            key=3Dlambda m: m.start())
+    # Sort all references by the starting position in text
+    #
+    sorted_matches =3D sorted(chain(*match_iterators), key=3Dlambda m: m.s=
tart())
     for m in sorted_matches:
         #
         # Include any text prior to match as a normal text node.
         #
         if m.start() > done:
             repl.append(nodes.Text(t[done:m.start()]))
+
         #
-        # Go through the dance of getting an xref out of the C domain
-        #
-        target =3D m.group(2)
-        target_text =3D nodes.Text(m.group(0))
-        xref =3D None
-        if not (m.re =3D=3D RE_function and target in Skipfuncs):
-            lit_text =3D nodes.literal(classes=3D['xref', 'c', class_str[m=
.re]])
-            lit_text +=3D target_text
-            pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
-                                          reftype =3D reftype_str[m.re],
-                                          reftarget =3D target, modname =
=3D None,
-                                          classname =3D None)
-            #
-            # XXX The Latex builder will throw NoUri exceptions here,
-            # work around that by ignoring them.
-            #
-            try:
-                xref =3D cdom.resolve_xref(app.env, docname, app.builder,
-                                         reftype_str[m.re], target, pxref,
-                                         lit_text)
-            except NoUri:
-                xref =3D None
-        #
-        # Toss the xref into the list if we got it; otherwise just put
-        # the function text.
+        # Call the function associated with the regex that matched this te=
xt and
+        # append its return to the text
         #
-        if xref:
-            repl.append(xref)
-        else:
-            repl.append(target_text)
+        repl.append(markup_func[m.re](docname, app, m))
+
         done =3D m.end()
     if done < len(t):
         repl.append(nodes.Text(t[done:]))
     return repl
=20
+#
+# Try to replace a C reference (function() or struct/union/enum/typedef
+# type_name) with an appropriate cross reference.
+#
+def markup_c_ref(docname, app, match):
+    class_str =3D {RE_function: 'c-func', RE_type: 'c-type'}
+    reftype_str =3D {RE_function: 'function', RE_type: 'type'}
+
+    cdom =3D app.env.domains['c']
+    #
+    # Go through the dance of getting an xref out of the C domain
+    #
+    target =3D match.group(2)
+    target_text =3D nodes.Text(match.group(0))
+    xref =3D None
+    if not (match.re =3D=3D RE_function and target in Skipfuncs):
+        lit_text =3D nodes.literal(classes=3D['xref', 'c', class_str[match=
.re]])
+        lit_text +=3D target_text
+        pxref =3D addnodes.pending_xref('', refdomain =3D 'c',
+                                      reftype =3D reftype_str[match.re],
+                                      reftarget =3D target, modname =3D No=
ne,
+                                      classname =3D None)
+        #
+        # XXX The Latex builder will throw NoUri exceptions here,
+        # work around that by ignoring them.
+        #
+        try:
+            xref =3D cdom.resolve_xref(app.env, docname, app.builder,
+                                     reftype_str[match.re], target, pxref,
+                                     lit_text)
+        except NoUri:
+            xref =3D None
+    #
+    # Return the xref if we got it; otherwise just return the plain text.
+    #
+    if xref:
+        return xref
+    else:
+        return target_text
+
 def auto_markup(app, doctree, name):
     #
     # This loop could eventually be improved on.  Someday maybe we
@@ -108,7 +121,7 @@ def auto_markup(app, doctree, name):
     for para in doctree.traverse(nodes.paragraph):
         for node in para.traverse(nodes.Text):
             if not isinstance(node.parent, nodes.literal):
-                node.parent.replace(node, markup_c_refs(name, app, node))
+                node.parent.replace(node, markup_refs(name, app, node))
=20
 def setup(app):
     app.connect('doctree-resolved', auto_markup)
--=20
2.28.0


