Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945F5280689
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbgJAS2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:28:13 -0400
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:59716 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729412AbgJAS2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:28:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 2BF8D180208D7;
        Thu,  1 Oct 2020 18:28:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3653:3865:3867:3868:3870:3871:3872:4321:5007:10004:10400:10848:11658:11914:12297:12555:12760:13069:13311:13357:13439:14181:14394:14659:14721:21080:21627:21660:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: play54_0a011812719d
X-Filterd-Recvd-Size: 1543
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Oct 2020 18:28:11 +0000 (UTC)
Message-ID: <1fd5f9188a14acdca703ca00301ee323de672a8d.camel@perches.com>
Subject: [PATCH] checkpatch: Emit a warning on embedded filenames
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Oct 2020 11:28:10 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Embedding the complete filename path inside the file
isn't particularly useful as often the path is moved
around and becomes incorrect.

Emit a warning when the source contains the filename.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a213cdb82ab0..84d2ee118c55 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3273,6 +3273,12 @@ sub process {
 			}
 		}
 
+# check for embedded filenames
+		if ($rawline =~ /^\+.*\Q$realfile\E/) { di
+			WARN("EMBEDDED_FILENAME",
+			     "It's generally not useful to have the filename in the file\n" . $herecurr);
+		}
+
 # check we are in a valid source file if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
 


