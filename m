Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B347229DF53
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbgJ2BAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731527AbgJ1WR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:28 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C075324779;
        Wed, 28 Oct 2020 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895014;
        bh=V6QsyZd0PXEAsCDZS8qFtNNLXeIRdLWFm77WuVZ8lA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0XU6g0bjbDZZiP1h3QlLK7KrQqsR1fW8Zh8Zyty2Oj+TlyRc+LzEfJm7Dhr/kNv3p
         8529FtRY6gS2gDn7GFvxuC6ifNQopDvYsrfzEi/sqglM4T5YB+W0WGNgg18DJisFju
         DGnGY37w9rVKA+VTms7GAkxgDODh5lT7d/IrkL48=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXmMO-003hlS-Pu; Wed, 28 Oct 2020 15:23:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/33] docs: kernel_abi.py: Handle with a lazy Sphinx parser
Date:   Wed, 28 Oct 2020 15:23:14 +0100
Message-Id: <4995a3d4e28b3dc50ecab3f3dee020b6005867d7.1603893146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603893146.git.mchehab+huawei@kernel.org>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

The Sphinx docutils parser is lazy: if the content is bigger than
a certain number of lines, it silenlty stops parsing it,
producing an incomplete content. This seems to be worse on newer
Sphinx versions, like 2.0.

So, change the logic to parse the contents per input file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
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

