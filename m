Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0ED2605F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 22:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgIGUuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 16:50:17 -0400
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:43838 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbgIGUuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:50:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 056CB837F24D;
        Mon,  7 Sep 2020 20:50:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3872:4321:4605:5007:6119:7875:10004:10400:10450:10455:10471:10848:11026:11232:11473:11658:11914:12043:12114:12291:12297:12555:12683:12740:12760:12895:13095:13255:13439:14181:14659:14721:19904:19999:21080:21212:21221:21433:21451:21627:21660:21939:30054:30056:30070:30080:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: size37_3508ebd270cf
X-Filterd-Recvd-Size: 4524
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Sep 2020 20:50:14 +0000 (UTC)
Message-ID: <beed63208cc412f122fe273602675801add08ede.camel@perches.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] checkpatch: GIT_COMMIT_ID:
 handle commit messages with multiple quotes
From:   Joe Perches <joe@perches.com>
To:     Ayush <ayush@disroot.org>, apw@canonical.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Sep 2020 13:50:13 -0700
In-Reply-To: <20200907151417.44453-1-ayush@disroot.org>
References: <20200907151417.44453-1-ayush@disroot.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-09-07 at 20:44 +0530, Ayush wrote:
> Commits which mentioned/referenced "revert commits" in their description will
> get error even if they follow the proper syntax.

I think all your examples are broken.

I think all should start with revert
i.e.: Reverts commit <SHA-1> ("description...")

> for reference:
> commit e8a170ff9a35 ("drm/amdgpu: enable -msse2 for GCC 7.1+ users")
> 
> This patch checks for quotes inside the commit message and adds it
> to $orig_desc.
> 
> Earlier, the script just won't update in case of such commit message.
> I modified old condition and added new conditions to check possible
> patterns.
> 
> Following patters are solved (commit taken as example):
> - commit 193392ed9f69 ("Revert "drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"")
> 
> - commit 193392ed9f69 ("Revert
> "drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"")
> 
> - commit 193392ed9f69 ("Revert "drm/amd/display:
> add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"")
> 
> - commit 193392ed9f69
> ("Revert "drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"")
> 
> Signed-off-by: Ayush <ayush@disroot.org>
> ---
>  scripts/checkpatch.pl | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 149518d2a6a7..e90e13b013d3 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2862,23 +2862,42 @@ sub process {
>  				$orig_desc = $1;
>  				$hasparens = 1;
>  			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
> -				 defined $rawlines[$linenr] &&
> -				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
> +				 defined $rawlines[$linenr]) {
> +				if ($rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
> +					$orig_desc = $1;
> +					$hasparens = 1;
> +				} elsif ($rawlines[$linenr] =~ /^\s*\("([^"]+"[^"]+[^"]")"\)/) {
> +					$orig_desc = $1;
> +					$hasparens = 1;
> +				}
> +			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
> +				 defined $rawlines[$linenr]) {
> +				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
>  				$orig_desc = $1;
> +				if($rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
> +					$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
> +					$orig_desc .= " " . $1;
>  				$hasparens = 1;
> -			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
> +				} elsif ($rawlines[$linenr] =~ /^\s*"[^"]+""\)/) {
> +					$rawlines[$linenr] =~ /^\s*("[^"]+")"\)/;
> +					$orig_desc .= " " . $1;
> +					$hasparens = 1;
> +				}
> +			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+"[^"]+[^"]")"\)/i) {
> +				$orig_desc = $1;
> +			    $hasparens = 1;
> +			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+"[^"]+$/i &&
>  				 defined $rawlines[$linenr] &&
> -				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
> -				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
> +				 $rawlines[$linenr] =~ /^\s*[^"]+""\)/) {
> +				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+"[^"]+)$/i;
>  				$orig_desc = $1;
> -				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
> +				$rawlines[$linenr] =~ /^\s*([^"]+")"\)/;
>  				$orig_desc .= " " . $1;
>  				$hasparens = 1;
>  			}
>  
>  			($id, $description) = git_commit_info($orig_commit,
>  							      $id, $orig_desc);
> 
>  			if (defined($id) &&
>  			   ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
>  				ERROR("GIT_COMMIT_ID",

