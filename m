Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4053429F614
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgJ2UTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgJ2UT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:19:28 -0400
Received: from mail-pg1-x564.google.com (mail-pg1-x564.google.com [IPv6:2607:f8b0:4864:20::564])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA8BC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:19:27 -0700 (PDT)
Received: by mail-pg1-x564.google.com with SMTP id f38so3293346pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=drivescale-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gIXQNYArJjpdvZENOglS8RO9DhQVI/HUIbAzBDiu3tI=;
        b=Me8FaUxOaGFVEh2ZTcLPj9BdiV4kvibHzLNTqRgnhAyW2pmt/IkBMTTo2WDykNeTWk
         sPMx/i8Z8lYX2+ejbwqMoyNslf2hqxsrvOhdSRiVTaAbguJVY5Nx0anFcwGCXS50qZqI
         5Q7c2o2mxOHN/Ue06Wd0Q9y51ceDYhFyDwcPq58iba93ChoW0e1RPzOXVxH/LyZnBn2b
         0hKQJLIp6BiV2YzMkr863QmfggSSeWqcAMpui+gbcxHAmyajkjVS6+lx64YVsjzYxfGg
         1uu5sa4O/pQnP9KL1Zc9i4/+SE9GIYT+6ZpJ0YosjPJy2fM085h67FJgXsh5AFb+toUZ
         2OHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gIXQNYArJjpdvZENOglS8RO9DhQVI/HUIbAzBDiu3tI=;
        b=bUngWVQsVERUKP5kJkGn0aWwUj2K0NICPijqUzkZGNB7xkYEZwbof5WY3p/kmZos7K
         vnwVq/CFu/9vJoBxZx2F1MNUm+gGdlXXrBK4BH6Za1/nBw+5/sEONgwtkiaPV7L3ASj+
         0WYxoFTXS2ahNue0qdnThP53tHTQqfkLQIsxsKkQMawz5TMJWvEStF9C7Ky2G1WH+wy/
         zmpt2l4IHWYyqeu1KZo1+eunycYG5Ip6GenLP49i1Oirab0NYWv4gNOmL5C31OMuTQxP
         ysjzBcI17OdW7QnConV32ohafQbcX2AJzegQplwTFyu12sPCISKUKX/E02PJJ/6T3IW9
         x9/Q==
X-Gm-Message-State: AOAM533d3+Bmbvh7Y/tFTYDs2GG0g0tYVA9oR0iZsggaKP2TbqQsMuJj
        KRoWKcnh6A//U7Y0++1ouyZ//3CDJ7CQHLfxXtYad5xVvTUSpA==
X-Google-Smtp-Source: ABdhPJzVUSp1kVcGC4ajq3SyjonaTJ31nJC62PhjEmYFcRnN1U5u5MsGTNAey2mVJU0xKaarPAkMdnTIerLr
X-Received: by 2002:a17:90b:e14:: with SMTP id ge20mr932315pjb.10.1604002766518;
        Thu, 29 Oct 2020 13:19:26 -0700 (PDT)
Received: from dcs.hq.drivescale.com ([68.74.115.3])
        by smtp-relay.gmail.com with ESMTP id mj21sm189892pjb.10.2020.10.29.13.19.26;
        Thu, 29 Oct 2020 13:19:26 -0700 (PDT)
X-Relaying-Domain: drivescale.com
Received: from localhost.localdomain (gw1-dc.hq.drivescale.com [192.168.33.175])
        by dcs.hq.drivescale.com (Postfix) with ESMTP id B8A6042126;
        Thu, 29 Oct 2020 20:19:25 +0000 (UTC)
From:   Christopher Unkel <cunkel@drivescale.com>
To:     linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Christopher Unkel <cunkel@drivescale.com>
Subject: [PATCH v2 1/3] md: factor out repeated sb alignment logic
Date:   Thu, 29 Oct 2020 13:13:56 -0700
Message-Id: <20201029201358.29181-2-cunkel@drivescale.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029201358.29181-1-cunkel@drivescale.com>
References: <20201029201358.29181-1-cunkel@drivescale.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

super_1_load() and super_1_sync() both contain a copy of logic to pad
out the superblock size so that it is aligned on a logical block
boundary.  Factor into new function, and use round_up() rather than
explict bitmask-based calculation.

Signed-off-by: Christopher Unkel <cunkel@drivescale.com>
---
This series replaces the first patch of the previous series
(https://lkml.org/lkml/2020/10/22/1058), with the following changes:

1. Creates a helper function super_1_sb_length_ok().
2. Fixes operator placement style violation.
3. Covers case in super_1_sync().
4. Refactors duplicate logic.
5. Covers a case in existing code where aligned superblock could
   run into bitmap.

drivers/md/md.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 98bac4f304ae..d6a55ca1d52e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1646,6 +1646,17 @@ static __le32 calc_sb_1_csum(struct mdp_superblock_1 *sb)
 	return cpu_to_le32(csum);
 }
 
+/*
+ * set rdev->sb_size to that required for number of devices in array
+ * with appropriate padding to underlying sectors
+ */
+static void
+super_1_set_rdev_sb_size(struct md_rdev *rdev, int max_dev)
+{
+	int sb_size = max_dev * 2 + 256;
+	rdev->sb_size = round_up(sb_size, bdev_logical_block_size(rdev->bdev));
+}
+
 static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_version)
 {
 	struct mdp_superblock_1 *sb;
@@ -1653,7 +1664,6 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	sector_t sb_start;
 	sector_t sectors;
 	char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
-	int bmask;
 	bool spare_disk = true;
 
 	/*
@@ -1720,10 +1730,7 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 		rdev->new_data_offset += (s32)le32_to_cpu(sb->new_offset);
 	atomic_set(&rdev->corrected_errors, le32_to_cpu(sb->cnt_corrected_read));
 
-	rdev->sb_size = le32_to_cpu(sb->max_dev) * 2 + 256;
-	bmask = queue_logical_block_size(rdev->bdev->bd_disk->queue)-1;
-	if (rdev->sb_size & bmask)
-		rdev->sb_size = (rdev->sb_size | bmask) + 1;
+	super_1_set_rdev_sb_size(rdev, le32_to_cpu(sb->max_dev));
 
 	if (minor_version
 	    && rdev->data_offset < sb_start + (rdev->sb_size/512))
@@ -2132,12 +2139,8 @@ static void super_1_sync(struct mddev *mddev, struct md_rdev *rdev)
 			max_dev = rdev2->desc_nr+1;
 
 	if (max_dev > le32_to_cpu(sb->max_dev)) {
-		int bmask;
 		sb->max_dev = cpu_to_le32(max_dev);
-		rdev->sb_size = max_dev * 2 + 256;
-		bmask = queue_logical_block_size(rdev->bdev->bd_disk->queue)-1;
-		if (rdev->sb_size & bmask)
-			rdev->sb_size = (rdev->sb_size | bmask) + 1;
+		super_1_set_rdev_sb_size(rdev, max_dev);
 	} else
 		max_dev = le32_to_cpu(sb->max_dev);
 
-- 
2.17.1

