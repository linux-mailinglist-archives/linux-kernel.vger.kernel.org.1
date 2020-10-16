Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D23C290E3E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 01:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411487AbgJPXnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 19:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411475AbgJPXm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 19:42:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170FCC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:43:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u3so2336350pjr.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qMIRGtCbidqhrVX1CFgIfHv8dz3tcb7jhdidwcYxnP4=;
        b=zNJGuaSa/UOOmpCM2ejLE+gbnxYvpsN4PrCllOcIq6txGgth2hWs4Kahvl56OBGlF2
         oddGpMO4ChARNKE231A9fb38mBwgVNVs4yqz4YqurPU8o9wMhE9tsZ2coQZ4lua/iTli
         iZ4gqQm0h0ac/h+dDXs7vCM6ICWwAgOhHW1bP+Zgm76Xs6t/drLrqxQ9H+Q7txOdTNOK
         XeZ/vOv/vSAmdZW9FYh92YzH5+JUPUnLuQnr6yTaSFWzeW0zy/IR7L4pwtWVV3xOiVma
         3SrgENG/qIaLHbXz0DqJCIAt3wZOWrnNJpTTLSoYNn1vgyzAAqIqfklz9MD6GbTXKxsI
         VI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qMIRGtCbidqhrVX1CFgIfHv8dz3tcb7jhdidwcYxnP4=;
        b=eDReBRBn+lZ9MhhzsgxD4n7AUINPFWSQZoAAW7hhrAUohqj+MMY/dO/NvIrhXqoL3V
         o5nkePr8bnGrU6+KnGcZ6DVxY423w9EDwi19Crt0hiO7OEmdtC3gWSVA9QOpHHgNbexx
         JDo5/PBDBMWqGoE8bWxbkXeVATUTyBTHszvsFZySCrG4hBX+Ftjxu1NT1FzRI3sInYD4
         ByV0VXvv41EieNjfiLHubdGSW/35JLPa27AaWokK6yXJaB5QaRb/nec8CVQ1HWt6Lx2q
         isUuohefCxH34LgJ9t0dP4ZRtVsNSTNox6EGqYgbNvnjoBEX4v1XVjpwx4sEFuuiJ9HY
         Sf9Q==
X-Gm-Message-State: AOAM532Ueofhx2AykV/mHJud3OUVonVIcYFvAurkYe36hJpHu67rotC2
        B6nRCivHAzSgGY17JAdxgscWzNeCoN0rIw==
X-Google-Smtp-Source: ABdhPJw6B/u/ToVubuEWZVq/Lozat2V7O/5p5ci4bYqKnj6SFO2/t4oIHApIt9tsjOK0GUf/NncuiQ==
X-Received: by 2002:a17:902:c395:b029:d3:f156:ef0c with SMTP id g21-20020a170902c395b02900d3f156ef0cmr6518051plg.55.1602891825119;
        Fri, 16 Oct 2020 16:43:45 -0700 (PDT)
Received: from ?IPv6:2600:380:4910:fe35:1659:7eea:2a98:b14b? ([2600:380:4910:fe35:1659:7eea:2a98:b14b])
        by smtp.gmail.com with ESMTPSA id s187sm4086218pgb.54.2020.10.16.16.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 16:43:44 -0700 (PDT)
Subject: Re: [PATCH] task_work: cleanup notification modes
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <93292d5b-9124-d252-c81f-1f2cfbd60e7b@kernel.dk>
 <87tuutalre.fsf@nanos.tec.linutronix.de>
 <aaed79d1-972f-e4bd-f3ac-d589cd729163@kernel.dk>
 <87zh4lix8l.fsf@nanos.tec.linutronix.de>
 <2ebe7e45-b4e5-1a6b-d3ee-4a790817a119@kernel.dk>
 <87wnzpivvx.fsf@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7e32aa44-35ff-3a48-87d0-8e7df586db1d@kernel.dk>
