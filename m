Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7E8298E45
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780403AbgJZNlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:41:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38207 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780394AbgJZNlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:41:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id q26so6650222qtb.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Is8Ndd9dIIOH5Ln0+KPpq3sguokvidqL7+W/lmE7uFw=;
        b=s+Co15GsJi18U1mgkjWFvIaLqiwFeHg7V+a9VVcdmHo1Zog8I9StYIzdngDyShVzDw
         NLYerOlJyVMiBlIHdMXOeZdXPwdyiJBhL875UAJ/KMnr79U7Hwq5pDtmiyodO4FNSUZn
         TGwW6uvauww5Sl9C86F4dzdBVLAAR6TD4UORDa8es1CiPKxRYf0nMJhVtIyo74RO/rQP
         v2CJXXx5a/Cq0IUZyy+UrkA0m8RoQD4p/Uu2vwdOS8W0Jkpw5gCwWP0Oqb3pwug4W9IS
         leAPrRNAnpa9EgBwnCS/Qm0hyOKALQZDNDfQRmL7lCEqK9nV634iU42p1VPZfH77dGyM
         WcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Is8Ndd9dIIOH5Ln0+KPpq3sguokvidqL7+W/lmE7uFw=;
        b=IeEkvm2y2cgqth3Bj1VjnpNe9QQ2g3nMVcToFLirgNUXJ26ODm1jn0WRKWFbdeN8Cr
         nAumDMTM5D3uoTNnJ+We6U4qwvay4JOs13/mOLPSY90F/Z+oHySujWueE9xemF9p/VBc
         OKSrKR/8kR+vG1439woGgMq6urt8pAd0/XsNIxmjpTgwkB2El2Wbf2BrxTk/mw6CW9cm
         Jp04N/HS4T8r/qTRfQp3gmXza0wG4LWiTzLcnlYuCbDuls44UaAgtc175B1nRHv0MqmF
         vND3inwL2Vtn1EssnHCJx8VXXOkVEC5oowirLXbNAsl3MumPOrbtcAJxyH6z8kYE/o+D
         3BJA==
X-Gm-Message-State: AOAM533Rcvbigx1ak/T/rha+jzQBi9X+G68pvAySQc0a3RA9xKaK9Pay
        noeCRa6wqTyMkOFttuZF0vo=
X-Google-Smtp-Source: ABdhPJxlmsw7CFyINq07gVGdS1LDX+QeTwQsT7BCd2TNkNAA2NWTtYk2i8Jyj7MHnJw4OgGmrxYEQg==
X-Received: by 2002:ac8:4a07:: with SMTP id x7mr17679588qtq.110.1603719678157;
        Mon, 26 Oct 2020 06:41:18 -0700 (PDT)
Received: from localhost (dhcp-48-d6-d5-c6-42-27.cpe.echoes.net. [199.96.181.106])
        by smtp.gmail.com with ESMTPSA id d7sm6528705qkg.29.2020.10.26.06.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:41:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Oct 2020 09:41:14 -0400
From:   Tejun Heo <tj@kernel.org>
To:     qiang.zhang@windriver.com
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: replace call_rcu with kfree_rcu
Message-ID: <20201026134010.GA73258@mtj.duckdns.org>
References: <20201014083145.16959-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014083145.16959-1-qiang.zhang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 04:31:45PM +0800, qiang.zhang@windriver.com wrote:
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index ac088ce6059b..8d4fe649631a 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3653,11 +3653,6 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
>  	return NULL;
>  }
>  
> -static void rcu_free_pwq(struct rcu_head *rcu)
> -{
> -	kmem_cache_free(pwq_cache,
> -			container_of(rcu, struct pool_workqueue, rcu));
> -}
>  
>  /*
>   * Scheduled on system_wq by put_pwq() when an unbound pwq hits zero refcnt
> @@ -3683,7 +3678,7 @@ static void pwq_unbound_release_workfn(struct work_struct *work)
>  	put_unbound_pool(pool);
>  	mutex_unlock(&wq_pool_mutex);
>  
> -	call_rcu(&pwq->rcu, rcu_free_pwq);
> +	kfree_rcu(pwq, rcu);

kfree_rcu() eventually calls kfree() which is different from
kmem_cache_free(). It can only be used for kmalloc'd areas, not
kmem_cache_alloc'd ones.

Thanks.

-- 
tejun
