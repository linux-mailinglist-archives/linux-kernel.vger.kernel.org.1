Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A9A277685
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgIXQVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgIXQVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:21:53 -0400
Received: from mail.kernel.org (ip5f5ad5c4.dynamic.kabel-deutschland.de [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 492DE2311B;
        Thu, 24 Sep 2020 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600964512;
        bh=+dpjmYWc6xwsu3KtKMm2ZusLC9NPxNgjvUVnQyxzmaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TiyK1fUm8IYt1B5yPpzllv/SPI66Rx1F4aOSBfvCb4gPfkzztkV6xizkFcx/DYQ6I
         oWBrBSg9t9/LXliB4S1174vhsZGbAK+QwtIpg8f/m1o7maICYs2mmmmz0ZnOkl+Z8e
         IX5MJbrOmYRYEWX724YJM0WY3JuUabjtvdP8/USY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kLU0E-000KGc-5M; Thu, 24 Sep 2020 18:21:50 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] docs: cdomain.py: add support for two new Sphinx 3.1+ tags
Date:   Thu, 24 Sep 2020 18:21:45 +0200
Message-Id: <64f6f8bc4c416bcf1a6439529346ec6cbcf34ac1.1600963096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600963096.git.mchehab+huawei@kernel.org>
References: <cover.1600963096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Sphinx 3.0, the C domain code was rewritten, but only
after version 3.1 it got support for setting namespaces on
C domains, with is something that it is required, in order to
document system calls, like ioctl() and others.

As part of changing the documentation subsystem to properly
build with Sphinx 3.1+, add support for two tags:

	- :c:expr:`foo`
	- .. c:namespace::"

The first one just replaces the expresion by ``foo``, with
produces a monotext expression.

The second one replaces the optional "name" tag for functions,
setting a domain for all C references found after its usage.

With that, it should be possible to convert the existing
documentation to be compatible with both Sphinx 1.x/2.x and
3.1+.

Unfortunately, building the documentation with Sphinx 3.0
will produce lots of warnings, because the namespace tag
doesn't exist there, with will cause both warnings for the
usage of a non-existing tag and warnings about multiple
definitions for system calls. There's not much we can
do to solve such issues.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/cdomain.py | 56 ++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
index cbac8e608dc4..3f6228787282 100644
--- a/Documentation/sphinx/cdomain.py
+++ b/Documentation/sphinx/cdomain.py
@@ -40,14 +40,61 @@ from sphinx import addnodes
 from sphinx.domains.c import c_funcptr_sig_re, c_sig_re
 from sphinx.domains.c import CObject as Base_CObject
 from sphinx.domains.c import CDomain as Base_CDomain
+from itertools import chain
+import re
 
-__version__  = '1.0'
+__version__  = '1.1'
 
 # Get Sphinx version
 major, minor, patch = sphinx.version_info[:3]
 
+# Namespace to be prepended to the full name
+namespace = None
+
+#
+# Handle trivial newer c domain tags that are part of Sphinx 3.1 c domain tags
+# - Convert :c:expr:`foo` into ``foo``
+# - Store the namespace if ".. c:namespace::" tag is found
+
+RE_namespace = re.compile(r'^\s*..\s*c:namespace::\s*(\S+)\s*$')
+RE_expr = re.compile(r':c:expr:`([^\`]+)`')
+
+def markup_namespace(match):
+    namespace = match.group(1)
+
+    return ""
+
+def markup_c_expr(match):
+
+    return '\ ``' + match.group(1) + '``\ '
+
+def c_markups(app, docname, source):
+    result = ""
+    markup_func = {
+        RE_namespace: markup_namespace,
+        RE_expr: markup_c_expr
+    }
+
+    lines = iter(source[0].splitlines(True))
+    for n in lines:
+        match_iterators = [regex.finditer(n) for regex in markup_func]
+        matches = sorted(chain(*match_iterators), key=lambda m: m.start())
+        for m in matches:
+            n = n[:m.start()] + markup_func[m.re](m) + n[m.end():]
+
+        result = result + n
+
+    source[0] = result
+
+#
+# Now implements support for the cdomain namespacing logic
+#
+
 def setup(app):
 
+    # Handle easy Sphinx 3.1+ simple new tags: :c:expr and .. c:namespace::
+    app.connect('source-read', c_markups)
+
     if (major == 1 and minor < 8):
         app.override_domain(CDomain)
     else:
@@ -107,6 +154,9 @@ class CObject(Base_CObject):
             param += nodes.emphasis(argname, argname)
             paramlist += param
 
+        if namespace:
+            fullname = namespace + "." + fullname
+
         return fullname
 
     def handle_signature(self, sig, signode):
@@ -122,6 +172,10 @@ class CObject(Base_CObject):
             else:
                 # FIXME: handle :name: value of other declaration types?
                 pass
+        else:
+            if namespace:
+                fullname = namespace + "." + fullname
+
         return fullname
 
     def add_target_and_index(self, name, sig, signode):
-- 
2.26.2

