Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA052F9C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388707AbhARJXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 04:23:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:44430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388427AbhARJN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:13:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610961101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p8fwS1DB31B2wR2MHPMBtXln7P5hjc1ZNhQlrBXPwpU=;
        b=UlI0Jzs+dTrYQtcCFa2J7lZFVMOPOVHS9VV9j4F4uqTbPr5rfVU+YM3Lqe+O+zFE/6/z43
        +EEe304ietTt3wEdJovmd0H8ocHvmtbmCCccLz0BBGuxui2q3lQsrHxMo1R68mUKP9BJ55
        /EhVUZACcXeocBtJxkZ6JcuYdeDqMx8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 150BDB727;
        Mon, 18 Jan 2021 09:11:41 +0000 (UTC)
Date:   Mon, 18 Jan 2021 10:11:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Tang Yizhou <tangyizhou@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v2] mm, oom: Fix a comment in dump_task
Message-ID: <20210118091140.GA14336@dhcp22.suse.cz>
References: <20210115142314.12903-1-tangyizhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115142314.12903-1-tangyizhou@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-01-21 22:23:14, Tang Yizhou wrote:
> If p is a kthread, it will be checked in oom_unkillable_task() so
> we can delete the corresponding comment.
> 
> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Michal Hocko <mhocko@kernel.org>

Yes, this is outdated for a long time. Thanks
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> v2: Update Cc list
>  mm/oom_kill.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 04b19b7b5435..9f043ad29554 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -395,9 +395,8 @@ static int dump_task(struct task_struct *p, void *arg)
>  	task = find_lock_task_mm(p);
>  	if (!task) {
>  		/*
> -		 * This is a kthread or all of p's threads have already
> -		 * detached their mm's.  There's no need to report
> -		 * them; they can't be oom killed anyway.
> +		 * All of p's threads have already detached their mm's. There's
> +		 * no need to report them; they can't be oom killed anyway.
>  		 */
>  		return 0;
>  	}
> -- 
> 2.22.0

-- 
Michal Hocko
SUSE Labs
