Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB11291446
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 22:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439735AbgJQUSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 16:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbgJQUSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 16:18:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560DBC061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 13:18:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602965931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nVSItM5xGZp18npzBBZXdGhrRdFkZ+P/HmdtT+W/pqA=;
        b=I4tzo2C7Qw1AFK1o3MPNQY4cwgDqikwXqk1cqxvzmiOHsr9wtCOfK7L0yXJqtNHxOWgLVo
        02VMtf1Lcqc9WHbKqCpX6KU8BHfAjuzMV/MP8RMQ7AlvbpbXW64qSg/EpYMn/guwbluXjq
        9oDa276PQclg8x8LiEPy7JxHcb+GLI/2AkE9objwtK6SBhdVgGCM/0s7wmh4BgKE/nJkdL
        wHC4pAuuhoWzvxn7LpfhY4Y4EECbszN5NkFXSTGOWHB+y0Sh1nAgtWGu3FEoK66vGZUFFZ
        JTKlcGmCFumHsHOV79QgRdvs46++0RZmCzqieUumWbSbHaprnXBD1sxTxMScXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602965931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nVSItM5xGZp18npzBBZXdGhrRdFkZ+P/HmdtT+W/pqA=;
        b=GNf9RZ+w71MUotgmu+S01TdBDQQE+tYvhu9b8unvXKnFPi1NR+0uOtSu+gRSaHuX6k2gw4
        WaEGtVCQIRADloCw==
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_work: cleanup notification modes
In-Reply-To: <4a2f1a71-3548-1f13-23a4-2f7e73408cf3@kernel.dk>
References: <93292d5b-9124-d252-c81f-1f2cfbd60e7b@kernel.dk> <87tuutalre.fsf@nanos.tec.linutronix.de> <aaed79d1-972f-e4bd-f3ac-d589cd729163@kernel.dk> <87zh4lix8l.fsf@nanos.tec.linutronix.de> <2ebe7e45-b4e5-1a6b-d3ee-4a790817a119@kernel.dk> <87wnzpivvx.fsf@nanos.tec.linutronix.de> <7e32aa44-35ff-3a48-87d0-8e7df586db1d@kernel.dk> <87tuusj2ch.fsf@nanos.tec.linutronix.de> <4a2f1a71-3548-1f13-23a4-2f7e73408cf3@kernel.dk>
Date:   Sat, 17 Oct 2020 22:18:51 +0200
Message-ID: <87k0voip1w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17 2020 at 09:36, Jens Axboe wrote:
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 613b2d634af8..d82c224ab5d5 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -9,23 +9,28 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
>   * task_work_add - ask the @task to execute @work->func()
>   * @task: the task which should run the callback
>   * @work: the callback to run
> - * @notify: send the notification if true
> + * @notify: how to notify the targeted task
>   *
> - * Queue @work for task_work_run() below and notify the @task if @notify.
> + * Queue @work for task_work_run() below and notify the @task if @notify
> + * is @TWA_RESUME or @TWA_SIGNAL. @TWA_SIGNAL work like signals, in that the

s/work/works/

> + * it will interrupt the targeted task and run the task_work. @TWA_RESUME
> + * work is run only when the task exits the kernel and returns to user mode.

It's also run before entering a guest. At least on x86, but all other
architectures should do the same.

>   * Fails if the @task is exiting/exited and thus it can't process this @work.
>   * Otherwise @work->func() will be called when the @task returns from kernel
>   * mode or exits.
>   *
> - * This is like the signal handler which runs in kernel mode, but it doesn't
> - * try to wake up the @task.
> + * If the targeted task is exiting, then an error is returned and the work item
> + * is not queued. It's up to the caller to arrange for an alternative mechanism
> + * in tht case.

s/tht/that/

Looks good otherwise.

Thanks,

        tglx
