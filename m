Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779581AAA32
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634485AbgDOOh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 10:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394089AbgDOOdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:33:05 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1117221EA;
        Wed, 15 Apr 2020 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961172;
        bh=S+Euk9oHhmfilRY+lsBzopI5g3W+nxnpkfKBSclUXC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Yj8RCF6MCTBaqPooIEsJpaHO5HUVpcjXi+keyMTNr2EACIqBPhgg+sixBLZre1Xv
         pl+tPGHlkJQD7ArSHEYIO8/4u4xj3f4bIpRzqhGyHZsoeoVVlfieJOszcJnAVOduTd
         MWKjYWWTareblHtQCnXqACjyWWCklIDvDEG0tJPQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5u-006kQ5-3w; Wed, 15 Apr 2020 16:32:50 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 30/34] docs: filesystems: convert spufs/spu_run.txt to ReST
Date:   Wed, 15 Apr 2020 16:32:43 +0200
Message-Id: <2a6a774ce0d3c2a71391235a80a9d9f0db6242aa.1586960617.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586960617.git.mchehab+huawei@kernel.org>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
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
 Documentation/filesystems/spufs/index.rst     |  1 +
 .../spufs/{spu_run.txt => spu_run.rst}        | 65 ++++++++++++-------
 2 files changed, 42 insertions(+), 24 deletions(-)
 rename Documentation/filesystems/spufs/{spu_run.txt => spu_run.rst} (84%)

diff --git a/Documentation/filesystems/spufs/index.rst b/Documentation/filesystems/spufs/index.rst
index 939cf59a7d9e..5ed4a8494967 100644
--- a/Documentation/filesystems/spufs/index.rst
+++ b/Documentation/filesystems/spufs/index.rst
@@ -10,3 +10,4 @@ SPU Filesystem
 
    spufs
    spu_create
+   spu_run
diff --git a/Documentation/filesystems/spufs/spu_run.txt b/Documentation/filesystems/spufs/spu_run.rst
similarity index 84%
rename from Documentation/filesystems/spufs/spu_run.txt
rename to Documentation/filesystems/spufs/spu_run.rst
index d5c6a00d0f97..7fdb1c31cb91 100644
--- a/Documentation/filesystems/spufs/spu_run.txt
+++ b/Documentation/filesystems/spufs/spu_run.rst
@@ -1,17 +1,26 @@
-SPU_RUN(2)                 Linux Programmer's Manual                SPU_RUN(2)
+.. SPDX-License-Identifier: GPL-2.0
 
+=======
+spu_run
+=======
 
 
-NAME
+Name
+====
        spu_run - execute an spu context
 
 
-SYNOPSIS
-       #include <sys/spu.h>
+Synopsis
+========
 
-       int spu_run(int fd, unsigned int *npc, unsigned int *event);
+       ::
 
-DESCRIPTION
+	    #include <sys/spu.h>
+
+	    int spu_run(int fd, unsigned int *npc, unsigned int *event);
+
+Description
+===========
        The  spu_run system call is used on PowerPC machines that implement the
        Cell Broadband Engine Architecture in order to access Synergistic  Pro-
        cessor  Units  (SPUs).  It  uses the fd that was returned from spu_cre-
@@ -45,24 +54,31 @@ DESCRIPTION
        If NULL is passed as the event argument, these errors will result in  a
        signal delivered to the calling process.
 
-RETURN VALUE
+Return Value
+============
        spu_run  returns the value of the spu_status register or -1 to indicate
        an error and set errno to one of the error  codes  listed  below.   The
        spu_status  register  value  contains  a  bit  mask of status codes and
        optionally a 14 bit code returned from the stop-and-signal  instruction
        on the SPU. The bit masks for the status codes are:
 
-       0x02   SPU was stopped by stop-and-signal.
+       0x02
+	      SPU was stopped by stop-and-signal.
 
-       0x04   SPU was stopped by halt.
+       0x04
+	      SPU was stopped by halt.
 
-       0x08   SPU is waiting for a channel.
+       0x08
+	      SPU is waiting for a channel.
 
-       0x10   SPU is in single-step mode.
+       0x10
+	      SPU is in single-step mode.
 
-       0x20   SPU has tried to execute an invalid instruction.
+       0x20
+	      SPU has tried to execute an invalid instruction.
 
-       0x40   SPU has tried to access an invalid channel.
+       0x40
+	      SPU has tried to access an invalid channel.
 
        0x3fff0000
               The  bits  masked with this value contain the code returned from
@@ -71,7 +87,8 @@ RETURN VALUE
        There are always one or more of the lower eight bits set  or  an  error
        code is returned from spu_run.
 
-ERRORS
+Errors
+======
        EAGAIN or EWOULDBLOCK
               fd is in non-blocking mode and spu_run would block.
 
@@ -93,29 +110,29 @@ ERRORS
               not loaded.
 
 
-NOTES
+Notes
+=====
        spu_run  is  meant  to  be  used  from  libraries that implement a more
        abstract interface to SPUs, not to be used from  regular  applications.
        See  http://www.bsc.es/projects/deepcomputing/linuxoncell/ for the rec-
        ommended libraries.
 
 
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
        capabilities(7), close(2), spu_create(2), spufs(7)
-
-
-
-
-Linux                             2005-09-28                        SPU_RUN(2)
-- 
2.25.2

