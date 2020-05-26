Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED1D1BB047
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 23:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgD0VRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 17:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgD0VRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:17:24 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEAFB2072D;
        Mon, 27 Apr 2020 21:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022243;
        bh=ibhqu9wbHO2Nr5Go+p4R/byvKmaLw8tA3rQiXg3iZfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3sE612Oi9x3zsJz4ytCpK2j1jvxW0j4WDiWxawlMHfMQ3ittvqut7Zdvd9u+tQqw
         eqpd4T2lJ/MSJvsptxzLQsQMgZ5bu2a966TZWcpxUtPLJepPg1f2RiFZotPjXBHGFN
         f6nev2QuJVkk+TxJgwgQA/8jdxQDGGp/WssEn390=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jTB7y-000Hjf-1F; Mon, 27 Apr 2020 23:17:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Subject: [PATCH v3 01/29] docs: filesystems: convert caching/object.txt to ReST
Date:   Mon, 27 Apr 2020 23:16:53 +0200
Message-Id: <49026a8ea7e714c2e0f003aa26b975b1025476b7.1588021877.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588021877.git.mchehab+huawei@kernel.org>
References: <cover.1588021877.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Adjust document and section titles;
- Comment out text ToC for html/pdf output;
- Some whitespace fixes and new line breaks;
- Adjust the events list to make them look better for html output;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/caching/fscache.txt |  2 +-
 Documentation/filesystems/caching/index.rst   |  9 ++++
 .../caching/{object.txt => object.rst}        | 43 ++++++++-----------
 Documentation/filesystems/index.rst           |  2 +
 fs/fscache/object.c                           |  2 +-
 5 files changed, 31 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/filesystems/caching/index.rst
 rename Documentation/filesystems/caching/{object.txt => object.rst} (95%)

diff --git a/Documentation/filesystems/caching/fscache.txt b/Documentation/filesystems/caching/fscache.txt
index 50f0a5757f48..071ff50a774d 100644
--- a/Documentation/filesystems/caching/fscache.txt
+++ b/Documentation/filesystems/caching/fscache.txt
@@ -191,7 +191,7 @@ The cache backend API to FS-Cache can be found in:
 A description of the internal representations and object state machine can be
 found in:
 
-	Documentation/filesystems/caching/object.txt
+	Documentation/filesystems/caching/object.rst
 
 
 =======================
diff --git a/Documentation/filesystems/caching/index.rst b/Documentation/filesystems/caching/index.rst
new file mode 100644
index 000000000000..e5ec95ff0be2
--- /dev/null
+++ b/Documentation/filesystems/caching/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Filesystem Caching
+==================
+
+.. toctree::
+   :maxdepth: 2
+
+   object
diff --git a/Documentation/filesystems/caching/object.txt b/Documentation/filesystems/caching/object.rst
similarity index 95%
rename from Documentation/filesystems/caching/object.txt
rename to Documentation/filesystems/caching/object.rst
index 100ff41127e4..ce0e043ccd33 100644
--- a/Documentation/filesystems/caching/object.txt
+++ b/Documentation/filesystems/caching/object.rst
@@ -1,10 +1,12 @@
-	     ====================================================
-	     IN-KERNEL CACHE OBJECT REPRESENTATION AND MANAGEMENT
-	     ====================================================
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================================
+In-Kernel Cache Object Representation and Management
+====================================================
 
 By: David Howells <dhowells@redhat.com>
 
-Contents:
+.. Contents:
 
  (*) Representation
 
@@ -18,8 +20,7 @@ Contents:
  (*) The set of events.
 
 
-==============
-REPRESENTATION
+Representation
 ==============
 
 FS-Cache maintains an in-kernel representation of each object that a netfs is
@@ -38,7 +39,7 @@ or even by no objects (it may not be cached).
 
 Furthermore, both cookies and objects are hierarchical.  The two hierarchies
 correspond, but the cookies tree is a superset of the union of the object trees
-of multiple caches:
+of multiple caches::
 
 	    NETFS INDEX TREE               :      CACHE 1     :      CACHE 2
 	                                   :                  :
@@ -89,8 +90,7 @@ pointers to the cookies.  The cookies themselves and any objects attached to
 those cookies are hidden from it.
 
 
-===============================
-OBJECT MANAGEMENT STATE MACHINE
+Object Management State Machine
 ===============================
 
 Within FS-Cache, each active object is managed by its own individual state
@@ -124,7 +124,7 @@ is not masked, the object will be queued for processing (by calling
 fscache_enqueue_object()).
 
 
-PROVISION OF CPU TIME
+Provision of CPU Time
 ---------------------
 
 The work to be done by the various states was given CPU time by the threads of
@@ -141,7 +141,7 @@ because:
      workqueues don't necessarily have the right numbers of threads.
 
 
-LOCKING SIMPLIFICATION
+Locking Simplification
 ----------------------
 
 Because only one worker thread may be operating on any particular object's
@@ -151,8 +151,7 @@ from the cache backend's representation (fscache_object) - which may be
 requested from either end.
 
 
-=================
-THE SET OF STATES
+The Set of States
 =================
 
 The object state machine has a set of states that it can be in.  There are
@@ -275,19 +274,17 @@ memory and potentially deletes stuff from disk:
      this state.
 
 
-THE SET OF EVENTS
+The Set of Events
 -----------------
 
 There are a number of events that can be raised to an object state machine:
 
- (*) FSCACHE_OBJECT_EV_UPDATE
-
+ FSCACHE_OBJECT_EV_UPDATE
      The netfs requested that an object be updated.  The state machine will ask
      the cache backend to update the object, and the cache backend will ask the
      netfs for details of the change through its cookie definition ops.
 
- (*) FSCACHE_OBJECT_EV_CLEARED
-
+ FSCACHE_OBJECT_EV_CLEARED
      This is signalled in two circumstances:
 
      (a) when an object's last child object is dropped and
@@ -296,20 +293,16 @@ There are a number of events that can be raised to an object state machine:
 
      This is used to proceed from the dying state.
 
- (*) FSCACHE_OBJECT_EV_ERROR
-
+ FSCACHE_OBJECT_EV_ERROR
      This is signalled when an I/O error occurs during the processing of some
      object.
 
- (*) FSCACHE_OBJECT_EV_RELEASE
- (*) FSCACHE_OBJECT_EV_RETIRE
-
+ FSCACHE_OBJECT_EV_RELEASE, FSCACHE_OBJECT_EV_RETIRE
      These are signalled when the netfs relinquishes a cookie it was using.
      The event selected depends on whether the netfs asks for the backing
      object to be retired (deleted) or retained.
 
- (*) FSCACHE_OBJECT_EV_WITHDRAW
-
+ FSCACHE_OBJECT_EV_WITHDRAW
      This is signalled when the cache backend wants to withdraw an object.
      This means that the object will have to be detached from the netfs's
      cookie.
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 0641429f53a2..f8781c13aee3 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -25,6 +25,8 @@ algorithms work.
    locking
    directory-locking
 
+   caching/index
+
    porting
 
 Filesystem support layers
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index cfeba839a0f2..efaa003b8323 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
- * See Documentation/filesystems/caching/object.txt for a description of the
+ * See Documentation/filesystems/caching/object.rst for a description of the
  * object state machine and the in-kernel representations.
  */
 
-- 
2.25.4

