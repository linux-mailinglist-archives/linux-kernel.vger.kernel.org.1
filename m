Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187602918EA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 20:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgJRSpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 14:45:47 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:41168 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbgJRSpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 14:45:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4F7A3182CED28;
        Sun, 18 Oct 2020 18:45:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6299:7875:7903:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12555:12760:13141:13230:13255:13439:14093:14097:14181:14394:14659:14721:21080:21433:21627:21819:21990:30003:30022:30025:30029:30046:30054:30070:30080:30089,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: trees27_0205dac27230
X-Filterd-Recvd-Size: 3770
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sun, 18 Oct 2020 18:45:44 +0000 (UTC)
Message-ID: <c5e23b45562373d632fccb8bc04e563abba4dd1d.camel@perches.com>
Subject: [PATCH V2] checkpatch: Enable GIT_DIR environment use to set git
 repository location
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 18 Oct 2020 11:45:43 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If set, use the environment variable GIT_DIR to change the
default .git location of the kernel git tree.

If GIT_DIR is unset, keep using the current ".git" default.

Signed-off-by: Joe Perches <joe@perches.com>
---

V2: learn to type my own email address...

commit f5f613259f3f ("checkpatch: allow not using -f with files that are in git")
breaks the use of checkpatch with:

   Global symbol "$gitroot" requires explicit package name (did you forget to declare "my $gitroot"?) at ./scripts/checkpatch.pl line 980.
   Execution of ./scripts/checkpatch.pl aborted due to compilation errors.

An unsigned test patch exists in -next that is required for
that new commit.

So, provide a better commit description for that test patch
and sign it too...

scripts/checkpatch.pl | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f40a81f24d43..a213cdb82ab0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -43,6 +43,8 @@ my $list_types = 0;
 my $fix = 0;
 my $fix_inplace = 0;
 my $root;
+my $gitroot = $ENV{'GIT_DIR'};
+$gitroot = ".git" if !defined($gitroot);
 my %debug;
 my %camelcase = ();
 my %use_type = ();
@@ -908,7 +910,7 @@ sub is_maintained_obsolete {
 sub is_SPDX_License_valid {
 	my ($license) = @_;
 
-	return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$root/.git"));
+	return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$gitroot"));
 
 	my $root_path = abs_path($root);
 	my $status = `cd "$root_path"; echo "$license" | python scripts/spdxcheck.py -`;
@@ -926,7 +928,7 @@ sub seed_camelcase_includes {
 
 	$camelcase_seeded = 1;
 
-	if (-e ".git") {
+	if (-e "$gitroot") {
 		my $git_last_include_commit = `${git_command} log --no-merges --pretty=format:"%h%n" -1 -- include`;
 		chomp $git_last_include_commit;
 		$camelcase_cache = ".checkpatch-camelcase.git.$git_last_include_commit";
@@ -954,7 +956,7 @@ sub seed_camelcase_includes {
 		return;
 	}
 
-	if (-e ".git") {
+	if (-e "$gitroot") {
 		$files = `${git_command} ls-files "include/*.h"`;
 		@include_files = split('\n', $files);
 	}
@@ -987,7 +989,7 @@ sub git_is_single_file {
 sub git_commit_info {
 	my ($commit, $id, $desc) = @_;
 
-	return ($id, $desc) if ((which("git") eq "") || !(-e ".git"));
+	return ($id, $desc) if ((which("git") eq "") || !(-e "$gitroot"));
 
 	my $output = `${git_command} log --no-color --format='%H %s' -1 $commit 2>&1`;
 	$output =~ s/^\s*//gm;
@@ -1026,7 +1028,7 @@ my $fixlinenr = -1;
 
 # If input is git commits, extract all commits from the commit expressions.
 # For example, HEAD-3 means we need check 'HEAD, HEAD~1, HEAD~2'.
-die "$P: No git repository found\n" if ($git && !-e ".git");
+die "$P: No git repository found\n" if ($git && !-e "$gitroot");
 
 if ($git) {
 	my @commits = ();


