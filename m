Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34F22E789A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 13:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgL3Mjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 07:39:41 -0500
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:56798 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726547AbgL3Mjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 07:39:40 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 1762E1730840;
        Wed, 30 Dec 2020 12:38:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2903:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:4321:4362:5007:7652:7875:8603:10004:10400:10848:11026:11232:11658:11783:11914:12043:12295:12296:12297:12438:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21451:21627:21660:30029:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: field67_0e06870274a5
X-Filterd-Recvd-Size: 2547
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Dec 2020 12:38:58 +0000 (UTC)
Message-ID: <9defa63ffed0e526269672776c94eca36af6afae.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: ignore warning designated initializers
 using NR_CPUS
From:   Joe Perches <joe@perches.com>
To:     Peng Wang <rocking@linux.alibaba.com>, apw@canonical.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 30 Dec 2020 04:38:56 -0800
In-Reply-To: <5d4998aa8a8ac7efada2c7daffa9e73559f8b186.1609331255.git.rocking@linux.alibaba.com>
References: <5ca6c2d28f6cf091a676f8e7d8f14a933da0b267.camel@perches.com>
         <5d4998aa8a8ac7efada2c7daffa9e73559f8b186.1609331255.git.rocking@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-30 at 20:29 +0800, Peng Wang wrote:
> Some max_length wants to hold as large room as possible to
> ensure enough size to tackle with the biggest NR_CPUS.
> An example below:
> 
> kernel/cgroup/cpuset.c:
> static struct cftype legacy_files[] = {
>         {
>                 .name = "cpus",
>                 .seq_show = cpuset_common_seq_show,
>                 .write = cpuset_write_resmask,
>                 .max_write_len = (100U + 6 * NR_CPUS),
>                 .private = FILE_CPULIST,
>         },
> 	...
> }
> 
> Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
> ---
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7028,12 +7028,14 @@ sub process {
>  
>  # use of NR_CPUS is usually wrong
>  # ignore definitions of NR_CPUS and usage to define arrays as likely right
> +# ignore designated initializers using NR_CPUS
>  		if ($line =~ /\bNR_CPUS\b/ &&
>  		    $line !~ /^.\s*\s*#\s*if\b.*\bNR_CPUS\b/ &&
>  		    $line !~ /^.\s*\s*#\s*define\b.*\bNR_CPUS\b/ &&
>  		    $line !~ /^.\s*$Declare\s.*\[[^\]]*NR_CPUS[^\]]*\]/ &&
>  		    $line !~ /\[[^\]]*\.\.\.[^\]]*NR_CPUS[^\]]*\]/ &&
> -		    $line !~ /\[[^\]]*NR_CPUS[^\]]*\.\.\.[^\]]*\]/)
> +		    $line !~ /\[[^\]]*NR_CPUS[^\]]*\.\.\.[^\]]*\]/ &&
> +		    $line !~ /^.\s*\.\w+\s*=\s*.*\bNR_CPUS\b/)
>  		{
>  			WARN("NR_CPUS",
>  			     "usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc\n" . $herecurr);

Thanks.

Acked-by: Joe Perches <joe@perches.com>


