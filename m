Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B532B290E36
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 01:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411457AbgJPXiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 19:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411448AbgJPXiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 19:38:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF29C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:39:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602891538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pwOu6iBSzHlI9OWkxQuAIUj1HnZVyXFzwEp+nY7kQxU=;
        b=02tpDUqarze4p4jXvYJFnC6NbbagFdFCs9jXjSCi4r1KD5e9Bi9IM7tt4aoMrcWMBchX9o
        OUJ6n3pe5pFO1UOYhhE6cUci8iEYxJ1n0Q4bNZKAVPfWkruROkd02jtPlGB/LVaiaZ/F/l
        54LEJy4fqk/kEW8iAnhN+GgzdrSNT0A5cYH4KC6KTKm73/guWwadnZeoXhdGlAhyt8GHY5
        V054xdVeMsPWigHEPs/7cDaEembQlznJOKUCoVgzR3H6MFcV1aFiCCgQsgn5H/GMWiz39/
        enOOy7cj13J/Yp1Ty0oE2MQKuFXj+i6IG90Q3mix1778ezxuYxXyfA4gGw5O4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602891538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pwOu6iBSzHlI9OWkxQuAIUj1HnZVyXFzwEp+nY7kQxU=;
        b=9JJGj6uUGo4968MIPq19qjB2+WZqU+wyKWwB4cTdyrYM6K0Gs3+JkcBJQR64V3e41lGTan
        +6i7926H847equCg==
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_work: cleanup notification modes
In-Reply-To: <2ebe7e45-b4e5-1a6b-d3ee-4a790817a119@kernel.dk>
References: <93292d5b-9124-d252-c81f-1f2cfbd60e7b@kernel.dk> <87tuutalre.fsf@nanos.tec.linutronix.de> <aaed79d1-972f-e4bd-f3ac-d589cd729163@kernel.dk> <87zh4lix8l.fsf@nanos.tec.linutronix.de> <2ebe7e45-b4e5-1a6b-d3ee-4a790817a119@kernel.dk>
Date:   Sat, 17 Oct 2020 01:38:58 +0200
Message-ID: <87wnzpivvx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16 2020 at 17:13, Jens Axboe wrote:
> /**
>  * task_work_add - ask the @task to execute @work->func()
>  * @task: the task which should run the callback
>  * @work: the callback to run
>  * @notify: how to notify the targeted task
>  *
>  * Queue @work for task_work_run() below and notify the @task if @notify
>  * is @TWA_RESUME or @TWA_SIGNAL. @TWA_SIGNAL work like signals, in that the

s/the//

>  * it will interrupt the targeted task and run the task_work. @TWA_RESUME
>  * work is run only when the task exits the kernel and returns to user mode.
>  * Fails if the @task is exiting/exited and thus it can't process this @work.
>  * Otherwise @work->func() will be called when the @task returns from kernel
>  * mode or exits.

Yes, that makes a lot more sense.

What's still lacking is a description of the return value and how to act
upon it.

Most of the call sites ignore it, some are acting upon it but I can't
make any sense of these actions:

fs/io_uring.c-	notify = 0;
fs/io_uring.c-	if (!(ctx->flags & IORING_SETUP_SQPOLL) && twa_signal_ok)
fs/io_uring.c-		notify = TWA_SIGNAL;
fs/io_uring.c-
fs/io_uring.c:	ret = task_work_add(tsk, &req->task_work, notify);
fs/io_uring.c-	if (!ret)
fs/io_uring.c-		wake_up_process(tsk);

???

fs/io_uring.c-	if (unlikely(ret)) {
fs/io_uring.c-		struct task_struct *tsk;
fs/io_uring.c-
fs/io_uring.c-		init_task_work(&req->task_work, io_req_task_cancel);
fs/io_uring.c-		tsk = io_wq_get_task(req->ctx->io_wq);
fs/io_uring.c:		task_work_add(tsk, &req->task_work, 0);
fs/io_uring.c-		wake_up_process(tsk);

yet more magic wakeup.

fs/io_uring.c-
fs/io_uring.c-	init_task_work(&req->task_work, io_req_task_submit);
fs/io_uring.c-	percpu_ref_get(&req->ctx->refs);
fs/io_uring.c-
fs/io_uring.c-	/* submit ref gets dropped, acquire a new one */
fs/io_uring.c-	refcount_inc(&req->refs);
fs/io_uring.c:	ret = io_req_task_work_add(req, true);
fs/io_uring.c-	if (unlikely(ret)) {
fs/io_uring.c-		struct task_struct *tsk;
fs/io_uring.c-
fs/io_uring.c-		/* queue just for cancelation */
fs/io_uring.c-		init_task_work(&req->task_work, io_req_task_cancel);
fs/io_uring.c-		tsk = io_wq_get_task(req->ctx->io_wq);
fs/io_uring.c:		task_work_add(tsk, &req->task_work, 0);
fs/io_uring.c-		wake_up_process(tsk);

Ditto. Why the heck is this wakeup making any sense? The initial
task_work_add() within io_req_task_work_add() failed already ...

fs/io_uring.c:	ret = io_req_task_work_add(req, twa_signal_ok);
fs/io_uring.c-	if (unlikely(ret)) {
fs/io_uring.c-		struct task_struct *tsk;
fs/io_uring.c-
fs/io_uring.c-		WRITE_ONCE(poll->canceled, true);
fs/io_uring.c-		tsk = io_wq_get_task(req->ctx->io_wq);
fs/io_uring.c:		task_work_add(tsk, &req->task_work, 0);
fs/io_uring.c-		wake_up_process(tsk);

...

Thanks,

        tglx