Date:   Fri, 16 Oct 2020 17:43:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87wnzpivvx.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 5:38 PM, Thomas Gleixner wrote:
> On Fri, Oct 16 2020 at 17:13, Jens Axboe wrote:
>> /**
>>  * task_work_add - ask the @task to execute @work->func()
>>  * @task: the task which should run the callback
>>  * @work: the callback to run
>>  * @notify: how to notify the targeted task
>>  *
>>  * Queue @work for task_work_run() below and notify the @task if @notify
>>  * is @TWA_RESUME or @TWA_SIGNAL. @TWA_SIGNAL work like signals, in that the
> 
> s/the//

Thanks, good catch.

>>  * it will interrupt the targeted task and run the task_work. @TWA_RESUME
>>  * work is run only when the task exits the kernel and returns to user mode.
>>  * Fails if the @task is exiting/exited and thus it can't process this @work.
>>  * Otherwise @work->func() will be called when the @task returns from kernel
>>  * mode or exits.
> 
> Yes, that makes a lot more sense.
> 
> What's still lacking is a description of the return value and how to act
> upon it.

That's really up to the caller. But we should add some explanation of
that. Most callers use some alternative if the task is exiting, like
using a work queue for example.

> Most of the call sites ignore it, some are acting upon it but I can't

If you know the task isn't exiting, then yeah you can ignore it. But
seems a bit dicey...

> make any sense of these actions:
> 
> fs/io_uring.c-	notify = 0;
> fs/io_uring.c-	if (!(ctx->flags & IORING_SETUP_SQPOLL) && twa_signal_ok)
> fs/io_uring.c-		notify = TWA_SIGNAL;
> fs/io_uring.c-
> fs/io_uring.c:	ret = task_work_add(tsk, &req->task_work, notify);
> fs/io_uring.c-	if (!ret)
> fs/io_uring.c-		wake_up_process(tsk);
> 
> ???
> 
> fs/io_uring.c-	if (unlikely(ret)) {
> fs/io_uring.c-		struct task_struct *tsk;
> fs/io_uring.c-
> fs/io_uring.c-		init_task_work(&req->task_work, io_req_task_cancel);
> fs/io_uring.c-		tsk = io_wq_get_task(req->ctx->io_wq);
> fs/io_uring.c:		task_work_add(tsk, &req->task_work, 0);
> fs/io_uring.c-		wake_up_process(tsk);
> 
> yet more magic wakeup.

It's not magic, but probably needs a comment... If we fail, that task is
exiting. But we know we have our io-wq threads, so we use that as a
fallback. Not really expected in the fast path.

> fs/io_uring.c-
> fs/io_uring.c-	init_task_work(&req->task_work, io_req_task_submit);
> fs/io_uring.c-	percpu_ref_get(&req->ctx->refs);
> fs/io_uring.c-
> fs/io_uring.c-	/* submit ref gets dropped, acquire a new one */
> fs/io_uring.c-	refcount_inc(&req->refs);
> fs/io_uring.c:	ret = io_req_task_work_add(req, true);
> fs/io_uring.c-	if (unlikely(ret)) {
> fs/io_uring.c-		struct task_struct *tsk;
> fs/io_uring.c-
> fs/io_uring.c-		/* queue just for cancelation */
> fs/io_uring.c-		init_task_work(&req->task_work, io_req_task_cancel);
> fs/io_uring.c-		tsk = io_wq_get_task(req->ctx->io_wq);
> fs/io_uring.c:		task_work_add(tsk, &req->task_work, 0);
> fs/io_uring.c-		wake_up_process(tsk);
> 
> Ditto. Why the heck is this wakeup making any sense? The initial
> task_work_add() within io_req_task_work_add() failed already ...

Right, but we're using a new task for this. And that task is a kthread
that we manage, hence no notification is needed outside of just waking
it up.

-- 
Jens Axboe

