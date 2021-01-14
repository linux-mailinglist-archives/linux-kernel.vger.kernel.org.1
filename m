Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2757F2F5625
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbhANBmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:42:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:10964 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbhANBmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 20:42:35 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DGRq31btxzj69R;
        Thu, 14 Jan 2021 09:41:03 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 14 Jan 2021 09:41:45 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v5 5/5] f2fs: introduce sb_status sysfs node
Date:   Thu, 14 Jan 2021 09:41:27 +0800
Message-ID: <20210114014127.54510-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce /sys/fs/f2fs/<devname>/stat/sb_status to show superblock
status in real time as a hexadecimal value.

value           sb status macro                 description

0x1             SBI_IS_DIRTY,                   /* dirty flag for checkpoint */
0x2             SBI_IS_CLOSE,                   /* specify unmounting */
0x4             SBI_NEED_FSCK,                  /* need fsck.f2fs to fix */
0x8             SBI_POR_DOING,                  /* recovery is doing or not */
0x10            SBI_NEED_SB_WRITE,              /* need to recover superblock */
0x20            SBI_NEED_CP,                    /* need to checkpoint */
0x40            SBI_IS_SHUTDOWN,                /* shutdown by ioctl */
0x80            SBI_IS_RECOVERED,               /* recovered orphan/data */
0x100           SBI_CP_DISABLED,                /* CP was disabled last mount */
0x200           SBI_CP_DISABLED_QUICK,          /* CP was disabled quickly */
0x400           SBI_QUOTA_NEED_FLUSH,           /* need to flush quota info in CP */
0x800           SBI_QUOTA_SKIP_FLUSH,           /* skip flushing quota in current CP */
0x1000          SBI_QUOTA_NEED_REPAIR,          /* quota file may be corrupted */
0x2000          SBI_IS_RESIZEFS,                /* resizefs is in process */

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v5:
- fix compile warning reported by Stephen:
Documentation/ABI/testing/sysfs-fs-f2fs:382: WARNING: Malformed table.
 Documentation/ABI/testing/sysfs-fs-f2fs | 23 +++++++++++++++++++++++
 fs/f2fs/sysfs.c                         |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 3dfee94e0618..362803901614 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -377,3 +377,26 @@ Description:	This gives a control to limit the bio size in f2fs.
 		Default is zero, which will follow underlying block layer limit,
 		whereas, if it has a certain bytes value, f2fs won't submit a
 		bio larger than that size.
+
+What:		/sys/fs/f2fs/<disk>/stat/sb_status
+Date:		December 2020
+Contact:	"Chao Yu" <yuchao0@huawei.com>
+Description:	Show status of f2fs superblock in real time.
+
+		====== ===================== =================================
+		value  sb status macro       description
+		0x1    SBI_IS_DIRTY          dirty flag for checkpoint
+		0x2    SBI_IS_CLOSE          specify unmounting
+		0x4    SBI_NEED_FSCK         need fsck.f2fs to fix
+		0x8    SBI_POR_DOING         recovery is doing or not
+		0x10   SBI_NEED_SB_WRITE     need to recover superblock
+		0x20   SBI_NEED_CP           need to checkpoint
+		0x40   SBI_IS_SHUTDOWN       shutdown by ioctl
+		0x80   SBI_IS_RECOVERED      recovered orphan/data
+		0x100  SBI_CP_DISABLED       CP was disabled last mount
+		0x200  SBI_CP_DISABLED_QUICK CP was disabled quickly
+		0x400  SBI_QUOTA_NEED_FLUSH  need to flush quota info in CP
+		0x800  SBI_QUOTA_SKIP_FLUSH  skip flushing quota in current CP
+		0x1000 SBI_QUOTA_NEED_REPAIR quota file may be corrupted
+		0x2000 SBI_IS_RESIZEFS       resizefs is in process
+		====== ===================== =================================
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index bd1174ed2e6f..f39874d512ea 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -96,6 +96,12 @@ static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
 				sbi->sectors_written_start) >> 1)));
 }
 
+static ssize_t sb_status_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	return sprintf(buf, "%lx\n", sbi->s_flag);
+}
+
 static ssize_t features_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
@@ -702,7 +708,9 @@ static struct attribute *f2fs_feat_attrs[] = {
 };
 ATTRIBUTE_GROUPS(f2fs_feat);
 
+F2FS_GENERAL_RO_ATTR(sb_status);
 static struct attribute *f2fs_stat_attrs[] = {
+	ATTR_LIST(sb_status),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_stat);
-- 
2.29.2

