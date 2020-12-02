Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4A2CB160
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 01:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgLBAQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 19:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgLBAQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 19:16:49 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BF6C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 16:16:09 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id v21so69340plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 16:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rddYXQ1chSQ/44aNOoY5OL8nU9RA9keQX0WiJ5lfxfQ=;
        b=XWzEmZRA/24EkGOCsHIExgHVCGM9YmwB9JIPFRYPMGf7zDZXGKiZ4KXQOByL3YtduH
         /noTuKybEyPggK0pfBBIppk9Ig7Xn7HfK9rDbjFzOxJVUGUIaXmZuJ59Ln5kTd8MGzv2
         B8NTtM+/84Df5axGLpqgQwisyYIVIqm6RM6rjTw86R8di1H/vVx0zkqLTOMgL6UF2iXY
         KbiBvkg1EVLuGjNrd9Z5ivzr9AaNB0qPhsmSTTot1INbUH7Fn13M1svjJY0G7Uvi3Mez
         S7F1zE1w7CvdwH08CqLprnv/fK/3ns5xe1SVvjdRiJHueCtPoN3oWKQOMA9O9Qsu5Om4
         7clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rddYXQ1chSQ/44aNOoY5OL8nU9RA9keQX0WiJ5lfxfQ=;
        b=VxKbNQr9nCeodhHczmPPfvfmfDI1L++OeDXLZRFPKQzb/6FWKCqxq569PQUBhl1m7g
         8iJ36aDp+btTBVIE3juFiuQ52jtgaKkxKY/F5HIc6kWz5i8dFkdc/pZRlqp368lehJVG
         oME0+syDKtc5j9XwB37UhWpkIgRG7fO8b2CYcq+/kkGHbv+DyqHpA4DJ5hIQdkRR7+jS
         Pp+JxolGw1bgQb0EwZIJX5jRTr0xweGUAdbJqmd/mQid5dHwePcDzDx5eS0grApUuetO
         TT6NEFBAL4R1n8u/GXjQ4KVy4dxFRT8yB9NjgOwkFk6FS32Asm9vC96GdFW16lN9G9WP
         C5Jw==
X-Gm-Message-State: AOAM530eNJXsiORTaod3/SULkwsxFM2Gy/epJeRCpSLqDWGqDnM9wxuq
        rJZ5/sv2JQuCY0E1XdOgG1fahCuyzYY6I2w4V41cEA==
X-Google-Smtp-Source: ABdhPJyCJedPd2jugvuXpBXoY18cjU0FRD66tWXLvPIRPtCNrzgAMYZEJREn4RNuRjhRVE+BFG2UWkD87ws/FMpEcrw=
X-Received: by 2002:a17:90b:1287:: with SMTP id fw7mr266848pjb.52.1606868169073;
 Tue, 01 Dec 2020 16:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20201130233504.3725241-1-axelrasmussen@google.com>
 <CALvZod42+o7naLOkpo9Jngmhru-aR4K6RCuTk7TukCikAYrDbQ@mail.gmail.com>
 <CAJHvVcgtoyJ_C0L=KByb8UbZm6x_RtCTnznYA1HwmdzX4Y=mHw@mail.gmail.com>
 <xr93lfehl8al.fsf@gthelen.svl.corp.google.com> <CALvZod4j9fFpGRfkios1ef0D5qhyw3XA_VSVm0k__RuMG1Qhwg@mail.gmail.com>
 <CAJHvVchcm_HLd1RaibCZDZi27_2CVCwUWDX515dvnPPyTpHBHw@mail.gmail.com> <CALvZod5CpPhvzB99VZTc33Sb5YCbJNHFe3k33k+HwNfJvJbpJQ@mail.gmail.com>
In-Reply-To: <CALvZod5CpPhvzB99VZTc33Sb5YCbJNHFe3k33k+HwNfJvJbpJQ@mail.gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 1 Dec 2020 16:15:32 -0800
Message-ID: <CAJHvVcjBErccEwNjuDqzsrbuzSmJva7uknZKhtBwWfs9_t4zTg@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: fix use-after-free race and css ref leak
 in tracepoints
To:     Shakeel Butt <shakeelb@google.com>
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

