Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A032AB7C0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgKIMHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKIMHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:07:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45DFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 04:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SEg9o19P1oU0SOhiF3mICDABrubXxOmsaY562ffq9Us=; b=Qpc+qZyonhmTKiOXGulCn7GjWP
        5mm+kKxInVYhk3qSim68L36as7yyQMT2WR0ZGgtqtNfKJDtjPWlaCg47SDrYe0SquEcigIhLiQN33
        Vhpp8qXG7AojTQ1psuzonRZdljE2wzp3cU+hz1Ctg8imUYRBZ5nN9yPSkYRUkwBzxywhfThZDRL0g
        aT7lp3DtfcLwIzLbU19tM2WyIUiP6ziLBJZokpdKHsioxXd2ObxdHPWb0709vgffQesrt1/94dxvi
        e+UaJL1+o53KZmpY4GUwyvwhGQQQyE/1wT/8UM27tjg0OBH7MILQCqrgP+EuiZqZFqpTiS++IlWa8
        v4KJV2kQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc5wv-0000Cr-AQ; Mon, 09 Nov 2020 12:07:05 +0000
Date:   Mon, 9 Nov 2020 12:07:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linmiaohe@huawei.com, akpm@linux-foundation.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REF PATCH] mm/swap: fix swapon failure
Message-ID: <20201109120705.GZ17076@casper.infradead.org>
References: <1604922436-16597-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604922436-16597-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 07:47:16PM +0800, Alex Shi wrote:
> Go through the context I found the exit_swap_address_space(p->type)
> shouldn't be used in good result path. So just move it to error path.

But ... it's not used in the success path.  There's a 'goto' right
before it.  Does this really fix your problem?

> @@ -3339,7 +3339,8 @@ static bool swap_discardable(struct swap_info_struct *si)
>  	error = inode_drain_writes(inode);
>  	if (error) {
>  		inode->i_flags &= ~S_SWAPFILE;
> -		goto free_swap_address_space;
> +		exit_swap_address_space(p->type);
> +		goto bad_swap_unlock_inode;
>  	}
>  
>  	mutex_lock(&swapon_mutex);
> @@ -3364,8 +3365,6 @@ static bool swap_discardable(struct swap_info_struct *si)
>  
>  	error = 0;
>  	goto out;
> -free_swap_address_space:
> -	exit_swap_address_space(p->type);
>  bad_swap_unlock_inode:
>  	inode_unlock(inode);
>  bad_swap:
> -- 
> 1.8.3.1
> 
> 
