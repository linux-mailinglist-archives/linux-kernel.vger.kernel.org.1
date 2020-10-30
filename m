Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D9E29FEE2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgJ3Hm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgJ3HlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:05 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABD0422249;
        Fri, 30 Oct 2020 07:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043662;
        bh=RSLlp7NFOho2DOxE67B0Km3fmvoT/Ed43tCyvFwn4sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AnkZ7pNsgqubpz5jGi6zGKZjzVBM2pH6nOtPne5s0/UkGE+Nac6Hx+Yq5BZwpvPr3
         eJGUE+yMS+QY9BQIEqm7FW1I4FmYMyTsk1EhjWkpZ0JwAFW619B3cWx/vgkPq1hZHn
         JXRn34/ROsSoa+1MfFnomjg/9zRmpW6EPiBTmSlc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1w-004Oft-ON; Fri, 30 Oct 2020 08:41:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/39] docs: kernel_abi.py: Handle with a lazy Sphinx parser
Date:   Fri, 30 Oct 2020 08:40:35 +0100
Message-Id: <4659b60795739308e34d2d00c57ee0742a9cd2ab.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sphinx docutils parser is lazy: if the content is bigger than
a certain number of lines, it silenlty stops parsing it,
producing an incomplete content. This seems to be worse on newer
Sphinx versions, like 2.0.

So, change the logic to parse the contents per input file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 39 ++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 096dec482e96..ce5f3b0ae811 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -37,6 +37,7 @@ import os
 import subprocess
 import sys
 import re
+import kernellog
 
 from os import path
 
@@ -80,12 +81,6 @@ class KernelCmd(Directive):
         "debug"     : directives.flag
     }
 
-    def warn(self, message, **replace):
-        replace["fname"]   = self.state.document.current_source
-        replace["line_no"] = replace.get("line_no", self.lineno)
-        message = ("%(fname)s:%(line_no)s: [kernel-abi WARN] : " + message) % replace
-        self.state.document.settings.env.app.warn(message, prefix="")
-
     def run(self):
 
         doc = self.state.document
@@ -111,7 +106,7 @@ class KernelCmd(Directive):
         shell_env["srctree"] = srctree
 
         lines = self.runCmd(cmd, shell=True, cwd=cwd, env=shell_env)
-        nodeList = self.nestedParse(lines, fname)
+        nodeList = self.nestedParse(lines, self.arguments[0])
         return nodeList
 
     def runCmd(self, cmd, **kwargs):
@@ -138,9 +133,9 @@ class KernelCmd(Directive):
                               % (self.name, ErrorString(exc)))
         return out
 
-    def nestedParse(self, lines, f):
+    def nestedParse(self, lines, fname):
         content = ViewList()
-        node    = nodes.section()
+        node = nodes.section()
 
         if "debug" in self.options:
             code_block = "\n\n.. code-block:: rst\n    :linenos:\n"
@@ -150,22 +145,42 @@ class KernelCmd(Directive):
 
         line_regex = re.compile("^#define LINENO (\S+)\#([0-9]+)$")
         ln = 0
+        n = 0
+        f = fname
 
         for line in lines.split("\n"):
+            n = n + 1
             match = line_regex.search(line)
             if match:
-                f = match.group(1)
+                new_f = match.group(1)
+
+                # Sphinx parser is lazy: it stops parsing contents in the
+                # middle, if it is too big. So, handle it per input file
+                if new_f != f and content:
+                    self.do_parse(content, node)
+                    content = ViewList()
+
+                f = new_f
+
                 # sphinx counts lines from 0
                 ln = int(match.group(2)) - 1
             else:
                 content.append(line, f, ln)
 
-        buf  = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
+        kernellog.info(self.state.document.settings.env.app, "%s: parsed %i lines" % (fname, n))
 
+        if content:
+            self.do_parse(content, node)
+
+        return node.children
+
+    def do_parse(self, content, node):
         if Use_SSI:
             with switch_source_input(self.state, content):
                 self.state.nested_parse(content, 0, node, match_titles=1)
         else:
+            buf  = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
+
             self.state.memo.title_styles  = []
             self.state.memo.section_level = 0
             self.state.memo.reporter      = AutodocReporter(content, self.state.memo.reporter)
@@ -173,5 +188,3 @@ class KernelCmd(Directive):
                 self.state.nested_parse(content, 0, node, match_titles=1)
             finally:
                 self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = buf
-
-        return node.children
-- 
2.26.2

