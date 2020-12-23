Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDA02E17D8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 04:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgLWDq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 22:46:26 -0500
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:34596 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727396AbgLWDq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 22:46:26 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 7165A181D3028;
        Wed, 23 Dec 2020 03:45:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1540:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3350:3653:3865:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:8957:9025:10004:10400:10848:11026:11658:11914:12043:12297:12438:12555:12760:12986:13069:13311:13357:13439:14181:14394:14659:14721:14777:21080:21451:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: truck68_080733e27465
X-Filterd-Recvd-Size: 1673
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 23 Dec 2020 03:45:44 +0000 (UTC)
Message-ID: <19fe91084890e2c16fe56f960de6c570a93fa99b.camel@perches.com>
Subject: [PATCH] checkpatch: Prefer strscpy to strlcpy
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Date:   Tue, 22 Dec 2020 19:45:43 -0800
In-Reply-To: <20201222155852.54d9393837ec884870ab4c3b@linux-foundation.org>
References: <20201222155852.54d9393837ec884870ab4c3b@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer strscpy over the deprecated strlcpy function.

Requested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 00085308ed9d..27679cc0ec17 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6646,6 +6646,12 @@ sub process {
 #			}
 #		}
 
+# strlcpy uses that should likely be strscpy
+		if ($line =~ /\bstrlcpy\s*\(/) {
+			WARN("STRLCPY",
+			     "Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw\@mail.gmail.com/\n" . $herecurr);
+		}
+
 # typecasts on min/max could be min_t/max_t
 		if ($perl_version_ok &&
 		    defined $stat &&

