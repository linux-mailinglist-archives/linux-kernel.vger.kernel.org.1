Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142082E72F1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 19:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgL2SQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 13:16:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgL2SQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 13:16:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2A8922209;
        Tue, 29 Dec 2020 18:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609265772;
        bh=xanVi1iw88MT8ZhxmKG43l0yIw1fF5uWKSjJPRJhZSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m2gA0N65pNUHyzDdejFZhUVX/ICIMJUg6D32qYU6SkGXYT+cE6P15SdzizG15J0Bk
         QsEkP8w8mgN2jTbyA7S+B/gujST3XR7BFiWo8UvmS20LH+/4UH9uYo1SxU33T/J/hC
         2uTAgH2rtDBZ9QjLS/afZ51CJg3SzDXfqhXD75T8BpAC139xU0tBqf/N8fBSiK9eAf
         TeGIziPZBjT2BfLqpHYuiFPvJx48WMXcamHhJmEb2ZHIR8MhWaaDcqv2oQfvpdBz0H
         VLChngXsiXm17NcrXBWTSqbCg6G5CBlg2xkS4gasCQtMWuu8wRV1Fq0POybhWVk1tP
         3OHkSXLdPxs1w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6978C411E9; Tue, 29 Dec 2020 15:16:29 -0300 (-03)
Date:   Tue, 29 Dec 2020 15:16:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v6 2/4] perf: support build BPF skeletons with perf
Message-ID: <20201229181629.GJ521329@kernel.org>
References: <20201228174054.907740-1-songliubraving@fb.com>
 <20201228174054.907740-3-songliubraving@fb.com>
 <CAM9d7chjWMFNeQMBftu725cTbCRauUJinQSqy9E9itv=AJXvyA@mail.gmail.com>
 <20201229114828.GG521329@kernel.org>
 <7219C2C5-48F1-44A3-9787-FBD39CC58514@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7219C2C5-48F1-44A3-9787-FBD39CC58514@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 29, 2020 at 05:14:12PM +0000, Song Liu escreveu:
> > On Dec 29, 2020, at 3:48 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > Em Tue, Dec 29, 2020 at 04:01:41PM +0900, Namhyung Kim escreveu:
> >> On Tue, Dec 29, 2020 at 2:41 AM Song Liu <songliubraving@fb.com> wrote:
> >>> BPF programs are useful in perf to profile BPF programs. BPF skeleton is

> >> I'm having difficulties understanding the first sentence - looks like a
> >> recursion. :)  So do you want to use two (or more) BPF programs?

> > Yeah, we use perf to perf perf, so we need to use bpf with perf to perf
> > bpf :-)

> > Look at tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c, the BPF
> > skeleton used to create the in-kernel scaffold to profile BPF programs.

> > It uses two BPF programs (fentry/XXX and fexit/XXX) and some a
                                                           s/some//
> > PERF_EVENT_ARRAY map and an array to diff counters read at exit from
> > counters read at exit of the profiled BPF programs and then accumulate
                    s/exit/entry/
> > those diffs in another PERCPU_ARRAY.

> > This all ends up composing a "BPF PMU" that is what the userspace perf
> > tooling will read (from "accum_readings" BPF map)  and 'perf stat' will
> > consume as if reading from an "old style perf counter" :-)

> > Song, did I get it right? :-)
 
> Thanks Arnaldo! I don't think anyone can explain it better. :-)

There, a patch :-)

- Arnaldo
