Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F1F2CAAF9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbgLASn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbgLASnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:43:25 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A441C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:42:45 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id s30so6340405lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqRLOgSSngXxVOAnfQD6a3wxBRwbRfpA188t/eorU38=;
        b=oAYolcRUtyNOlu0qSVv9Jzn8JQGLUSsJ03RWOe9OxC2Nzt5xRJaiAXD4o1C0r+vXPk
         rcAjVmhdD0PYgZ1Yvc8/SPAFJvo8M0zpnADTTXIUgujIEPSI9ozeIxf/ELYL9cnLlJiF
         VsE899d9HynbBpdG7klJ2iHsY1/eWAoqbQpu7LWYfyYALrbwAhh7TXNF7O9NUviLz6BP
         /fv6K0jKlZbLk7m4S9gcCmezGFJp1Ib8Ea4y7n1VF7p4SdiMrpIjTNnYJ7xBJT6D46lx
         DPRgSsb13ZKt+ZJg46xwcl7JwhDbnMNFFddp1WsYhjdYfclJcvvwBtphrMjYFIpOMYWN
         VHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqRLOgSSngXxVOAnfQD6a3wxBRwbRfpA188t/eorU38=;
        b=r9gZymYFg50G85h3CPRlulJncY/xtn0B2xhJbCOu3hyJGzpUK4ARtwQinyV7iSSP0O
         k+c3WA3qJgvDeP8CO/+AbVE4w2pJQlX/GpO6Cb7PfG5frXiGvm/PP+k74eq5sfA9UYUx
         /qFoAxCO8CvcQjCTiAsHT1uiaP2+0bb3tHnguCmP9yMSwCrmbmIg7Ezd3FLdRXujlVlX
         YWz3+4Kzhd0f91nQ1TkjAkxEZN6aIjNaW/T2feGimbJYgA1Z3lphVgS9+DHokMmdaJCq
         m4HPPdHM30kzfoBUKLMD9Qjb1Xj3o4F8yG0zR1DD+y4QjtBI7vhGjEJzRKLdS/gGbuOk
         qvkA==
X-Gm-Message-State: AOAM532sPUkDtPyHN9Tkjx3QcQdoWiHZjnA3XyNL3PCC2Y/l28heRSRd
        0Xv1tjooAciEj787XzFWo8j1U/mQXpclq4SIH6HyvA==
X-Google-Smtp-Source: ABdhPJyWVpDI64oBV7dbda0j6ihNwr7zrEY7XH0lQbOlrGGo5/ieutK3kSEwUhNKpELSlEioU8Gl2Pnhfu/q2v/w5W4=
X-Received: by 2002:a19:be4a:: with SMTP id o71mr1723950lff.494.1606848163219;
 Tue, 01 Dec 2020 10:42:43 -0800 (PST)
MIME-Version: 1.0
References: <20201130233504.3725241-1-axelrasmussen@google.com>
 <CALvZod42+o7naLOkpo9Jngmhru-aR4K6RCuTk7TukCikAYrDbQ@mail.gmail.com>
 <CAJHvVcgtoyJ_C0L=KByb8UbZm6x_RtCTnznYA1HwmdzX4Y=mHw@mail.gmail.com> <xr93lfehl8al.fsf@gthelen.svl.corp.google.com>
In-Reply-To: <xr93lfehl8al.fsf@gthelen.svl.corp.google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 1 Dec 2020 10:42:31 -0800
Message-ID: <CALvZod4j9fFpGRfkios1ef0D5qhyw3XA_VSVm0k__RuMG1Qhwg@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: fix use-after-free race and css ref leak
 in tracepoints
To:     Greg Thelen <gthelen@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <walken@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yafang Shao <laoar.shao@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, dsahern@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>, liuhangbin@gmail.com,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 9:56 AM Greg Thelen <gthelen@google.com> wrote:
>
> Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> > On Mon, Nov 30, 2020 at 5:34 PM Shakeel Butt <shakeelb@google.com> wrote:
> >>
> >> On Mon, Nov 30, 2020 at 3:43 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
> >> >
> >> > syzbot reported[1] a use-after-free introduced in 0f818c4bc1f3. The bug
> >> > is that an ongoing trace event might race with the tracepoint being
> >> > disabled (and therefore the _unreg() callback being called). Consider
> >> > this ordering:
> >> >
> >> > T1: trace event fires, get_mm_memcg_path() is called
> >> > T1: get_memcg_path_buf() returns a buffer pointer
> >> > T2: trace_mmap_lock_unreg() is called, buffers are freed
> >> > T1: cgroup_path() is called with the now-freed buffer
> >>
> >> Any reason to use the cgroup_path instead of the cgroup_ino? There are
> >> other examples of trace points using cgroup_ino and no need to
> >> allocate buffers. Also cgroup namespace might complicate the path
> >> usage.
> >
> > Hmm, so in general I would love to use a numeric identifier instead of a string.
> >
> > I did some reading, and it looks like the cgroup_ino() mainly has to
> > do with writeback, instead of being just a general identifier?
> > https://www.kernel.org/doc/Documentation/cgroup-v2.txt

I think you are confusing cgroup inodes with real filesystem inodes in that doc.

> >
> > There is cgroup_id() which I think is almost what I'd want, but there
> > are a couple problems with it:
> >
> > - I don't know of a way for userspace to translate IDs -> paths, to
> > make them human readable?
>
> The id => name map can be built from user space with a tree walk.
> Example:
>
> $ find /sys/fs/cgroup/memory -type d -printf '%i %P\n'                                                                          # ~ [main]
> 20387 init.scope
> 31 system.slice
>
> > - Also I think the ID implementation we use for this is "dense",
> > meaning if a cgroup is removed, its ID is likely to be quickly reused.
> >

The ID for cgroup nodes (underlying it is kernfs) are allocated from
idr_alloc_cyclic() which gives new ID after the last allocated ID and
wrap after around INT_MAX IDs. So, likeliness of repetition is very
low. Also the file_handle returned by name_to_handle_at() for cgroupfs
returns the inode ID which gives confidence to the claim of low chance
of ID reusing.
