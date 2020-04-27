Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E175A1B96AB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 07:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgD0Fk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 01:40:57 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:57318 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726172AbgD0Fk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 01:40:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id CBBFF100E7B40;
        Mon, 27 Apr 2020 05:40:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:305:355:379:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2827:2828:3138:3139:3140:3141:3142:3354:3653:3865:3867:3868:3870:3872:3874:4250:4605:5007:6299:7903:7904:8957:9010:9040:9592:10004:10848:11026:11658:11914:12043:12291:12296:12297:12346:12438:12555:12679:12683:13161:13229:13439:13894:14181:14394:14659:14721:21080:21324:21433:21451:21505:21627:21660:21819:21939:21990:30003:30022:30026:30046:30054:30062:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: owl97_7daddaa7d028
X-Filterd-Recvd-Size: 5572
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 05:40:53 +0000 (UTC)
Message-ID: <7beaedfd63017973b910dd21cac13ecb42dbe503.camel@perches.com>
Subject: [PATCH] get_maintainer: Add email addresses from .yaml files
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Collabora Kernel ML <kernel@collabora.com>
Date:   Sun, 26 Apr 2020 22:40:52 -0700
In-Reply-To: <9a32f150f85f851d04afd148b2a9a5cf203f7ce1.camel@perches.com>
References: <87d082jtfn.fsf@collabora.com>
         <20200420175909.GA5810@ravnborg.org>
         <CAL_JsqJXa8QxQmLfkCO8_SSsgYm2nTFW1J6wx4bGbZgAy8Sxog@mail.gmail.com>
         <9a32f150f85f851d04afd148b2a9a5cf203f7ce1.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.yaml files can contain maintainer/author addresses and it seems
unlikely or unnecessary that individual MAINTAINER file section
entries for each .yaml file will be created.

So dd the email addresses found in .yaml files to the default
get_maintainer output.

The email addresses are marked with "(in file)" when using the
"--roles" or "--rolestats" options.

Miscellanea:

o Change $file_emails to $email_file_emails to avoid visual
  naming conflicts with @file_emails

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/get_maintainer.pl | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 6cbcd1..6d973f 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -57,7 +57,7 @@ my $status = 0;
 my $letters = "";
 my $keywords = 1;
 my $sections = 0;
-my $file_emails = 0;
+my $email_file_emails = 0;
 my $from_filename = 0;
 my $pattern_depth = 0;
 my $self_test = undef;
@@ -69,6 +69,12 @@ my $vcs_used = 0;
 
 my $exit = 0;
 
+my @files = ();
+my @fixes = ();			# If a patch description includes Fixes: lines
+my @range = ();
+my @keyword_tvi = ();
+my @file_emails = ();
+
 my %commit_author_hash;
 my %commit_signer_hash;
 
@@ -266,7 +272,7 @@ if (!GetOptions(
 		'pattern-depth=i' => \$pattern_depth,
 		'k|keywords!' => \$keywords,
 		'sections!' => \$sections,
-		'fe|file-emails!' => \$file_emails,
+		'fe|file-emails!' => \$email_file_emails,
 		'f|file' => \$from_filename,
 		'find-maintainer-files' => \$find_maintainer_files,
 		'mpath|maintainer-path=s' => \$maintainer_path,
@@ -424,6 +430,22 @@ sub read_all_maintainer_files {
     }
 }
 
+sub maintainers_in_file {
+    my ($file) = @_;
+
+    return if ($file =~ m@\bMAINTAINERS$@);
+
+    if (-f $file && ($email_file_emails || $file =~ /\.yaml$/)) {
+	open(my $f, '<', $file)
+	    or die "$P: Can't open $file: $!\n";
+	my $text = do { local($/) ; <$f> };
+	close($f);
+
+	my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
+	push(@file_emails, clean_file_emails(@poss_addr));
+    }
+}
+
 #
 # Read mail address map
 #
@@ -504,12 +526,6 @@ sub read_mailmap {
 
 ## use the filenames on the command line or find the filenames in the patchfiles
 
-my @files = ();
-my @fixes = ();			# If a patch description includes Fixes: lines
-my @range = ();
-my @keyword_tvi = ();
-my @file_emails = ();
-
 if (!@ARGV) {
     push(@ARGV, "&STDIN");
 }
@@ -527,7 +543,7 @@ foreach my $file (@ARGV) {
 	$file =~ s/^\Q${cur_path}\E//;	#strip any absolute path
 	$file =~ s/^\Q${lk_path}\E//;	#or the path to the lk tree
 	push(@files, $file);
-	if ($file ne "MAINTAINERS" && -f $file && ($keywords || $file_emails)) {
+	if ($file ne "MAINTAINERS" && -f $file && $keywords) {
 	    open(my $f, '<', $file)
 		or die "$P: Can't open $file: $!\n";
 	    my $text = do { local($/) ; <$f> };
@@ -539,10 +555,6 @@ foreach my $file (@ARGV) {
 		    }
 		}
 	    }
-	    if ($file_emails) {
-		my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
-		push(@file_emails, clean_file_emails(@poss_addr));
-	    }
 	}
     } else {
 	my $file_cnt = @files;
@@ -923,6 +935,8 @@ sub get_maintainers {
 		print("\n");
 	    }
 	}
+
+	maintainers_in_file($file);
     }
 
     if ($keywords) {
@@ -1835,7 +1849,7 @@ tm toggle maintainers
 tg toggle git entries
 tl toggle open list entries
 ts toggle subscriber list entries
-f  emails in file       [$file_emails]
+f  emails in file       [$email_file_emails]
 k  keywords in file     [$keywords]
 r  remove duplicates    [$email_remove_duplicates]
 p# pattern match depth  [$pattern_depth]
@@ -1960,7 +1974,7 @@ EOT
 		bool_invert(\$email_git_all_signature_types);
 		$rerun = 1;
 	    } elsif ($sel eq "f") {
-		bool_invert(\$file_emails);
+		bool_invert(\$email_file_emails);
 		$rerun = 1;
 	    } elsif ($sel eq "r") {
 		bool_invert(\$email_remove_duplicates);


