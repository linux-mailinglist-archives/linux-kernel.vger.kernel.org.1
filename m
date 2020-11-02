Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567972A327C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgKBSDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:03:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58012 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgKBSDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:03:05 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kZeAZ-0004RJ-CZ; Mon, 02 Nov 2020 18:03:03 +0000
Date:   Mon, 2 Nov 2020 19:03:01 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC PATCH v1 1/4] Increase size of ucounts to atomic_long_t
Message-ID: <20201102180301.dup2cmbqdyrexp22@wittgenstein>
References: <cover.1604335819.git.gladkov.alexey@gmail.com>
 <f3c95ffedbab07f05e0e6e4e5a8bdd6c358194e7.1604335819.git.gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3c95ffedbab07f05e0e6e4e5a8bdd6c358194e7.1604335819.git.gladkov.alexey@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 05:50:30PM +0100, Alexey Gladkov wrote:
> In order to be able to use ucounts for rlimits, the size must be increased.
> For example user_struct.mq_bytes (RLIMIT_MSGQUEUE) is unsigned long.

I don't have any issues with this change I just wonder what the exact
reason is. It's not immediately obvious to me.

> 
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> ---
>  include/linux/user_namespace.h |  4 ++--
>  kernel/ucount.c                | 14 +++++++-------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 6ef1c7109fc4..fc75af812d73 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -86,7 +86,7 @@ struct user_namespace {
>  	struct ctl_table_header *sysctls;
>  #endif
>  	struct ucounts		*ucounts;
> -	int ucount_max[UCOUNT_COUNTS];
> +	long ucount_max[UCOUNT_COUNTS];
>  } __randomize_layout;
>  
>  struct ucounts {
> @@ -94,7 +94,7 @@ struct ucounts {
>  	struct user_namespace *ns;
>  	kuid_t uid;
>  	int count;
> -	atomic_t ucount[UCOUNT_COUNTS];
> +	atomic_long_t ucount[UCOUNT_COUNTS];
>  };
>  
>  extern struct user_namespace init_user_ns;
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 11b1596e2542..7b2bca8582ef 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -175,14 +175,14 @@ static void put_ucounts(struct ucounts *ucounts)
>  	kfree(ucounts);
>  }
>  
> -static inline bool atomic_inc_below(atomic_t *v, int u)
> +static inline bool atomic_long_inc_below(atomic_long_t *v, int u)
>  {
> -	int c, old;
> -	c = atomic_read(v);
> +	long c, old;
> +	c = atomic_long_read(v);
>  	for (;;) {
>  		if (unlikely(c >= u))
>  			return false;
> -		old = atomic_cmpxchg(v, c, c+1);
> +		old = atomic_long_cmpxchg(v, c, c+1);
>  		if (likely(old == c))
>  			return true;
>  		c = old;
> @@ -199,14 +199,14 @@ struct ucounts *inc_ucount(struct user_namespace *ns, kuid_t uid,
>  		int max;
>  		tns = iter->ns;
>  		max = READ_ONCE(tns->ucount_max[type]);
> -		if (!atomic_inc_below(&iter->ucount[type], max))
> +		if (!atomic_long_inc_below(&iter->ucount[type], max))
>  			goto fail;
>  	}
>  	return ucounts;
>  fail:
>  	bad = iter;
>  	for (iter = ucounts; iter != bad; iter = iter->ns->ucounts)
> -		atomic_dec(&iter->ucount[type]);
> +		atomic_long_dec(&iter->ucount[type]);
>  
>  	put_ucounts(ucounts);
>  	return NULL;
> @@ -216,7 +216,7 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
>  {
>  	struct ucounts *iter;
>  	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
> -		int dec = atomic_dec_if_positive(&iter->ucount[type]);
> +		int dec = atomic_long_dec_if_positive(&iter->ucount[type]);
>  		WARN_ON_ONCE(dec < 0);
>  	}
>  	put_ucounts(ucounts);
> -- 
> 2.25.4
> 
