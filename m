Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDAC2A0355
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgJ3KxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgJ3KxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:53:12 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65220C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:53:12 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id l2so7336470lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGxKu6N/ljpRrMPYO1GHJVR+cRftYgBFEsOMeaX+uIU=;
        b=jZND6rDLmrO9spICzgJTCgUyIjDgF2iwHIqFMlTUr5c9lYncRHD31/x/7EQi8MjLrT
         uCRhE0xLq1LIUI/SSr+wlB7wQUcMXvAaLBBVYkc80DlaSVmw2nlcyDEh7KQtFUjODJfH
         QdvLS+s3ocJFBCsofDUuwLvK2t30YKuqtpn8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGxKu6N/ljpRrMPYO1GHJVR+cRftYgBFEsOMeaX+uIU=;
        b=Yth2dvxeoYFtgH3y/WwT99HcCRB8857b0p/4HX540xfW8PeRMZWO/hqSQij5/Iw+ay
         xRqKXnSvhScn+ObP22Go7ZDymiRkqyRmhA9ybQzrUoj5JaWS/EJZmSo0ZzFz3ttm4/FN
         ansnJRL/o7VEU8RITjoODFjVhyeoChk2RCanTnGyvXQWSeNqzh12BQQUa6vcoJSIq8Ve
         o3CpZ4nMQB4WV4i8Ha/Hq5MrovacuNoR4NeDnLQ/ti7NitF6B78u64rKSyiw3VV6bXtp
         H42qQtZQZYhYDiJo1kO0hn7YTlB88ncWuulCiV/JVbRD3inXICIw6aC3isk851Y9pv5E
         UAbw==
X-Gm-Message-State: AOAM531XAgrE71CWba9mddgTbnscLu2tQi4U9ywque2UKESd+ZsakLHA
        oxn2bg2E0k3v1LLg7/pOmwzYyk5iVHV9GOcL7ZnzqQ==
X-Google-Smtp-Source: ABdhPJyn8C/IW8kpR0WGiynCq34PNMOu9BFU7lnVDmeeTtH6KSiBOtCcj00bW85p7RR18fFKc7htyMPhRGrh8t1bYY4=
X-Received: by 2002:a19:c80a:: with SMTP id y10mr736934lff.329.1604055190871;
 Fri, 30 Oct 2020 03:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201027170317.2011119-1-kpsingh@chromium.org>
 <20201027170317.2011119-2-kpsingh@chromium.org> <20201028011321.4yu62347lfzisxwy@kafai-mbp>
In-Reply-To: <20201028011321.4yu62347lfzisxwy@kafai-mbp>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 30 Oct 2020 11:53:00 +0100
Message-ID: <CACYkzJ5VU2Pd2ZiY7AKJM0yZ2NsDbQOu1Y_FYwkBv6M6NFvkcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Implement task local storage
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking a look!

On Wed, Oct 28, 2020 at 2:13 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Oct 27, 2020 at 06:03:13PM +0100, KP Singh wrote:
> [ ... ]
>
> > diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> > new file mode 100644
> > index 000000000000..774140c458cc
> > --- /dev/null
> > +++ b/kernel/bpf/bpf_task_storage.c
> > @@ -0,0 +1,327 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2019 Facebook
> > + * Copyright 2020 Google LLC.
> > + */
> > +
> > +#include "linux/pid.h"
> > +#include "linux/sched.h"
> > +#include <linux/rculist.h>
> > +#include <linux/list.h>
> > +#include <linux/hash.h>
> > +#include <linux/types.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/bpf.h>
> > +#include <linux/bpf_local_storage.h>
> > +#include <net/sock.h>
> Is this required?

Nope. Removed.

>
> > +#include <uapi/linux/sock_diag.h>
> > +#include <uapi/linux/btf.h>
> > +#include <linux/bpf_lsm.h>
> > +#include <linux/btf_ids.h>
> > +#include <linux/fdtable.h>
> > +
> > +DEFINE_BPF_STORAGE_CACHE(task_cache);
> > +
> > +static struct bpf_local_storage __rcu **task_storage_ptr(void *owner)

[...]

> > +             err = -EBADF;
> > +             goto out_fput;
> > +     }
> > +
> > +     pid = get_pid(f->private_data);
> n00b question. Is get_pid(f->private_data) required?
> f->private_data could be freed while holding f->f_count?

I would assume that holding a reference to the file should also
keep the private_data alive but I was not sure so I grabbed the
extra reference.

>
> > +     task = get_pid_task(pid, PIDTYPE_PID);
> Should put_task_struct() be called before returning?

If we keep using get_pid_task then, yes, I see it grabs a reference to the task.
We could also call pid_task under rcu locks but it might be cleaner to
just get_pid_task
and put_task_struct().

>
> > +     if (!task || !task_storage_ptr(task)) {
> "!task_storage_ptr(task)" is unnecessary, task_storage_lookup() should
> have taken care of it.
>
>
> > +             err = -ENOENT;
> > +             goto out;
> > +     }
> > +
> > +     sdata = task_storage_lookup(task, map, true);
> > +     put_pid(pid);

[...]

> > +     .map_lookup_elem = bpf_pid_task_storage_lookup_elem,
> > +     .map_update_elem = bpf_pid_task_storage_update_elem,
> > +     .map_delete_elem = bpf_pid_task_storage_delete_elem,
> Please exercise the syscall use cases also in the selftest.

Will do. Thanks for the nudge :)

>
> > +     .map_check_btf = bpf_local_storage_map_check_btf,
> > +     .map_btf_name = "bpf_local_storage_map",
> > +     .map_btf_id = &task_storage_map_btf_id,
> > +     .map_owner_storage_ptr = task_storage_ptr,
> > +};
> > +
