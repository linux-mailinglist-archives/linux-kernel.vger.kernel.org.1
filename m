Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B52029FEE3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgJ3HnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgJ3HlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:05 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B302222C8;
        Fri, 30 Oct 2020 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043663;
        bh=segxH5qhIJGNNI/Ye3+evMCmvSzyDneJvAcjm8Yoz20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H09O/s9lOE7VCJcT74ssm7enzkIsq71R1eSmWF2oVB048IXDfiht15x7SLhjV+aTS
         SaUq8f/2fvwOjvwFWlZsGvGPhumB4gklEJ47wEnMumj1Vw1obKuutBAB1Y+W0dliHI
         sDM4Zq0PQoKQDy1TEamavtWNHYRAyKFLtaCNoKWI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1x-004OgH-6T; Fri, 30 Oct 2020 08:41:01 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/39] docs: ABI: make it parse ABI/stable as ReST-compatible files
Date:   Fri, 30 Oct 2020 08:40:41 +0100
Message-Id: <59ccbaa75ff05f23e701dd9a0bbe118e9343a553.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the stable ABI files are compatible with ReST,
parse them without converting complex descriptions as literal
blocks nor escaping special characters.

Please notice that escaping special characters will probably
be needed at descriptions, at least for the asterisk character.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/abi-stable.rst | 1 +
 Documentation/sphinx/kernel_abi.py       | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/abi-stable.rst b/Documentation/admin-guide/abi-stable.rst
index 7495d7a35048..70490736e0d3 100644
--- a/Documentation/admin-guide/abi-stable.rst
+++ b/Documentation/admin-guide/abi-stable.rst
@@ -11,3 +11,4 @@ Most interfaces (like syscalls) are expected to never change and always
 be available.
 
 .. kernel-abi:: $srctree/Documentation/ABI/stable
+   :rst:
diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index ce5f3b0ae811..f3da859c9878 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -73,12 +73,13 @@ class KernelCmd(Directive):
     u"""KernelABI (``kernel-abi``) directive"""
 
     required_arguments = 1
-    optional_arguments = 0
+    optional_arguments = 2
     has_content = False
     final_argument_whitespace = True
 
     option_spec = {
-        "debug"     : directives.flag
+        "debug"     : directives.flag,
+        "rst"       : directives.unchanged
     }
 
     def run(self):
@@ -92,6 +93,9 @@ class KernelCmd(Directive):
         cmd = "get_abi.pl rest --enable-lineno --dir "
         cmd += self.arguments[0]
 
+        if 'rst' in self.options:
+            cmd += " --rst-source"
+
         srctree = path.abspath(os.environ["srctree"])
 
         fname = cmd
-- 
2.26.2

