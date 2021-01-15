Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7012F7057
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 03:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbhAOCE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 21:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731831AbhAOCE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 21:04:27 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D085C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 18:03:47 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c5so7727998wrp.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 18:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=10w8fJ7HUwCnTet+u7SjiINkkCL4v8L0zPFXzuJY7/Q=;
        b=gfy8hO3ayvWgysx/f330maw5p2uzTnd5PHPkzbbEYvfIpsTCmgdfF/CLGiCfn+mAeB
         EO/QjkaqNfLlj3LH326LoiEAygap647csZVHMBJkO57zoCvixZ6TxxuP3HHaN/NMZnK9
         Ll2+5/Pf1d/5cNMUIiBuOybODES31b8TFwj7clxLcBky25lweDyRJ6UkN0Q5H1bgtyib
         kPbYGoFdPV03Apjw3QbhwKQy5h3I2FWneglDQnTnhtq2yYlb7/JCCtoUDTsU7+VgsosV
         xDguIgi1RScYa48KJkkkQBV/q9Flo1Q+YgeIFJpfGCDPziKttWVZkiylZUHnQVCWaIQx
         hm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=10w8fJ7HUwCnTet+u7SjiINkkCL4v8L0zPFXzuJY7/Q=;
        b=IWohZbEmgZItxvnhRaHmuK2B4E3PnU9CdB+aOoirTlCERydejZaRYUt+nyMToCSNRD
         PYz8twZlFsbvvRLrFk5Q7KtWWna7OkhOfzu/88h0vmpBmZx3YYfveUotJ0PQBEJ8c0KW
         iYnvU2qcU/PiJmCq/viNSM8WSooPkIufmnlqBCNc9XHqS1uZT63oQiItSDa1Fsd95Epp
         V1kwqpuOYOsEvUjluScPZud8eHln/ogCRv6G7p+uvDdBZlQ8Ndx+0Yb76uyYKWJJLKjN
         vsMJFE+YWSVQ7kJYEA8K0qkFPz0+sAGrjc88QcpxAwI0M5eG5BxFlevLpZQvZcJycNxN
         mFnw==
X-Gm-Message-State: AOAM533gKvavXGlvs8d7Upozrd/TDA4/PHtAPxDT48JX/khhcyABh3RK
        pmNIVxkO3y2zJdeafnlTJhVni8BYk3zwIzm4bHo=
X-Google-Smtp-Source: ABdhPJy1V3b4B6RGgf7Js5sTPvPVKp6ALWuyN6hqeTADQHBy+3PXpjykR/U4fKrYge7TcFcT25jL/lS4NxtZkUKtsJU=
X-Received: by 2002:a5d:43ce:: with SMTP id v14mr10624515wrr.342.1610676225799;
 Thu, 14 Jan 2021 18:03:45 -0800 (PST)
MIME-Version: 1.0
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Fri, 15 Jan 2021 11:03:34 +0900
Message-ID: <CAM7-yPSAeerKjthXuVpae+CQ1kJu-kJLofX+-+UcTAGcNT6CWw@mail.gmail.com>
Subject: Question about qspinlock
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Ingo, Will and linux-kernel.

While I read the code of queued_spin_lock_slowpath function,
I have some questions about an unrelated nesting case when qspinlock is waiting.

Suppose there are CPU1 to CPU8.
There are two locks named lock1 and lock2 which are not related to each other.

At first, Thread 1 got a lock1.
And Thread 2 and Thread 3 are contending to get lock1 and each waiting on
CPU2 and CPU3.

Next, Thread 5 got a lock2.
And Thread 6 and Thread 7 are contending to get lock2 and each waiting on
CPU6 and CPU7.

In this situation, Thread 2 consumes all its quantum and switched new
thread named "NTHREAD"
But This NTHREAD tries to get lock2 and recognize someone is waiting on queue,
and try to add itself to queue again.

My questions are:
    1. When this situation happens, the qnode idx will not be 0, but
it seems to be nesting.
         Could this situation happen or just my leak of understanding of code?

    2. If (1) situation does not happen, why does it not happen?

    3. If (1) situation can happen, lock contamination could be
happened when more than
        three threads waiting, unlocked one of them and another
waiting again on same CPU.
        So, how about making them wait as idx >= MAX_NODE when someone
try to queuing,
        But it try to lock different from one who queue in waiting other lock?

My idea is:
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index b9515fcc9b29..fbb6e2effb59 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -106,6 +106,7 @@ struct qnode {
  * PV doubles the storage and uses the second cacheline for PV state.
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
+static DEFINE_PER_CPU(struct qspinlock *, curr_lock);

 /*
  * We must be able to distinguish between no-tail and the tail at 0:0,
@@ -315,6 +316,7 @@ static __always_inline u32
__pv_wait_head_or_lock(struct qspinlock *lock,
 void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
  struct mcs_spinlock *prev, *next, *node;
+ struct qspinlock *saved_lock = NULL;
  u32 old, tail;
  int idx;

@@ -401,6 +403,13 @@ void queued_spin_lock_slowpath(struct qspinlock
*lock, u32 val)
  idx = node->count++;
  tail = encode_tail(smp_processor_id(), idx);

+ if (likely(!idx)) {
+ *this_cpu_ptr(&curr_lock) = lock;
+ saved_lock = lock;
+ } else {
+ saved_lock = *this_cpu_ptr(&curr_lock);
+ }
+
  /*
  * 4 nodes are allocated based on the assumption that there will
  * not be nested NMIs taking spinlocks. That may not be true in
@@ -410,7 +419,7 @@ void queued_spin_lock_slowpath(struct qspinlock
*lock, u32 val)
  * any MCS node. This is not the most elegant solution, but is
  * simple enough.
  */
- if (unlikely(idx >= MAX_NODES)) {
+ if (unlikely((idx >= MAX_NODES) || lock != saved_lock)) {
  lockevent_inc(lock_no_node);
  while (!queued_spin_trylock(lock))
  cpu_relax();
@@ -557,7 +566,8 @@ void queued_spin_lock_slowpath(struct qspinlock
*lock, u32 val)
  /*
  * release the node
  */
- __this_cpu_dec(qnodes[0].mcs.count);
+ if (unlikely(saved_lock == lock))
+ __this_cpu_dec(qnodes[0].mcs.count);
 }
 EXPORT_SYMBOL(queued_spin_lock_slowpath);

Thank you.
