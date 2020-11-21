Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC06C2BC1E9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 21:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgKUUFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 15:05:25 -0500
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:60790 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728402AbgKUUFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 15:05:25 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B2461182CED28;
        Sat, 21 Nov 2020 20:05:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3866:3867:4321:5007:6642:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21451:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:16,LUA_SUMMARY:none
X-HE-Tag: clam12_3c079d827356
X-Filterd-Recvd-Size: 1784
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Nov 2020 20:05:23 +0000 (UTC)
Message-ID: <185d4505b35be4b9d039f430b3f95e7c33ed6a49.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add --fix option for INCLUDE_LINUX
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Sat, 21 Nov 2020 12:05:22 -0800
In-Reply-To: <20201121161706.104631-1-dwaipayanray1@gmail.com>
References: <20201121161706.104631-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-11-21 at 21:47 +0530, Dwaipayan Ray wrote:
> Provide fix option to INCLUDE_LINUX check to replace asm
> includes.
> 
> Macros of type:
>  #include <asm/percpu.h>
> 
> are corrected to:
>  #include <linux/percpu.h>
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5468,8 +5468,11 @@ sub process {
>  						CHK("ARCH_INCLUDE_LINUX",
>  						    "Consider using #include <linux/$file> instead of <asm/$file>\n" . $herecurr);
>  					} else {
> -						WARN("INCLUDE_LINUX",
> -						     "Use #include <linux/$file> instead of <asm/$file>\n" . $herecurr);
> +						if (WARN("INCLUDE_LINUX",
> +							 "Use #include <linux/$file> instead of <asm/$file>\n" . $herecurr) &&
> +						    $fix) {
> +							$fixed[$fixlinenr] =~ s/\<asm\/$file\>/\<linux\/$file\>/;

$file can include a slash.

e.g.: arch/arm/kernel/atags_parse.c:#include <asm/mach/arch.h>

Probably simpler to use /Q /E quoting.


