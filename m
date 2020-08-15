Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E637E245201
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Aug 2020 23:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHOVfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 17:35:47 -0400
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:60198 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726004AbgHOVfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:35:47 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 60D6D182D4AEB
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 01:38:17 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 24B0718027FA1;
        Sat, 15 Aug 2020 01:38:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3865:3866:3867:4250:5007:10004:10400:10848:11026:11473:11658:11914:12297:12346:12555:12760:13069:13311:13357:13439:14096:14097:14181:14394:14659:14721:21080:21627:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: brick56_401558527001
X-Filterd-Recvd-Size: 1649
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 15 Aug 2020 01:38:16 +0000 (UTC)
Message-ID: <15f52e9b0e50296aba35871bc1575a684c4a258a.camel@perches.com>
Subject: [PATCH] genksyms: keywords: Use __restrict not _restrict
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Aug 2020 18:38:15 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the proper form of the RESTRICT keyword.

Quote the comments properly too.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/genksyms/keywords.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/genksyms/keywords.c b/scripts/genksyms/keywords.c
index 7a85c4e21175..057c6cabad1d 100644
--- a/scripts/genksyms/keywords.c
+++ b/scripts/genksyms/keywords.c
@@ -25,9 +25,9 @@ static struct resword {
 	{ "__int128_t", BUILTIN_INT_KEYW },
 	{ "__uint128_t", BUILTIN_INT_KEYW },
 
-	// According to rth, c99 defines "_Bool", __restrict", __restrict__", "restrict".  KAO
+	// According to rth, c99 defines "_Bool", "__restrict", "__restrict__", "restrict".  KAO
 	{ "_Bool", BOOL_KEYW },
-	{ "_restrict", RESTRICT_KEYW },
+	{ "__restrict", RESTRICT_KEYW },
 	{ "__restrict__", RESTRICT_KEYW },
 	{ "restrict", RESTRICT_KEYW },
 	{ "asm", ASM_KEYW },

