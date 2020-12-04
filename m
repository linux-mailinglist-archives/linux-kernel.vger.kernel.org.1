Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4742CE844
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 07:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgLDGop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 01:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbgLDGoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 01:44:37 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B92C061A52;
        Thu,  3 Dec 2020 22:43:57 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kl4oq-0001Rq-AK; Fri, 04 Dec 2020 07:43:52 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] docs: make reporting-bugs.rst obsolete
Date:   Fri,  4 Dec 2020 07:43:50 +0100
Message-Id: <3df7c2d16de112b47bb6e6158138608e78562bf5.1607063223.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607063223.git.linux@leemhuis.info>
References: <cover.1607063223.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1607064237;d850bb54;
X-HE-SMSGID: 1kl4oq-0001Rq-AK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make various places which point to
Documentation/admin-guide/reporting-bugs.rst point to
Documentation/admin-guide/reporting-issues.rst instead. That document is
brand new and as of now is not completely finished. But even at this
stage it's a lot more helpful and accurate than reporting-bugs.rst.
Hence also add a note to reporting-bugs.rst, telling people they're
better off reading reporting-issues.rst instead.

reporting-bugs.rst is scheduled for removal once reporting-issues.rst
is considered ready.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/README.rst                     | 4 ++--
 Documentation/admin-guide/bug-bisect.rst                 | 2 +-
 Documentation/admin-guide/index.rst                      | 2 +-
 Documentation/admin-guide/reporting-bugs.rst             | 5 +++++
 Documentation/admin-guide/security-bugs.rst              | 2 +-
 .../networking/device_drivers/ethernet/3com/vortex.rst   | 4 ++--
 Documentation/process/howto.rst                          | 9 ++++-----
 7 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 95a28f47ac30..261b7b4cca1f 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -398,8 +398,8 @@ If something goes wrong
 
    If you for some reason cannot do the above (you have a pre-compiled
    kernel image or similar), telling me as much about your setup as
-   possible will help.  Please read the :ref:`admin-guide/reporting-bugs.rst <reportingbugs>`
-   document for details.
+   possible will help.  Please read
+   'Documentation/admin-guide/reporting-issues.rst' for details.
 
  - Alternatively, you can use gdb on a running kernel. (read-only; i.e. you
    cannot change values or set break points.) To do this, first compile the
diff --git a/Documentation/admin-guide/bug-bisect.rst b/Documentation/admin-guide/bug-bisect.rst
index 59567da344e8..325c5d0ed34a 100644
--- a/Documentation/admin-guide/bug-bisect.rst
+++ b/Documentation/admin-guide/bug-bisect.rst
@@ -15,7 +15,7 @@ give up. Report as much as you have found to the relevant maintainer. See
 MAINTAINERS for who that is for the subsystem you have worked on.
 
 Before you submit a bug report read
-:ref:`Documentation/admin-guide/reporting-bugs.rst <reportingbugs>`.
+'Documentation/admin-guide/reporting-issues.rst'.
 
 Devices not appearing
 =====================
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index c52c1882bd04..937e1a157fc9 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -34,7 +34,7 @@ problems and bugs in particular.
    :maxdepth: 1
 
    reporting-issues
-   reporting-bugs
+   Reporting bugs (obsolete) <reporting-bugs>
    security-bugs
    bug-hunting
    bug-bisect
diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 42481ea7b41d..409fa91d7495 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -1,5 +1,10 @@
 .. _reportingbugs:
 
+.. note::
+
+   This document is obsolete, and will be replaced by
+   'Documentation/admin-guide/reporting-issues.rst' in the near future.
+
 Reporting bugs
 ++++++++++++++
 
diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
index c32eb786201c..82e29837d589 100644
--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -21,7 +21,7 @@ understand and fix the security vulnerability.
 
 As it is with any bug, the more information provided the easier it
 will be to diagnose and fix.  Please review the procedure outlined in
-:doc:`reporting-bugs` if you are unclear about what
+'Documentation/admin-guide/reporting-issues.rst' if you are unclear about what
 information is helpful.  Any exploit code is very helpful and will not
 be released without consent from the reporter unless it has already been
 made public.
diff --git a/Documentation/networking/device_drivers/ethernet/3com/vortex.rst b/Documentation/networking/device_drivers/ethernet/3com/vortex.rst
index eab10fc6da5c..e89e4192af88 100644
--- a/Documentation/networking/device_drivers/ethernet/3com/vortex.rst
+++ b/Documentation/networking/device_drivers/ethernet/3com/vortex.rst
@@ -374,8 +374,8 @@ steps you should take:
    email address will be in the driver source or in the MAINTAINERS file.
 
 - The contents of your report will vary a lot depending upon the
-  problem.  If it's a kernel crash then you should refer to the
-  admin-guide/reporting-bugs.rst file.
+  problem.  If it's a kernel crash then you should refer to
+  'Documentation/admin-guide/reporting-issues.rst'.
 
   But for most problems it is useful to provide the following:
 
diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index 20c9e07e09a4..7a5c105e34d4 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -348,11 +348,10 @@ tool.  For details on how to use the kernel bugzilla, please see:
 
 	https://bugzilla.kernel.org/page.cgi?id=faq.html
 
-The file :ref:`admin-guide/reporting-bugs.rst <reportingbugs>`
-in the main kernel source directory has a good
-template for how to report a possible kernel bug, and details what kind
-of information is needed by the kernel developers to help track down the
-problem.
+The file 'Documentation/admin-guide/reporting-issues.rst' in the main kernel
+source directory has a good template for how to report a possible kernel bug,
+and details what kind of information is needed by the kernel developers to help
+track down the problem.
 
 
 Managing bug reports
-- 
2.28.0

