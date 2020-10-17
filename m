Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C8A2912A5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438523AbgJQPbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 11:31:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50418 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438516AbgJQPbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 11:31:45 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602948703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h+yVwEx6UlSb28MYyb4hCQ5aam028HimOBjq54tjfPM=;
        b=bO29nU6vbkENaUbtkZDhzX6JQpr34nUvwFGH82umQbNaFc3Qn/sLCakWiyTMk2PyiuqR5c
        GkPt7VBGxbgvX1/+XJCwdFJt6jAKpqsQma0U5PNagYBmGgUotLFaAZMHYhOcOA9dwU4s9O
        4mxP2fJNhynuh0Kyq12taF0yO5iTODKGzGZCJooxa4AqjeN0BdeYt4+W5eAuXn6/ISnX3B
        1hAz/2FbSXmAuIVYgWhupFO7d9IexuYd18HPG7v45OZOIf1w/cjlwMeGlGpHPv5J5srEly
        L/xl9yoFWHdtvIqtnVfeH5T+963KccxFXpLTH60PLvgoCD6HpcGn9xuvYfloyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602948703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h+yVwEx6UlSb28MYyb4hCQ5aam028HimOBjq54tjfPM=;
        b=PlIGX9nMZGMlbtaW6uJ9Dprx+ikXwso11iDryJgujIlC7s6sbggSa/nrRrFcYBEUVIR/8a
        hxyIfc4juU6qVpBQ==
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_work: cleanup notification modes
In-Reply-To: <7e32aa44-35ff-3a48-87d0-8e7df586db1d@kernel.dk>
References: <93292d5b-9124-d252-c81f-1f2cfbd60e7b@kernel.dk> <87tuutalre.fsf@nanos.tec.linutronix.de> <aaed79d1-972f-e4bd-f3ac-d589cd729163@kernel.dk> <87zh4lix8l.fsf@nanos.tec.linutronix.de> <2ebe7e45-b4e5-1a6b-d3ee-4a790817a119@kernel.dk> <87wnzpivvx.fsf@nanos.tec.linutronix.de> <7e32aa44-35ff-3a48-87d0-8e7df586db1d@kernel.dk>
Date:   Sat, 17 Oct 2020 17:31:42 +0200
Message-ID: <87tuusj2ch.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16 2020 at 17:43, Jens Axboe wrote:
> On 10/16/20 5:38 PM, Thomas Gleixner wrote:
> If you know the task isn't exiting, then yeah you can ignore it. But
> seems a bit dicey...

Indeed.

>> fs/io_uring.c-	if (unlikely(ret)) {
>> fs/io_uring.c-		struct task_struct *tsk;
>> fs/io_uring.c-
>> fs/io_uring.c-		init_task_work(&req->task_work, io_req_task_cancel);
>> fs/io_uring.c-		tsk = io_wq_get_task(req->ctx->io_wq);
>> fs/io_uring.c:		task_work_add(tsk, &req->task_work, 0);
>> fs/io_uring.c-		wake_up_process(tsk);
>> 
>> yet more magic wakeup.
>
> It's not magic, but probably needs a comment... If we fail, that task is
> exiting. But we know we have our io-wq threads, so we use that as a
> fallback. Not really expected in the fast path.

I somehow misread it. So ignore me.

Thanks,

        tglx


