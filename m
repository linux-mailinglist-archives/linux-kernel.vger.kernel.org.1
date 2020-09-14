Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AB0268FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgINP3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbgINP2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:28:46 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 897042076C;
        Mon, 14 Sep 2020 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600097324;
        bh=KUx9v7VrfGPDPhRZ5dko3SCtGBsguc8cUCdytZ9AShc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSzvELn2EwSjaWPuf1bfkUNg96c32aOwkNPmKRKVFatvT8h+ASMG8VVhFJfkcmJNY
         2Ms9HZ6L8PSaLEBd6li/HkRQNxNlbWZqIEQfMtVQ6clvWPUquQgHqzvn63fVgIfe1T
         0ZxDjq9k6ysdlbePm2m437Fjc64z3GuAY9o5+YnQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6C46440D3D; Mon, 14 Sep 2020 12:28:41 -0300 (-03)
Date:   Mon, 14 Sep 2020 12:28:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
Message-ID: <20200914152841.GC160517@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 14, 2020 at 02:38:27PM +0900, Namhyung Kim escreveu:
> On Mon, Sep 14, 2020 at 6:03 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > Add new version of mmap event. The MMAP3 record is an
> > augmented version of MMAP2, it adds build id value to
> > identify the exact binary object behind memory map:

> >   struct {
> >     struct perf_event_header header;

> >     u32                      pid, tid;
> >     u64                      addr;
> >     u64                      len;
> >     u64                      pgoff;
> >     u32                      maj;
> >     u32                      min;
> >     u64                      ino;
> >     u64                      ino_generation;
> >     u32                      prot, flags;
> >     u32                      reserved;

What for this reserved? its all nicely aligned already, u64 followed by
two u32 (prot, flags).

> >     u8                       buildid[20];
 
> Do we need maj, min, ino, ino_generation for mmap3 event?
> I think they are to compare binaries, then we can do it with
> build-id (and I think it'd be better)..

Humm, I thought MMAP2 would be a superset of MMAP and MMAP3 would be a
superset of MMAP2.

If we want to ditch useless stuff, then trow away pid, tid too, as we
can select those via sample_type.

Having said that, at this point I don't even know if adding new
PERF_RECORD_ that are an update for a preexisting one is the right way
to proceed.

Perhaps we should attach a BPF program to point where a mmap/munmap is
being done (perf_event_mmap()) and allow userspace to ask for whatever
it wants?  With a kprobes there right now we can implement this MMAP3
easily, no?

Start with a kprobes and all this would be already available in kernels
with BPF, no need to reboot with a PERF_RECORD_MMAP3 enabled kernel,
when we get a tracepoint there, then use it, as its more efficient.

sample_id stuff would be done as with other records, etc, just the
things that are MMAP3 specific would be in the payload, perf.data has
the struct layout description, etc.

Then use a BPF_TRACE_ITER to generate preexisting MMAP records instead
of going thru /proc/ doing tons of syscalls, instead injecting directly
into the perf ring buffer the MMAP3 (or MMAP2 or MMAP or something else
according to the tools needs).

- Arnaldo
 
> 
> >     char                     filename[];
> >     struct sample_id         sample_id;
> >   };
> >
> > Adding 4 bytes reserved field to align buildid data to 8 bytes,
> > so sample_id data is properly aligned.
> >
> > The mmap3 event is enabled by new mmap3 bit in perf_event_attr
> > struct.  When set for an event, it enables the build id retrieval
> > and will use mmap3 format for the event.
> >
> > Keeping track of mmap3 events and calling build_id_parse
> > in perf_event_mmap_event only if we have any defined.
> >
> > Having build id attached directly to the mmap event will help
> > tool like perf to skip final search through perf data for
> > binaries that are needed in the report time. Also it prevents
> > possible race when the binary could be removed or replaced
> > during profiling.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/perf_event.h | 27 ++++++++++++++++++++++-
> >  kernel/events/core.c            | 38 +++++++++++++++++++++++++++------
> >  2 files changed, 57 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index 077e7ee69e3d..facfc3c673ed 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -384,7 +384,8 @@ struct perf_event_attr {
> >                                 aux_output     :  1, /* generate AUX records instead of events */
> >                                 cgroup         :  1, /* include cgroup events */
> >                                 text_poke      :  1, /* include text poke events */
> > -                               __reserved_1   : 30;
> > +                               mmap3          :  1, /* include bpf events */
> 
> ???
> 
> > +                               __reserved_1   : 29;
> >
> >         union {
> >                 __u32           wakeup_events;    /* wakeup every n events */
> > @@ -1060,6 +1061,30 @@ enum perf_event_type {
> >          */
> >         PERF_RECORD_TEXT_POKE                   = 20,
> >
> > +       /*
> > +        * The MMAP3 records are an augmented version of MMAP2, they add
> > +        * build id value to identify the exact binary behind map
> > +        *
> > +        * struct {
> > +        *      struct perf_event_header        header;
> > +        *
> > +        *      u32                             pid, tid;
> > +        *      u64                             addr;
> > +        *      u64                             len;
> > +        *      u64                             pgoff;
> > +        *      u32                             maj;
> > +        *      u32                             min;
> > +        *      u64                             ino;
> > +        *      u64                             ino_generation;
> > +        *      u32                             prot, flags;
> > +        *      u32                             reserved;
> > +        *      u8                              buildid[20];
> > +        *      char                            filename[];
> > +        *      struct sample_id                sample_id;
> > +        * };
> > +        */
> > +       PERF_RECORD_MMAP3                       = 21,
> > +
> >         PERF_RECORD_MAX,                        /* non-ABI */
> >  };
> >
> [SNIP]
> > @@ -8098,6 +8116,9 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
> >         mmap_event->prot = prot;
> >         mmap_event->flags = flags;
> >
> > +       if (atomic_read(&nr_mmap3_events))
> > +               build_id_parse(vma, mmap_event->buildid);
> 
> What about if it failed?  We should zero out the build-id..
> 
> Thanks
> Namhyung
> 
> > +
> >         if (!(vma->vm_flags & VM_EXEC))
> >                 mmap_event->event_id.header.misc |= PERF_RECORD_MISC_MMAP_DATA;
> >
> > @@ -8241,6 +8262,7 @@ void perf_event_mmap(struct vm_area_struct *vma)
> >                 /* .ino_generation (attr_mmap2 only) */
> >                 /* .prot (attr_mmap2 only) */
> >                 /* .flags (attr_mmap2 only) */
> > +               /* .buildid (attr_mmap3 only) */
> >         };
> >
> >         perf_addr_filters_adjust(vma);
> > @@ -11040,6 +11062,8 @@ static void account_event(struct perf_event *event)
> >                 inc = true;
> >         if (event->attr.mmap || event->attr.mmap_data)
> >                 atomic_inc(&nr_mmap_events);
> > +       if (event->attr.mmap3)
> > +               atomic_inc(&nr_mmap3_events);
> >         if (event->attr.comm)
> >                 atomic_inc(&nr_comm_events);
> >         if (event->attr.namespaces)
> > --
> > 2.26.2
> >

-- 

- Arnaldo
