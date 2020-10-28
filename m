Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FA229D73E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbgJ1WU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731696AbgJ1WRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:41 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B23DB2476E;
        Wed, 28 Oct 2020 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895014;
        bh=RbVYiyu/rnWFPmPj9R4bvXieqOVYpclyWM2vnETsDtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kTNF5Pqjd1M4SY1bzV51A86oc9KUrFY736pMM1/DVy3MTp/dGcJf0MYBTmbhqw7zS
         a+jCuxZJgdr4Qb7aPUFKeGMWoA1w2EssdpleQJ2EdNYC58dwDKja4JKyT3kdRAhWrQ
         RTnicPpRM+JELSNJml6ExltnvUR0o8oL43wEo6HM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXmMO-003hlP-OH; Wed, 28 Oct 2020 15:23:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/33] docs: kernel_abi.py: use --enable-lineno for get_abi.pl
Date:   Wed, 28 Oct 2020 15:23:13 +0100
Message-Id: <7ae62dc8a05ece0b1c04a57dde0ad25d62d13742.1603893146.git.mchehab+huawei@kernel.org>
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

Just like kernel-doc extension, we need to be able to identify
what part of an imported document has issues, as reporting them
as:

	get_abi.pl rest --dir $srctree/Documentation/ABI/obsolete --rst-source:1689: ERROR: Unexpected indentation.

Makes a lot harder for someone to fix.

It should be noticed that it the line which will be reported is
the line where the "What:" definition is, and not the line
with actually has an error.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 8601a3b75a28..096dec482e96 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -36,6 +36,7 @@ import codecs
 import os
 import subprocess
 import sys
+import re
 
 from os import path
 
@@ -93,7 +94,7 @@ class KernelCmd(Directive):
 
         env = doc.settings.env
         cwd = path.dirname(doc.current_source)
-        cmd = "get_abi.pl rest --dir "
+        cmd = "get_abi.pl rest --enable-lineno --dir "
         cmd += self.arguments[0]
 
         srctree = path.abspath(os.environ["srctree"])
@@ -137,7 +138,7 @@ class KernelCmd(Directive):
                               % (self.name, ErrorString(exc)))
         return out
 
-    def nestedParse(self, lines, fname):
+    def nestedParse(self, lines, f):
         content = ViewList()
         node    = nodes.section()
 
@@ -147,8 +148,17 @@ class KernelCmd(Directive):
                 code_block += "\n    " + l
             lines = code_block + "\n\n"
 
-        for c, l in enumerate(lines.split("\n")):
-            content.append(l, fname, c)
+        line_regex = re.compile("^#define LINENO (\S+)\#([0-9]+)$")
+        ln = 0
+
+        for line in lines.split("\n"):
+            match = line_regex.search(line)
+            if match:
+                f = match.group(1)
+                # sphinx counts lines from 0
+                ln = int(match.group(2)) - 1
+            else:
+                content.append(line, f, ln)
 
         buf  = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter
 
-- 
2.26.2

