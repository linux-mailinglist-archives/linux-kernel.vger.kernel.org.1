Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08B42EF769
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbhAHSdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:33:14 -0500
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:52030 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728783AbhAHSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:33:13 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A10DB4FFA;
        Fri,  8 Jan 2021 18:32:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3653:3867:3870:3874:4605:5007:7652:7875:10004:10400:10848:11026:11473:11658:11914:12043:12291:12297:12438:12555:12683:12760:13069:13311:13357:13439:14110:14181:14394:14659:14721:21080:21433:21451:21627:21990:30029:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cloud32_07061be274f5
X-Filterd-Recvd-Size: 2925
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 Jan 2021 18:32:31 +0000 (UTC)
Message-ID: <47c01081533a417c99c9a80a4cd537f8c308503f.camel@perches.com>
Subject: [PATCH] checkpatch: Prefer ftrace over function entry/exit printks
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 08 Jan 2021 10:32:29 -0800
In-Reply-To: <20210107105310.GB5083@kadam>
References: <20210105202945.26913-1-fil.kolev@gmail.com>
         <X/VsF364jpGz6oze@kroah.com>
         <dcdda829-89d6-badd-4f22-72d95d24e9e3@gmail.com>
         <X/X45909l1Tk7Bni@kroah.com>
         <c9284a7f1443146b3885e8ceae3dcf113c531a36.camel@perches.com>
         <20210106193633.GK2809@kadam>
         <c5781c80a582cc68e1ae1bdc106c50cb263f81bf.camel@perches.com>
         <20210107105310.GB5083@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer using ftrace over function entry/exit logging messages.

Warn with various function entry/exit only logging that only
use __func__ with or without descriptive decoration.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e6857bdfcb2d..7c95f23352ae 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -507,6 +507,30 @@ our $signature_tags = qr{(?xi:
 	Cc:
 )};
 
+our $tracing_logging_tags = qr{(?xi:
+	[=-]*> |
+	<[=-]* |
+	\[ |
+	\] |
+	start |
+	called |
+	entered |
+	entry |
+	enter |
+	in |
+	inside |
+	here |
+	begin |
+	exit |
+	end |
+	done |
+	leave |
+	completed |
+	out |
+	return |
+	[\.\!:\s]*
+)};
+
 sub edit_distance_min {
 	my (@arr) = @_;
 	my $len = scalar @arr;
@@ -5981,6 +6005,17 @@ sub process {
 			     "Prefer using '\"%s...\", __func__' to using '$context_function', this function's name, in a string\n" . $herecurr);
 		}
 
+# check for unnecessary function tracing like uses
+# This does not use $logFunctions because there are many instances like
+# 'dprintk(FOO, "%s()\n", __func__);' which do not match $logFunctions
+		if ($rawline =~ /^\+.*\([^"]*"$tracing_logging_tags{0,3}%s(?:\s*\(\s*\)\s*)?$tracing_logging_tags{0,3}(?:\\n)?"\s*,\s*__func__\s*\)\s*;/) {
+			if (WARN("TRACING_LOGGING",
+				 "Unnecessary ftrace-like logging - prefer using ftrace\n" . $herecurr) &&
+			    $fix) {
+                                fix_delete_line($fixlinenr, $rawline);
+			}
+		}
+
 # check for spaces before a quoted newline
 		if ($rawline =~ /^.*\".*\s\\n/) {
 			if (WARN("QUOTED_WHITESPACE_BEFORE_NEWLINE",