On Tue, Dec 1, 2020 at 12:53 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> +Tejun Heo
>
> On Tue, Dec 1, 2020 at 11:14 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
> >
> > On Tue, Dec 1, 2020 at 10:42 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Tue, Dec 1, 2020 at 9:56 AM Greg Thelen <gthelen@google.com> wrote:
> > > >
> > > > Axel Rasmussen <axelrasmussen@google.com> wrote:
> > > >
> > > > > On Mon, Nov 30, 2020 at 5:34 PM Shakeel Butt <shakeelb@google.com> wrote:
> > > > >>
> > > > >> On Mon, Nov 30, 2020 at 3:43 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
> > > > >> >
> > > > >> > syzbot reported[1] a use-after-free introduced in 0f818c4bc1f3. The bug
> > > > >> > is that an ongoing trace event might race with the tracepoint being
> > > > >> > disabled (and therefore the _unreg() callback being called). Consider
> > > > >> > this ordering:
> > > > >> >
> > > > >> > T1: trace event fires, get_mm_memcg_path() is called
> > > > >> > T1: get_memcg_path_buf() returns a buffer pointer
> > > > >> > T2: trace_mmap_lock_unreg() is called, buffers are freed
> > > > >> > T1: cgroup_path() is called with the now-freed buffer
> > > > >>
> > > > >> Any reason to use the cgroup_path instead of the cgroup_ino? There are
> > > > >> other examples of trace points using cgroup_ino and no need to
> > > > >> allocate buffers. Also cgroup namespace might complicate the path
> > > > >> usage.
> > > > >
> > > > > Hmm, so in general I would love to use a numeric identifier instead of a string.
> > > > >
> > > > > I did some reading, and it looks like the cgroup_ino() mainly has to
> > > > > do with writeback, instead of being just a general identifier?
> > > > > https://www.kernel.org/doc/Documentation/cgroup-v2.txt
> > >
> > > I think you are confusing cgroup inodes with real filesystem inodes in that doc.
> > >
> > > > >
> > > > > There is cgroup_id() which I think is almost what I'd want, but there
> > > > > are a couple problems with it:
> > > > >
> > > > > - I don't know of a way for userspace to translate IDs -> paths, to
> > > > > make them human readable?
> > > >
> > > > The id => name map can be built from user space with a tree walk.
> > > > Example:
> > > >
> > > > $ find /sys/fs/cgroup/memory -type d -printf '%i %P\n'                                                                          # ~ [main]
> > > > 20387 init.scope
> > > > 31 system.slice
> > > >
> > > > > - Also I think the ID implementation we use for this is "dense",
> > > > > meaning if a cgroup is removed, its ID is likely to be quickly reused.
> > > > >
> > >
> > > The ID for cgroup nodes (underlying it is kernfs) are allocated from
> > > idr_alloc_cyclic() which gives new ID after the last allocated ID and
> > > wrap after around INT_MAX IDs. So, likeliness of repetition is very
> > > low. Also the file_handle returned by name_to_handle_at() for cgroupfs
> > > returns the inode ID which gives confidence to the claim of low chance
> > > of ID reusing.
> >
> > Ah, for some reason I remembered it using idr_alloc(), but you're
> > right, it does use cyclical IDs. Even so, tracepoints which expose
> > these IDs would still be difficult to use I think.
>
> The writeback tracepoint in include/trace/events/writeback.h is
> already using the cgroup IDs. Actually it used to use cgroup_path but
> converted to cgroup_ino.
>
> Tejun, how do you use these tracepoints?
>
> > Say we're trying to
> > collect a histogram of lock latencies over the course of some test
> > we're running. At the end, we want to produce some kind of
> > human-readable report.
> >
>
> I am assuming the test infra and the tracing infra are decoupled
> entities and test infra is orchestrating the cgroups as well.
>
> > cgroups may come and go throughout the test. Even if we never re-use
> > IDs, in order to be able to map all of them to human-readable paths,
> > it seems like we'd need some background process to poll the
> > /sys/fs/cgroup/memory directory tree as Greg described, keeping track
> > of the ID<->path mapping. This seems expensive, and even if we poll
> > relatively frequently we might still miss short-lived cgroups.
> >
> > Trying to aggregate such statistics across physical machines, or
> > reboots of the same machine, is further complicated. The machine(s)
> > may be running the same application, which runs in a container with
> > the same path, but it'll end up with different IDs. So we'd have to
> > collect the ID<->path mapping from each, and then try to match up the
> > names for aggregation.
>
> How about adding another tracepoint in cgroup_create which will output
> the ID along with the name or path? With a little post processing you
> can get the same information. Also note that if the test is
> deleting/creating the cgroup with the same name, you will miss that
> information if filtering with just path.
>
> IMHO cgroup IDs will make the kernel code much simpler with the
> tradeoff of a bit more work in user space.

I like this idea! I think userspace can use the synthetic trace event
API to construct an event which includes the strings, like the one
I've added, if we had this separate ID<->path mapping tracepoint. If
so, it would be just as easy for userspace to use, but it would let us
deal with integer IDs everywhere else in the kernel, and keep the
complexity related to dealing with buffers limited to just one place.

That said, I'd prefer to pursue this as a follow-up thing, rather than
as part of fixing this bug. Seem reasonable?
