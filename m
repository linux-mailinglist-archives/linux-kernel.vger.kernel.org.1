Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AAB291E0D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 21:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbgJRTtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 15:49:36 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:34524 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729758AbgJRTt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 15:49:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 805F012E9;
        Sun, 18 Oct 2020 19:49:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3653:3866:3871:4321:4823:5007:10004:10400:10848:11026:11232:11658:11914:12050:12297:12555:12760:13069:13161:13229:13311:13357:13439:14181:14394:14659:14721:21080:21221:21627:21990:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: pot35_22082b127231
X-Filterd-Recvd-Size: 2009
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 18 Oct 2020 19:49:27 +0000 (UTC)
Message-ID: <dfe24da760056e31d90ff639b47c494263b5f4a7.camel@perches.com>
Subject: [PATCH] checkpatch: Allow --fix removal of unnecessary break
 statements
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>, trix@redhat.com,
        linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>
Date:   Sun, 18 Oct 2020 12:49:26 -0700
In-Reply-To: <alpine.DEB.2.22.394.2010172016370.9440@hadrien>
References: <20201017160928.12698-1-trix@redhat.com>
         <f530b7aeecbbf9654b4540cfa20023a4c2a11889.camel@perches.com>
         <alpine.DEB.2.22.394.2010172016370.9440@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

switch/case use of break after a return or goto is unnecessary.

There is an existing warning for these uses, so add a --fix option too.

Signed-off-by: Joe Perches <joe@perches.com>
---

For today's next, this would remove ~300 instances like:

	case FOO:
		return bar;
		break;
or
	case FOO:
		goto bar;
		break;

 scripts/checkpatch.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..22263b278e87 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3678,8 +3678,11 @@ sub process {
 		if ($sline =~ /^\+([\t]+)break\s*;\s*$/) {
 			my $tabs = $1;
 			if ($prevline =~ /^\+$tabs(?:goto|return)\b/) {
-				WARN("UNNECESSARY_BREAK",
-				     "break is not useful after a goto or return\n" . $hereprev);
+				if (WARN("UNNECESSARY_BREAK",
+					 "break is not useful after a goto or return\n" . $hereprev) &&
+				    $fix) {
+					fix_delete_line($fixlinenr, $rawline);
+				}
 			}
 		}
 


