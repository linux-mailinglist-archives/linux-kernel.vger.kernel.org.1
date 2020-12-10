Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2171B2D56EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbgLJJVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:21:42 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8976 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgLJJVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:21:30 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cs7g9024CzhqBR;
        Thu, 10 Dec 2020 17:20:21 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 17:20:36 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH RFC] f2fs: compress: add compress_flag in struct f2fs_comp_option
Date:   Thu, 10 Dec 2020 17:20:20 +0800
Message-ID: <20201210092020.66245-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a extra field compress_flag to get/set more compress option from/to
compressed inode.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---

Daeho, Jaegeuk,

Could you please check whether we could add this new field to struct
f2fs_comp_option? so we can expand to allow user to query/config more
options of compressed inode via new ioctl.

It needs to consider before original patches goes to merge window, let
me know you have other concerns.

 fs/f2fs/file.c            | 1 +
 include/uapi/linux/f2fs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 16ea10f2bcf5..fbf06311c88d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3965,6 +3965,7 @@ static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
 
 	option.algorithm = F2FS_I(inode)->i_compress_algorithm;
 	option.log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
+	option.compress_flag = F2FS_I(inode)->i_compress_flag;
 
 	inode_unlock_shared(inode);
 
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
index 352a822d4370..2b9c4c99ceee 100644
--- a/include/uapi/linux/f2fs.h
+++ b/include/uapi/linux/f2fs.h
@@ -93,6 +93,7 @@ struct f2fs_sectrim_range {
 struct f2fs_comp_option {
 	__u8 algorithm;
 	__u8 log_cluster_size;
+	__u16 compress_flag;
 };
 
 #endif /* _UAPI_LINUX_F2FS_H */
-- 
2.29.2

