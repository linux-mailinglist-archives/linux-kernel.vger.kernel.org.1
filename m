Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4499273206
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 20:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgIUSft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 14:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbgIUSfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:35:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F650C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 11:35:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y11so15170471lfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3H9YpzDr3X14drRKvlsAvX8RY4KyoutkJwxcViMFMG0=;
        b=Bz7ry4ySbRwuYNfkv8MA3P25Tm4sboS1EyBeIbPxTS95Tibu6ZeKhSab9D2NlWuSHo
         K8fWaOuqX8HdN99oAHbq+wxMgJBxqDEQQI868X8cwp851LpiN2Ix3/m1KBvSKaZkBYZm
         E9oMpti6SOjVVL3NhvyIyFaQUu8ZBSzypfM/XRXSJwygb5hMHriyByWNY41QR6NffMsv
         odvk3FBsiDKpQQN7QITKFswvw3glMGEA4uDEQSr0AJxaB1FKgmyOVUW2efTsLEfzPTRd
         rHzlXZfDCdRuEl5xekhmcP7Hl1lUizR0y21RUV5vvgoW3esEpP+giRu6YI56Q9EF/SJ4
         Wfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3H9YpzDr3X14drRKvlsAvX8RY4KyoutkJwxcViMFMG0=;
        b=cGt0lx95LMsrS9WzhjwEM21qf28+J15OW6+bpPRsk8Uz5+u5WdkGmCo3h8LXJuii3f
         FzMTng6J+90y56MCFh0BB8J0pBTSSrbhoC2XDf7SJktwVDXkZkKQC9YNeogIS6BoEYtv
         W2fLvV3pbYeeJPZgm5Ocw7qTkTLx+dj4GV1fSIJkufIe8FfrQLzuh7/ldSjNfkobAl+L
         3bnzobU9qjiEytKNDua2+EOaVuxfVD0CKUqXD9Gbfl6tG1IQALHJdqJN1Nbp85c8cVeL
         034QQPOSRRo2+odxpR+3p8mTJT5gg8GbBWfhcBkD51P0Ox8SPcFin1tIa+ZuIL/K7H8Y
         Sq3Q==
X-Gm-Message-State: AOAM532Hbz6B8cdFrc0F6v9boU9f7Ip8W+LgXFcRwENmSv4HSlecHAvm
        lOC0EgfQ4dIvoWHbneVrCaiAI/TVW8YBy1ReviVzpw==
X-Google-Smtp-Source: ABdhPJzsyCPBprfsxiAiUfFR8p+6qGQcPalMI5+O6KDG52jXfAzHBi7otkfbS75L7R3lmE3ItdrcmFtvBekvC6HeML8=
X-Received: by 2002:a19:604e:: with SMTP id p14mr360359lfk.385.1600713346547;
 Mon, 21 Sep 2020 11:35:46 -0700 (PDT)
MIME-Version: 1.0
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 21 Sep 2020 11:35:35 -0700
Message-ID: <CALvZod4FWLsV9byrKQojeus7tMDhHjQHFF5J_JpNsyB0HkaERA@mail.gmail.com>
Subject: Machine lockups on extreme memory pressure
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We are seeing machine lockups due extreme memory pressure where the
free pages on all the zones are way below the min watermarks. The stack
of the stuck CPU looks like the following (I had to crash the machine to
get the info).

 #0 [ ] crash_nmi_callback
 #1 [ ] nmi_handle
 #2 [ ] default_do_nmi
 #3 [ ] do_nmi
 #4 [ ] end_repeat_nmi
--- <NMI exception stack> ---
 #5 [ ] queued_spin_lock_slowpath
 #6 [ ] _raw_spin_lock
 #7 [ ] ____cache_alloc_node
 #8 [ ] fallback_alloc
 #9 [ ] __kmalloc_node_track_caller
#10 [ ] __alloc_skb
#11 [ ] tcp_send_ack
#12 [ ] tcp_delack_timer
#13 [ ] run_timer_softirq
#14 [ ] irq_exit
#15 [ ] smp_apic_timer_interrupt
#16 [ ] apic_timer_interrupt
--- <IRQ stack> ---
#17 [ ] apic_timer_interrupt
#18 [ ] _raw_spin_lock
#19 [ ] vmpressure
#20 [ ] shrink_node
#21 [ ] do_try_to_free_pages
#22 [ ] try_to_free_pages
#23 [ ] __alloc_pages_direct_reclaim
#24 [ ] __alloc_pages_nodemask
#25 [ ] cache_grow_begin
#26 [ ] fallback_alloc
#27 [ ] __kmalloc_node_track_caller
#28 [ ] __alloc_skb
#29 [ ] tcp_sendmsg_locked
#30 [ ] tcp_sendmsg
#31 [ ] inet6_sendmsg
#32 [ ] ___sys_sendmsg
#33 [ ] sys_sendmsg
#34 [ ] do_syscall_64

These are high traffic machines. Almost all the CPUs are stuck on the
root memcg's vmpressure sr_lock and almost half of the CPUs are stuck
on kmem cache node's list_lock in the IRQ. Note that the vmpressure
sr_lock is irq-unsafe. Couple of months back, we observed a similar
situation with swap locks which forces us to disable swap on global
pressure. Since we do proactive reclaim disabling swap on global reclaim
was not an issue. However now we have started seeing the same situation
with other irq-unsafe locks like vmpressure sr_lock and almost all the
slab shrinkers have irq-unsafe spinlocks. One of way to mitigate this
is by converting all such locks (which can be taken in reclaim path)
to be irq-safe but it does not seem like a maintainable solution.

Please note that we are running user space oom-killer which is more
aggressive than oomd/PSI but even that got stuck under this much memory
pressure.

I am wondering if anyone else has seen a similar situation in production
and if there is a recommended way to resolve this situation.

thanks,
Shakeel
