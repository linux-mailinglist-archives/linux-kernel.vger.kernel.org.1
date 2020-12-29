Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876E92E7023
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgL2Lsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:48:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgL2Lsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:48:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9A03206DC;
        Tue, 29 Dec 2020 11:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609242492;
        bh=xN1v16nk6ENBUgfUhK3clvu4RQVrIgmGXFiJqD3V6h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t19w97khFAtBRwZhrxtCIDQI7kAwxiytMv+A5XPnzBfLDTg+WUxosEPhcrbGPfEZj
         0wkp25pKUdOgsISiYfJUZG1ra+2LZz/MTHmD4bI90J8tnpb+MV67yM/8OepbQ2gZqG
         MveV7sX0z55KwceR7JI9Kf2//HbPZLnpInebWZc5uP7JK6JBfY8RBy2q8WmA4CaFno
         qW0nTE81X9HEVYmhTO9Xao7UEeMv1BhqORk8x4XxStrHz0NK91jQgrNUEuGm2Z1S7r
         Pzv8NCikw1cOBFyTG6xam+qStKd/gpYlWZTeT2pgAciDJN7C2DtRnYWFKCueSd7v86
         Px6IEK9Ts2FpQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 93AD1411E9; Tue, 29 Dec 2020 08:48:28 -0300 (-03)
Date:   Tue, 29 Dec 2020 08:48:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 2/4] perf: support build BPF skeletons with perf
Message-ID: <20201229114828.GG521329@kernel.org>
References: <20201228174054.907740-1-songliubraving@fb.com>
 <20201228174054.907740-3-songliubraving@fb.com>
 <CAM9d7chjWMFNeQMBftu725cTbCRauUJinQSqy9E9itv=AJXvyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chjWMFNeQMBftu725cTbCRauUJinQSqy9E9itv=AJXvyA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 29, 2020 at 04:01:41PM +0900, Namhyung Kim escreveu:
> On Tue, Dec 29, 2020 at 2:41 AM Song Liu <songliubraving@fb.com> wrote:
> > BPF programs are useful in perf to profile BPF programs. BPF skeleton is
 
> I'm having difficulties understanding the first sentence - looks like a
> recursion. :)  So do you want to use two (or more) BPF programs?

Yeah, we use perf to perf perf, so we need to use bpf with perf to perf
bpf :-)

Look at tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c, the BPF
skeleton used to create the in-kernel scaffold to profile BPF programs.

It uses two BPF programs (fentry/XXX and fexit/XXX) and some a
PERF_EVENT_ARRAY map and an array to diff counters read at exit from
counters read at exit of the profiled BPF programs and then accumulate
those diffs in another PERCPU_ARRAY.

This all ends up composing a "BPF PMU" that is what the userspace perf
tooling will read (from "accum_readings" BPF map)  and 'perf stat' will
consume as if reading from an "old style perf counter" :-)

Song, did I get it right? :-)

For convenience, it is below:

- Arnaldo
 
[acme@five perf]$ cat tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c 
// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
// Copyright (c) 2020 Facebook
#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>

/* map of perf event fds, num_cpu * num_metric entries */
struct {
	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(int));
} events SEC(".maps");

/* readings at fentry */
struct {
	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(struct bpf_perf_event_value));
	__uint(max_entries, 1);
} fentry_readings SEC(".maps");

/* accumulated readings */
struct {
	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(struct bpf_perf_event_value));
	__uint(max_entries, 1);
} accum_readings SEC(".maps");

const volatile __u32 num_cpu = 1;

SEC("fentry/XXX")
int BPF_PROG(fentry_XXX)
{
	__u32 key = bpf_get_smp_processor_id();
	struct bpf_perf_event_value *ptr;
	__u32 zero = 0;
	long err;

	/* look up before reading, to reduce error */
	ptr = bpf_map_lookup_elem(&fentry_readings, &zero);
	if (!ptr)
		return 0;

	err = bpf_perf_event_read_value(&events, key, ptr, sizeof(*ptr));
	if (err)
		return 0;

	return 0;
}

static inline void
fexit_update_maps(struct bpf_perf_event_value *after)
{
	struct bpf_perf_event_value *before, diff, *accum;
	__u32 zero = 0;

	before = bpf_map_lookup_elem(&fentry_readings, &zero);
	/* only account samples with a valid fentry_reading */
	if (before && before->counter) {
		struct bpf_perf_event_value *accum;

		diff.counter = after->counter - before->counter;
		diff.enabled = after->enabled - before->enabled;
		diff.running = after->running - before->running;

		accum = bpf_map_lookup_elem(&accum_readings, &zero);
		if (accum) {
			accum->counter += diff.counter;
			accum->enabled += diff.enabled;
			accum->running += diff.running;
		}
	}
}

SEC("fexit/XXX")
int BPF_PROG(fexit_XXX)
{
	struct bpf_perf_event_value reading;
	__u32 cpu = bpf_get_smp_processor_id();
	__u32 one = 1, zero = 0;
	int err;

	/* read all events before updating the maps, to reduce error */
	err = bpf_perf_event_read_value(&events, cpu, &reading, sizeof(reading));
	if (err)
		return 0;

	fexit_update_maps(&reading);
	return 0;
}

char LICENSE[] SEC("license") = "Dual BSD/GPL";
[acme@five perf]$
