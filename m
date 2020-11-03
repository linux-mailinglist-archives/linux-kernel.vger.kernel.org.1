Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0012A3A33
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 03:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgKCCFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 21:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgKCCFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 21:05:16 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CB5C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 18:05:16 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id b19so7825110pld.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 18:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGZQ0eNv5jFognYSAXpqqzXbISxqXlVmF2iO+e6yiH0=;
        b=mkyPS9odEV84J1E76Z2rTlTyXpc8yZu1HmF8A9O4kzAAfqFlaW+MHnE6ehUeVlRuBj
         cSbyg+GYxanofiSyWPTNMloWjcGvFRKlErtVuNpEzx66nhOWKabkl+bJLvuyTZpku0ze
         smLS+OOHNNRbIrBXkDkSfS2FdISY2pkk0goC4LrpUMpD0eelA+lWD1NmaqCXkmfsD1sJ
         hY/dI2uzegsRUkwWJkkrG1V8f8ecD+XE7b+uqMtygJRgBu8Ad3JzDuNNzTlhvz8pmi9t
         DhCpd9L8jd1bqimJkllrBIObkSI6AVrKULVYHfEpTphPdqbG8asoG2uAV1qQSUq1XiID
         wWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGZQ0eNv5jFognYSAXpqqzXbISxqXlVmF2iO+e6yiH0=;
        b=YaK9shu+8Kjnyk6/HEFzKfhhAHttd6J2uglxeBVJ3Nnk2dC/QNxEqWZVniW63pk63y
         I5Mnmh0p3WsAf62C2IAKXCF1dwAA83lYb9EfbROL/xcVig5TGVZuHJSpS7Wp7WIOj0Mo
         QknxG+tL0M1sPCGXL/NdcfwbuIQWpHVPO5vF5KHOhjtmixY7RHUzWRje5zh0q/ksRpRK
         Ze0UW68Mp/BLM1+DBeYiiQFIp7X19GrMuIaNsu9HgLyR/OuerKzg/bROKFNmfC0zOv62
         ermlMmVZSzKRfkRYbQdpLVEhT3eah3T4V7hofzbVnuz5fiSOOdXA9zjmDrlshatgXDAL
         i9Lg==
X-Gm-Message-State: AOAM532hE3QaxCg8ysMiADpMYHq6yffEdTZA4EEjKjwx7WePy4rfJWV2
        d0NOHeI3TQElK0I+ut3IQZs=
X-Google-Smtp-Source: ABdhPJxsk4VlonaleY3dMSjbAgJLzN5d6hInKyAVB3ACOKt5ohsnKX4FSJUqC0AQdyD2CWjbn7av5g==
X-Received: by 2002:a17:902:bd85:b029:d6:c451:817d with SMTP id q5-20020a170902bd85b02900d6c451817dmr9694493pls.66.1604369115413;
        Mon, 02 Nov 2020 18:05:15 -0800 (PST)
Received: from localhost.localdomain (cl-ubuntu-kdev.xen.prgmr.com. [71.19.148.84])
        by smtp.gmail.com with ESMTPSA id 16sm14213446pfp.163.2020.11.02.18.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 18:05:14 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     phillip@squashfs.org.uk
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org,
        syzbot+8e28bba73ed1772a6802@syzkaller.appspotmail.com
Subject: [PATCH] squashfs: Add id_table sanity check to squashfs_get_id
Date:   Tue,  3 Nov 2020 10:04:31 +0800
Message-Id: <20201103020431.147711-1-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When uid/gid info in superblocks or id_index_table is corrupted,
The uid/gid index can be larger than the size of msblk->id_table.
This is reported by syzkaller.

This patch adds a sanity check to squashfs_get_id which calculates
the max available room for uid/gid table by doing
msblk->xattr_table - msblk->id_table[0]
and check if index is larger than this.

While this provides some sort of check, it is
imperfect because id_table can be smaller than that.

Reported-by: syzbot+8e28bba73ed1772a6802@syzkaller.appspotmail.com
Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 fs/squashfs/id.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/id.c b/fs/squashfs/id.c
index 6be5afe7287d..81bd67c0f649 100644
--- a/fs/squashfs/id.c
+++ b/fs/squashfs/id.c
@@ -35,10 +35,16 @@ int squashfs_get_id(struct super_block *sb, unsigned int index,
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
 	int block = SQUASHFS_ID_BLOCK(index);
 	int offset = SQUASHFS_ID_BLOCK_OFFSET(index);
-	u64 start_block = le64_to_cpu(msblk->id_table[block]);
+	u64 start_block;
 	__le32 disk_id;
 	int err;
 
+	// sanity check
+	if (le64_to_cpu(msblk->id_table[0]) + block >= msblk->xattr_table)
+		return -EINVAL;
+
+	start_block = le64_to_cpu(msblk->id_table[block]);
+
 	err = squashfs_read_metadata(sb, &disk_id, &start_block, &offset,
 							sizeof(disk_id));
 	if (err < 0)
-- 
2.25.1

