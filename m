Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6A32AB270
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgKIIdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKIIdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:33:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C995C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 00:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bGUxI0B07YWLmHjnQQTBE3xPkOaIZ78B6Zxl84c+J9U=; b=Q0sOqOM65heRoPF+jc8XOfTi7g
        ETiwo1AjafjROzc51giTjimk6ZB9F9uP3QJ9IAXgromYGcMXv5Uz7M1A5libjj07rUw0AiViJKvEJ
        cnZflQFO7OuhAgj2T1xbTN33my/RlQMFIu/TECRt8mIymXo31FpM0xOU115WFaOqiWj+8QPiNiUVq
        lRIjQts/Ybh1bDUdp8B7C+XPFkgu4vrNausUHBJXQ6h+m7rdMg9qsXlWNPawI/3AE+jW8Hw7NlZwu
        YYfxfLixEUE+OVu6bJLMMRT/vz85QhSMXUxVPBkHvzcaxZvrO3+1RlUYlapQpGnlTzPmoSdOS3owl
        PBjgLdpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc2bg-0003Ps-25; Mon, 09 Nov 2020 08:32:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 664AB3006E0;
        Mon,  9 Nov 2020 09:32:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58A282C2296F6; Mon,  9 Nov 2020 09:32:51 +0100 (CET)
Date:   Mon, 9 Nov 2020 09:32:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] locking/lock_events: no need to check return value of
 debugfs_create functions
Message-ID: <20201109083251.GA2594@hirez.programming.kicks-ass.net>
References: <1604740753-17662-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604740753-17662-1-git-send-email-yangtiezhu@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 05:19:13PM +0800, Tiezhu Yang wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

I strongly disagree and have told this to Greg before. Having half a
debug interface is weird at best, so upon failure we remove the whole
thing, which is consistent.

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  kernel/locking/lock_events.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/locking/lock_events.c b/kernel/locking/lock_events.c
> index fa2c2f9..bac77a1 100644
> --- a/kernel/locking/lock_events.c
> +++ b/kernel/locking/lock_events.c
> @@ -146,9 +146,6 @@ static int __init init_lockevent_counts(void)
>  	struct dentry *d_counts = debugfs_create_dir(LOCK_EVENTS_DIR, NULL);
>  	int i;
>  
> -	if (!d_counts)
> -		goto out;
> -
>  	/*
>  	 * Create the debugfs files
>  	 *
> @@ -159,21 +156,13 @@ static int __init init_lockevent_counts(void)
>  	for (i = 0; i < lockevent_num; i++) {
>  		if (skip_lockevent(lockevent_names[i]))
>  			continue;
> -		if (!debugfs_create_file(lockevent_names[i], 0400, d_counts,
> -					 (void *)(long)i, &fops_lockevent))
> -			goto fail_undo;
> +		debugfs_create_file(lockevent_names[i], 0400, d_counts,
> +				    (void *)(long)i, &fops_lockevent);
>  	}
>  
> -	if (!debugfs_create_file(lockevent_names[LOCKEVENT_reset_cnts], 0200,
> -				 d_counts, (void *)(long)LOCKEVENT_reset_cnts,
> -				 &fops_lockevent))
> -		goto fail_undo;
> +	debugfs_create_file(lockevent_names[LOCKEVENT_reset_cnts], 0200, d_counts,
> +			    (void *)(long)LOCKEVENT_reset_cnts, &fops_lockevent);
>  
>  	return 0;
> -fail_undo:
> -	debugfs_remove_recursive(d_counts);
> -out:
> -	pr_warn("Could not create '%s' debugfs entries\n", LOCK_EVENTS_DIR);
> -	return -ENOMEM;
>  }
>  fs_initcall(init_lockevent_counts);
> -- 
> 2.1.0
> 
