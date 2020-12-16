Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF90C2DC265
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgLPOkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLPOkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:40:21 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029FAC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:39:41 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id 7so17352064qtp.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VYADik0C9sbwj6qyoxdzG2/mYRSOyXp6GJsvSZKDXoU=;
        b=vMonULkIHpZCV3FofCZbLYccKhzFZqC4I+tn0MQPkE2DE9B154uI+Mvf6wbYMsZGHL
         TvCy28l27L4VNo4MZSWGfPQIUm7QS18lCCBXRp/th8pl1NfHvXOJvrqhOB8AFKoQmmS1
         w1fODBQghuTqvX1eNRRgkucvSW3sPooHmbIgW5yb98Zco8v8kZBbtU91qebjilFrnGVS
         IuQfa32DBDpx8DwqXDXkkWaALCVeGG4L6ExOksKuiQYZcryUq+6KfAhCQkqfQdHbRPKy
         JbIUA1HO79mm++RPUXM2DMJtkk+Mygi5ftBOuvjlnFJbg5tgUQau5E9o2lRjn4W6UE/C
         O8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VYADik0C9sbwj6qyoxdzG2/mYRSOyXp6GJsvSZKDXoU=;
        b=t6DJbPtv9CuQST5cDcxsYp8BJEQ5Vwz/DhUhVyh2han1eO0puMXO5DAiq3ZhIEikhH
         4bFnOuU0I0H2vOvQ2Rsf7tfvVMTtU2NE76VgaEIe+nZutaJg1be9QknWmo1M7yTSEGaX
         YBcKaHl4z6spC0k5MY0llR2twjPwERSEICPtJBw2d4BxBXXTwwLlpLbGpR3I4s4CweP3
         nXVlfczcVkPBpLPcRTyHS/2rt8GGcdrtMJ3/kCaiVAhNH1g4w1t16gNJd/yfHm+msXMz
         NesOec/8bGYcmFvocvByM+OCnEkFpPvH+EKtPhstmEgJ0z2d/zhtjRnGN0sO/6SfhK+7
         8YOw==
X-Gm-Message-State: AOAM533+4xaR8ypfBZyI2tvixzGy3nyhaPikZBGMIhciWHhWMmP3SMkm
        mAO7TtllknG1kWyU5H1jvxM=
X-Google-Smtp-Source: ABdhPJxBnJL1O5TOwJCXGCdSKFlXvewi0emolI7aLq2eqb/aoMyGXPbhgVSXAISjZ+end6lhBbDNIg==
X-Received: by 2002:aed:31c5:: with SMTP id 63mr42656411qth.84.1608129580100;
        Wed, 16 Dec 2020 06:39:40 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:cbde])
        by smtp.gmail.com with ESMTPSA id r1sm1003852qta.32.2020.12.16.06.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:39:39 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Dec 2020 09:39:06 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 04/10] workqueue: don't set the worker's cpumask when
 kthread_bind_mask()
Message-ID: <X9ocCpJC87d2vjdg@mtj.duckdns.org>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
 <20201214155457.3430-5-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214155457.3430-5-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 11:54:51PM +0800, Lai Jiangshan wrote:
> @@ -1945,7 +1945,15 @@ static struct worker *create_worker(struct worker_pool *pool)
>  		goto fail;
>  
>  	set_user_nice(worker->task, pool->attrs->nice);
> -	kthread_bind_mask(worker->task, pool->attrs->cpumask);
> +
> +	/*
> +	 * Set PF_NO_SETAFFINITY via kthread_bind_mask().  We use
> +	 * cpu_possible_mask other than pool->attrs->cpumask, because
                             ^
                             instead of

> +	 * there might be no online cpu in the pool->attrs->cpumask.
                 ^
                 might not be any

> +	 * The cpumask of the worker will be set properly later in
> +	 * worker_attach_to_pool().
> +	 */
> +	kthread_bind_mask(worker->task, cpu_possible_mask);

This is a bit ugly but not the end of the world. Maybe we can move it to the
start of worker_thread() but that'd require an extra handshake. Oh well...

Thanks.

-- 
tejun
