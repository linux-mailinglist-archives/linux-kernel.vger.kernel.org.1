Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2282C884C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgK3PiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:38:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:47458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgK3PiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:38:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606750654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KtPZdWr+m2QwCVPUCkiJTsHf3OlVY3Ly9fgprsglCU4=;
        b=eUXvSWAPyjvCrAeAgYzVyVd+FonqqypwesPOQe0sC6Z683Njv52cpm5d2tWLj4mSVEguSG
        HgzxczKhxfq/SjhoxDmzFIV6mDa+etZ507CQYynKGDFlY95N8RA2WIIxeGTwjyd8Z/83pQ
        Q7eoOo+V9ROvc8W8QmiVrkMnnePtQBE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4CC7EADC5;
        Mon, 30 Nov 2020 15:37:34 +0000 (UTC)
Date:   Mon, 30 Nov 2020 16:37:33 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH] printk: remove obsolete dead assignment
Message-ID: <X8URvRhAB2AE4DZT@alley>
References: <20201130124915.7573-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130124915.7573-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-11-30 13:49:15, Lukas Bulwahn wrote:
> Commit 849f3127bb46 ("switch /dev/kmsg to ->write_iter()") refactored
> devkmsg_write() and left over a dead assignment on the variable 'len'.
> 
> Hence, make clang-analyzer warns:
> 
>   kernel/printk/printk.c:744:4: warning: Value stored to 'len' is never read
>     [clang-analyzer-deadcode.DeadStores]
>                           len -= endp - line;
>                           ^
> 
> Simply remove this obsolete dead assignment here.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on current master and next-20201130
> 
> Petr, please pick this minor non-urgent clean-up patch.
> 
>  kernel/printk/printk.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index f279d4fbd9dd..6e4e38b7cd91 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -741,7 +741,6 @@ static ssize_t devkmsg_write(struct kiocb *iocb, struct iov_iter *from)
>  			if (LOG_FACILITY(u) != 0)
>  				facility = LOG_FACILITY(u);
>  			endp++;
> -			len -= endp - line;
>  			line = endp;
>  		}
>  	}

Yup, it was used to write the trailing '\0'. But it is done earlier
now. So, it is not longer needed.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I'll give it few days just in case anyone else would want to
review it. I'll push it then unless anyone complains.
