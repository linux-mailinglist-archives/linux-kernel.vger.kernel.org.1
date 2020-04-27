Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E031BB036
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 23:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD0VSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 17:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgD0VR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:17:27 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E70B122202;
        Mon, 27 Apr 2020 21:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022245;
        bh=xxrO2m1szhSXLhg7ZVFFMsns3ZK7iqjIdInVfLVLim0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cg+Z31Hv2sZFBnbmCAipvwuQf400TSxzkowv7GUFAsJigZpWYjF7NrBOsGMvsm+Lz
         nKZ1sJiRJHtgk3VbXVK5rhC+zsG54ZLiC2WG9SFgEZ2LGiXdJ4thgPzuY8gwwp1NWa
         dBDNT44YjNi8tV5qZeqhuJVIma1Q5X5VHZSW2bm0=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jTB7z-000HlM-6R; Mon, 27 Apr 2020 23:17:23 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 22/29] docs: filesystems: convert spufs/spu_create.txt to ReST
Date:   Mon, 27 Apr 2020 23:17:14 +0200
Message-Id: <4d42e97d5560a79bd5dd443c592be04f9ae9a757.1588021877.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588021877.git.mchehab+huawei@kernel.org>
References: <cover.1588021877.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is at groff output format. Manually convert it to
ReST format, trying to preserve a similar output after parsed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 Documentation/filesystems/spufs/index.rst     | 11 ++++
 .../spufs/{spu_create.txt => spu_create.rst}  | 52 ++++++++++++-------
 3 files changed, 44 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/filesystems/spufs/index.rst
 rename Documentation/filesystems/spufs/{spu_create.txt => spu_create.rst} (90%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 30f1583015bd..36462b0a7836 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -106,6 +106,7 @@ Documentation for filesystem implementations.
    ramfs-rootfs-initramfs
    relay
    romfs
+   spufs/index
    squashfs
    sysfs
    sysv-fs
diff --git a/Documentation/filesystems/spufs/index.rst b/Documentation/filesystems/spufs/index.rst
new file mode 100644
index 000000000000..39553c6ebefd
--- /dev/null
+++ b/Documentation/filesystems/spufs/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+SPU Filesystem
+==============
+
+
+.. toctree::
+   :maxdepth: 1
+
+   spu_create
diff --git a/Documentation/filesystems/spufs/spu_create.txt b/Documentation/filesystems/spufs/spu_create.rst
similarity index 90%
rename from Documentation/filesystems/spufs/spu_create.txt
rename to Documentation/filesystems/spufs/spu_create.rst
index 8ede5a35340f..83108c099696 100644
--- a/Documentation/filesystems/spufs/spu_create.txt
+++ b/Documentation/filesystems/spufs/spu_create.rst
@@ -1,18 +1,26 @@
-SPU_CREATE(2)              Linux Programmer's Manual             SPU_CREATE(2)
+.. SPDX-License-Identifier: GPL-2.0
 
+==========
+spu_create
+==========
 
-
-NAME
+Name
+====
        spu_create - create a new spu context
 
 
-SYNOPSIS
-       #include <sys/types.h>
-       #include <sys/spu.h>
+Synopsis
+========
 
-       int spu_create(const char *pathname, int flags, mode_t mode);
+       ::
 
-DESCRIPTION
+         #include <sys/types.h>
+         #include <sys/spu.h>
+
+         int spu_create(const char *pathname, int flags, mode_t mode);
+
+Description
+===========
        The  spu_create  system call is used on PowerPC machines that implement
        the Cell Broadband Engine Architecture in order to  access  Synergistic
        Processor  Units (SPUs). It creates a new logical context for an SPU in
@@ -43,13 +51,15 @@ DESCRIPTION
        possible mode values.
 
 
-RETURN VALUE
+Return Value
+============
        spu_create  returns a new file descriptor. It may return -1 to indicate
        an error condition and set errno to  one  of  the  error  codes  listed
        below.
 
 
-ERRORS
+Errors
+======
        EACCES
               The  current  user does not have write access on the spufs mount
               point.
@@ -87,33 +97,35 @@ ERRORS
 
 
 
-NOTES
+Notes
+=====
        spu_create  is  meant  to  be used from libraries that implement a more
        abstract interface to SPUs, not to be used from  regular  applications.
        See  http://www.bsc.es/projects/deepcomputing/linuxoncell/ for the rec-
        ommended libraries.
 
 
-FILES
+Files
+=====
        pathname must point to a location beneath the mount point of spufs.  By
        convention, it gets mounted in /spu.
 
 
-CONFORMING TO
+Conforming to
+=============
        This call is Linux specific and only implemented by the ppc64 architec-
        ture. Programs using this system call are not portable.
 
 
-BUGS
+Bugs
+====
        The code does not yet fully implement all features lined out here.
 
 
-AUTHOR
+Author
+======
        Arnd Bergmann <arndb@de.ibm.com>
 
-SEE ALSO
+See Also
+========
        capabilities(7), close(2), spu_run(2), spufs(7)
-
-
-
-Linux                             2005-09-28                     SPU_CREATE(2)
-- 
2.25.4

