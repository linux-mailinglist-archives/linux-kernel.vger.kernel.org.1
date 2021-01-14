Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A072F61FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbhANN2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:28:45 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:52126 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbhANN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:28:44 -0500
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 1C39BEF870;
        Thu, 14 Jan 2021 21:26:25 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [113.57.152.160])
        by smtp.263.net (postfix) whith ESMTP id P25768T139699018872576S1610630781466147_;
        Thu, 14 Jan 2021 21:26:25 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <5f77833fcca4fb1f9b3a37589cb440f1>
X-RL-SENDER: changlianzhi@uniontech.com
X-SENDER: changlianzhi@uniontech.com
X-LOGIN-NAME: changlianzhi@uniontech.com
X-FST-TO: jack@suse.cz
X-SENDER-IP: 113.57.152.160
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   lianzhi chang <changlianzhi@uniontech.com>
To:     jack@suse.cz, magnani@ieee.org
Cc:     linux-kernel@vger.kernel.org, 282827961@qq.com,
        lianzhi chang <changlianzhi@uniontech.com>
Subject: [PATCH] udf: fix the problem that the disc content is not displayed
Date:   Thu, 14 Jan 2021 21:26:15 +0800
Message-Id: <20210114132615.16522-1-changlianzhi@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the capacity of the disc is too large (assuming the 4.7G
specification), the disc (UDF file system) will be burned
multiple times in the windows (Multisession Usage). When the
remaining capacity of the CD is less than 300M (estimated
value, for reference only), open the CD in the Linux system,
the content of the CD is displayed as blank (the kernel will
say "No VRS found"). Windows can display the contents of the
CD normally.
Through analysis, in the "fs/udf/super.c": udf_check_vsd
function, the actual value of VSD_MAX_SECTOR_OFFSET may
be much larger than 0x800000. According to the current code
logic, it is found that the type of sbi->s_session is "__s32",
 when the remaining capacity of the disc is less than 300M
(take a set of test values: sector=3154903040,
sbi->s_session=1540464, sb->s_blocksize_bits=11 ), the
calculation result of "sbi->s_session << sb->s_blocksize_bits"
 will overflow. Therefore, it is necessary to convert the
type of s_session to "loff_t" (when udf_check_vsd starts,
assign a value to _sector, which is also converted in this
way), so that the result will not overflow, and then the
content of the disc can be displayed normally.

Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
---
 fs/udf/super.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 5bef3a68395d..f2ff98f393fb 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -705,6 +705,7 @@ static int udf_check_vsd(struct super_block *sb)
 	struct buffer_head *bh = NULL;
 	int nsr = 0;
 	struct udf_sb_info *sbi;
+	loff_t sector_offset;
 
 	sbi = UDF_SB(sb);
 	if (sb->s_blocksize < sizeof(struct volStructDesc))
@@ -712,7 +713,8 @@ static int udf_check_vsd(struct super_block *sb)
 	else
 		sectorsize = sb->s_blocksize;
 
-	sector += (((loff_t)sbi->s_session) << sb->s_blocksize_bits);
+	sector_offset = (loff_t)sbi->s_session << sb->s_blocksize_bits;
+	sector += sector_offset;
 
 	udf_debug("Starting at sector %u (%lu byte sectors)\n",
 		  (unsigned int)(sector >> sb->s_blocksize_bits),
@@ -757,8 +759,7 @@ static int udf_check_vsd(struct super_block *sb)
 
 	if (nsr > 0)
 		return 1;
-	else if (!bh && sector - (sbi->s_session << sb->s_blocksize_bits) ==
-			VSD_FIRST_SECTOR_OFFSET)
+	else if (!bh && sector - sector_offset == VSD_FIRST_SECTOR_OFFSET)
 		return -1;
 	else
 		return 0;
-- 
2.20.1



