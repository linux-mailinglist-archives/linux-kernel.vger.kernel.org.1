Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5FD2E2D8E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 08:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgLZHEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 02:04:15 -0500
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:36956 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgLZHEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 02:04:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 131BC837F27E;
        Sat, 26 Dec 2020 07:03:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3872:4321:5007:7514:7652:10004:10400:10848:11026:11232:11658:11783:11914:12043:12266:12296:12297:12438:12555:12740:12895:12986:13069:13311:13357:13439:13894:14181:14659:14721:21080:21365:21451:21627:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cake09_2c178b227480
X-Filterd-Recvd-Size: 2210
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sat, 26 Dec 2020 07:03:28 +0000 (UTC)
Message-ID: <204aeca57b8649b311745c8f9c56f48dfcf36a85.camel@perches.com>
Subject: Re: [PATCH] mfd: ab8500-debugfs: Remove extraneous curly brace
From:   Joe Perches <joe@perches.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Date:   Fri, 25 Dec 2020 23:03:27 -0800
In-Reply-To: <20201226013549.1973451-1-natechancellor@gmail.com>
References: <20201226013549.1973451-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-12-25 at 18:35 -0700, Nathan Chancellor wrote:
> Clang errors:
> 
> ../drivers/mfd/ab8500-debugfs.c:1526:2: error: non-void function does
> not return a value [-Werror,-Wreturn-type]
>         }
>         ^
> ../drivers/mfd/ab8500-debugfs.c:1528:2: error: expected identifier or '('
> return 0;
>         ^
> ../drivers/mfd/ab8500-debugfs.c:1529:1: error: extraneous closing brace ('}')
> }
> ^
> 3 errors generated.
> 
> The cleanup in ab8500_interrupts_show left a curly brace around, remove
> it to fix the error.
> 
> Fixes: 886c8121659d ("mfd: ab8500-debugfs: Remove the racy fiddling with irq_desc")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/mfd/ab8500-debugfs.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
[]
> @@ -1521,7 +1521,6 @@ static int ab8500_interrupts_show(struct seq_file *s, void *p)
>  			   line + irq_first,
>  			   num_interrupts[line],
>  			   num_wake_interrupts[line]);
> -		}
>  		seq_putc(s, '\n');

It looks as if this seq_putc should be removed as well
as the seq_printf above already ends in a newline.

>  	}
>  
> 
> 
> base-commit: 61d791365b72a89062fbbea69aa61479476da946


