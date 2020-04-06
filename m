Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 628AC19FCEF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 20:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgDFSRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 14:17:24 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40755 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgDFSRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:17:23 -0400
Received: by mail-pj1-f65.google.com with SMTP id kx8so190292pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9b9hEkLgJW0u89MdK2XsWTuR5aijAVAWLv2chqGomps=;
        b=JsHGdIDXuwjmPSHJjLEDK8zgvfdd3hjUDRu5wKMGvXq1VAnqBSMdZqWSqosI8khfY4
         oE7p1A6ocFhiN8J5PbtrntkttDAy5bwjyyV+zhZ6n7R4pyqsq2ZlwYqp2Jj9Pr3H4iWw
         yjjxQnVjzYa0EN8gv6ursR3nykwcAZX87QBeKKWSOqoNYFCTg3M02R2tGXnSFUh2g7wp
         mHZZKwfoypGCcoY7S/RgpL0qAamQnASkCogjwdZ1q13bQH/mphjLvOBfeANpWYYwEnsd
         yJVZb6avJbAy7kaOWajvsajd22wSvf6ymxRVPLp+QOrMhL/AnmvJ1tCvVzqzg/zhBJoH
         z0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=9b9hEkLgJW0u89MdK2XsWTuR5aijAVAWLv2chqGomps=;
        b=sV2VbSQKtVEb1h2B7mgkRGWd1IjGI4S8v7o30J+EMlgqg02H84NbCDjT3yWfM+RKHN
         sAfVIWHuIFVKJK4qDBtU7sERgGzgeR6suoAyVPUctbKX8Pbtw3zg1VPzCu/gayDsI7f1
         JLQqwntl4uW+O/fyUrA5URvpsMOPDk5eXqyW21WRDsNCT7K7/vUPr03s1yiKLDkNg2s1
         S9d/KF3Ep5qB85eQ8y2kaBt4dQsxy3e2q+GCDcMFhfjEbvD2RUmbSHrUaAL6qzxNlJMA
         spK7d68WaBfe/4zj6LZkjGKzp+4LwVVcjL/megaLw2Dvxj3gAaH99HhhHv+swqSh4MGH
         QlAg==
X-Gm-Message-State: AGi0PuZEgB9BYchx8dBuStl0Shcx9Gk80Zcc2YDSpY9b8hnNBEDlM5k/
        h+BIYRegHOkID35py1iHTz43ww==
X-Google-Smtp-Source: APiQypKRMesRGHVSwEHWEWMOhGBkXtbS0emQ0GQwosoNU3Fhzn6Eu5sENDsWslhvhf0HXX4J0ehcDA==
X-Received: by 2002:a17:902:7e05:: with SMTP id b5mr19413098plm.253.1586197041855;
        Mon, 06 Apr 2020 11:17:21 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id y13sm11957859pfp.88.2020.04.06.11.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 11:17:20 -0700 (PDT)
From:   bsegall@google.com
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Subject: Re: [PATCH] sched/fair: Fix call walk_tg_tree_from() without hold rcu_lock
References: <20200406121008.62903-1-songmuchun@bytedance.com>
Date:   Mon, 06 Apr 2020 11:17:19 -0700
In-Reply-To: <20200406121008.62903-1-songmuchun@bytedance.com> (Muchun Song's
        message of "Mon, 6 Apr 2020 20:10:08 +0800")
Message-ID: <xm26imico4wg.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Muchun Song <songmuchun@bytedance.com> writes:

> The walk_tg_tree_from() caller must hold rcu_lock, but the caller
> do not call rcu_read_lock() in the unthrottle_cfs_rq(). The
> unthrottle_cfs_rq() is used in 3 places. There are
> distribute_cfs_runtime(), unthrottle_offline_cfs_rqs() and
> tg_set_cfs_bandwidth(). The former 2 already hold the rcu lock,
> but the last one does not. So fix it with calling rcu_read_lock()
> in the unthrottle_cfs_rq().

It might be a tiny bit better to put it in the tg_set_cfs_bandwidth
instead, but the other two sources were kinda by accident, so this is
reasonable too.

Reviewed-by: Ben Segall <bsegall@google.com>

>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6f05843c76d7d..870853c47b63c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4782,7 +4782,9 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  	raw_spin_unlock(&cfs_b->lock);
>  
>  	/* update hierarchical throttle state */
> +	rcu_read_lock();
>  	walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
> +	rcu_read_unlock();
>  
>  	if (!cfs_rq->load.weight)
>  		return;
