Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0792F2D8F64
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 19:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392964AbgLMSlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 13:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390051AbgLMSj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 13:39:56 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B951C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 10:39:41 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id m12so24640637lfo.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 10:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qCn3NHtoWSZwuf21MXbxZMkWcXxQPfte0L3AbThqKOs=;
        b=PQe1yb2FT6b3+I5xwdl+l2pAvL2uAUA3xo3uVxyNTlGJ8LYDvptzluXtJTfugZu4Jl
         nYKGs6vdkRE3I/zr9B+xrS6/2MrN73SfFPtyUZ4YF50p/pXTBLgPs1lf4tLZx/iFl2rC
         LDZuE+iI7INtKWTlSu9McBWtrTzb4Sp2Td0km3Qw34nF81+vkOEyv+LnBe19Pud/gPau
         6bgAE4V6b1vGArlimMvRbyf7cc6e0Mdf4XjUg3YQ338ZLov4GelZqpkMXs+A7A4V5Wjy
         gbFTXk/lFeYpEWFQaP5quspXrG8lsclrKUJofR20SVN6HH51rS89qxaMSQIvGjX5QeHm
         tRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qCn3NHtoWSZwuf21MXbxZMkWcXxQPfte0L3AbThqKOs=;
        b=mpmbTYtOV1gVUvNtBe8JN2tuig83xNW0wTqY4Z7MRQ3JAxeTN02cLky/8LwBVa4M/s
         VnQM8gBsYkGYjGZBKnmsrhVmwpc5Y+dLQjOgEMILL4dV0B9hQqcRRJ0ml7J7kkJtgx5y
         ao5NLtX8hSaJQvs5b+TA5qHb+F2x1pZdEUC7sTHu8hjy9uNG7J1A2pPAxE6A9YHiNKjQ
         lD/yEJLqG+Pliix/qHjUlDTXkm+UbC8M2dwpudDlD7vs80/VafwyCfs+FlfKYDgP4sov
         E4eSWtFpUIRaDzU79pAk2FYONiDoTxi7nyxi1+O5P2oNaIupf3gtD9JkTx8WcWjDVcIU
         Eddg==
X-Gm-Message-State: AOAM5339qmJgtFp034Sfd0XmuA/5QZMfFMTZjhlzT02TcD0P+Ogb8DRD
        fkvlsZBSo/48joUtUm7iPSU=
X-Google-Smtp-Source: ABdhPJxSo0ee6ZjLQoK2ZfQEL0k6blaIVMM25WSDnIHC0hMbKO6+BOiBSTqiHdwFr76bWV9GIrkzDg==
X-Received: by 2002:a19:5512:: with SMTP id n18mr5617641lfe.270.1607884778749;
        Sun, 13 Dec 2020 10:39:38 -0800 (PST)
Received: from pc636 (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t1sm1002713ljg.44.2020.12.13.10.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 10:39:38 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sun, 13 Dec 2020 19:39:36 +0100
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: Fix unlock order in s_stop()
Message-ID: <20201213183936.GA20007@pc636>
References: <20201213180843.16938-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213180843.16938-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 01:08:43PM -0500, Waiman Long wrote:
> When multiple locks are acquired, they should be released in reverse
> order. For s_start() and s_stop() in mm/vmalloc.c, that is not the
> case.
> 
>   s_start: mutex_lock(&vmap_purge_lock); spin_lock(&vmap_area_lock);
>   s_stop : mutex_unlock(&vmap_purge_lock); spin_unlock(&vmap_area_lock);
> 
> This unlock sequence, though allowed, is not optimal. If a waiter is
> present, mutex_unlock() will need to go through the slowpath of waking
> up the waiter with preemption disabled. Fix that by releasing the
> spinlock first before the mutex.
> 
> Fixes: e36176be1c39 ("mm/vmalloc: rework vmap_area_lock")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/vmalloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6ae491a8b210..75913f685c71 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3448,11 +3448,11 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
>  }
>  
>  static void s_stop(struct seq_file *m, void *p)
> -	__releases(&vmap_purge_lock)
>  	__releases(&vmap_area_lock)
> +	__releases(&vmap_purge_lock)
>  {
> -	mutex_unlock(&vmap_purge_lock);
>  	spin_unlock(&vmap_area_lock);
> +	mutex_unlock(&vmap_purge_lock);
>  }
>  
>  static void show_numa_info(struct seq_file *m, struct vm_struct *v)
BTW, if navigation over both list is an issue, for example when there
are multiple heavy readers of /proc/vmallocinfo, i think, it make sense
to implement RCU safe lists iteration and get rid of both locks.

As for the patch: Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thanks!

--
Vlad Rezki
