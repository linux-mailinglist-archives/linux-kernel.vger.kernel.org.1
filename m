Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8291E2F3454
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391852AbhALPjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390080AbhALPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:39:06 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432EAC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:38:26 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n16so1969981wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOV0cGnLD6qBCaGIE1shCotYjFdRckEKlehMf2yGT3A=;
        b=MEr0HxloIEPHfEmoiFNzUFdXLXaEw2f1dWq29ykQxfeYmboEkEjZYMNq19Indit8q8
         4stIuCbCSFNnuCCgoDxp+2befAdAuBKA/inBKs0CYrEHlI/FKrwoy8UlNsfuJdzm1+Kt
         RLnYJ1/oqZTEsqdmHVZjNyOq7mH/JMo5Zn9tiZTZmFEvV2k6d2kt09dzbNMQlOP7rv/3
         uofTB/8JmaUl4Q6FBRyFdPF0R95fO4GhlqpCAAwIkVywmgAkRRXFc2ok19W0RIAC/0tw
         /cqH8V1kDbxyRApcqdUKs2AwrkhWBy8DELbUgkKcmhYc7HkXwmEH2Y6RBKdU5zLz6uyH
         wDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOV0cGnLD6qBCaGIE1shCotYjFdRckEKlehMf2yGT3A=;
        b=Rw1V9gI/ZPx1WaJL0DBFaRbfXwuFSTC+NjLmRFu0gmbSvV4AHE7umdWV35LVedm5ff
         ItHbmB9Jd7IsCHDqeK6fRZ9KG4/P7wtql8OSDQN4O6819jWUuZ1B5KoZuTyKKERDTHFX
         d32Y71s8gMjS1YL8B1by+TGVgPHU9/o3YMe8uFel9ubU/3Hn1rVbcj1M+gZmLGgWcnrt
         tUixXdq1EzPq0m8a/F4bJSaV+yDySrUAjSjVQG1SvrBPgPU/uTOgscgS7WlRUwTGbxm+
         VfzFyF0HCdUTG2BvX1Dlk5K5IPu4X66C6lE6Sq/tidzagbJFLfWmpilAt/saLe0Oqfyq
         3GyQ==
X-Gm-Message-State: AOAM533BQM37WmUP4FCYS37VRuCEW8tKFdHMiORN2EMaejc2bOLuz3/d
        5HNySy0baXnHAAr6FjfoesMFCn3KF3gZR9+n7Js=
X-Google-Smtp-Source: ABdhPJyTHCrkmneZjZXvMC/1PfZ4MAcIeOdw0bU1UwpdCp8gsgg6xJVrtLJ2E80CEgefeGWz12JNB8WERg3hsN3nnW0=
X-Received: by 2002:a1c:5459:: with SMTP id p25mr3987843wmi.19.1610465904341;
 Tue, 12 Jan 2021 07:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20201226025117.2770-1-jiangshanlai@gmail.com> <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de> <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
 <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net> <jhj7doj1dr1.mognet@arm.com>
 <X/yzrJw4UbQsK3KB@hirez.programming.kicks-ass.net> <CAJhGHyA0rfR92W7T7RnhPrmLMkmV4Mb7fUSeG2VEHhsH-pSxsw@mail.gmail.com>
 <X/236obyM0nqL5+X@hirez.programming.kicks-ass.net>
In-Reply-To: <X/236obyM0nqL5+X@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 12 Jan 2021 23:38:12 +0800
Message-ID: <CAJhGHyDtku6PjLtkq7TGmcQnds5cakR6viki=bPoxxkdC0p-Tw@mail.gmail.com>
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

On Tue, Jan 12, 2021 at 10:53 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 12, 2021 at 12:33:03PM +0800, Lai Jiangshan wrote:
> > > Well yes, but afaict the workqueue stuff hasn't been settled yet, and
> > > the rcutorture patch Paul did was just plain racy and who knows what
> > > other daft kthread users are out there. That and we're at -rc3.
> >
> > I just send the V4 patchset for the workqueue.  Please take a look.
>
> Yes, I've seen it. But I think this approach is smaller and simpler.
>
> By distinguishing between geniuine per-cpu kthreads and kthreads that
> happen to have a single CPU affinity, things become much simpler and
> robust.

Again, fixing the problem of tasks running on dying cpu is easy.
(In other word, adjusting affinity correctly is easy, not matter adjusting
affinity initiatively like here or passively via new !KTHREAD_IS_PER_CPU)

For workqueue, Valentin Schneider patch can almost complete it, only
a small additional fix for percpu unbound workers needed.

And all four versions of my patchset can complete it.

But the hard problem is "how to suppress the warning of
online&!active in __set_cpus_allowed_ptr()" for late spawned
unbound workers during hotplug.

It is not handled completely until my fourth version patchset.

And your patchset ignores this theoretical case, I agree it is
Okay since no one has reported the warning in practice so far.

So something like CPUHP_AP_WORKQUEUE_UNBOUND_ONLINE is still needed
after your patchset merged.

Or you move the warning in __set_cpus_allowed_ptr() in deeper
places where the problem are really happen.
