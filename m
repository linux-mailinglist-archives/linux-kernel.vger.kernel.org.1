Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD7D2CB19C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 01:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgLBAhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 19:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgLBAhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 19:37:31 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8860EC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 16:36:45 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y10so6506868ljc.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 16:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJhztdZynXb7tPEI36+ujzKI7+HaogLqrwHqJZ6xSGk=;
        b=owdHCrcJ8DWGtNg1gUGzdJYOz+JfjJI+BVPQw3DjEShWJfSVB7EeMno/mLpIndvihC
         wLz2gyFIwd/QB724Gn0PJRsp8yc4M/gCpND3Zp5PoQt6ZqjzDpUy9RWDQ3XyhUXEpq3r
         ml5D/mIrSRCo1XJLt9Ui/0VMcoy4Qy6EmvcuKWiWSX0Htw5R6q0mfZPxLqJ05cit2gJJ
         gZN+JbTsS9nkkH83MaULxOwHZOHOatoe6th68DZ6zeuKI5YkgMH5SzgoyXdWGg+f3B02
         v/d6+4+6DG6Cl3s2eUgLbChJbwGvI2b3tf6sO9N3843lcOxOCa4LUnFRra3hZ5lS4D+h
         vFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJhztdZynXb7tPEI36+ujzKI7+HaogLqrwHqJZ6xSGk=;
        b=qKX8GwId87oswj0JK4E8iur1VIh651T2+GcWYzel/sQC/fKntoj5CXny0VKIuo4G73
         Bpt3ZUFCWB7HtysW4EdKJ2GQir7UGm0Beor9T5yYxlE9aNEJIhIAgUVQ/ziMwOrt7HbB
         4K8itnj4wl275C00udykXHqjmhl9ry1CqcSRn7jzgaEP0xYA4x3lPC9AQu+i71EpaglD
         YdWraZf++Jxxj6j9xNk+cPXrYRQjfyPr71t69PAlSSSzbbNEbVvDcY6s2o3Hs2ZCqScn
         a1uHCCYt/wxyJKrNPM33k4T+X+nVDlVsposhlGNeS0bEMAGTq/wShxygfFauuojg/Euz
         ldvg==
X-Gm-Message-State: AOAM532BIX0BqFjd14kO+59z3awTkCI3GNP5R+xuhBgUEhJ3XLMXyRFI
        jurqcFpV0ifU0xjVFAptbZxFGbmVFQ0V+CUuWbh70A==
X-Google-Smtp-Source: ABdhPJx56U3HGwLozDT7g65P6Eu9H5HaAcE6TATV6De2j5p0V6cIQEMtJGbtS5WtuhBSe+AUqOxlM/Jk0EBkmwozYvk=
X-Received: by 2002:a2e:9746:: with SMTP id f6mr11918ljj.270.1606869403687;
 Tue, 01 Dec 2020 16:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20201130233504.3725241-1-axelrasmussen@google.com>
 <CALvZod42+o7naLOkpo9Jngmhru-aR4K6RCuTk7TukCikAYrDbQ@mail.gmail.com>
 <CAJHvVcgtoyJ_C0L=KByb8UbZm6x_RtCTnznYA1HwmdzX4Y=mHw@mail.gmail.com>
 <xr93lfehl8al.fsf@gthelen.svl.corp.google.com> <CALvZod4j9fFpGRfkios1ef0D5qhyw3XA_VSVm0k__RuMG1Qhwg@mail.gmail.com>
 <CAJHvVchcm_HLd1RaibCZDZi27_2CVCwUWDX515dvnPPyTpHBHw@mail.gmail.com>
 <CALvZod5CpPhvzB99VZTc33Sb5YCbJNHFe3k33k+HwNfJvJbpJQ@mail.gmail.com> <CAJHvVcjBErccEwNjuDqzsrbuzSmJva7uknZKhtBwWfs9_t4zTg@mail.gmail.com>
