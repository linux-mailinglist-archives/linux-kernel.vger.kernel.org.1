Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE492DD62A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgLQR2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:28:11 -0500
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:34976 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729821AbgLQR2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:28:10 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C2865181D303C;
        Thu, 17 Dec 2020 17:27:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:6119:10004:10400:10848:11026:11232:11473:11658:11914:12114:12296:12297:12438:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21324:21451:21627:21660:21886:30012:30029:30054:30070:30089:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: ocean85_55014a627436
X-Filterd-Recvd-Size: 1902
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Dec 2020 17:27:28 +0000 (UTC)
Message-ID: <816c1571b4132f991089b40a759cf68afcf4af43.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add new warning when lookup_symbol_name()
 is used
From:   Joe Perches <joe@perches.com>
To:     Helge Deller <deller@gmx.de>, Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Dec 2020 09:27:27 -0800
In-Reply-To: <20201217171111.GA8295@ls3530.fritz.box>
References: <20201217171111.GA8295@ls3530.fritz.box>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-17 at 18:11 +0100, Helge Deller wrote:
> In most cases people use lookup_symbol_name() to resolve a kernel symbol
> and then print it via printk().
> 
> In such cases using the %ps, %pS, %pSR or %pB printk formats are easier
> to use and thus should be preferred.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -4317,6 +4317,12 @@ sub process {
>  			     "LINUX_VERSION_CODE should be avoided, code should be for the version to which it is merged\n" . $herecurr);
>  		}
> 
> +# avoid lookup_symbol_name()
> +		if ($line =~ /\blookup_symbol_name\b/) {
> +			WARN("PREFER_PRINTK_FORMAT",
> +			     "If possible prefer %ps or %pS printk format string to print symbol name instead of using lookup_symbol_name()\n" . $herecurr);
> +		}
> +
>  # check for uses of printk_ratelimit
>  		if ($line =~ /\bprintk_ratelimit\s*\(/) {
>  			WARN("PRINTK_RATELIMITED",

Huh?  nak.

lookup_symbol_name is used in the kernel a grand total of 3 times.
2 uses are kprobe, the other is fs/proc

None of the existing uses is equivalent to %ps

Why should this be applied?


