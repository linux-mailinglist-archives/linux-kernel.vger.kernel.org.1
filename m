Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44AA2DA7D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 06:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgLOFqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 00:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgLOFpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 00:45:46 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DBFC06179C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 21:45:05 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id o6so6204027iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 21:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHVr1anWLI1TLmh52CW6dxKfzRz2cu/3qwp42HHkimw=;
        b=HIy5BGqaDr+XBHYAp/L7dFeWPr6nkiY26X7wYaiHL8F7E22SJh9o+0e6ydIAtESdJm
         WR0n8p12QwOUCWT32KdjIJD4nn9l/BAsBRYmkKiJgEOxxbaFlzFT6BE8q2i0yl1BDWaV
         xs9ua8dbT2q7d5JByx8u87XO5i+PzfhBU02HLmTox4tXYtigt+DrAIp06QMT5H1RltNi
         OlEZ74xHMlqK1twKSLvsrMKvIyJG04q/d1MZuTJ6WBwVBhT3qcjTl8iLErAt16d6vgzK
         z2NOJvEr7EVsU9ul8H1WgGzLthlEirYu/c/N/u4Op6XRLX05u6QWSrnb8bWM4bTrXK5h
         ACIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHVr1anWLI1TLmh52CW6dxKfzRz2cu/3qwp42HHkimw=;
        b=bEc3SHV/sb9YmFXvF+UBb3pVUplvg/gkU/2FtorOEM0s1IOw714JW5NZZ1V0bm5VJn
         E+1KbnUhyPWRctZesBhNM5MG2mIFBRN6IAcVF7M0wSRgWAo28Vto+G8OFRUvUbKX4cto
         w1/RrnmuXrtyMEmagVvg9za31hn0EhmDzOpF7oJVyx9DxIMeHtI5GqFYt721p6K0HlkB
         TQNRuVOj+Wfeo75oYQkJrr0OcLMWwfdcFuplEWJinG+GPyc64Go9fuQL7F0fs4qvxW++
         eGsrqKvZZlfyiD1oiBCJYAa7lQO6e3xy3YObe6hjQvy01P6CbyvU7gX2SDpRKKhxgc8W
         5VDQ==
X-Gm-Message-State: AOAM533FP+6MsZm5FQOuJ3/G+FfZPgDhE0IHn34e6aZxVMAtbItqkRw4
        wHTcTNjDxomEBRJATGDBgsSZ4MLXNgEcchm+awg=
X-Google-Smtp-Source: ABdhPJyTNaM+ngVBFXpphKUEeXysqG24CtFnlAG88S5ysQkeDs6iNdZN4mneEQ9ClPhUC3coOT5KgL6qb7c5aAfaLEo=
X-Received: by 2002:a5e:c811:: with SMTP id y17mr35734229iol.207.1608011104649;
 Mon, 14 Dec 2020 21:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20201214155457.3430-1-jiangshanlai@gmail.com> <X9eirnnrD/+VqqEo@hirez.programming.kicks-ass.net>
In-Reply-To: <X9eirnnrD/+VqqEo@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 15 Dec 2020 13:44:53 +0800
Message-ID: <CAJhGHyDYbU2=dQyiyx-AC+wu9=B7mTvsbU=QYPyV4xTE8PFPog@mail.gmail.com>
Subject: Re: [PATCH 00/10] workqueue: break affinity initiatively
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 1:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 14, 2020 at 11:54:47PM +0800, Lai Jiangshan wrote:
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > 06249738a41a ("workqueue: Manually break affinity on hotplug")
> > said that scheduler will not force break affinity for us.
> >
> > But workqueue highly depends on the old behavior. Many parts of the codes
> > relies on it, 06249738a41a ("workqueue: Manually break affinity on hotplug")
> > is not enough to change it, and the commit has flaws in itself too.
> >
> > We need to thoroughly update the way workqueue handles affinity
> > in cpu hot[un]plug, what is this patchset intends to do and
> > replace the Valentin Schneider's patch [1].
>
> So the actual problem is with per-cpu kthreads, the new assumption is
> that hot-un-plug will make all per-cpu kthreads for the dying CPU go
> away.

Hello, Peter

"new assumption" is all needed to be aligned. I haven't read the code.
I thought I understood to some extent which is enough for me to know
that workqueue does violate that.

Workqueue does not break affinity for all per-cpu kthreads in several
cases such as hot-un-plug and workers detaching from pool (those workers
will not be searchable from pools and should be handled alike to hot-un-plug).

But workqueue has not only per-cpu kthreads but also per-node threads.
And per-node threads may be bound to multiple CPUs or may be bound to
a single CPU. I don't know how the scheduler distinguishes all these
different cases under the "new assumption". But at least workqueue
handle these different cases at the same few places.  Since workqueue
have to "break affinity" for per-cpu kthreads, it can also "break affinity"
for other cases. Making workqueue totally do not rely on scheduler's
work to "break affinity" is worth doing since we have to do it for the
most parts.

I haven't read the code about "new assumption", if possible, I'll first
try to find out how will scheduler handle these cases:

If a per-node thread has only cpu 4, and when it goes down, does
workqueue need to "break affinity" for it?

If a per-node thread has only cpu 41,42, and when both go down, does
workqueue need to "break affinity" for it?

Thanks
Lai

>
> Workqueues violated that. I fixed the obvious site, and Valentin's patch
> avoids workqueues from quickly creating new ones while we're not
> looking.
>
> What other problems did you find?
