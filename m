Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685CE2D7221
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437086AbgLKIpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437027AbgLKIoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:44:34 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B96C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:43:54 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id o8so8717824ioh.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3nZGElLoKmf1C18zA8XwumBvcYHFPZLc61ouMw28/Mg=;
        b=pe3DOJmozb4lcpQU9AzFs07tM5T8Emsj3n06q+r12W4Zf0W9F6xNSmVGGAR4EhuraT
         zQvuxLDrU3qRpUYzOoNy3L1gDInj6kf7b053gNDKC/Z8TM5g0ivJHuS/RyaRhurbRlZ+
         geflGF3jOye93tpNF/bVIl2ebeLTT3ovrsH4L8YtGftCCf+ARNpEDo78DmqEgAeCvQtC
         Scqc+OZ3DVtX99kFYx9ERk7PDwTfZPYRrny8xA5VBvnSy4wqGUCwsjZQYUYiBQjIgirp
         aSq7EGUx0PR2UXUDlG2Y0kzk3FFW9iQ8WxG0AENlzkcXaWYudNuxHhUNIWrROS7Ncqeo
         Jrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nZGElLoKmf1C18zA8XwumBvcYHFPZLc61ouMw28/Mg=;
        b=UmoO84a23Gje7ciCQ2GJ9nQ4JTD8B3GiT1LeQXWQGlSUQwRDPge8lYy8z/JKF1X1Zi
         VsvEKj3KNe6wa0pvxGNq/9GvkVW3j4XGXvGsx6waQ1CMKdwCXwyFAIhkqxjT1+wFoY3P
         4PV12IHmAVfOfM7XakegZmuXF0Xhf7eDBkAZfkSJqG3xpPKGXxKnjqnPWwg358Lq45Wv
         DhwtxCVcUmKdJU5DaZaljzU1V2N+APms+BQCTqTH/XVocdXCPp+GWqHg0n5U6WMPUnPd
         DtuOmrFXEEONT13uEB43LEr3gbOY76Ho2z/ZbyXkUnwpG4Kg9hUC1avaB8GEqykXFUjv
         As0Q==
X-Gm-Message-State: AOAM531nhvZfyBdMDag9zanCZG1iN33s9/gGItRFtYk48nbLRvbbTHTH
        /FO3sNm6PzTEy/y7Ixdu5JArOv+y2Hnrv8YwI3La2A==
X-Google-Smtp-Source: ABdhPJzCJsp4aekQmuTRerh7qbU1QXw1ZhFvw7w3DRXDW1N/0+vlGlwaI0m1pFfs1/8o7XmRCEan8ei0Bgb2Xd65unU=
X-Received: by 2002:a02:c981:: with SMTP id b1mr14530626jap.6.1607676233403;
 Fri, 11 Dec 2020 00:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20201211082032.26965-1-sjpark@amazon.com> <20201211082032.26965-2-sjpark@amazon.com>
In-Reply-To: <20201211082032.26965-2-sjpark@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 11 Dec 2020 09:43:41 +0100
Message-ID: <CANn89iJdPa-2FQS18p3d_YjZx_5OD=eZr_3+a6LPiAxpj=fowA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] net/ipv4/inet_fragment: Batch fqdir destroy works
To:     SeongJae Park <sjpark@amazon.com>
Cc:     David Miller <davem@davemloft.net>,
        SeongJae Park <sjpark@amazon.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Florian Westphal <fw@strlen.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        netdev <netdev@vger.kernel.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 9:21 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> For each 'fqdir_exit()' call, a work for destroy of the 'fqdir' is
> enqueued.  The work function, 'fqdir_work_fn()', internally calls
> 'rcu_barrier()'.  In case of intensive 'fqdir_exit()' (e.g., frequent
> 'unshare()' systemcalls), this increased contention could result in
> unacceptably high latency of 'rcu_barrier()'.  This commit avoids such
> contention by doing the 'rcu_barrier()' and subsequent lightweight works
> in a batched manner using a dedicated singlethread worker, as similar to
> that of 'cleanup_net()'.


Not sure why you submit a patch series with a single patch.

Your cover letter contains interesting info that would better be
captured in this changelog IMO

