Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5F62136B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgGCIvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 04:51:55 -0400
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:43960 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725648AbgGCIvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:51:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C8DFD181D207E;
        Fri,  3 Jul 2020 08:51:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:421:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1963:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:4321:5007:6119:6691:10004:10400:11232:11658:11914:12297:12555:12740:12760:12895:12986:13069:13146:13230:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: joke15_500b9db26e90
X-Filterd-Recvd-Size: 1972
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Jul 2020 08:51:52 +0000 (UTC)
Message-ID: <80902e5d0d5ef752e71672e9c5794d0f5f9ccd15.camel@perches.com>
Subject: Re: [PATCH] scripts/Lindent: increase the maximum line length to 100
From:   Joe Perches <joe@perches.com>
To:     Zong Li <zong.li@sifive.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 03 Jul 2020 01:51:51 -0700
In-Reply-To: <050476a0ee608046569588936394159d650ab535.1593763492.git.zong.li@sifive.com>
References: <050476a0ee608046569588936394159d650ab535.1593763492.git.zong.li@sifive.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-03 at 16:08 +0800, Zong Li wrote:
> As the patch 'bdc48fa11e46 ("checkpatch/coding-style: deprecate
> 80-column warning")', increase the default limit to 100 characters,
> we also increase the maximum line length to 100 for indent script.

I'd prefer to delete Lindent instead.

Also any reformatting tool like this will
_always_ use up to whatever the maximum
line length is rather than use a preferred
length of 80 and and only use the allowed
maximum length of 100 when necessary for
human readability.

> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  scripts/Lindent | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Lindent b/scripts/Lindent
> index 1688c44c2df6..11f14a4f2048 100755
> --- a/scripts/Lindent
> +++ b/scripts/Lindent
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  
> -PARAM="-npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1"
> +PARAM="-npro -kr -i8 -ts8 -sob -l100 -ss -ncs -cp1"
>  
>  RES=`indent --version | cut -d' ' -f3`
>  if [ "$RES" = "" ]; then

