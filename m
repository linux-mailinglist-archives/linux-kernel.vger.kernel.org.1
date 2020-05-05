Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A737C1C616B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 21:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgEET5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 15:57:42 -0400
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:52612 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgEET5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:57:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C0BD518026A37;
        Tue,  5 May 2020 19:57:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2525:2560:2563:2682:2685:2693:2828:2859:2911:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3355:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4425:4470:5007:7875:7903:8829:9025:9545:10004:10400:10848:11232:11658:11914:12043:12295:12297:12555:12679:12740:12760:12895:12986:13161:13229:13439:14181:14659:14721:21063:21080:21221:21433:21451:21627:21740:21819:30022:30045:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: son84_5ff89f9aca943
X-Filterd-Recvd-Size: 3923
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 May 2020 19:57:39 +0000 (UTC)
Message-ID: <1b0b4e6562cbbf4621e71042e511ae3cd0b542f6.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: use patch subject when reading from stdin
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, users@linux.kernel.org
Date:   Tue, 05 May 2020 12:57:37 -0700
In-Reply-To: <20200505132613.17452-1-geert+renesas@glider.be>
References: <20200505132613.17452-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-05 at 15:26 +0200, Geert Uytterhoeven wrote:
> While "git am" can apply an mbox file containing multiple patches (e.g.
> as created by b4[1], or a patch bundle downloaded from patchwork),
> checkpatch does not have proper support for that.  When operating on an
> mbox, checkpatch will merge all detected tags, and complain falsely
> about duplicates:
> 
>     WARNING: Duplicate signature
> 
> As modifying checkpatch to reset state in between each patch is a lot of
> work, a simple solution is splitting the mbox into individual patches,
> and invoking checkpatch for each of them.  Fortunately checkpatch can read
> a patch from stdin, so the classic "formail" tool can be used to split
> the mbox, and pipe all individual patches to checkpatch:
> 
>     formail -s scripts/checkpatch.pl < my-mbox
> 
> However, when reading a patch file from standard input, checkpatch calls
> it "Your patch", and reports its state as:
> 
>     Your patch has style problems, please review.
> 
> or:
> 
>     Your patch has no obvious style problems and is ready for submission.
> 
> Hence it can be difficult to identify which patches need to be reviewed
> and improved.
> 
> Fix this by replacing "Your patch" by (the first line of) the email
> subject, if present.
> 
> Note that "git mailsplit" can also be used to split an mbox, but it will
> create individual files for each patch, thus requiring cleanup
> afterwards.  Formail does not have this disadvantage.
> 
> [1] https://git.kernel.org/pub/scm/utils/b4/b4.git
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Add more rationale,
>   - Refer to the new b4 tool.
> ---
>  scripts/checkpatch.pl | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index eac40f0abd56a9f4..3355358697d9e790 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1057,6 +1057,10 @@ for my $filename (@ARGV) {
>  	}
>  	while (<$FILE>) {
>  		chomp;
> +		if ($vname eq 'Your patch') {
> +			my ($subject) = $_ =~ /^Subject:\s*(.*)/;
> +			$vname = '"' . $subject . '"' if $subject;
> +		}
>  		push(@rawlines, $_);
>  	}
>  	close($FILE);

There's a less cpu intensive way to do this,
for small patches, on my little laptop it's a
few dozen milliseconds faster, and for very
large patches multiple seconds faster to use
the following patch:

Substitute Geert's patch with the below but:

Acked-by: Joe Perches <joe@perches.com>

---

 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f0092104ff7b..29786a097862 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1062,6 +1062,7 @@ for my $filename (@ARGV) {
 	while (<$FILE>) {
 		chomp;
 		push(@rawlines, $_);
+		$vname = "\"$1\"" if ($filename eq '-' && $_ =~ /^Subject:\s*(.*)/);
 	}
 	close($FILE);
 

