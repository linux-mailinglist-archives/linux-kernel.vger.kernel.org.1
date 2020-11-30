Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B512C8838
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgK3Phn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbgK3Phn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:37:43 -0500
Received: from mail.kernel.org (ip5f5ad5b3.dynamic.kabel-deutschland.de [95.90.213.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD02A207FF;
        Mon, 30 Nov 2020 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606750604;
        bh=xO4S5NkIBdZ9OiG/3a+NJUdrNzV84loqbWK//hcnEx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0BXSsg1t0cWlTnNMBuhw0LnzRv4mBwghl+eLjna66P0gd3bFVLbychQH6FTTMT1hP
         54yzAUhDgIqY99SUFoeaf0M9z6scMi29r9YqXDktl/8W/aolk8/1vX3cKPRaIGxLg9
         3Ddsw1/4V+uTIbrLbcMwpRE23R5JeE5rplAm02qM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kjlEI-00CjvP-FU; Mon, 30 Nov 2020 16:36:42 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] sphinx: kernel_feat.py: add a script to parse feature files
Date:   Mon, 30 Nov 2020 16:36:33 +0100
Message-Id: <bb2e51e5aa883e2583a4a6280f1c1b391bd8ef4c.1606748711.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606748711.git.mchehab+huawei@kernel.org>
References: <cover.1606748711.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature files have a special well-defined format. Add
a script that parses them, allowing to search for a feature
and/or by an architecture and to produce ReST-compatible
outputs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_feat.py | 169 ++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 Documentation/sphinx/kernel_feat.py

diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
new file mode 100644
index 000000000000..2fee04f1dedd
--- /dev/null
+++ b/Documentation/sphinx/kernel_feat.py
@@ -0,0 +1,169 @@
+# coding=utf-8
+# SPDX-License-Identifier: GPL-2.0
+#
+u"""
+    kernel-feat
+    ~~~~~~~~~~~
+
+    Implementation of the ``kernel-feat`` reST-directive.
+
+    :copyright:  Copyright (C) 2016  Markus Heiser
+    :copyright:  Copyright (C) 2016-2019  Mauro Carvalho Chehab
+    :maintained-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
+    :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
+
+    The ``kernel-feat`` (:py:class:`KernelFeat`) directive calls the
+    scripts/get_feat.pl script to parse the Kernel ABI files.
+
+    Overview of directive's argument and options.
+
+    .. code-block:: rst
+
+        .. kernel-feat:: <ABI directory location>
+            :debug:
+
+    The argument ``<ABI directory location>`` is required. It contains the
+    location of the ABI files to be parsed.
+
+    ``debug``
+      Inserts a code-block with the *raw* reST. Sometimes it is helpful to see
+      what reST is generated.
+
+"""
+
+import codecs
+import os
+import subprocess
+import sys
+
+from os import path
+
+from docutils import nodes, statemachine
+from docutils.statemachine import ViewList
+from docutils.parsers.rst import directives, Directive
+from docutils.utils.error_reporting import ErrorString
+
+#
+# AutodocReporter is only good up to Sphinx 1.7
+#
+import sphinx
+
+Use_SSI = sphinx.__version__[:3] >= '1.7'
+if Use_SSI:
+    from sphinx.util.docutils import switch_source_input
+else:
+    from sphinx.ext.autodoc import AutodocReporter
+
+__version__  = '1.0'
+
+def setup(app):
+
+    app.add_directive("kernel-feat", KernelFeat)
+    return dict(
+        version = __version__
+        , parallel_read_safe = True
+        , parallel_write_safe = True
+    )
+
+class KernelFeat(Directive):
+
+    u"""KernelFeat (``kernel-feat``) directive"""
+
+    required_arguments = 1
+    optional_arguments = 2
+    has_content = False
+    final_argument_whitespace = True
+
+    option_spec = {
+        "debug"     : directives.flag
+    }
+
+    def warn(self, message, **replace):
+        replace["fname"]   = self.state.document.current_source
+        replace["line_no"] = replace.get("line_no", self.lineno)
+        message = ("%(fname)s:%(line_no)s: [kernel-feat WARN] : " + message) % replace
+        self.state.document.settings.env.app.warn(message, prefix="")
+
+    def run(self):
+
+        doc = self.state.document
+        if not doc.settings.file_insertion_enabled:
+            raise self.warning("docutils: file insertion disabled")
+
+        env = doc.settings.env
+        cwd = path.dirname(doc.current_source)
+        cmd = "get_feat.pl rest --dir "
+        cmd += self.arguments[0]
+
+        if len(self.arguments) > 1:
+            cmd += " --arch " + self.arguments[1]
+
+        srctree = path.abspath(os.environ["srctree"])
+
+        fname = cmd
+
+        # extend PATH with $(srctree)/scripts
+        path_env = os.pathsep.join([
+            srctree + os.sep + "scripts",
+            os.environ["PATH"]
+        ])
+        shell_env = os.environ.copy()
+        shell_env["PATH"]    = path_env
+        shell_env["srctree"] = srctree
+
+        lines = self.runCmd(cmd, shell=True, cwd=cwd, env=shell_env)
+        nodeList = self.nestedParse(lines, fname)
+        return nodeList
+
+    def runCmd(self, cmd, **kwargs):
+        u"""Run command ``cmd`` and return it's stdout as unicode."""
+
+        try:
+            proc = subprocess.Popen(
+                cmd
+                , stdout = subprocess.PIPE
+                , stderr = subprocess.PIPE
+                , **kwargs
+            )
+            out, err = proc.communicate()
+
+            out, err = codecs.decode(out, 'utf-8'), codecs.decode(err, 'utf-8')
+
+            if proc.returncode != 0:
+                raise self.severe(
+                    u"command '%s' failed with return code %d"
+                    % (cmd, proc.returncode)
+                )
+        except OSError as exc:
+            raise self.severe(u"problems with '%s' directive: %s."
+                              % (self.name, ErrorString(exc)))
+        return out
+
+    def nestedParse(self, lines, fname):
+        content = ViewList()
+        node    = nodes.section()
+
+        if "debug" in self.options:
+            code_block = "\n\n.. code-block:: rst\n    :linenos:\n"
+            for l in lines.split("\n"):
+                code_block += "\n    " + l
+            lines = code_block + "\n\n"
+
+        for c, l in enumerate(lines.split("\n")):
+            content.append(l, fname, c)
+
+        buf  = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
+
+        if Use_SSI:
+            with switch_source_input(self.state, content):
+                self.state.nested_parse(content, 0, node, match_titles=1)
+        else:
+            self.state.memo.title_styles  = []
+            self.state.memo.section_level = 0
+            self.state.memo.reporter      = AutodocReporter(content, self.state.memo.reporter)
+            try:
+                self.state.nested_parse(content, 0, node, match_titles=1)
+            finally:
+                self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = buf
+
+        return node.children
-- 
2.28.0

