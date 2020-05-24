Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159F91E0189
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 20:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbgEXSti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 14:49:38 -0400
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:40220 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387903AbgEXSth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 14:49:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9A4F418009FEB;
        Sun, 24 May 2020 18:49:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3866:3868:3872:3874:4321:5007:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12297:12438:12533:12555:12740:12760:12895:12986:13069:13075:13311:13357:13439:14181:14659:14721:21067:21080:21451:21627:30029:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: base72_230952626d3a
X-Filterd-Recvd-Size: 2154
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sun, 24 May 2020 18:49:35 +0000 (UTC)
Message-ID: <d00a5503d271e127c948e3352a51d9646136a6d1.camel@perches.com>
Subject: Re: [PATCH] printk: Remove pr_cont_once()
From:   Joe Perches <joe@perches.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 24 May 2020 11:49:34 -0700
In-Reply-To: <20200524153243.11690-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20200524153243.11690-1-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-25 at 00:32 +0900, Tetsuo Handa wrote:
> pr_cont_once() does not make sense; at least emitting module name using
> pr_fmt() into middle of a line (after e.g. pr_info_once()) does not make
> sense. Let's remove unused pr_cont_once().

Right, thanks.

It's nearly a decade old cut'n'paste defect and
no one has ever used it or noticed it until now.

> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Joe Perches <joe@perches.com>
> ---
>  include/linux/printk.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 2562ffb438ed..4c565871f659 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -476,8 +476,7 @@ extern int kptr_restrict;
>  	printk_once(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
>  #define pr_info_once(fmt, ...)					\
>  	printk_once(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> -#define pr_cont_once(fmt, ...)					\
> -	printk_once(KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
> +/* no pr_cont_once, don't do that... */
>  
>  #if defined(DEBUG) || defined(CONFIG_TWIST_ALWAYS_EVALUATE_DEBUG_PRINTK)
>  #define pr_devel_once(fmt, ...)					\

