Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8FF2DF69C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 20:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgLTTC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 14:02:59 -0500
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:37032 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726623AbgLTTC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 14:02:59 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 253AB2496;
        Sun, 20 Dec 2020 19:02:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2908:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3871:3872:4321:5007:7903:10004:10400:10848:11232:11658:11914:12043:12297:12555:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: rain70_05167f927451
X-Filterd-Recvd-Size: 1863
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sun, 20 Dec 2020 19:02:16 +0000 (UTC)
Message-ID: <6f5c18acb8bac6f2d8c24e50eabc0f163c062475.camel@perches.com>
Subject: Re: [PATCH 1/2] checkpatch: kconfig: replace '---help---' with
 'help'
From:   Joe Perches <joe@perches.com>
To:     Nicolai Fischer <nicolai.fischer@fau.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Date:   Sun, 20 Dec 2020 11:02:15 -0800
In-Reply-To: <eed0902b-2c5d-61fc-bb88-7edf286832c7@fau.de>
References: <eed0902b-2c5d-61fc-bb88-7edf286832c7@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-12-14 at 11:23 +0100, Nicolai Fischer wrote:
> All '---help---' lines have been replaced by just 'help'.
> Therefore it is no longer necessary to include '---' in the regex.
> 
> Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
> Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
> Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>

Acked-by: Joe Perches <joe@perches.com>

> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 52f467fd32f9..5cd98f2b75f6 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3323,7 +3323,7 @@ sub process {
>  
> 
>  				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
>  					$is_start = 1;
> -				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:---)?help(?:---)?$/) {
> +				} elsif ($lines[$ln - 1] =~ /^\+\s*help$/) {
>  					$length = -1;
>  				}
>  
> 