>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  include/net/inet_frag.h  |  1 +
>  net/ipv4/inet_fragment.c | 45 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 39 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
> index bac79e817776..48cc5795ceda 100644
> --- a/include/net/inet_frag.h
> +++ b/include/net/inet_frag.h
> @@ -21,6 +21,7 @@ struct fqdir {
>         /* Keep atomic mem on separate cachelines in structs that include it */
>         atomic_long_t           mem ____cacheline_aligned_in_smp;
>         struct work_struct      destroy_work;
> +       struct llist_node       free_list;
>  };
>
>  /**
> diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
> index 10d31733297d..a6fc4afcc323 100644
> --- a/net/ipv4/inet_fragment.c
> +++ b/net/ipv4/inet_fragment.c
> @@ -145,12 +145,17 @@ static void inet_frags_free_cb(void *ptr, void *arg)
>                 inet_frag_destroy(fq);
>  }
>
> -static void fqdir_work_fn(struct work_struct *work)
> +static struct workqueue_struct *fqdir_wq;
> +static LLIST_HEAD(free_list);
> +
> +static void fqdir_free_fn(struct work_struct *work)
>  {
> -       struct fqdir *fqdir = container_of(work, struct fqdir, destroy_work);
> -       struct inet_frags *f = fqdir->f;
> +       struct llist_node *kill_list;
> +       struct fqdir *fqdir, *tmp;
> +       struct inet_frags *f;
>
> -       rhashtable_free_and_destroy(&fqdir->rhashtable, inet_frags_free_cb, NULL);
> +       /* Atomically snapshot the list of fqdirs to free */
> +       kill_list = llist_del_all(&free_list);
>
>         /* We need to make sure all ongoing call_rcu(..., inet_frag_destroy_rcu)
>          * have completed, since they need to dereference fqdir.
> @@ -158,12 +163,38 @@ static void fqdir_work_fn(struct work_struct *work)
>          */
>         rcu_barrier();
>
> -       if (refcount_dec_and_test(&f->refcnt))
> -               complete(&f->completion);
> +       llist_for_each_entry_safe(fqdir, tmp, kill_list, free_list) {
> +               f = fqdir->f;
> +               if (refcount_dec_and_test(&f->refcnt))
> +                       complete(&f->completion);
>
> -       kfree(fqdir);
> +               kfree(fqdir);
> +       }
>  }
>
> +static DECLARE_WORK(fqdir_free_work, fqdir_free_fn);
> +
> +static void fqdir_work_fn(struct work_struct *work)
> +{
> +       struct fqdir *fqdir = container_of(work, struct fqdir, destroy_work);
> +
> +       rhashtable_free_and_destroy(&fqdir->rhashtable, inet_frags_free_cb, NULL);
> +
> +       if (llist_add(&fqdir->free_list, &free_list))
> +               queue_work(fqdir_wq, &fqdir_free_work);

I think you misunderstood me.

Since this fqdir_free_work will have at most one instance, you can use
system_wq here, there is no risk of abuse.

My suggestion was to not use system_wq for fqdir_exit(), to better
control the number
 of threads in rhashtable cleanups.

void fqdir_exit(struct fqdir *fqdir)
{
        INIT_WORK(&fqdir->destroy_work, fqdir_work_fn);
-       queue_work(system_wq, &fqdir->destroy_work);
+      queue_work(fqdir_wq, &fqdir->destroy_work);
}



> +}
> +
> +static int __init fqdir_wq_init(void)
> +{
> +       fqdir_wq = create_singlethread_workqueue("fqdir");


And here, I suggest to use a non ordered work queue, allowing one
thread per cpu, to allow concurrent rhashtable cleanups

Also "fqdir" name is rather vague, this is an implementation detail ?

fqdir_wq =create_workqueue("inet_frag_wq");

> +       if (!fqdir_wq)
> +               panic("Could not create fqdir workq");
> +       return 0;
> +}
> +
> +pure_initcall(fqdir_wq_init);
> +
> +
>  int fqdir_init(struct fqdir **fqdirp, struct inet_frags *f, struct net *net)
>  {
>         struct fqdir *fqdir = kzalloc(sizeof(*fqdir), GFP_KERNEL);
> --
> 2.17.1
>
