Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5FB2CAB90
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbgLATPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730253AbgLATPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:15:00 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F6DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:14:20 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id u2so1677404pls.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdocc321VZyr0ixZFcdnUEHMOpRJjTac2mIc24NQYwg=;
        b=Gf0MeNT55gxsCDRpeW4s7Kjs+enGX/dzKKeUTGutLyd+p2rqOpcAhEN/SvgHPXDnEU
         GY6MVPfHYEFhbrveN11MdgfgVReEmJflFhBeZOHZY0nRSD78gNKqUCySLJD73Zu1x/GJ
         Kr+6CCFtY46cY5vidIX/TmOo1zGqAMpCmORScNys91ZMSLuxkGHU/zB/x9/qyhu7vzPK
         4EJdslCc1En6Ai0BE414lPvEPpQgLVvMsp4U6bMmkBnp7Bc8xgVXafY/yrQmo4zry2k1
         EbMjBq5rM6zXdciQ7+by//EZiSuD2IZVYASSSmnckA71pNe6oGqBEVrWT9BtCgltlDE5
         JbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdocc321VZyr0ixZFcdnUEHMOpRJjTac2mIc24NQYwg=;
        b=oO9EhL2C9EvtWOyqgXSmD6g7YcZ9cUZkGIQlUWABKcIpsTINAK1IVojkCJu5E2EShh
         LRPxTE72QSb6TUUTBtZqINBxfDNNX9ABqVJE+pzalvF4uVS6WymTiXu0hAT+OofGRX79
         UNy59l7pgYCF3HUgt8MVbcZcrXQOWkdwVBlPf1Wuulp27qG8ZYixPqfcLcAjNsPs2+92
         47aKhOBiaN4g3kilmZSf9CFpPHo/+F/+JycPearbutVroG6TtXej4JF3mcWZKAcjg4ST
         qlBX/oVMecSXnKRKI2Ciszoy3n8Pd6k5VyTOM2D2L6YY3eekpfkJQvsiKFOFgdZ2Ar4M
         8caQ==
X-Gm-Message-State: AOAM530Fd5XHC1MOPcSADtb3tgo2uz9W2eGWTXQ1NJ0JiTkZOmk7VlpQ
        JfUyS2GGvsMW0wdTeXA7BaxJtyjORjLvM45gqA+xKA==
X-Google-Smtp-Source: ABdhPJxpM+h/Ol5ujwAYgDBAn/TNuW7lOCE47CRtxTYaM8G5O4s4TceUUL03NwreIEFaza+hHXQ+so6u+FO0ZPgJlZ8=
X-Received: by 2002:a17:90b:1287:: with SMTP id fw7mr4341953pjb.52.1606850059415;
 Tue, 01 Dec 2020 11:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20201130233504.3725241-1-axelrasmussen@google.com>
 <CALvZod42+o7naLOkpo9Jngmhru-aR4K6RCuTk7TukCikAYrDbQ@mail.gmail.com>
 <CAJHvVcgtoyJ_C0L=KByb8UbZm6x_RtCTnznYA1HwmdzX4Y=mHw@mail.gmail.com>
 <xr93lfehl8al.fsf@gthelen.svl.corp.google.com> <CALvZod4j9fFpGRfkios1ef0D5qhyw3XA_VSVm0k__RuMG1Qhwg@mail.gmail.com>
In-Reply-To: <CALvZod4j9fFpGRfkios1ef0D5qhyw3XA_VSVm0k__RuMG1Qhwg@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 1 Dec 2020 11:13:43 -0800
Message-ID: <CAJHvVchcm_HLd1RaibCZDZi27_2CVCwUWDX515dvnPPyTpHBHw@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: fix use-after-free race and css ref leak
 in tracepoints
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Greg Thelen <gthelen@google.com>,
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

On Tue, Dec 1, 2020 at 10:42 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, Dec 1, 2020 at 9:56 AM Greg Thelen <gthelen@google.com> wrote:
> >
> > Axel Rasmussen <axelrasmussen@google.com> wrote:
> >
> > > On Mon, Nov 30, 2020 at 5:34 PM Shakeel Butt <shakeelb@google.com> wrote:
> > >>
> > >> On Mon, Nov 30, 2020 at 3:43 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
> > >> >
> > >> > syzbot reported[1] a use-after-free introduced in 0f818c4bc1f3. The bug
> > >> > is that an ongoing trace event might race with the tracepoint being
> > >> > disabled (and therefore the _unreg() callback being called). Consider
> > >> > this ordering:
> > >> >
> > >> > T1: trace event fires, get_mm_memcg_path() is called
> > >> > T1: get_memcg_path_buf() returns a buffer pointer
> > >> > T2: trace_mmap_lock_unreg() is called, buffers are freed
> > >> > T1: cgroup_path() is called with the now-freed buffer
> > >>
> > >> Any reason to use the cgroup_path instead of the cgroup_ino? There are
> > >> other examples of trace points using cgroup_ino and no need to
> > >> allocate buffers. Also cgroup namespace might complicate the path
> > >> usage.
> > >
> > > Hmm, so in general I would love to use a numeric identifier instead of a string.
> > >
> > > I did some reading, and it looks like the cgroup_ino() mainly has to
> > > do with writeback, instead of being just a general identifier?
> > > https://www.kernel.org/doc/Documentation/cgroup-v2.txt
>
> I think you are confusing cgroup inodes with real filesystem inodes in that doc.
>
> > >
> > > There is cgroup_id() which I think is almost what I'd want, but there
> > > are a couple problems with it:
> > >
> > > - I don't know of a way for userspace to translate IDs -> paths, to
> > > make them human readable?
> >
> > The id => name map can be built from user space with a tree walk.
> > Example:
> >
> > $ find /sys/fs/cgroup/memory -type d -printf '%i %P\n'                                                                          # ~ [main]
> > 20387 init.scope
> > 31 system.slice
> >
> > > - Also I think the ID implementation we use for this is "dense",
> > > meaning if a cgroup is removed, its ID is likely to be quickly reused.
> > >
>
> The ID for cgroup nodes (underlying it is kernfs) are allocated from
> idr_alloc_cyclic() which gives new ID after the last allocated ID and
> wrap after around INT_MAX IDs. So, likeliness of repetition is very
> low. Also the file_handle returned by name_to_handle_at() for cgroupfs
> returns the inode ID which gives confidence to the claim of low chance
> of ID reusing.

Ah, for some reason I remembered it using idr_alloc(), but you're
right, it does use cyclical IDs. Even so, tracepoints which expose
these IDs would still be difficult to use I think. Say we're trying to
collect a histogram of lock latencies over the course of some test
we're running. At the end, we want to produce some kind of
human-readable report.

cgroups may come and go throughout the test. Even if we never re-use
IDs, in order to be able to map all of them to human-readable paths,
it seems like we'd need some background process to poll the
/sys/fs/cgroup/memory directory tree as Greg described, keeping track
of the ID<->path mapping. This seems expensive, and even if we poll
relatively frequently we might still miss short-lived cgroups.

Trying to aggregate such statistics across physical machines, or
reboots of the same machine, is further complicated. The machine(s)
may be running the same application, which runs in a container with
the same path, but it'll end up with different IDs. So we'd have to
collect the ID<->path mapping from each, and then try to match up the
names for aggregation.
