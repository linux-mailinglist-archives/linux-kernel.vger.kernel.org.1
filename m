Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0692EA36C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 03:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbhAECmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbhAECmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:42:00 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E389DC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 18:41:19 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id w18so26977958iot.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 18:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GcsC8lp175/RSBxacvCaBbl9ftLmbMsKR9zwf/ifHzg=;
        b=SLcWXupBZc8HMhM+91+H2UlhEKcVksMphM8CG5/Q8gZUo+5VUDuaot1HWck411dKSg
         ZZnjYMTwChIQ7K5y12TC4tkiEb4MWdUgtQ/gcByWPsQNRASSKNkA4mfNib1b6AJVQHdV
         yH0WuXERXI/dWbY3dRON7zFZzTZzuVctpNQvzxZbP/N2TElc7PWkOvZj6tTOnV5fBWC2
         OGUl5aepNIk831CToxOMhRH4YwcbKZiRFX+v/30037mtbBz1XzDj0yFoQNU7Ky6a+CW7
         6eL9FFBzCTtp0bG7T3MBBeiwyCDErQnn64tbf3GFU79aSayd9iU0H/IMyUbnQUPHMoDF
         n65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GcsC8lp175/RSBxacvCaBbl9ftLmbMsKR9zwf/ifHzg=;
        b=Y3NtVgY6idY9KBccs8mCBw5Hf1S+JjjL140/CkzoThc9cCmXkMguLpyCf4utG9wMvr
         xwJz+nYz4ih7dye0grb9aQEz3FAu6ZhBO7rXHZdOxdyszaOwU0j8/cBv5N3l/qixRot0
         BfthFk+u7tnN0Dx+b1fLRk/KKn4GAAFJVJy8oW7Zuvl/oU+5KEgFBoOY6YYBqUljJ+Vf
         pXr1XnEo2h8cb3r83UVPQvOsz1xaucxX3Zux68PB+Kp1zsVWfZ1nFuaJeIg0aSzTbAvO
         0dYF2jfG7NhkTM5xzOJ6NzN65q7dHiDIB+60ZlMFXgjhyy2wn2Bh2fR9vkTN4weuBcbo
         r5oA==
X-Gm-Message-State: AOAM532CCJfn7XTHuAJjOYKHzWUkyrfejkVGRRrmf7REwCPk9BLsdhbx
        ihg2RC2LDAZjcuQZVegjt5DKwI6YAsNexiBOVOc=
X-Google-Smtp-Source: ABdhPJw098+0w73Etaf/YEk5an/KfZ2f4rdPkMsKtsXMfSj6cyHJh3/2cMtaNszffXADxcbvrsO7JyHT8MbZFVJQ+HI=
X-Received: by 2002:a02:ccdc:: with SMTP id k28mr62694993jaq.137.1609814478958;
 Mon, 04 Jan 2021 18:41:18 -0800 (PST)
MIME-Version: 1.0
References: <20201226025117.2770-1-jiangshanlai@gmail.com> <20201226025117.2770-4-jiangshanlai@gmail.com>
 <20210104135649.GO3021@hirez.programming.kicks-ass.net>
In-Reply-To: <20210104135649.GO3021@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 5 Jan 2021 10:41:07 +0800
Message-ID: <CAJhGHyB_MUHG8GGANcN9sQbjY7M5m8WPHQgXp-PmkGK481M5Tg@mail.gmail.com>
Subject: Re: [PATCH -tip V3 3/8] workqueue: introduce wq_online_cpumask
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 9:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Dec 26, 2020 at 10:51:11AM +0800, Lai Jiangshan wrote:
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > wq_online_cpumask is the cached result of cpu_online_mask with the
> > going-down cpu cleared.
>
> You can't use cpu_active_mask ?


When a cpu is going out:
(cpu_active_mask is not protected by workqueue mutexs.)

create_worker() for unbound pool  |  cpu offlining
check cpu_active_mask             |
                                  |  remove bit from cpu_active_mask
                                  |  no cpu in pool->attrs->cpumask is active
set pool->attrs->cpumask to worker|
and hit the warning


And when a cpu is onlining, there may be some workers which were just created
after the workqueue hotplug callback is finished but before cpu_active_mask
was updated. workqueue has not call back after cpu_active_mask updated and
these workers' cpumask is not updated.

For percpu workers, these problems can be handled with the help of
POOL_DISASSOCIATED which is protected by workqueue mutexs and the
help of sched/core.c which doesn't warn when per-cpu-kthread.

For unbound workers, the way to handle it without using wq_online_cpumask
is much more complex when a cpu is going out.