In-Reply-To: <CAJHvVcjBErccEwNjuDqzsrbuzSmJva7uknZKhtBwWfs9_t4zTg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 1 Dec 2020 16:36:32 -0800
Message-ID: <CALvZod6qpbEX+kp_gh5O4U1-kc+DfoG4DnGoWMvVnuXUOTLBBg@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: fix use-after-free race and css ref leak
 in tracepoints
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Greg Thelen <gthelen@google.com>,
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
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 4:16 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> On Tue, Dec 1, 2020 at 12:53 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > +Tejun Heo
> >
> > On Tue, Dec 1, 2020 at 11:14 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
> > >
> > > On Tue, Dec 1, 2020 at 10:42 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > >
> > > > On Tue, Dec 1, 2020 at 9:56 AM Greg Thelen <gthelen@google.com> wrote:
> > > > >
> > > > > Axel Rasmussen <axelrasmussen@google.com> wrote:
> > > > >
> > > > > > On Mon, Nov 30, 2020 at 5:34 PM Shakeel Butt <shakeelb@google.com> wrote:
> > > > > >>
> > > > > >> On Mon, Nov 30, 2020 at 3:43 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
> > > > > >> >
> > > > > >> > syzbot reported[1] a use-after-free introduced in 0f818c4bc1f3. The bug
> > > > > >> > is that an ongoing trace event might race with the tracepoint being
> > > > > >> > disabled (and therefore the _unreg() callback being called). Consider
> > > > > >> > this ordering:
> > > > > >> >
> > > > > >> > T1: trace event fires, get_mm_memcg_path() is called
> > > > > >> > T1: get_memcg_path_buf() returns a buffer pointer
> > > > > >> > T2: trace_mmap_lock_unreg() is called, buffers are freed
> > > > > >> > T1: cgroup_path() is called with the now-freed buffer
> > > > > >>
> > > > > >> Any reason to use the cgroup_path instead of the cgroup_ino? There are
> > > > > >> other examples of trace points using cgroup_ino and no need to
> > > > > >> allocate buffers. Also cgroup namespace might complicate the path
> > > > > >> usage.
> > > > > >
> > > > > > Hmm, so in general I would love to use a numeric identifier instead of a string.
> > > > > >
> > > > > > I did some reading, and it looks like the cgroup_ino() mainly has to
> > > > > > do with writeback, instead of being just a general identifier?
> > > > > > https://www.kernel.org/doc/Documentation/cgroup-v2.txt
> > > >
> > > > I think you are confusing cgroup inodes with real filesystem inodes in that doc.
> > > >
> > > > > >
> > > > > > There is cgroup_id() which I think is almost what I'd want, but there
> > > > > > are a couple problems with it:
> > > > > >
> > > > > > - I don't know of a way for userspace to translate IDs -> paths, to
> > > > > > make them human readable?
> > > > >
> > > > > The id => name map can be built from user space with a tree walk.
> > > > > Example:
> > > > >
> > > > > $ find /sys/fs/cgroup/memory -type d -printf '%i %P\n'                                                                          # ~ [main]
> > > > > 20387 init.scope
> > > > > 31 system.slice
> > > > >
> > > > > > - Also I think the ID implementation we use for this is "dense",
> > > > > > meaning if a cgroup is removed, its ID is likely to be quickly reused.
> > > > > >
> > > >
> > > > The ID for cgroup nodes (underlying it is kernfs) are allocated from
> > > > idr_alloc_cyclic() which gives new ID after the last allocated ID and
> > > > wrap after around INT_MAX IDs. So, likeliness of repetition is very
> > > > low. Also the file_handle returned by name_to_handle_at() for cgroupfs
> > > > returns the inode ID which gives confidence to the claim of low chance
> > > > of ID reusing.
> > >
> > > Ah, for some reason I remembered it using idr_alloc(), but you're
> > > right, it does use cyclical IDs. Even so, tracepoints which expose
> > > these IDs would still be difficult to use I think.
> >
> > The writeback tracepoint in include/trace/events/writeback.h is
> > already using the cgroup IDs. Actually it used to use cgroup_path but
> > converted to cgroup_ino.
> >
> > Tejun, how do you use these tracepoints?
> >
> > > Say we're trying to
> > > collect a histogram of lock latencies over the course of some test
> > > we're running. At the end, we want to produce some kind of
> > > human-readable report.
> > >
> >
> > I am assuming the test infra and the tracing infra are decoupled
> > entities and test infra is orchestrating the cgroups as well.
> >
> > > cgroups may come and go throughout the test. Even if we never re-use
> > > IDs, in order to be able to map all of them to human-readable paths,
> > > it seems like we'd need some background process to poll the
> > > /sys/fs/cgroup/memory directory tree as Greg described, keeping track
> > > of the ID<->path mapping. This seems expensive, and even if we poll
> > > relatively frequently we might still miss short-lived cgroups.
> > >
> > > Trying to aggregate such statistics across physical machines, or
> > > reboots of the same machine, is further complicated. The machine(s)
> > > may be running the same application, which runs in a container with
> > > the same path, but it'll end up with different IDs. So we'd have to
> > > collect the ID<->path mapping from each, and then try to match up the
> > > names for aggregation.
> >
> > How about adding another tracepoint in cgroup_create which will output
> > the ID along with the name or path? With a little post processing you
> > can get the same information. Also note that if the test is
> > deleting/creating the cgroup with the same name, you will miss that
> > information if filtering with just path.
> >
> > IMHO cgroup IDs will make the kernel code much simpler with the
> > tradeoff of a bit more work in user space.
>
> I like this idea! I think userspace can use the synthetic trace event
> API to construct an event which includes the strings, like the one
> I've added, if we had this separate ID<->path mapping tracepoint. If
> so, it would be just as easy for userspace to use, but it would let us
> deal with integer IDs everywhere else in the kernel, and keep the
> complexity related to dealing with buffers limited to just one place.
>
> That said, I'd prefer to pursue this as a follow-up thing, rather than
> as part of fixing this bug. Seem reasonable?

SGTM but note that usually Andrew squash all the patches into one
before sending to Linus. If you plan to replace the path buffer with
integer IDs then no need to spend time fixing buffer related bug.
