Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E9E1AAA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 16:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370854AbgDOOlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 10:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394052AbgDOOc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:32:59 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 628F62192A;
        Wed, 15 Apr 2020 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961171;
        bh=+igjvRxpuDNk+ImNBCy+AlqzVmAqV4enYJJws75GPmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ft7S8nX6e3UDcYwZx2JhFoYsguOls5IwwZzQdZbY5iKsuQRVpi+cA+durJS9XO1ia
         el9QM56SEGU+vdFfkaBDroUO4xznr/D2yXiUERN+WzphcbQY7OsHY/rRsVnva1BGlA
         pV6LwtB9kQlNtbj+Q1WUqwTHMDmrdp7CUXFTVN74=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5t-006kPC-M8; Wed, 15 Apr 2020 16:32:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 19/34] docs: filesystems: convert locks.txt to ReST
Date:   Wed, 15 Apr 2020 16:32:32 +0200
Message-Id: <848106d373e9175ab29537f6c85f2b13e664f65a.1586960617.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586960617.git.mchehab+huawei@kernel.org>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Adjust document and section titles;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst                |  1 +
 Documentation/filesystems/{locks.txt => locks.rst} | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)
 rename Documentation/filesystems/{locks.txt => locks.rst} (93%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 6a34d1b578a9..40cdc4ce2ffc 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -29,6 +29,7 @@ algorithms work.
    dnotify
    fiemap
    files
+   locks
 
    automount-support
 
diff --git a/Documentation/filesystems/locks.txt b/Documentation/filesystems/locks.rst
similarity index 93%
rename from Documentation/filesystems/locks.txt
rename to Documentation/filesystems/locks.rst
index 5368690f412e..10f67fb9ce07 100644
--- a/Documentation/filesystems/locks.txt
+++ b/Documentation/filesystems/locks.rst
@@ -1,4 +1,8 @@
-		      File Locking Release Notes
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+File Locking Release Notes
+==========================
 
 		Andy Walker <andy@lysaker.kvaerner.no>
 
@@ -6,7 +10,7 @@
 
 
 1. What's New?
---------------
+==============
 
 1.1 Broken Flock Emulation
 --------------------------
@@ -25,7 +29,7 @@ anyway (see the file "Documentation/process/changes.rst".)
 ---------------------------
 
 1.2.1 Typical Problems - Sendmail
----------------------------------
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 Because sendmail was unable to use the old flock() emulation, many sendmail
 installations use fcntl() instead of flock(). This is true of Slackware 3.0
 for example. This gave rise to some other subtle problems if sendmail was
@@ -37,7 +41,7 @@ to lock solid with deadlocked processes.
 
 
 1.2.2 The Solution
-------------------
+^^^^^^^^^^^^^^^^^^
 The solution I have chosen, after much experimentation and discussion,
 is to make flock() and fcntl() locks oblivious to each other. Both can
 exists, and neither will have any effect on the other.
-- 
2.25.2

