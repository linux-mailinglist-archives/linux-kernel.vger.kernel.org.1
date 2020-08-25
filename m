Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32199251116
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 06:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgHYE5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 00:57:21 -0400
Received: from smtprelay0144.hostedemail.com ([216.40.44.144]:33320 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728803AbgHYE5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:57:12 -0400
X-Greylist: delayed 125017 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Aug 2020 00:57:12 EDT
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 7D2D418224D86;
        Tue, 25 Aug 2020 04:57:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1541:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3352:3867:3868:4321:5007:6261:7904:10004:10848:11658:11914:12296:12297:12555:12895:12986:13069:13311:13357:13894:14181:14384:14394:14721:21080:21627:21990:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: offer77_2f11fd827059
X-Filterd-Recvd-Size: 1989
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:57:09 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 15/29] mtd: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:12 -0700
Message-Id: <ae92f4c0507c470d9461886410dc7030192f9014.1598331149.git.joe@perches.com>
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
 drivers/mtd/devices/lart.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/lart.c b/drivers/mtd/devices/lart.c
index 56f50d27b7fd..aecd441e4183 100644
--- a/drivers/mtd/devices/lart.c
+++ b/drivers/mtd/devices/lart.c
@@ -436,7 +436,10 @@ static int flash_read (struct mtd_info *mtd,loff_t from,size_t len,size_t *retle
 	 {
 		int gap = BUSWIDTH - (from & (BUSWIDTH - 1));
 
-		while (len && gap--) *buf++ = read8 (from++), len--;
+		while (len && gap--) {
+			*buf++ = read8 (from++);
+			len--;
+		}
 	 }
 
    /* now we read dwords until we reach a non-dword boundary */
@@ -518,7 +521,10 @@ static int flash_write (struct mtd_info *mtd,loff_t to,size_t len,size_t *retlen
 		i = n = 0;
 
 		while (gap--) tmp[i++] = 0xFF;
-		while (len && i < BUSWIDTH) tmp[i++] = buf[n++], len--;
+		while (len && i < BUSWIDTH) {
+			tmp[i++] = buf[n++];
+			len--;
+		}
 		while (i < BUSWIDTH) tmp[i++] = 0xFF;
 
 		if (!write_dword (aligned,*((__u32 *) tmp))) return (-EIO);
-- 
2.26.0

