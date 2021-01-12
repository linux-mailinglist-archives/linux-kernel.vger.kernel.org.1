Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C732F280E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 06:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389436AbhALFzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 00:55:35 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:45220 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731219AbhALFzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 00:55:35 -0500
Received: from localhost (unknown [192.168.167.225])
        by lucky1.263xmail.com (Postfix) with ESMTP id 4475BB6A91;
        Tue, 12 Jan 2021 13:53:13 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [113.57.152.160])
        by smtp.263.net (postfix) whith ESMTP id P21842T140225080706816S1610430788033883_;
        Tue, 12 Jan 2021 13:53:13 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <0174191929b4418778d53ebba37a606c>
X-RL-SENDER: changlianzhi@uniontech.com
X-SENDER: changlianzhi@uniontech.com
X-LOGIN-NAME: changlianzhi@uniontech.com
X-FST-TO: jack@suse.com
X-SENDER-IP: 113.57.152.160
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   lianzhi chang <changlianzhi@uniontech.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, 282827961@qq.com,
        lianzhi chang <changlianzhi@uniontech.com>
Subject: [PATCH] udf: fix the problem that the disc content is not displayed
Date:   Tue, 12 Jan 2021 13:53:04 +0800
Message-Id: <20210112055304.31842-1-changlianzhi@uniontech.com>
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
 fs/udf/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 5bef3a68395d..6c3069cd1321 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -757,7 +757,7 @@ static int udf_check_vsd(struct super_block *sb)
 
 	if (nsr > 0)
 		return 1;
-	else if (!bh && sector - (sbi->s_session << sb->s_blocksize_bits) ==
+	else if (!bh && sector - ((loff_t)sbi->s_session << sb->s_blocksize_bits) ==
 			VSD_FIRST_SECTOR_OFFSET)
 		return -1;
 	else
-- 
2.20.1



