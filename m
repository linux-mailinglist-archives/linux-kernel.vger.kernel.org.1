Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A152F0424
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 23:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbhAIWlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 17:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbhAIWlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 17:41:46 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99879C0617A2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 14:41:06 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id d9so13784967iob.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 14:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bA/H+Ix6mdVNJUzCQktcbDCRUbkhKj8e09Gs4Zc1wZ8=;
        b=ccK5+N1mSWbGzm9r7hxBUfW5XZBc1mPYJHu7iWhZJeaNR7w6NfkHb6Pq5UCN01m+yg
         9gb/7azJbcq4lDUkGrtMTl5aZgJueArsi7SgCYDSvT9iN4I3gaGol/LSOI9VuYJaCiwb
         e+urBNCpU8ucIh3uc5MaRVAFuIiIImr5jG8zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bA/H+Ix6mdVNJUzCQktcbDCRUbkhKj8e09Gs4Zc1wZ8=;
        b=TdjY9wioHi2evco/68iJaMJDezkV69AxXLZ9gWeQLmHznZPCCiV66/nQ9FCwKf4+c3
         OP9aBo0ORaWF7xfYVzmUdq3tC/ctNkHODrTAJutYcObc/qHbRwiGyOHw8rWXGcss0qkP
         uB87uS5U/X5QCiB9BGTDmHsvVRJz7kh+tGfvnPgpmG6A8OijtScfq1az9EgClTS1pnbG
         BGiU62SW3Z1JpTIwCkbtWwvEebzt33PXwZGpzK1aN+n74VoyeHq16JRT6sWgWDqIqSYJ
         LkctCg1Tg/nmXaGkdg2lgvLRLmwTGT1eWg9QHLAlftf2mzzVYrmXZdbseDupS/okh2AE
         w6kA==
X-Gm-Message-State: AOAM531w2wQZKKtgQ5FTXzGTCZ8tnTWV3FKl/u9vXdidZj+iujwZt8Ri
        5NGPvkQYnYMyTj+/1EHtR+ElxA==
X-Google-Smtp-Source: ABdhPJxk//mxl8IRph0lgiaeZJwLVNyDskK4/jw+Ub9PvNn/m5xV/4oQ1z670pyI8pWTrA0ymaH9Lw==
X-Received: by 2002:a02:ce2c:: with SMTP id v12mr9065294jar.60.1610232065617;
        Sat, 09 Jan 2021 14:41:05 -0800 (PST)
Received: from sunraycer.home ([2601:246:4400:318::100])
        by smtp.gmail.com with ESMTPSA id z18sm10594106ilb.26.2021.01.09.14.41.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 Jan 2021 14:41:04 -0800 (PST)
Received: from puyallup.local (localhost [127.0.0.1])
        by sunraycer.home (Postfix) with ESMTPA id 04317366BC6;
        Sat,  9 Jan 2021 16:41:04 -0600 (CST)
From:   Steve Magnani <magnani@ieee.org>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <magnani@ieee.org>
Subject: [PATCH 1/2] udf: fix hole append when File Tail exists
Date:   Sat,  9 Jan 2021 16:40:53 -0600
Message-Id: <20210109224054.5694-2-magnani@ieee.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210109224054.5694-1-magnani@ieee.org>
References: <20210109224054.5694-1-magnani@ieee.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven J. Magnani <magnani@ieee.org>

When an ALLOCATED_NOT_RECORDED extent ("File Tail") follows the
extents describing a file body, don't (improperly) try to make use of it
as part of appending a hole to the file.

Fixes: fa33cdbf3ece ("udf: Fix incorrect final NOT_ALLOCATED (hole) extent length")
Signed-off-by: Steven J. Magnani <magnani@ieee.org>
---
--- a/fs/udf/inode.c	2020-12-28 20:51:29.000000000 -0600
+++ b/fs/udf/inode.c	2021-01-02 17:00:39.794157840 -0600
@@ -520,8 +520,7 @@ static int udf_do_extend_file(struct ino
 		prealloc_loc = last_ext->extLocation;
 		prealloc_len = last_ext->extLength;
 		/* Mark the extent as a hole */
-		last_ext->extLength = EXT_NOT_RECORDED_NOT_ALLOCATED |
-			(last_ext->extLength & UDF_EXTENT_LENGTH_MASK);
+		last_ext->extLength = EXT_NOT_RECORDED_NOT_ALLOCATED;
 		last_ext->extLocation.logicalBlockNum = 0;
 		last_ext->extLocation.partitionReferenceNum = 0;
 	}
