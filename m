Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCC42A3B70
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 05:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgKCEfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 23:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCEfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 23:35:19 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14CDC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 20:35:18 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id p10so14984521ile.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 20:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uvk2ZdzjcKXuUpblHIRZ8DqW+kjcCBeYkVpqBu+X+0M=;
        b=UDe8rfLf/tMXRU/pjzTHrMy2rH4uSVG1Gf7LdFKIuIlJPHr1GSzyHtx4AmCvni/O1c
         0gHdcUX1pKKtHaQkTVmaP4VN+zXGZ8bzHSHYY2BtOe2s/pU5FdYNkI+KONG1QVKJd7p3
         l6opkzBqKSC8NgCNPZ4I1JvNRspMOkUTnNypdz+//bQIIUxmsXTj7IN1ltme/51FOf0s
         vel+bm+5ttk9QPwvbD+BmgYISOcP3dPl2YXhG+cnRIRW8dmvdpv0hppTRi76mjS/nv1M
         BKszhCMekegsV6ralY8z9fkHI7k6Y4dmG1tN9sCjpsV9JRHBJahew2iSQ4G4TUcKh0fo
         QO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uvk2ZdzjcKXuUpblHIRZ8DqW+kjcCBeYkVpqBu+X+0M=;
        b=CYVC43p8G/XusqMpEDIhPNAIVT7PeuzF2X4QgkGyWeHB4igPOpOlJqBCOJJOLiPjwu
         vQ/Twm6QnA9VfAGO99mNJVAbcZPwgdtB885j3opchFqOFmH4xi7T/fUsX+kyrxYCxElC
         d6zBC+rRfjxFRe39Xj+VZ4nHN1n/DAD0GDyPDU1rM0sS1KQgkm+81DvDlD6nNVy21DOr
         tE4Y8I+xvNC+DBUcnuaXwrWz1NUjKWeG27+ipyJMzS6chotOxNyhJ11hOTHRn9yTmuk/
         l9xOg2MiluKwWyYWW52ejHVsJwlr8l4Hh5qciI0PlGyAZSN2bl/07ZvmX5wgLVXC14g3
         quLA==
X-Gm-Message-State: AOAM5306fwecTu1QyW2/mD0SodUrkbpzuSem9j2U8/ANyrYQ2ho1A/kZ
        wPW/GhQwuysZC8Ytcw1w/ltfMC7LgpgZeKZ0pME=
X-Google-Smtp-Source: ABdhPJzRtdgaLZYev7dcjlrUFAyXFz32Y52BvM9ZdCNwOtfFWo30bDa9edzAdzpIu+SF+OvoeXfX45Qeh7xmr53HR0I=
X-Received: by 2002:a92:d441:: with SMTP id r1mr13262483ilm.164.1604378118271;
 Mon, 02 Nov 2020 20:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20201101122124.1185-1-adrianhuang0701@gmail.com>
In-Reply-To: <20201101122124.1185-1-adrianhuang0701@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 3 Nov 2020 12:35:07 +0800
Message-ID: <CAJhGHyAQPGnF1rkeeNEHSmqFBS0Ku2h3rEc5tLfm-rEs1A=MhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] workqueue: Remove redundant assignment
To:     Adrian Huang <adrianhuang0701@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Adrian Huang <ahuang12@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Adrian

I believe the pool->node is being used as a node hint
before workqueue_init() for allocating memory. It is
useful when it is correct.

I think it is better to init it early unless there is a bug
about it in this early stage reported (on same archs).

Thanks
Lai.

On Sun, Nov 1, 2020 at 8:21 PM Adrian Huang <adrianhuang0701@gmail.com> wrote:
>
> From: Adrian Huang <ahuang12@lenovo.com>
>
> The member 'node' of worker_pool struct (per_cpu worker_pool) is
> assigned in workqueue_init_early() and workqueue_init().
> Commit 2186d9f940b6 ("workqueue: move wq_numa_init() to workqueue_init()")
> fixes an issue by moving wq_numa_init() to workqueue_init() in order
> to get the valid 'cpu to node' mapping. So, remove the redundant
> assignment in workqueue_init_early().
>
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  kernel/workqueue.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 437935e7a199..cf8c0df2410e 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5937,7 +5937,6 @@ void __init workqueue_init_early(void)
>                         pool->cpu = cpu;
>                         cpumask_copy(pool->attrs->cpumask, cpumask_of(cpu));
>                         pool->attrs->nice = std_nice[i++];
> -                       pool->node = cpu_to_node(cpu);
>
>                         /* alloc pool ID */
>                         mutex_lock(&wq_pool_mutex);
> --
> 2.17.1
>
