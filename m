Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0926B2510FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 06:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgHYE5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 00:57:04 -0400
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:50270 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728691AbgHYE44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:56:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 6C9D2100E7B44;
        Tue, 25 Aug 2020 04:56:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1515:1534:1539:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3352:3868:5007:6117:6261:7903:10004:10848:11026:11473:11658:11914:12297:12555:12895:13069:13311:13357:13894:14181:14384:14394:14721:21080:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: form52_130ff6727059
X-Filterd-Recvd-Size: 1515
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:56:53 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 07/29] lp: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:04 -0700
Message-Id: <850c60ea44927e8cb7604d178c613ff8fc667984.1598331148.git.joe@perches.com>
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
 drivers/char/lp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 45932f05fd67..0ec73917d8dd 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -853,8 +853,10 @@ static void lp_console_write(struct console *co, const char *s,
 			count--;
 			do {
 				written = parport_write(port, crlf, i);
-				if (written > 0)
-					i -= written, crlf += written;
+				if (written > 0) {
+					i -= written;
+					crlf += written;
+				}
 			} while (i > 0 && (CONSOLE_LP_STRICT || written > 0));
 		}
 	} while (count > 0 && (CONSOLE_LP_STRICT || written > 0));
-- 
2.26.0

