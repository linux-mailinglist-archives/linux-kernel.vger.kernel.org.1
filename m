Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC3F2FA60C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406635AbhARQYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:24:30 -0500
Received: from m12-11.163.com ([220.181.12.11]:50469 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406556AbhARQYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=qIeErAOk1NQJAq88EV
        HMFkXWThvbehNJtjlP9gEFWbc=; b=eyMeJbze5i3iu0YDplxlOeV/zbqNpLHvTf
        EzNKsLtozX703KK+SMty3xUEUvhF8294dME4Umzj+Yz+QRZsMFBMz7CQNjFP6UHU
        G2NuSuSgb3pNqnZut3aKmeB+MC0fw488MpNHTSV/yf8sjjg5O/FdphlTgy7ssvnQ
        oxufizzug=
Received: from localhost.localdomain (unknown [119.3.119.20])
        by smtp7 (Coremail) with SMTP id C8CowAAXZ69peQVg6luuJQ--.37554S4;
        Mon, 18 Jan 2021 20:05:05 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] isofs: release buffer head before return
Date:   Mon, 18 Jan 2021 04:04:55 -0800
Message-Id: <20210118120455.118955-1-bianpan2016@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowAAXZ69peQVg6luuJQ--.37554S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrWw4DtF4fXry7ZF1kKF4xtFb_yoWxArc_WF
        ykXF4v9r4IqFW7AwsxAFy3Ar1F9a4kCr1fAwsayFZxGryYyr9aqrWDArnxArsxCFWxKasx
        ArZ8ZFW2yr13KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjX18JUUUUU==
X-Originating-IP: [119.3.119.20]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiVBIeclUMPVV6wwAAsi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release the buffer header before returning error code.

Fixes: 2deb1acc653c ("isofs: fix access to unallocated memory when reading corrupted filesystem")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 fs/isofs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index f0fe641893a5..b9e6a7ec78be 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -152,6 +152,7 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 			printk(KERN_NOTICE "iso9660: Corrupted directory entry"
 			       " in block %lu of inode %lu\n", block,
 			       inode->i_ino);
+			brelse(bh);
 			return -EIO;
 		}
 
-- 
2.17.1

