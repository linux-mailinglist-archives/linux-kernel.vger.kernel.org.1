Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A962F8C10
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 08:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbhAPHcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 02:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbhAPHcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 02:32:41 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA0FC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 23:32:01 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k10so9228541wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 23:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lv0Q0ZG2k0XarjtCa7ZP7FZ5J5VWQiF5JurI9cxCmsE=;
        b=pZRkHD4egpZCJuupaiDWd5DAABWpEmoYZ3GtLj0z0zPCUAY0i6eDiUGUsW+m9Spwrm
         oxTt5b53oP6A/AmSqjDobPkqOq5iosECKcTUfZOFyizQBjfncYBaEvu25iY/LjYEFDN3
         zK8rMcWxhslG4aEVX5TO3lfwuhuN0h4rhg+KRnNy7TQdSkrzuhC1JgUGM+Rw5/IX3y9Y
         QmXC2WIKnxc2cQ2ijSWWy014y1p6QlO0SgSd/ojQFSKQFggC4IkujncAeCd7VNPEYIuA
         tdgscFF5o2SpJdher2HXUUOGRRq3Q5ii1N42ql76traMO5EaQPzNytJ7NFkaYrIyRjiZ
         yW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lv0Q0ZG2k0XarjtCa7ZP7FZ5J5VWQiF5JurI9cxCmsE=;
        b=W1lvaqLzlJHO/5qYIi54MFNrm/3LQQcFxJxDTLIlhH2PHCOeNXGqmgnILXkj+5AtW+
         IXh6D6/ZWvnlKvXKbWzu8HgxqBZoNesfCWDPydPoUPULZBj0jivNkpTTPLtMUqBTtGSK
         5C7I7YMIzXhwbsfjfsdkHPQALdlvZfNa55QfrekgG/paGD5B1Kufcj7SBVhkZSUcOwZf
         YiZ+XVOp89kM2qr17EvDkOY5GOB5+j6RkM/ZhXwk0HRuerhXUfqjSiYdNiX8fUjJaA5F
         2OULNJXcXX8qBUJlJuphHpjo/gTQDLQk9CagLiLwGahYM36PNy7XXA66UXGU0TbuZaOI
         4+hw==
X-Gm-Message-State: AOAM531l6OhFUZwvmRuzvcTK8YD8aQchTEjJ3q9jp4cOsiNlE19ePcbi
        3pP8vtlydK8GxcXM4+oFgYWLwTpge/YYGLF9Vdo=
X-Google-Smtp-Source: ABdhPJybdb/oiakZDxpPukIuWOWzNrPXNBG26foJIC4f4HefRHFg4BKcMtGCe1GCshOG3xj2h2+trQMSkfy6lXe38rk=
X-Received: by 2002:a1c:e309:: with SMTP id a9mr6129327wmh.181.1610782319557;
 Fri, 15 Jan 2021 23:31:59 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPSAeerKjthXuVpae+CQ1kJu-kJLofX+-+UcTAGcNT6CWw@mail.gmail.com>
In-Reply-To: <CAM7-yPSAeerKjthXuVpae+CQ1kJu-kJLofX+-+UcTAGcNT6CWw@mail.gmail.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Sat, 16 Jan 2021 16:31:48 +0900
Message-ID: <CAM7-yPRCTdx9kN_q0evU6_yKu2r=q=vT7tfr95eoYUNKWEZNFA@mail.gmail.com>
Subject: Re: Question about qspinlock
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry.. I see spin_lock is running after preempt_disable.
Sorry to make a noise.

On Fri, Jan 15, 2021 at 11:03 AM Yun Levi <ppbuk5246@gmail.com> wrote:
>
> Hi Peter, Ingo, Will and linux-kernel.
>
> While I read the code of queued_spin_lock_slowpath function,
> I have some questions about an unrelated nesting case when qspinlock is waiting.
>
> Suppose there are CPU1 to CPU8.
> There are two locks named lock1 and lock2 which are not related to each other.
>
> At first, Thread 1 got a lock1.
> And Thread 2 and Thread 3 are contending to get lock1 and each waiting on
> CPU2 and CPU3.
>
> Next, Thread 5 got a lock2.
> And Thread 6 and Thread 7 are contending to get lock2 and each waiting on
> CPU6 and CPU7.
>
> In this situation, Thread 2 consumes all its quantum and switched new
> thread named "NTHREAD"
> But This NTHREAD tries to get lock2 and recognize someone is waiting on queue,
> and try to add itself to queue again.
>
> My questions are:
>     1. When this situation happens, the qnode idx will not be 0, but
> it seems to be nesting.
>          Could this situation happen or just my leak of understanding of code?
>
>     2. If (1) situation does not happen, why does it not happen?
>
>     3. If (1) situation can happen, lock contamination could be
> happened when more than
>         three threads waiting, unlocked one of them and another
> waiting again on same CPU.
>         So, how about making them wait as idx >= MAX_NODE when someone
> try to queuing,
>         But it try to lock different from one who queue in waiting other lock?
>
> My idea is:
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index b9515fcc9b29..fbb6e2effb59 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -106,6 +106,7 @@ struct qnode {
>   * PV doubles the storage and uses the second cacheline for PV state.
>   */
>  static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
> +static DEFINE_PER_CPU(struct qspinlock *, curr_lock);
>
>  /*
>   * We must be able to distinguish between no-tail and the tail at 0:0,
> @@ -315,6 +316,7 @@ static __always_inline u32
> __pv_wait_head_or_lock(struct qspinlock *lock,
>  void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  {
>   struct mcs_spinlock *prev, *next, *node;
> + struct qspinlock *saved_lock = NULL;
>   u32 old, tail;
>   int idx;
>
> @@ -401,6 +403,13 @@ void queued_spin_lock_slowpath(struct qspinlock
> *lock, u32 val)
>   idx = node->count++;
>   tail = encode_tail(smp_processor_id(), idx);
>
> + if (likely(!idx)) {
> + *this_cpu_ptr(&curr_lock) = lock;
> + saved_lock = lock;
> + } else {
> + saved_lock = *this_cpu_ptr(&curr_lock);
> + }
> +
>   /*
>   * 4 nodes are allocated based on the assumption that there will
>   * not be nested NMIs taking spinlocks. That may not be true in
> @@ -410,7 +419,7 @@ void queued_spin_lock_slowpath(struct qspinlock
> *lock, u32 val)
>   * any MCS node. This is not the most elegant solution, but is
>   * simple enough.
>   */
> - if (unlikely(idx >= MAX_NODES)) {
> + if (unlikely((idx >= MAX_NODES) || lock != saved_lock)) {
>   lockevent_inc(lock_no_node);
>   while (!queued_spin_trylock(lock))
>   cpu_relax();
> @@ -557,7 +566,8 @@ void queued_spin_lock_slowpath(struct qspinlock
> *lock, u32 val)
>   /*
>   * release the node
>   */
> - __this_cpu_dec(qnodes[0].mcs.count);
> + if (unlikely(saved_lock == lock))
> + __this_cpu_dec(qnodes[0].mcs.count);
>  }
>  EXPORT_SYMBOL(queued_spin_lock_slowpath);
>
> Thank you.
