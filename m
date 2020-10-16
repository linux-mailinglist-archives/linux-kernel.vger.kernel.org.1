Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A7028FD94
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 07:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbgJPFPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 01:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732437AbgJPFPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 01:15:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E667C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 22:15:03 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so805855pfk.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 22:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPRKGwCWlhzW2fZpjziEJb0M3iHjtjmgnX8F6uX861E=;
        b=HyQm0F1Ds6YoQolTS544JgaLlzxxYxEJVA0HZFcTVEa0eKtX8IU2WfIKowIIlGlp80
         jJD9su0lBNh7fhLAY6BbMfyVwJU7egk6MdA4xhSiH0oyD3325wjY2VWzJwBuIb+tmVSb
         NVyHEx4eLTrfJ2+/P3klgnjbhwKdysoSnYyhJnL1Dvth5MiYz1RL7QZDwXzRB0hmYe71
         x46P3b0bxBjoeEXQs8tzgK+NE45chbib18jZIbBP2pzgyt+8lpDTI3a2MicJxrn+QA6b
         elUB4ZgQCym2YYWYlmWW8WEqOWfyO0IDjYPb8ZO+xYoGQ41lLTwlE8bhmxfsYr5bmZNd
         f/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPRKGwCWlhzW2fZpjziEJb0M3iHjtjmgnX8F6uX861E=;
        b=GKuzncKI15wSiwET3sL6WZ+/AxxYSGhxpUfoXOKqlKIHjFXLSBi+0NjJt1v/Fj5wlS
         MwU1Cb7ow8LS4J365T6FjadejSNFhWycfNXjAnZO+9Z24NKpM97Qf94LbTC8ZFzq1tTO
         AEVe5RbbX+WJHTQJoeFZmJdUnKYRtJVkkCpDU0RGKuJc1APfc/pwdQssaAB5t4NxMOPW
         WzfyrkmJrbWsTO5D3zrzBDiJ0uoI4elVy5boLd2UcMtjQ+MbYBO2lR9zoLulc5HSqvyt
         AeD7z5bk5PWRV7HsMKNR0XTcwPjMPUSWwqXYKoksNsS1417VYpaB5zMiBQcVNcsFMYAe
         0qgA==
X-Gm-Message-State: AOAM533gnrNsnQr0Yiiqf9rVa3EfPBTr41Panvl5rFfzv451Rkjr7h39
        7FzmCNSuj7N5KpwEJUrPLksZxZlKlPs=
X-Google-Smtp-Source: ABdhPJzUutEPt92K6TaLg/1fFgd8kxj4nhUPYUPqPgwM9EbegeLWlstMp7eXArbq5ZNTTFQkLlSvxw==
X-Received: by 2002:a62:5215:0:b029:156:6a80:a257 with SMTP id g21-20020a6252150000b02901566a80a257mr2003516pfb.63.1602825302319;
        Thu, 15 Oct 2020 22:15:02 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id m3sm1139218pjv.52.2020.10.15.22.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 22:15:01 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: add compr_inode and compr_blocks sysfs nodes
Date:   Fri, 16 Oct 2020 14:14:55 +0900
Message-Id: <20201016051455.1913795-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added compr_inode to show compressed inode count and compr_blocks to
show compressed block count in sysfs.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 10 ++++++++++
 fs/f2fs/sysfs.c                         | 17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 834d0becae6d..a01c26484c69 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -350,3 +350,13 @@ Date:		April 2020
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	Give a way to change iostat_period time. 3secs by default.
 		The new iostat trace gives stats gap given the period.
+
+What:		/sys/fs/f2fs/<disk>/compr_inode
+Date:		October 2020
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show compressed inode count
+
+What:		/sys/fs/f2fs/<disk>/compr_blocks
+Date:		October 2020
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show compressed block count
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 94c98e412aa1..7139a29a00d3 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -223,6 +223,19 @@ static ssize_t avg_vblocks_show(struct f2fs_attr *a,
 	f2fs_update_sit_info(sbi);
 	return sprintf(buf, "%llu\n", (unsigned long long)(si->avg_vblocks));
 }
+
+static ssize_t compr_inode_show(struct f2fs_attr *a,
+				struct f2fs_sb_info *sbi, char *buf)
+{
+	return sprintf(buf, "%u\n", atomic_read(&sbi->compr_inode));
+}
+
+static ssize_t compr_blocks_show(struct f2fs_attr *a,
+				struct f2fs_sb_info *sbi, char *buf)
+{
+	return sprintf(buf, "%llu\n", atomic64_read(&sbi->compr_blocks));
+}
+
 #endif
 
 static ssize_t main_blkaddr_show(struct f2fs_attr *a,
@@ -591,6 +604,8 @@ F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, gc_background_calls, bg_gc);
 F2FS_GENERAL_RO_ATTR(moved_blocks_background);
 F2FS_GENERAL_RO_ATTR(moved_blocks_foreground);
 F2FS_GENERAL_RO_ATTR(avg_vblocks);
+F2FS_GENERAL_RO_ATTR(compr_inode);
+F2FS_GENERAL_RO_ATTR(compr_blocks);
 #endif
 
 #ifdef CONFIG_FS_ENCRYPTION
@@ -675,6 +690,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(moved_blocks_foreground),
 	ATTR_LIST(moved_blocks_background),
 	ATTR_LIST(avg_vblocks),
+	ATTR_LIST(compr_inode),
+	ATTR_LIST(compr_blocks),
 #endif
 	NULL,
 };
-- 
2.29.0.rc1.297.gfa9743e501-goog

