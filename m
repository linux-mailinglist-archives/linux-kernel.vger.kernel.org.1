Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8382F271D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 05:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbhALEd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 23:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbhALEd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 23:33:56 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E69C061575
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 20:33:15 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id q137so1362351iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 20:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ubSy8FA8Cm0Wvh4KGL5pEI5FTj3nDO3yFAipNoj+fNY=;
        b=XCr50NqX0ZCIUYYQieDJ9kF/pIaCU8NUvD+e5I4IhTJpk0+Zy9Db8iDd0AnE1T3uxR
         Cy7PWlpVzJzhB9Llz8SWfG8SE4RSAR3S9ShaCexgEdwpPYfa2r/xDUOlxbIbdk9gh4Re
         k9ZjxUAQio45raDDX9zXMMIjOpR+Ehtg8Cuu9G2aXUtzyuqOi6isGHJp4yNdrQdlwySl
         7tFmM1YIURKHyzzSYsC/hY4dbar1dShYkF6YjViO5gEAtZS3PY+HXCjpgFwFqnlJkCQ/
         sJ73YmMd9EHZnpNt8H5TYgXGT7t1l2l1el3PoAoK2L3+JdRq8FD2V5xn9URJltpW7fVO
         lk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ubSy8FA8Cm0Wvh4KGL5pEI5FTj3nDO3yFAipNoj+fNY=;
        b=GxEH+8aWUQGZauM4x9LgmPnAoU+TmhEr/ImR8oZvbNuudF7mtaMfaiMTDJX5iBqRSx
         besQjU2RN2yRdpkiDWZ7wSs3lQrB8c6AxUWFOXJhprA3gCAuwnedkcC4stSZgTLRGx7x
         /jm9UjfnbH6uuHF+pMN9+03RLv4kEh6FC2SKbtg6drAL45qEavRWjSMmS08eSIG+WcAs
         qgGQhryybgpnb3ZsU82oneSpB1CcL6LXv3xEZtAhgMfSsl2NMWu97jmNzzV7vMNgn1g5
         izNZj/t6VYDlS241KSJ952asl3lh0KNccR42Sz45oDTU1sDrU94UuYo61wjys+mPDL37
         65aA==
X-Gm-Message-State: AOAM531Cjokds5cEp6XwAid4N/9RyWSQKhdxtypRKEU56dnmKwf/jEyF
        flvcuxA5+VjblUbmVILghEAfIa7WZWqFHG4p0/k=
X-Google-Smtp-Source: ABdhPJyxtyM0e2hl805nEUS6k0siOA/lKHE4v2Cn9dHeBLCoozZSu/XoqQ/LLi58T4EWJa+qxA457TQ55hCzLN1bH84=
X-Received: by 2002:a5d:8c85:: with SMTP id g5mr1894913ion.154.1610425994991;
 Mon, 11 Jan 2021 20:33:14 -0800 (PST)
MIME-Version: 1.0
References: <20201226025117.2770-1-jiangshanlai@gmail.com> <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de> <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
 <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net> <jhj7doj1dr1.mognet@arm.com>
 <X/yzrJw4UbQsK3KB@hirez.programming.kicks-ass.net>
In-Reply-To: <X/yzrJw4UbQsK3KB@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 12 Jan 2021 12:33:03 +0800
Message-ID: <CAJhGHyA0rfR92W7T7RnhPrmLMkmV4Mb7fUSeG2VEHhsH-pSxsw@mail.gmail.com>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paul McKenney <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Well yes, but afaict the workqueue stuff hasn't been settled yet, and
> the rcutorture patch Paul did was just plain racy and who knows what
> other daft kthread users are out there. That and we're at -rc3.

I just send the V4 patchset for the workqueue.  Please take a look.

> @@ -1861,6 +1861,8 @@ static void worker_attach_to_pool(struct worker *worker,
>         */
>         if (pool->flags & POOL_DISASSOCIATED)
>                 worker->flags |= WORKER_UNBOUND;
> +       else
> +               kthread_set_per_cpu(worker->task, true);

I think kthread_set_per_cpu(worker->task, false) is also needed for
worker_detach_from_pool() or at least rescuer_thread() who doesn't
go to die after detached from the pool.

> I thought only pcpu pools would get the POOL_DISASSOCIATED flag on
> offline, but it seems unbound pools also get it at init time. Did I get
> that right?

You are right.

The POOL_DISASSOCIATED flag indicates whether the pool is concurrency
management or not (negative way, POOL_DISASSOCIATED means "not concurrency
management"). So it should be applied for all unbound pools.

When !POOL_DISASSOCIATED means it is a percpu pool, and the pool->cpu
is online and the offline callback has not been called yet even the pool->cpu
is going to be offline.  So !POOL_DISASSOCIATED is used a lot in the code.
