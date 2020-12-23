Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58552E2119
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 21:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgLWUDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 15:03:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbgLWUDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 15:03:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 119F820575;
        Wed, 23 Dec 2020 20:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608753772;
        bh=OzQGdhwS/4twVbEa/nGXLGrUFMVqdR1IXK6igwQCBaY=;
        h=From:To:Cc:Subject:Date:From;
        b=iqJNWX99Qx764DXvmwDVsolI1kGuOUhAJqcvb7dobdR0xZeRJ2LqiPRSICKTeRnw7
         ulDaoNW/8Qjfpc/RmXhH06bY/kLQImUlj9Hrmd+EeEizahP1aXYWjhW3w+rSE8VYPe
         JU4ryaZkcNRjaehLC3EvmquVhYqys9v8eqBLGs4YuGNSHvyjT+AGX0yM9EAFKUm+Up
         llJQuEw3x7Ctcj4mItL68MWklO+C6i9AqLCrflvkQxZctYttOv+tvbhSDIVYS3l2r2
         ItJymhgjrFzjDfvgSUYf7ahJ4pdoeP/sXzVQEYcTDTAixDBI8c+08vXVHMSLrwSdH1
         QoGd5L1ZYUU0g==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: handle unallocated section and zone on pinned/atgc
Date:   Wed, 23 Dec 2020 12:02:42 -0800
Message-Id: <20201223200242.2078243-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have large section/zone, unallocated segment makes them corrupted.

E.g.,

  - Pinned file:       -1 119304647 119304647
  - ATGC   data:       -1 119304647 119304647

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index e81eb0748e2a..229814b4f4a6 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -101,11 +101,11 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 #define BLKS_PER_SEC(sbi)					\
 	((sbi)->segs_per_sec * (sbi)->blocks_per_seg)
 #define GET_SEC_FROM_SEG(sbi, segno)				\
-	((segno) / (sbi)->segs_per_sec)
+	(((segno) == -1) ? -1: (segno) / (sbi)->segs_per_sec)
 #define GET_SEG_FROM_SEC(sbi, secno)				\
 	((secno) * (sbi)->segs_per_sec)
 #define GET_ZONE_FROM_SEC(sbi, secno)				\
-	((secno) / (sbi)->secs_per_zone)
+	(((secno) == -1) ? -1: (secno) / (sbi)->secs_per_zone)
 #define GET_ZONE_FROM_SEG(sbi, segno)				\
 	GET_ZONE_FROM_SEC(sbi, GET_SEC_FROM_SEG(sbi, segno))
 
-- 
2.29.2.729.g45daf8777d-goog

