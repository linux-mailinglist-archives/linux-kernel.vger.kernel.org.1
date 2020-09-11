Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B42665AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgIKRJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:09:50 -0400
Received: from mail-41104.protonmail.ch ([185.70.41.104]:58561 "EHLO
        mail-41104.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgIKO7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 10:59:32 -0400
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com [91.134.188.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id 1BEBB20164A9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:36:53 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="m3qIqcqa"
Date:   Fri, 11 Sep 2020 13:34:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1599831289;
        bh=wBAL3KNSf46hGOkih/JyGKEDyIFMOn3a0k5iOcpB9C4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=m3qIqcqa098sS8XekOZEjH/qHXHIa+KZI06RzjozVpiIfy7SDv7RH3PvBA4vAr/MI
         J5riN4LyHXJh4ywJJb/MXdJlDozUOO1LbVht3ZHFxPk+v5X1O2uaW1WUU786saXthY
         9pzT0A122+1q4jvcXMSn8IGPc8LvUV6qQU+uHHZU=
To:     Jonathan Corbet <corbet@lwn.net>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH 2/3] docs: Add automatic cross-reference for documentation pages
Message-ID: <20200911133339.327721-3-nfraprado@protonmail.com>
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

Cross-referencing to other documentation pages is possible using the
:doc:`doc-file` directive from Sphinx.

Add automatic markup for references to other documentation pages in the
format Documentation/subfolder/doc-file.rst (the extension being
optional).
This requires that the path be passed all the way from the Documentation
folder, which can be longer than passing a relative path through the
:doc: directive, but avoids the markup, making the text cleaner when
read in plain text.

Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
---
 Documentation/sphinx/automarkup.py | 39 +++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/auto=
markup.py
index 6c8e8475eddb..a1b0f554cd82 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -24,6 +24,11 @@ from itertools import chain
 #
 RE_function =3D re.compile(r'(([\w_][\w\d_]+)\(\))')
 RE_type =3D re.compile(r'(struct|union|enum|typedef)\s+([\w_][\w\d_]+)')
+#
+# Detects a reference to a documentation page of the form Documentation/..=
. with
+# an optional extension
+#
+RE_doc =3D re.compile(r'Documentation(/[\w\-_/]+)(\.\w+)*')
=20
 #
 # Many places in the docs refer to common system calls.  It is
@@ -44,7 +49,8 @@ def markup_refs(docname, app, node):
     # Associate each regex with the function that will markup its matches
     #
     markup_func =3D {RE_type: markup_c_ref,
-                   RE_function: markup_c_ref}
+                   RE_function: markup_c_ref,
+                   RE_doc: markup_doc_ref}
     match_iterators =3D [regex.finditer(t) for regex in markup_func]
     #
     # Sort all references by the starting position in text
@@ -108,6 +114,37 @@ def markup_c_ref(docname, app, match):
     else:
         return target_text
=20
+#
+# Try to replace a documentation reference of the form Documentation/... w=
ith a
+# cross reference to that page
+#
+def markup_doc_ref(docname, app, match):
+    stddom =3D app.env.domains['std']
+    #
+    # Go through the dance of getting an xref out of the std domain
+    #
+    target =3D match.group(1)
+    xref =3D None
+    pxref =3D addnodes.pending_xref('', refdomain =3D 'std', reftype =3D '=
doc',
+                                  reftarget =3D target, modname =3D None,
+                                  classname =3D None, refexplicit =3D Fals=
e)
+    #
+    # XXX The Latex builder will throw NoUri exceptions here,
+    # work around that by ignoring them.
+    #
+    try:
+        xref =3D stddom.resolve_xref(app.env, docname, app.builder, 'doc',
+                                   target, pxref, None)
+    except NoUri:
+        xref =3D None
+    #
+    # Return the xref if we got it; otherwise just return the plain text.
+    #
+    if xref:
+        return xref
+    else:
+        return nodes.Text(match.group(0))
+
 def auto_markup(app, doctree, name):
     #
     # This loop could eventually be improved on.  Someday maybe we
--=20
2.28.0


