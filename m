Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DC329DEA2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbgJ1WRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731512AbgJ1WR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:27 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EABC2476C;
        Wed, 28 Oct 2020 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895014;
        bh=sG7DxcBFx0WTmu9b/Xo07LGFBwzzXb1v/PwdPGAsbeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lSxeqrXIceioIEcPe2aPxku+6Se4OlsR3goLHo+5mDm6nNj1ufRzuBeqtVpfnHsg+
         NMKMKYmEo7AdPY4FYzApiKKD9Q4Ps3vfx4Xp+p9mkkbcOjes7/QODzUR9pgAWwmMLD
         Ayn9Ov1vSwqM7wUNQaxJXvhYyJDbNjQYU2XdyLJ4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXmMO-003hlJ-Kg; Wed, 28 Oct 2020 15:23:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/33] docs: kernel_abi.py: fix UTF-8 support
Date:   Wed, 28 Oct 2020 15:23:11 +0100
Message-Id: <e84aa37199d3ec80e9685d985acbef2232195a49.1603893146.git.mchehab+huawei@kernel.org>
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

The parser breaks with UTF-8 characters with Sphinx 1.4.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index f8e7a02066c2..fe69c213716d 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -1,5 +1,7 @@
 # -*- coding: utf-8; mode: python -*-
+# coding=utf-8
 # SPDX-License-Identifier: GPL-2.0
+#
 u"""
     kernel-abi
     ~~~~~~~~~~
@@ -30,6 +32,7 @@ u"""
 
 """
 
+import codecs
 import sys
 import os
 from os import path
@@ -45,14 +48,6 @@ from docutils.utils.error_reporting import ErrorString
 
 __version__  = '1.0'
 
-# We can't assume that six is installed
-PY3 = sys.version_info[0] == 3
-PY2 = sys.version_info[0] == 2
-if PY3:
-    # pylint: disable=C0103, W0622
-    unicode     = str
-    basestring  = str
-
 def setup(app):
 
     app.add_directive("kernel-abi", KernelCmd)
@@ -117,12 +112,12 @@ class KernelCmd(Directive):
                 cmd
                 , stdout = subprocess.PIPE
                 , stderr = subprocess.PIPE
-                , universal_newlines = True
                 , **kwargs
             )
             out, err = proc.communicate()
-            if err:
-                self.warn(err)
+
+            out, err = codecs.decode(out, 'utf-8'), codecs.decode(err, 'utf-8')
+
             if proc.returncode != 0:
                 raise self.severe(
                     u"command '%s' failed with return code %d"
@@ -131,7 +126,7 @@ class KernelCmd(Directive):
         except OSError as exc:
             raise self.severe(u"problems with '%s' directive: %s."
                               % (self.name, ErrorString(exc)))
-        return unicode(out)
+        return out
 
     def nestedParse(self, lines, fname):
         content = ViewList()
-- 
2.26.2

