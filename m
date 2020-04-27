Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A691BB052
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 23:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgD0VS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 17:18:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgD0VR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:17:26 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98CA121D91;
        Mon, 27 Apr 2020 21:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022244;
        bh=sw5AX/A0uo+/dfj0dgZ8hpJE8TiY4YeROy9zTp7msAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pt1sIKkmVdWbheyPq+b2qBqJpY7j0hZiDGMYk0sA9tV8MREfLfc/AeQxppSbXXp41
         omrpZhyoVKoEwFT7v2caDTgWgRBeFSwlt4zn9UHvJW6lBWkdJLfIxQX7zH6mwGoU3G
         f7+BgY6fvl6eK65Ga3B7j03xWa3Y1ageDKpy7Fb8=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jTB7y-000Hkn-RN; Mon, 27 Apr 2020 23:17:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 15/29] docs: filesystems: convert locks.txt to ReST
Date:   Mon, 27 Apr 2020 23:17:07 +0200
Message-Id: <467b3f20e63d2640d22599b99229699b5fb79251.1588021877.git.mchehab+huawei@kernel.org>
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
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst                |  1 +
 Documentation/filesystems/{locks.txt => locks.rst} | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)
 rename Documentation/filesystems/{locks.txt => locks.rst} (93%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index d303d14e381a..7e975c9a5fbf 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -28,6 +28,7 @@ algorithms work.
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
2.25.4

