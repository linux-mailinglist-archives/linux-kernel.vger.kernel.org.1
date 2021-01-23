Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3942D301875
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 22:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbhAWVC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 16:02:28 -0500
Received: from smtprelay0119.hostedemail.com ([216.40.44.119]:59546 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725765AbhAWVC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 16:02:26 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 8D756100E7B42;
        Sat, 23 Jan 2021 21:01:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:800:960:967:968:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6117:7514:7652:7875:7903:7904:9025:10004:10400:11232:11658:11914:12043:12297:12555:12740:12895:12986:13095:13255:13439:13894:14181:14659:14721:21080:21324:21433:21451:21627:21660:21939:30012:30030:30054:30070:30089:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:4,LUA_SUMMARY:none
X-HE-Tag: bait30_0e0497e27577
X-Filterd-Recvd-Size: 3210
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sat, 23 Jan 2021 21:01:43 +0000 (UTC)
Message-ID: <a7329e5d5661ed6478a7eb33db854a6357447c16.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add warning for avoiding .L prefix
 symbols in assembly files
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com,
        broonie@kernel.org, ndesaulniers@google.com, jpoimboe@redhat.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Date:   Sat, 23 Jan 2021 13:01:42 -0800
In-Reply-To: <20210123190459.9701-1-yashsri421@gmail.com>
References: <f23f4003-0017-d52a-39b9-2737e60182bb@gmail.com>
         <20210123190459.9701-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-01-24 at 00:34 +0530, Aditya Srivastava wrote:
> objtool requires that all code must be contained in an ELF symbol.
> Symbol names that have a '.L' prefix do not emit symbol table entries, as
> they have special meaning for the assembler.
> 
> '.L' prefixed symbols can be used within a code region, but should be
> avoided for denoting a range of code via 'SYM_*_START/END' annotations.
> 
> Add a new check to emit a warning on finding the usage of '.L' symbols
> for '.S' files, if it denotes range of code via SYM_*_START/END
> annotation pair.
> 
> Suggested-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/lkml/20210112210154.GI4646@sirena.org.uk
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Joe Perches <joe@perches.com>

> ---
> * Applies perfectly on next-20210122
> 
> Changes in v3:
> - Modify regex for SYM_*_START/END pair
> - remove check for arch/x86/entry/* and arch/x86/lib/*
> - change 'Link:' in commit message to lkml
> - Modify commit description accordingly
> 
> Changes in v2:
> - Reduce the check to only SYM_*_START/END lines
> - Reduce the check for only .S files in arch/x86/entry/* and arch/x86/lib/* as suggested by Josh and Nick
> - Modify commit message
> 
>  scripts/checkpatch.pl | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7030c4d6d126..4a03326c87b6 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3590,6 +3590,13 @@ sub process {
>  			}
>  		}
>  
> 
> +# check for .L prefix local symbols in .S files
> +		if ($realfile =~ /\.S$/ &&
> +		    $line =~ /^\+\s*(?:[A-Z]+_)?SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) {
> +			WARN("AVOID_L_PREFIX",
> +			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotations.rst\n" . $herecurr);
> +		}
> +
>  # check we are in a valid source file C or perl if not then ignore this hunk
>  		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
>  
> 


