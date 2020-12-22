Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE462E04D7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 04:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgLVDuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 22:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLVDuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:50:06 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D787AC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 19:49:25 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id x23so2693898oop.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 19:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tdbzTUr3Pw+6/KahxCTYW+sU0lmWimxwgvACiw9JQC4=;
        b=Ah+5ws13d8qEq+zKY2YxfDFxNB/pkPb8TPI5D2Jb66/8ljWGfpt0/vBhscSxCYIM3M
         pHDyJ18A3QaQg0ysMehXTMPrEPkryCt3HGYUSG0ege4TWudhwtvz+JUm9GolsgQgu/A7
         gO5Yb20kiNXJ71NQi+yBYFyi4RzGS0WrPBTjgQIkFERQsPU5a59rJDM6bBWUU5O2UUHO
         IpmOj54GadwxljRncz62G+D5rL+B4Ui5xiryTJpnATsEGpobjt0TYOKNB3jsDBeM08du
         U7mz8wiFxtNkTYo7HDY+czagkcsfiG+fX3bynidHNLj1Fw01a4tjlqefZYMp5EFRnB6Y
         vLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tdbzTUr3Pw+6/KahxCTYW+sU0lmWimxwgvACiw9JQC4=;
        b=Bu6gcK+czZ68Gg5zSUyjYhetcnZpVyWkM6gN9qcNJBOgNBI7Eg/AfjpAEFUUcQfqZe
         2qD7/wvlgw9SW38lkCRpV5qDm6Kfqci6PIUha4iXGWRKn+Xn2xqL9XVDHnMLxz/HMErd
         1ycQTJ9mZprUOVtdQOJ5a4mqTmKSpru56ZIOrqjqMYq+wYH+RYaFIiQJpFEE239Dt1OC
         JZzovdVgrqWaGfu6yW/Vyq9h3Ebv1CAT3qcB1d/XjS1oF/jSbugNhe20lczxgHyhiIjd
         3RZWuK5EplycEa9PaZvyVYiT8Fl5n7eE57Pas4hWQas92ZQpDaSG1SWGvJpC9djoJLFL
         igrg==
X-Gm-Message-State: AOAM532l0wBAFYHZ156CI6v2QrVplB58p8t5CuHcs6GoQNgl2YLzgtZf
        BK3hb7UT3ApDAO44PASUO3/dDg==
X-Google-Smtp-Source: ABdhPJwdjDX3efR2YEyq+TOjs89PsUEP3xUtG0V2ICwD/6hUdtnXmt0XxvdnSpjuj2qQHDS//g0BoA==
X-Received: by 2002:a4a:81:: with SMTP id 123mr13729306ooh.46.1608608964904;
        Mon, 21 Dec 2020 19:49:24 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r25sm4312600otp.23.2020.12.21.19.49.23
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 21 Dec 2020 19:49:24 -0800 (PST)
Date:   Mon, 21 Dec 2020 19:49:22 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Hui Su <sh_def@163.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/compaction: remove rcu_read_lock during page
 compaction
In-Reply-To: <1608186532-81218-3-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2012211939050.1045@eggly.anvils>
References: <1608186532-81218-1-git-send-email-alex.shi@linux.alibaba.com> <1608186532-81218-3-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020, Alex Shi wrote:

> rcu_read_lock was used to guard memcg destory, now TestClearPageLRU
> could block this happen, so we don't need it. Remove it to reduce
> locking load in debugging mode.

"
isolate_migratepages_block() used rcu_read_lock() with the intention
of safeguarding against the mem_cgroup being destroyed concurrently;
but its TestClearPageLRU already protects against that.  Delete the
unnecessary rcu_read_lock() and _unlock().
"

> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Hugh Dickins <hughd@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/compaction.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 8049d3530812..02af220fb992 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -995,7 +995,6 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		if (!TestClearPageLRU(page))
>  			goto isolate_fail_put;
>  
> -		rcu_read_lock();
>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  
>  		/* If we already hold the lock, we can skip some rechecking */
> @@ -1005,7 +1004,6 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  
>  			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
>  			locked = lruvec;
> -			rcu_read_unlock();
>  
>  			lruvec_memcg_debug(lruvec, page);
>  
> @@ -1026,8 +1024,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  				SetPageLRU(page);
>  				goto isolate_fail_put;
>  			}
> -		} else
> -			rcu_read_unlock();
> +		}
>  
>  		/* The whole page is taken off the LRU; skip the tail pages. */
>  		if (PageCompound(page))
> -- 
> 2.29.GIT
