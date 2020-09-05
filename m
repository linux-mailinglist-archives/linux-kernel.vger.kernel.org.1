Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F2E25E999
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 19:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgIER6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 13:58:35 -0400
Received: from smtprelay0111.hostedemail.com ([216.40.44.111]:36470 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728387AbgIER6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 13:58:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 1EF071E01;
        Sat,  5 Sep 2020 17:58:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3653:3865:3867:3868:3872:3874:4321:5007:10004:10400:10848:11658:11914:12043:12296:12297:12555:12760:13019:13069:13161:13229:13311:13357:13439:14093:14097:14181:14394:14659:14721:21080:21221:21451:21627:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: earth46_3514226270bc
X-Filterd-Recvd-Size: 2360
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sat,  5 Sep 2020 17:58:30 +0000 (UTC)
Message-ID: <afc2cffdd315d3e4394af149278df9e8af7f49f4.camel@perches.com>
Subject: [PATCH] checkpatch: Warn on self-assignments
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>, julia.lawall@inria.fr
Date:   Sat, 05 Sep 2020 10:58:29 -0700
In-Reply-To: <20200901094812.428896-1-efremov@linux.com>
References: <20200811210127.11889-1-efremov@linux.com>
         <20200901094812.428896-1-efremov@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uninitialized_var() macro was removed recently via
commit 63a0895d960a ("compiler: Remove uninitialized_var() macro")
as it's not a particularly useful warning and its use can
"paper over real bugs".

Add a checkpatch test to warn on self-assignments as a means
to avoid compiler warnings and as a back-door mechanism to
reproduce the old uninitialized_var macro behavior.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 149518d2a6a7..300b2659aab3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3901,6 +3901,17 @@ sub process {
 #ignore lines not being added
 		next if ($line =~ /^[^\+]/);
 
+# check for self assigments used to avoid compiler warnings
+# e.g.:	int foo = foo, *bar = NULL;
+#	struct foo bar = *(&(bar));
+		if ($line =~ /^\+\s*(?:$Declare)?([A-Za-z_][A-Za-z\d_]*)\s*=/) {
+			my $var = $1;
+			if ($line =~ /^\+\s*(?:$Declare)?$var\s*=\s*(?:$var|\*\s*\(?\s*&\s*\(?\s*$var\s*\)?\s*\)?)\s*[;,]/) {
+				WARN("SELF_ASSIGNMENT",
+				     "Do not use self-assignments to avoid compiler warnings\n" . $herecurr);
+			}
+		}
+
 # check for dereferences that span multiple lines
 		if ($prevline =~ /^\+.*$Lval\s*(?:\.|->)\s*$/ &&
 		    $line =~ /^\+\s*(?!\#\s*(?!define\s+|if))\s*$Lval/) {



