Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6FB2E2E8D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 16:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgLZPut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 10:50:49 -0500
Received: from smtprelay0227.hostedemail.com ([216.40.44.227]:52166 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725995AbgLZPus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 10:50:48 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 486F4180A7FF1;
        Sat, 26 Dec 2020 15:50:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 93,11,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4605:5007:7652:7875:7904:10010:10400:10848:11026:11232:11658:11914:12297:12679:12740:12895:13095:13161:13229:13439:13894:14096:14097:14181:14659:14721:21080:21433:21627:21740:21741:21939:21966:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: self21_070e6ca27483
X-Filterd-Recvd-Size: 2984
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat, 26 Dec 2020 15:50:06 +0000 (UTC)
Message-ID: <c746437027a6aae481a8719be929970b33a67d2d.camel@perches.com>
Subject: Re: [PATCH v2 3/4] checkpatch: kconfig: enforce help text
 indentation
From:   Joe Perches <joe@perches.com>
To:     Nicolai Fischer <nicolai.fischer@fau.de>,
        linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de, akpm@linux-foundation.org
Date:   Sat, 26 Dec 2020 07:50:04 -0800
In-Reply-To: <20201226140511.662368-4-nicolai.fischer@fau.de>
References: <b1c83a13-204f-25ff-d08b-d08559e25a3b@fau.de>
         <20201226140511.662368-1-nicolai.fischer@fau.de>
         <20201226140511.662368-4-nicolai.fischer@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-12-26 at 15:05 +0100, Nicolai Fischer wrote:
> Adds a new warning in case the indentation level of the
> first line of a Kconfig help message is not two spaces
> higher than the keyword itself.
> Blank lines between the message and the help keyword
> are ignored.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3332,6 +3336,13 @@ sub process {
>  				$f =~ s/^\s+//;
>  				next if ($f =~ /^$/);
>  
> 
> +				if (defined $help_indent) {
> +					if ($lines[$ln - 1] !~ /^\+$help_indent\ {2}\S*/) {
> +						$help_stat_real = get_stat_real($ln - 1, $ln);
> +					}
> +					undef $help_indent;
> +				}

This doesn't work if the indent is more than 2 spaces.

$ cat Kconfigtest
menuconfig FOO
	bool "Enable foo" if EXPERT
	default y
	help
	   Line 1.
	   Line 2.
	   Line 3.
	   Line 4.

$ ./scripts/checkpatch.pl -f Kconfigtest
total: 0 errors, 0 warnings, 10 lines checked

Kconfigtest has no obvious style problems and is ready for submission.

Also, it may be useful to test that the indent after a block
uses a single tab more than the block start.

Look at the first block of block/Kconfig:

The indentation of bool and help uses 7 spaces but the indentation
of the help text uses a tab then 1 space.

It'd be useful to emit a warning for that.

menuconfig BLOCK
       bool "Enable the block layer" if EXPERT
       default y
       select SBITMAP
       select SRCU
       help
	 Provide block layer support for the kernel.

	 Disable this option to remove the block layer support from the
	 kernel. This may be useful for embedded devices.

	 If this option is disabled:

	   - block device files will become unusable
	   - some filesystems (such as ext3) will become unavailable.

	 Also, SCSI character devices and USB storage will be disabled since
	 they make use of various block layer definitions and facilities.

	 Say Y here unless you know you really don't want to mount disks and
	 suchlike.