@@ -626,7 +625,6 @@ static void udf_do_extend_final_block(st
 
 static int udf_extend_file(struct inode *inode, loff_t newsize)
 {
-
 	struct extent_position epos;
 	struct kernel_lb_addr eloc;
 	uint32_t elen;
@@ -639,6 +637,7 @@ static int udf_extend_file(struct inode
 	struct kernel_long_ad extent;
 	int err = 0;
 	int within_final_block;
+	loff_t hole_size = 0;
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
 		adsize = sizeof(struct short_ad);
@@ -648,7 +647,8 @@ static int udf_extend_file(struct inode
 		BUG();
 
 	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
-	within_final_block = (etype != -1);
+	within_final_block = (etype == (EXT_RECORDED_ALLOCATED >> 30)) ||
+			     (etype == (EXT_NOT_RECORDED_NOT_ALLOCATED >> 30));
 
 	if ((!epos.bh && epos.offset == udf_file_entry_alloc_offset(inode)) ||
 	    (epos.bh && epos.offset == sizeof(struct allocExtDesc))) {
@@ -658,9 +658,15 @@ static int udf_extend_file(struct inode
 		extent.extLocation.partitionReferenceNum = 0;
 		extent.extLength = EXT_NOT_RECORDED_NOT_ALLOCATED;
 	} else {
+		int8_t bmap_etype = etype;
 		epos.offset -= adsize;
 		etype = udf_next_aext(inode, &epos, &extent.extLocation,
 				      &extent.extLength, 0);
+		if ((bmap_etype == -1) &&
+		    (etype == (EXT_NOT_RECORDED_ALLOCATED >> 30))) {
+			/* offset is relative to prealloc extent end */
+			hole_size = extent.extLength;
+		}
 		extent.extLength |= etype << 30;
 	}
 
@@ -674,9 +680,9 @@ static int udf_extend_file(struct inode
 		udf_do_extend_final_block(inode, &epos, &extent,
 					  partial_final_block);
 	} else {
-		loff_t add = ((loff_t)offset << sb->s_blocksize_bits) |
+		hole_size += ((loff_t)offset << sb->s_blocksize_bits) |
 			     partial_final_block;
-		err = udf_do_extend_file(inode, &epos, &extent, add);
+		err = udf_do_extend_file(inode, &epos, &extent, hole_size);
 	}
 
 	if (err < 0)
@@ -700,7 +706,7 @@ static sector_t inode_getblk(struct inod
 	loff_t lbcount = 0, b_off = 0;
 	udf_pblk_t newblocknum, newblock;
 	sector_t offset = 0;
-	int8_t etype;
+	int8_t etype = -1;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	udf_pblk_t goal = 0, pgoal = iinfo->i_location.logicalBlockNum;
 	int lastblock = 0;
@@ -729,14 +735,22 @@ static sector_t inode_getblk(struct inod
 			cur_epos.bh = next_epos.bh;
 		}
 
-		lbcount += elen;
-
 		prev_epos.block = cur_epos.block;
 		cur_epos.block = next_epos.block;
 
 		prev_epos.offset = cur_epos.offset;
 		cur_epos.offset = next_epos.offset;
 
+		/* Corner case: preallocated extent that stops short of
+		 * desired block
+		 */
+		if ((etype == (EXT_NOT_RECORDED_ALLOCATED >> 30)) &&
+		    ((lbcount + elen) <= b_off)) {
+			etype = -1;
+			break;
+		}
+
+		lbcount += elen;
 		etype = udf_next_aext(inode, &next_epos, &eloc, &elen, 1);
 		if (etype == -1)
 			break;
