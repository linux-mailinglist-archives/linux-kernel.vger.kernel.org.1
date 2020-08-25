Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20A025111E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 06:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgHYE6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 00:58:45 -0400
Received: from smtprelay0180.hostedemail.com ([216.40.44.180]:33390 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728533AbgHYE5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:57:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id DA32C181D337B;
        Tue, 25 Aug 2020 04:57:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1540:1711:1714:1730:1747:1777:1792:2198:2199:2393:2559:2562:2895:3138:3139:3140:3141:3142:3351:3865:3866:3868:4321:5007:6119:6261:10004:10848:11026:11658:11914:12043:12296:12297:12438:12555:12895:13069:13311:13357:13894:14181:14384:14394:14721:21080:21627:21740:30003:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: low63_3a0323c27059
X-Filterd-Recvd-Size: 1653
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:57:16 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 19/29] s390/tty3270: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:16 -0700
Message-Id: <9988babd9cca4ac841961d9f0bbf5e49caa87659.1598331149.git.joe@perches.com>
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
 drivers/s390/char/tty3270.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index aec996de44d9..6acce975df26 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -424,8 +424,10 @@ tty3270_update(struct timer_list *t)
 			 * last output position matches the start address
 			 * of this line.
 			 */
-			if (s->string[1] == sba[0] && s->string[2] == sba[1])
-				str += 3, len -= 3;
+			if (s->string[1] == sba[0] && s->string[2] == sba[1]) {
+				str += 3;
+				len -= 3;
+			}
 			if (raw3270_request_add_data(wrq, str, len) != 0)
 				break;
 			list_del_init(&s->update);
-- 
2.26.0

