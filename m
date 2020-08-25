Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6681251105
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 06:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgHYE5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 00:57:33 -0400
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:59242 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728875AbgHYE5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:57:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B4CE01E09;
        Tue, 25 Aug 2020 04:57:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:857:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1541:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3353:3743:3865:3866:3867:3868:3870:3874:4321:5007:6261:7903:8879:10004:10848:11658:11914:12296:12297:12555:12895:13069:13311:13357:13894:14096:14181:14384:14394:14721:21067:21080:21524:21627:21773:30054:30075:30079,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: roll40_43024e127059
X-Filterd-Recvd-Size: 2151
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:57:22 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 22/29] video: fbdev: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:19 -0700
Message-Id: <3e56046e67e583ac93030297ff6d58c08ca54086.1598331149.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/fbdev/tgafb.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/tgafb.c b/drivers/video/fbdev/tgafb.c
index e9869135d833..666fbe2f671c 100644
--- a/drivers/video/fbdev/tgafb.c
+++ b/drivers/video/fbdev/tgafb.c
@@ -989,8 +989,10 @@ tgafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 	/* We can fill 2k pixels per operation.  Notice blocks that fit
 	   the width of the screen so that we can take advantage of this
 	   and fill more than one line per write.  */
-	if (width == line_length)
-		width *= height, height = 1;
+	if (width == line_length) {
+		width *= height;
+		height = 1;
+	}
 
 	/* The write into the frame buffer must be aligned to 4 bytes,
 	   but we are allowed to encode the offset within the word in
@@ -1171,8 +1173,10 @@ copyarea_8bpp(struct fb_info *info, u32 dx, u32 dy, u32 sx, u32 sy,
 	   More than anything else, these control how we do copies.  */
 	depos = dy * line_length + dx;
 	sepos = sy * line_length + sx;
-	if (backward)
-		depos += width, sepos += width;
+	if (backward) {
+		depos += width;
+		sepos += width;
+	}
 
 	/* Next copy full words at a time.  */
 	n32 = width / 32;
-- 
2.26.0

