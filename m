Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A1A2F5BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbhANHys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:54:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbhANHyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:54:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD0A423A02;
        Thu, 14 Jan 2021 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610610830;
        bh=j46GC8EQ+wDuLjInlFgJe8KE3E7zAC95eawxVM4OyVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBEIyN6xrBAwrDGRr7PolKZCEZ2IuCrm4dsYZ4EZOafK3gMz6ZlfuU5qKJrNT81sb
         hFDqMkpUiMntg1wqigxZ8xYoDzrq4bIxDMB/PunIWYL/YdBq8vDSdJs1lgs0rrxGVx
         r9ictQapiWVqYbP04m1qWmjPahn/drp34WBQKVkZTnefzPmsWxsdvHkbd+ipNPLpO/
         Hia9VtOAtCehRhE9+dlbERyRVK/n8tL12UyP4pOKa/v92q5igI7Yz4dS7ns5BJo4f1
         H788VGyg0HYe/qtjWCyrcQtT1s+wGp5mDYJNyWb+vCU7iPpSzrHwydg8YvdCJ9H2ct
         C2m1YUoISr3xw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxRz-00EPu5-53; Thu, 14 Jan 2021 08:53:47 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] ABI: sysfs-fs-f2fs: fix a table identation
Date:   Thu, 14 Jan 2021 08:53:37 +0100
Message-Id: <52a3058459673bc190ca6044779ccea9146c7208.1610610444.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610444.git.mchehab+huawei@kernel.org>
References: <cover.1610610444.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Solves this doc build error:

.../Documentation/ABI/testing/sysfs-fs-f2fs:382: WARNING: Malformed table.
Text in column margin in table line 15.

=====  ===================== =================================
value  sb status macro       description
0x1    SBI_IS_DIRTY          dirty flag for checkpoint
0x2    SBI_IS_CLOSE          specify unmounting
0x4    SBI_NEED_FSCK         need fsck.f2fs to fix
0x8    SBI_POR_DOING         recovery is doing or not
0x10   SBI_NEED_SB_WRITE     need to recover superblock
0x20   SBI_NEED_CP           need to checkpoint
0x40   SBI_IS_SHUTDOWN       shutdown by ioctl
0x80   SBI_IS_RECOVERED      recovered orphan/data
0x100  SBI_CP_DISABLED       CP was disabled last mount
0x200  SBI_CP_DISABLED_QUICK CP was disabled quickly
0x400  SBI_QUOTA_NEED_FLUSH  need to flush quota info in CP
0x800  SBI_QUOTA_SKIP_FLUSH  skip flushing quota in current CP
0x1000 SBI_QUOTA_NEED_REPAIR quota file may be corrupted
0x2000 SBI_IS_RESIZEFS       resizefs is in process
====== ===================== =================================

Fixes: 969945899a35 ("f2fs: introduce sb_status sysfs node")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index e5918c93f3bf..1ba8d533437a 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -383,8 +383,9 @@ Date:		December 2020
 Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	Show status of f2fs superblock in real time.
 
-		=====  ===================== =================================
+		====== ===================== =================================
 		value  sb status macro       description
+		====== ===================== =================================
 		0x1    SBI_IS_DIRTY          dirty flag for checkpoint
 		0x2    SBI_IS_CLOSE          specify unmounting
 		0x4    SBI_NEED_FSCK         need fsck.f2fs to fix
-- 
2.29.2

