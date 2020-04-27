Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B7D1BB058
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 23:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgD0VTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 17:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgD0VRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:17:25 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5324721BE5;
        Mon, 27 Apr 2020 21:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022244;
        bh=lgU5kQJKALcK/8kZC7aKJ8WIXmn4TvXevTBP41xPg8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q4J4cCfqihrVC7CO2CYq5CGeorm9gdyNVZjW2EqBq6dhxHWbCcgtXbvnJvLCmHo7s
         wjxoubYj/WumY37FO8Z899gILQvTGYGXxeWdytLjOMBeRxhSLxt019JV6n9gaboeK6
         dRykYy7lWYEnSk7DK9GrHaF9c6d5j9OldKPo1NkM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jTB7y-000HkO-IL; Mon, 27 Apr 2020 23:17:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 10/29] docs: filesystems: convert devpts.txt to ReST
Date:   Mon, 27 Apr 2020 23:17:02 +0200
Message-Id: <4ac8f3a7edd4d817acf0d173ead7ef74fe010c6c.1588021877.git.mchehab+huawei@kernel.org>
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
- Add a document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/sysctl/kernel.rst |  2 +-
 Documentation/filesystems/devpts.rst        | 36 +++++++++++++++++++++
 Documentation/filesystems/devpts.txt        | 26 ---------------
 Documentation/filesystems/index.rst         |  1 +
 4 files changed, 38 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/filesystems/devpts.rst
 delete mode 100644 Documentation/filesystems/devpts.txt

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index fce1c059fbab..474cabfac468 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -921,7 +921,7 @@ this sysctl interface anymore.
 pty
 ===
 
-See Documentation/filesystems/devpts.txt.
+See Documentation/filesystems/devpts.rst.
 
 
 randomize_va_space
diff --git a/Documentation/filesystems/devpts.rst b/Documentation/filesystems/devpts.rst
new file mode 100644
index 000000000000..a03248ddfb4c
--- /dev/null
+++ b/Documentation/filesystems/devpts.rst
@@ -0,0 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+The Devpts Filesystem
+=====================
+
+Each mount of the devpts filesystem is now distinct such that ptys
+and their indicies allocated in one mount are independent from ptys
+and their indicies in all other mounts.
+
+All mounts of the devpts filesystem now create a ``/dev/pts/ptmx`` node
+with permissions ``0000``.
+
+To retain backwards compatibility the a ptmx device node (aka any node
+created with ``mknod name c 5 2``) when opened will look for an instance
+of devpts under the name ``pts`` in the same directory as the ptmx device
+node.
+
+As an option instead of placing a ``/dev/ptmx`` device node at ``/dev/ptmx``
+it is possible to place a symlink to ``/dev/pts/ptmx`` at ``/dev/ptmx`` or
+to bind mount ``/dev/ptx/ptmx`` to ``/dev/ptmx``.  If you opt for using
+the devpts filesystem in this manner devpts should be mounted with
+the ``ptmxmode=0666``, or ``chmod 0666 /dev/pts/ptmx`` should be called.
+
+Total count of pty pairs in all instances is limited by sysctls::
+
+    kernel.pty.max = 4096	- global limit
+    kernel.pty.reserve = 1024	- reserved for filesystems mounted from the initial mount namespace
+    kernel.pty.nr		- current count of ptys
+
+Per-instance limit could be set by adding mount option ``max=<count>``.
+
+This feature was added in kernel 3.4 together with
+``sysctl kernel.pty.reserve``.
+
+In kernels older than 3.4 sysctl ``kernel.pty.max`` works as per-instance limit.
diff --git a/Documentation/filesystems/devpts.txt b/Documentation/filesystems/devpts.txt
deleted file mode 100644
index 9f94fe276dea..000000000000
--- a/Documentation/filesystems/devpts.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Each mount of the devpts filesystem is now distinct such that ptys
-and their indicies allocated in one mount are independent from ptys
-and their indicies in all other mounts.
-
-All mounts of the devpts filesystem now create a /dev/pts/ptmx node
-with permissions 0000.
-
-To retain backwards compatibility the a ptmx device node (aka any node
-created with "mknod name c 5 2") when opened will look for an instance
-of devpts under the name "pts" in the same directory as the ptmx device
-node.
-
-As an option instead of placing a /dev/ptmx device node at /dev/ptmx
-it is possible to place a symlink to /dev/pts/ptmx at /dev/ptmx or
-to bind mount /dev/ptx/ptmx to /dev/ptmx.  If you opt for using
-the devpts filesystem in this manner devpts should be mounted with
-the ptmxmode=0666, or chmod 0666 /dev/pts/ptmx should be called.
-
-Total count of pty pairs in all instances is limited by sysctls:
-kernel.pty.max = 4096		- global limit
-kernel.pty.reserve = 1024	- reserved for filesystems mounted from the initial mount namespace
-kernel.pty.nr			- current count of ptys
-
-Per-instance limit could be set by adding mount option "max=<count>".
-This feature was added in kernel 3.4 together with sysctl kernel.pty.reserve.
-In kernels older than 3.4 sysctl kernel.pty.max works as per-instance limit.
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 9a7021bcb91f..10207f158a3e 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -24,6 +24,7 @@ algorithms work.
    splice
    locking
    directory-locking
+   devpts
 
    automount-support
 
-- 
2.25.4

