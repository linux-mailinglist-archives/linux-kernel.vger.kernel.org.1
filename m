Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E3E250CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 02:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHYAEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 20:04:35 -0400
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:47738 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726041AbgHYAEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:04:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2A086837F253;
        Tue, 25 Aug 2020 00:04:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:305:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3653:3865:3867:3870:3872:5007:6299:7903:10004:10400:10848:11026:11658:11914:12296:12297:12555:12760:13019:13069:13161:13229:13311:13357:13439:14181:14394:14659:14721:21080:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hen28_1000ccd27057
X-Filterd-Recvd-Size: 1577
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 00:04:32 +0000 (UTC)
Message-ID: <f63229c051567041819f25e76f49d83c6e4c0f71.camel@perches.com>
Subject: [PATCH] get_maintainer: Add test for file in VCS
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 24 Aug 2020 17:04:31 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's somewhat common for me to ask get_maintainer
to tell me who
maintains a patch file rather than
the files modified by the patch.

Emit a warning if using get_maintainer.pl -f <patchfile>

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/get_maintainer.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 484d2fbf5921..5a36354a38cc 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -541,6 +541,9 @@ foreach my $file (@ARGV) {
 	    die "$P: file '${file}' not found\n";
 	}
     }
+    if ($from_filename && (vcs_exists() && !vcs_file_exists($file))) {
+	warn "$P: file '$file' not found in version control $!\n";
+    }
     if ($from_filename || ($file ne "&STDIN" && vcs_file_exists($file))) {
 	$file =~ s/^\Q${cur_path}\E//;	#strip any absolute path
 	$file =~ s/^\Q${lk_path}\E//;	#or the path to the lk tree



