Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44D3271540
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 17:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgITPJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 11:09:45 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:37384 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726267AbgITPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 11:09:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 1A7B7180A7FFE;
        Sun, 20 Sep 2020 15:09:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2691:2828:2895:3138:3139:3140:3141:3142:3355:3622:3653:3865:3867:3868:3870:3871:3872:3873:3874:4250:4321:4470:4605:5007:6119:7514:7576:7903:7974:8825:10004:10848:11026:11232:11473:11658:11914:12043:12291:12295:12297:12438:12555:12663:12679:12683:12740:12895:13095:13255:13439:13894:14093:14097:14180:14181:14659:14721:21060:21080:21221:21324:21433:21451:21627:21740:21819:21990:30003:30022:30029:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: taste68_280c5f42713d
X-Filterd-Recvd-Size: 5265
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun, 20 Sep 2020 15:09:43 +0000 (UTC)
Message-ID: <7958ded756c895ca614ba900aae7b830a992475e.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: extend author Signed-off-by check for
 split From: header
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Sun, 20 Sep 2020 08:09:42 -0700
In-Reply-To: <20200920091706.56276-1-dwaipayanray1@gmail.com>
References: <20200920091706.56276-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-09-20 at 14:47 +0530, Dwaipayan Ray wrote:
> Checkpatch did not handle cases where the author From: header
> was split into multiple lines. The author identity could not
> be resolved and checkpatch generated a false NO_AUTHOR_SIGN_OFF
> warning.

Hi Dwaipayan.

> A typical example is Commit e33bcbab16d1 ("tee: add support for
> session's client UUID generation"). When checkpatch was run on
> this commit, it displayed:
> 
> "WARNING:NO_AUTHOR_SIGN_OFF: Missing Signed-off-by: line by nominal
> patch author ''"
> 
> This was due to split header lines not being handled properly and
> the author himself wrote in Commit cd2614967d8b ("checkpatch: warn
> if missing author Signed-off-by"):
> 
> "Split From: headers are not fully handled: only the first part
> is compared."
> 
> Support split From: headers by correctly parsing the header
> extension lines. RFC 2822, Section-2.2.3 stated that each extended
> line must start with a WSP character (a space or htab). The solution
> was therefore to concatenate the lines which start with a WSP to
> get the correct long header.

This is a good commit message, though I believe the
latest rfc is 5322.  I'm not sure there is any real
difference in the referenced section though.

While your patch seems to work for git format-email,
other emailers seem to set headers that have multiple
whitespace chars that should be collapsed into a
single space.

I think you'll find that the eliding all whitespace
after header folding causes mismatches for emails.

For instance:

From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>

Always inserting a single space if there is any
whitespace after the folding WSP might be better
otherwise this is decoded as

From: "Christian König"<ckoenig.leichtzumerken@gmail.com>

What I have does a bit more by saving any post-folding

"From: <name and email address>"

and comparing that to any "name and perhaps different
email address" in a Signed-off-by: line.

A new message is emitted if the name matches but the
email address is different.

Perhaps it's reasonable to apply your patch and then
update it with something like the below:
---
 scripts/checkpatch.pl | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3e474072aa90..1ecc179e938d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1240,6 +1240,15 @@ sub same_email_addresses {
 	       $email1_address eq $email2_address;
 }
 
+sub same_email_names {
+	my ($email1, $email2) = @_;
+
+	my ($email1_name, $name1_comment, $email1_address, $comment1) = parse_email($email1);
+	my ($email2_name, $name2_comment, $email2_address, $comment2) = parse_email($email2);
+
+	return $email1_name eq $email2_name;
+}
+
 sub which {
 	my ($bin) = @_;
 
@@ -2679,20 +2688,32 @@ sub process {
 		}
 
 # Check the patch for a From:
-		if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
+		if ($line =~ /^From:\s*(.*)/i) {
 			$author = $1;
-			$author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);
+			my $curline = $linenr;
+			while (defined($rawlines[$curline]) && $rawlines[$curline++] =~ /^\s(\s+)?(.*)/) {
+				$author .= ' ' if (defined($1));
+				$author .= "$2";
+			}
+			if ($author =~ /=\?utf-8\?/i) {
+				$author = decode("MIME-Header", $author);
+				$author = encode("utf8", $author);
+			}
+
 			$author =~ s/"//g;
 			$author = reformat_email($author);
 		}
 
 # Check the patch for a signoff:
 		if ($line =~ /^\s*signed-off-by:\s*(.*)/i) {
+			my $sig = $1;
 			$signoff++;
 			$in_commit_log = 0;
 			if ($author ne '') {
-				if (same_email_addresses($1, $author)) {
-					$authorsignoff = 1;
+				if (same_email_addresses($sig, $author)) {
+					$authorsignoff = "1";
+				} elsif (same_email_names($sig, $author)) {
+					$authorsignoff = $sig;
 				}
 			}
 		}
@@ -6937,6 +6958,9 @@ sub process {
 		} elsif (!$authorsignoff) {
 			WARN("NO_AUTHOR_SIGN_OFF",
 			     "Missing Signed-off-by: line by nominal patch author '$author'\n");
+		} elsif ($authorsignoff ne "1") {
+			WARN("NO_AUTHOR_SIGN_OFF",
+			     "From:/SoB: email address mismatch: 'From: $author' != 'Signed-off-by: $authorsignoff'\n");
 		}
 	}
 

