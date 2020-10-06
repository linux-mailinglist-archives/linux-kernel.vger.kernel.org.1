Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDD2284CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgJFODz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:32852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgJFODy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:54 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6693920796;
        Tue,  6 Oct 2020 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993033;
        bh=efSy3EsZtYlchN7NNLMKbFLNt9OD+EOXOZ/6wuSW+N0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xfvaeKsvo+7aDuSllVA0FwFRqbRF/iFnpSpbV4mqX1KAVhH4XyIhPYEjQI9m/Q7hH
         kEaPSdjh2ovX7WyoytWakrbDoaCDwLpwFSa06HCcNeNj/ERcoN0Fo/Amf0f9H7uAVQ
         xTNt0ap3hcoo0X12cHCmrm+aH64F5lWy+zqjAb5I=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZH-0019Ez-E1; Tue, 06 Oct 2020 16:03:51 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>, Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/52] docs: kerneldoc.py: add support for kerneldoc -nosymbol
Date:   Tue,  6 Oct 2020 16:03:09 +0200
Message-Id: <ed1e5f394afb1f9f80f3033969d4c81d8ae7db97.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there's no way to exclude identifiers from
a kernel-doc markup. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/doc-guide/kernel-doc.rst | 8 ++++++++
 Documentation/sphinx/kerneldoc.py      | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 4fd86c21397b..52a87ab4c99f 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -490,6 +490,14 @@ identifiers: *[ function/type ...]*
     .. kernel-doc:: lib/idr.c
        :identifiers:
 
+no-identifiers: *[ function/type ...]*
+  Exclude documentation for each *function* and *type* in *source*.
+
+  Example::
+
+    .. kernel-doc:: lib/bitmap.c
+       :no-identifiers: bitmap_parselist
+
 functions: *[ function/type ...]*
   This is an alias of the 'identifiers' directive and deprecated.
 
diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index a3a5427130da..e9857ab904f1 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -62,6 +62,7 @@ class KernelDocDirective(Directive):
         'export': directives.unchanged,
         'internal': directives.unchanged,
         'identifiers': directives.unchanged,
+        'no-identifiers': directives.unchanged,
         'functions': directives.unchanged,
     }
     has_content = False
@@ -104,6 +105,12 @@ class KernelDocDirective(Directive):
             else:
                 cmd += ['-no-doc-sections']
 
+        if 'no-identifiers' in self.options:
+            no_identifiers = self.options.get('no-identifiers').split()
+            if no_identifiers:
+                for i in no_identifiers:
+                    cmd += ['-nosymbol', i]
+
         for pattern in export_file_patterns:
             for f in glob.glob(env.config.kerneldoc_srctree + '/' + pattern):
                 env.note_dependency(os.path.abspath(f))
-- 
2.26.2

