Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CEA269877
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgINWAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgINWAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:00:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFC5D208DB;
        Mon, 14 Sep 2020 22:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600120817;
        bh=1WK2AiRzsstsPgVwti+HDccoV1eD8PIA3rHhgAqzy7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrOo3XUZIMzxCP9gVIDo8xCHTh1xv7l4JKRuDh5YDJaT6kEccaH+S9ql6qNDhxtI8
         wGedIos3dGvwzX4wYnNfdemOuma1FXjLNheE9/u28XbgNNsxuK5GkJd40gH3muhPUS
         tiTrmKf0HbwQHzvg6PJZwbj4cS0Q5nLKWC5iSOVw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EE1CE40D3D; Mon, 14 Sep 2020 19:00:14 -0300 (-03)
Date:   Mon, 14 Sep 2020 19:00:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
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
Message-ID: <20200914220014.GH166601@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
 <20200914152841.GC160517@kernel.org>
 <20200914193907.GO1714160@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914193907.GO1714160@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 14, 2020 at 09:39:07PM +0200, Jiri Olsa escreveu:
> On Mon, Sep 14, 2020 at 12:28:41PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Sep 14, 2020 at 02:38:27PM +0900, Namhyung Kim escreveu:
> > > On Mon, Sep 14, 2020 at 6:03 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > Add new version of mmap event. The MMAP3 record is an
> > > > augmented version of MMAP2, it adds build id value to
> > > > identify the exact binary object behind memory map:
 
> > > >   struct {
> > > >     struct perf_event_header header;
 
> > > >     u32                      pid, tid;
> > > >     u64                      addr;
> > > >     u64                      len;
> > > >     u64                      pgoff;
> > > >     u32                      maj;
> > > >     u32                      min;
> > > >     u64                      ino;
> > > >     u64                      ino_generation;
> > > >     u32                      prot, flags;
> > > >     u32                      reserved;
 
> > What for this reserved? its all nicely aligned already, u64 followed by
> > two u32 (prot, flags).
 
> > > >     u8                       buildid[20];
  
> > > Do we need maj, min, ino, ino_generation for mmap3 event?
> > > I think they are to compare binaries, then we can do it with
> > > build-id (and I think it'd be better)..
 
> > Humm, I thought MMAP2 would be a superset of MMAP and MMAP3 would be a
> > superset of MMAP2.
 
> > If we want to ditch useless stuff, then trow away pid, tid too, as we
> > can select those via sample_type.
 
> > Having said that, at this point I don't even know if adding new
> > PERF_RECORD_ that are an update for a preexisting one is the right way
> > to proceed.

> > Perhaps we should attach a BPF program to point where a mmap/munmap is
> > being done (perf_event_mmap()) and allow userspace to ask for whatever
> > it wants?  With a kprobes there right now we can implement this MMAP3
> > easily, no?
 
> hmm, I'm always woried about solutions based on kprobes,
> because once the function is moved/removed you're screwed
> and need to keep up with function name changes and be
> backward compatible..

Well, I'm not advocating to have it as kprobes permanently, but we can
implement it now using a kprobes, i.e. systems wouldn't have to have its
kernel updated to have this feature, but once then need, for some other
reason, to have their kernel upgraded, then perf would notice that there
is a tracepoint for that and would happily use it.

So we would be able to use that tracepoint with things like ftrace,
bpftrace, everything that knows about tracepoints, and perf would get
build-ids and whatever else is needed to have a mmap record, in the
future we could even ask for some more (or less) according to the what
is needed for some new feature.

I.e. the point wasn't about kprobes was about using BPF to state what
we want to collect when a mmap is being put in place.

- Arnaldo
