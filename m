Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6814E250CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 02:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgHYAJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 20:09:19 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:52432 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726189AbgHYAJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:09:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 82CB9100E7B44;
        Tue, 25 Aug 2020 00:09:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3353:3653:3865:3867:3868:3870:3871:3872:4321:5007:6299:7903:8957:9163:10004:10400:10848:11026:11473:11658:11914:12043:12297:12438:12555:12679:12760:13069:13311:13357:13439:14181:14394:14659:14721:21063:21080:21451:21627:21990:30054:30070:30080,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hen06_14153db27057
X-Filterd-Recvd-Size: 2241
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 00:09:16 +0000 (UTC)
Message-ID: <45b81a48e1568bd0126a96f5046eb7aaae9b83c9.camel@perches.com>
Subject: [PATCH] checkpatch: Allow not using -f with files that are in git
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 24 Aug 2020 17:09:15 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a file exists in git and checkpatch is used without the -f
flag for scanning a file, then checkpatch will scan the file
assuming it's a patch and emit:

ERROR: Does not appear to be a unified-diff format patch

Change the behavior to assume the -f flag if the file exists
in git.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79fc357b18cd..cdee7cfadc11 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -976,6 +976,16 @@ sub seed_camelcase_includes {
 	}
 }
 
+sub git_is_single_file {
+	my ($filename) = @_;
+
+	return 0 if ((which("git") eq "") || !(-e "$gitroot"));
+
+	my $output = `${git_command} ls-files -- $filename`;
+	my $count = $output =~ tr/\n//;
+	return $count eq 1 && $output =~ m{^${filename}$};
+}
+
 sub git_commit_info {
 	my ($commit, $id, $desc) = @_;
 
@@ -1049,6 +1059,9 @@ my $vname;
 $allow_c99_comments = !defined $ignore_type{"C99_COMMENT_TOLERANCE"};
 for my $filename (@ARGV) {
 	my $FILE;
+	my $is_git_file = git_is_single_file($filename);
+	my $oldfile = $file;
+	$file = 1 if ($is_git_file);
 	if ($git) {
 		open($FILE, '-|', "git format-patch -M --stdout -1 $filename") ||
 			die "$P: $filename: git format-patch failed - $!\n";
@@ -1093,6 +1106,7 @@ for my $filename (@ARGV) {
 	@modifierListFile = ();
 	@typeListFile = ();
 	build_types();
+	$file = $oldfile if ($is_git_file);
 }
 
 if (!$quiet) {


