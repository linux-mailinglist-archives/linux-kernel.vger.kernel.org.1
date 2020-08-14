Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18166244E93
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 20:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHNSva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 14:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgHNSv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 14:51:29 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEB5C061385;
        Fri, 14 Aug 2020 11:51:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b30so5313030lfj.12;
        Fri, 14 Aug 2020 11:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1B6r/UIAY57PjYht7F+lUfA0mDhvlwhw8UINtZ/LxTk=;
        b=WfUIMuV+7Hapors9LYPkIGnqShQFVa+SkOdmN8lo4cPVlaelIgeXd/sIHA72JkTZf7
         Js+/vIyjpB3z5acwYirKHmCKXvqOhyYlnEuWfEOkjZ+kLLaMh0zKjipZoon+1ksNRdr0
         uYKWccXnEDkIsE4d2Xf4mjzgz7dy4qLr1OsvtOQmQ2PvXEoDYnyK03j0G2ouN+m7Mp7C
         HOSaonBIULXFqPy8NHIpUI93huNeRPb44MwtnQSjsc2J+w3rLRJo0ITt4dMRIvxrxW1v
         ah5ad8QqpyCSUJ0vEKm622O+m7maqy2cFakiKuaIlFl5DQqcIxOZEh2KqbE4WET2cNGB
         Ww4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1B6r/UIAY57PjYht7F+lUfA0mDhvlwhw8UINtZ/LxTk=;
        b=R0QUu0CVuHIjy9JLC5YOMapQ/NzZSpzoEvxZ5ysg/kTNjrnM7xJltrDIGLKNZf+HTq
         cpz12I7+y0vU8ZAmiNGJq4IAgAatVWnJWCPj39u2gmFS00NGJfVKFDuJEZfqr/qyfU7k
         vyNonfcf2uxEqfiKAyduhD0gikvnD5F6DO+JXoy9u86E7p2N1OqfBUU17KzqQNxrfLgB
         +Mqqx3HDNreGzzS9RYuXPLS5JcY0/r5EX5AM8fj3MCLTUI6DxAzSng5r88hMTtDztMrq
         HkoxlQLCx3Iwh1QEuHr7Xj0//DgxM553B9G9NSyJYCgH4LP1/VQHXFrzTUKJo2f9wr6U
         ft+g==
X-Gm-Message-State: AOAM533LY7XYTrdVKRL4PZrORauIyG3Ctt9zl18ruHUHrXJ3/fNawbJy
        HHJbBItn4eupp/Ja9sotsGw8L2YVPW2zcQ==
X-Google-Smtp-Source: ABdhPJzANvpGPUM6QRhE81pE2sZ8e3f7WfkjcwORHmRdrmbD3ZptEnBO4le5cxH4mYhfDfiHUbYruw==
X-Received: by 2002:a19:983:: with SMTP id 125mr1862397lfj.129.1597431087364;
        Fri, 14 Aug 2020 11:51:27 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id v20sm1919295lji.64.2020.08.14.11.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 11:51:26 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 14 Aug 2020 20:51:24 +0200
To:     qiang.zhang@windriver.com, Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: shrink each possible cpu krcp
Message-ID: <20200814185124.GA2113@pc636>
References: <20200814064557.17365-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814064557.17365-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Zqiang <qiang.zhang@windriver.com>
> 
> Due to cpu hotplug. some cpu may be offline after call "kfree_call_rcu"
> func, if the shrinker is triggered at this time, we should drain each
> possible cpu "krcp".
> 
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  kernel/rcu/tree.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8ce77d9ac716..619ccbb3fe4b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3443,7 +3443,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  	unsigned long count = 0;
>  
>  	/* Snapshot count of all CPUs */
> -	for_each_online_cpu(cpu) {
> +	for_each_possible_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		count += READ_ONCE(krcp->count);
> @@ -3458,7 +3458,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  	int cpu, freed = 0;
>  	unsigned long flags;
>  
> -	for_each_online_cpu(cpu) {
> +	for_each_possible_cpu(cpu) {
>  		int count;
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
> @@ -3491,7 +3491,7 @@ void __init kfree_rcu_scheduler_running(void)
>  	int cpu;
>  	unsigned long flags;
>  
> -	for_each_online_cpu(cpu) {
> +	for_each_possible_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		raw_spin_lock_irqsave(&krcp->lock, flags);
>
I agree that it can happen.

Joel, what is your view?

Thanks!

--
Vlad Rezki
