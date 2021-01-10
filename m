Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87192F0858
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 17:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbhAJQRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 11:17:04 -0500
Received: from m12-13.163.com ([220.181.12.13]:56110 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbhAJQRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 11:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=uWCpczaT+Kp1u2fPcI
        VWE1toUte4ZvxGSaJT+gjXIv0=; b=IXnsJKlLPiqHSedfWmDHerfp3Ct6f6Lljv
        KpCuUWEBdmBBzLcxS+QVZeAR4IZTCIBbBGQtKyW0xbVIXPYgS59CQJgCF2JGTfhO
        Ib6sospHy5sByjTLPhDCjbaIBO1bQmYygBGsZVCzhC89u5GQqnqj+gEKvdamOutk
        iIyG/8cq8=
Received: from localhost.localdomain.localdomain (unknown [182.150.135.160])
        by smtp9 (Coremail) with SMTP id DcCowAB3v2tZt_pf69c2aQ--.11668S2;
        Sun, 10 Jan 2021 16:14:19 +0800 (CST)
From:   winndows@163.com
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liao Pingfang <winndows@163.com>
Subject: [PATCH] docs: filesystems: vfs: Correct the struct name
Date:   Sun, 10 Jan 2021 15:59:59 +0800
Message-Id: <1610265599-5101-1-git-send-email-winndows@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DcCowAB3v2tZt_pf69c2aQ--.11668S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gry5KrWxGr1fCF4kKw15Jwb_yoWxKwbE9r
        WxXF4kWFZ7JryftF4kCF1YvF1fZrsakr1rXwn3AF4DA343t3ykJFykX34jvrW5Wr4I9rZ8
        Gan8ZrZIqFnrJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjDKs7UUUUU==
X-Originating-IP: [182.150.135.160]
X-CM-SenderInfo: hzlq0vxrzvqiywtou0bp/xtbByhsWmV0CPnHalwAAsD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Pingfang <winndows@163.com>

The struct name should be file_system_type instead of
file_system_operations.

Signed-off-by: Liao Pingfang <winndows@163.com>
---
 Documentation/filesystems/vfs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index ca52c82..18d69a4 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -112,7 +112,7 @@ members are defined:
 
 .. code-block:: c
 
-	struct file_system_operations {
+	struct file_system_type {
 		const char *name;
 		int fs_flags;
 		struct dentry *(*mount) (struct file_system_type *, int,
-- 
1.8.3.1


