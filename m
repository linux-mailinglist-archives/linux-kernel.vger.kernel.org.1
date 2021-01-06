Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7177C2EB7C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbhAFBu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:50:57 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47475 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725822AbhAFBu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:50:56 -0500
X-IronPort-AV: E=Sophos;i="5.78,478,1599494400"; 
   d="scan'208";a="103220525"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Jan 2021 09:50:06 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 5769B4CE601C;
        Wed,  6 Jan 2021 09:50:02 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 6 Jan 2021 09:50:01 +0800
Received: from localhost.localdomain (10.167.225.206) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 6 Jan 2021 09:50:02 +0800
From:   Hao Li <lihao2018.fnst@cn.fujitsu.com>
To:     <corbet@lwn.net>
CC:     <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <alexander.deucher@amd.com>, <mchehab+huawei@kernel.org>,
        <lee.jones@linaro.org>, <ira.weiny@intel.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lihao2018.fnst@cn.fujitsu.com>
Subject: [PATCH v2] Documentation/dax: Update description of DAX policy changing
Date:   Wed, 6 Jan 2021 09:50:00 +0800
Message-ID: <20210106015000.5263-1-lihao2018.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5769B4CE601C.AE19D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 77573fa310d9 ("fs: Kill DCACHE_DONTCACHE dentry even if
DCACHE_REFERENCED is set"), changes to DAX policy will take effect
as soon as all references to this file are gone.

Update the documentation accordingly.

Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
---
Changes in v2:
  * simplify sentences and fix style problems.

 Documentation/filesystems/dax.txt | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
index 8fdb78f3c6c9..e03c20564f3a 100644
--- a/Documentation/filesystems/dax.txt
+++ b/Documentation/filesystems/dax.txt
@@ -83,20 +83,9 @@ Summary
        directories.  This has runtime constraints and limitations that are
        described in 6) below.
 
- 6. When changing the S_DAX policy via toggling the persistent FS_XFLAG_DAX flag,
-    the change in behaviour for existing regular files may not occur
-    immediately.  If the change must take effect immediately, the administrator
-    needs to:
-
-    a) stop the application so there are no active references to the data set
-       the policy change will affect
-
-    b) evict the data set from kernel caches so it will be re-instantiated when
-       the application is restarted. This can be achieved by:
-
-       i. drop-caches
-       ii. a filesystem unmount and mount cycle
-       iii. a system reboot
+ 6. When changing the S_DAX policy via toggling the persistent FS_XFLAG_DAX
+    flag, the change to existing regular files won't take effect until the
+    files are closed by all processes.
 
 
 Details
-- 
2.29.2



