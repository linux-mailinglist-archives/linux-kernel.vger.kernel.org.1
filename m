Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF602DB096
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbgLOPxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:53:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730524AbgLOPw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:52:56 -0500
Date:   Tue, 15 Dec 2020 12:52:26 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608047535;
        bh=H97xx6SMQMd2hqyfmUto9HQyY5XM0MtVFL7nQCZK+Zs=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ArcVFn2nU/IZvk5sybVyucC6Yi0o0TFve8HItIIGsqPkyeil+RP6dPZNv5+FHYBuX
         Vs1STupkBGEhw/ntrFHQ8BLJaanYDehrLi5zeB/bsJio4u0DdT7Ds4bFchnLfPnxnW
         OIPFCilXh1PAaEVsOHoYWTOb8mjp8x09tDJhYDeM4gJ7tRFMo1+DawciW7Y4PhCHqL
         0ze8EEv+kT1aK5W4GMfFd7USynVYsu+T2VKRkJsoZ8BIVPfm/MudOGVdyhXPEccDOM
         6hcqQM3eIt8nlcgL9zm12DribIfPc7+/tEl0DUQjRZJs2oq5jRlOH5vPIXjepPMcSc
         zhi4FbTaWv2JQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 03/15] perf: Add build id data in mmap2 event
Message-ID: <20201215155226.GK258566@kernel.org>
References: <20201214105457.543111-1-jolsa@kernel.org>
 <20201214105457.543111-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214105457.543111-4-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 14, 2020 at 11:54:45AM +0100, Jiri Olsa escreveu:
> Adding support to carry build id data in mmap2 event.
> 
> The build id data replaces maj/min/ino/ino_generation
> fields, which are also used to identify map's binary,
> so it's ok to replace them with build id data:
> 
>   union {
>           struct {
>                   u32       maj;
>                   u32       min;
>                   u64       ino;
>                   u64       ino_generation;
>           };
>           struct {
>                   u8        build_id_size;
>                   u8        __reserved_1;
>                   u16       __reserved_2;
>                   u8        build_id[20];
>           };
>   };

Alexei/Daniel, this one depends on BPFs build id routines to be exported
for use by the perf kernel subsys, PeterZ already acked this, so can you
guys consider getting the first three patches in this series via the bpf
tree?

The BPF bits were acked by Song.

- Arnaldo
 
> Replaced maj/min/ino/ino_generation fields give us size
> of 24 bytes. We use 20 bytes for build id data, 1 byte
> for size and rest is unused.
> 
> There's new misc bit for mmap2 to signal there's build
> id data in it:
> 
>   #define PERF_RECORD_MISC_MMAP_BUILD_ID   (1 << 14)
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/uapi/linux/perf_event.h | 42 +++++++++++++++++++++++++++++----
>  kernel/events/core.c            | 32 +++++++++++++++++++++----
>  2 files changed, 65 insertions(+), 9 deletions(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index b95d3c485d27..45a216bea048 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -384,7 +384,8 @@ struct perf_event_attr {
>  				aux_output     :  1, /* generate AUX records instead of events */
>  				cgroup         :  1, /* include cgroup events */
>  				text_poke      :  1, /* include text poke events */
> -				__reserved_1   : 30;
> +				build_id       :  1, /* use build id in mmap2 events */
> +				__reserved_1   : 29;
>  
>  	union {
>  		__u32		wakeup_events;	  /* wakeup every n events */
> @@ -657,6 +658,22 @@ struct perf_event_mmap_page {
>  	__u64	aux_size;
>  };
>  
> +/*
> + * The current state of perf_event_header::misc bits usage:
> + * ('|' used bit, '-' unused bit)
> + *
> + *  012         CDEF
> + *  |||---------||||
> + *
> + *  Where:
> + *    0-2     CPUMODE_MASK
> + *
> + *    C       PROC_MAP_PARSE_TIMEOUT
> + *    D       MMAP_DATA / COMM_EXEC / FORK_EXEC / SWITCH_OUT
> + *    E       MMAP_BUILD_ID / EXACT_IP / SCHED_OUT_PREEMPT
> + *    F       (reserved)
> + */
> +
>  #define PERF_RECORD_MISC_CPUMODE_MASK		(7 << 0)
>  #define PERF_RECORD_MISC_CPUMODE_UNKNOWN	(0 << 0)
>  #define PERF_RECORD_MISC_KERNEL			(1 << 0)
> @@ -688,6 +705,7 @@ struct perf_event_mmap_page {
>   *
>   *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise events
>   *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
> + *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
>   *
>   *
>   * PERF_RECORD_MISC_EXACT_IP:
> @@ -697,9 +715,13 @@ struct perf_event_mmap_page {
>   *
>   * PERF_RECORD_MISC_SWITCH_OUT_PREEMPT:
>   *   Indicates that thread was preempted in TASK_RUNNING state.
> + *
> + * PERF_RECORD_MISC_MMAP_BUILD_ID:
> + *   Indicates that mmap2 event carries build id data.
>   */
>  #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
>  #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
> +#define PERF_RECORD_MISC_MMAP_BUILD_ID		(1 << 14)
>  /*
>   * Reserve the last bit to indicate some extended misc field
>   */
> @@ -911,10 +933,20 @@ enum perf_event_type {
>  	 *	u64				addr;
>  	 *	u64				len;
>  	 *	u64				pgoff;
> -	 *	u32				maj;
> -	 *	u32				min;
> -	 *	u64				ino;
> -	 *	u64				ino_generation;
> +	 *	union {
> +	 *		struct {
> +	 *			u32		maj;
> +	 *			u32		min;
> +	 *			u64		ino;
> +	 *			u64		ino_generation;
> +	 *		};
> +	 *		struct {
> +	 *			u8		build_id_size;
> +	 *			u8		__reserved_1;
> +	 *			u16		__reserved_2;
> +	 *			u8		build_id[20];
> +	 *		};
> +	 *	};
>  	 *	u32				prot, flags;
>  	 *	char				filename[];
>  	 * 	struct sample_id		sample_id;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index dc568ca295bd..6cbd04a24d3a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -51,6 +51,7 @@
>  #include <linux/proc_ns.h>
>  #include <linux/mount.h>
>  #include <linux/min_heap.h>
> +#include <linux/buildid.h>
>  
>  #include "internal.h"
>  
> @@ -395,6 +396,7 @@ static atomic_t nr_ksymbol_events __read_mostly;
>  static atomic_t nr_bpf_events __read_mostly;
>  static atomic_t nr_cgroup_events __read_mostly;
>  static atomic_t nr_text_poke_events __read_mostly;
> +static atomic_t nr_build_id_events __read_mostly;
>  
>  static LIST_HEAD(pmus);
>  static DEFINE_MUTEX(pmus_lock);
> @@ -4665,6 +4667,8 @@ static void unaccount_event(struct perf_event *event)
>  		dec = true;
>  	if (event->attr.mmap || event->attr.mmap_data)
>  		atomic_dec(&nr_mmap_events);
> +	if (event->attr.build_id)
> +		atomic_dec(&nr_build_id_events);
>  	if (event->attr.comm)
>  		atomic_dec(&nr_comm_events);
>  	if (event->attr.namespaces)
> @@ -7934,6 +7938,8 @@ struct perf_mmap_event {
>  	u64			ino;
>  	u64			ino_generation;
>  	u32			prot, flags;
> +	u8			build_id[BUILD_ID_SIZE_MAX];
> +	u32			build_id_size;
>  
>  	struct {
>  		struct perf_event_header	header;
> @@ -7965,6 +7971,7 @@ static void perf_event_mmap_output(struct perf_event *event,
>  	struct perf_sample_data sample;
>  	int size = mmap_event->event_id.header.size;
>  	u32 type = mmap_event->event_id.header.type;
> +	bool use_build_id;
>  	int ret;
>  
>  	if (!perf_event_mmap_match(event, data))
> @@ -7989,13 +7996,25 @@ static void perf_event_mmap_output(struct perf_event *event,
>  	mmap_event->event_id.pid = perf_event_pid(event, current);
>  	mmap_event->event_id.tid = perf_event_tid(event, current);
>  
> +	use_build_id = event->attr.build_id && mmap_event->build_id_size;
> +
> +	if (event->attr.mmap2 && use_build_id)
> +		mmap_event->event_id.header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
> +
>  	perf_output_put(&handle, mmap_event->event_id);
>  
>  	if (event->attr.mmap2) {
> -		perf_output_put(&handle, mmap_event->maj);
> -		perf_output_put(&handle, mmap_event->min);
> -		perf_output_put(&handle, mmap_event->ino);
> -		perf_output_put(&handle, mmap_event->ino_generation);
> +		if (use_build_id) {
> +			u8 size[4] = { (u8) mmap_event->build_id_size, 0, 0, 0 };
> +
> +			__output_copy(&handle, size, 4);
> +			__output_copy(&handle, mmap_event->build_id, BUILD_ID_SIZE_MAX);
> +		} else {
> +			perf_output_put(&handle, mmap_event->maj);
> +			perf_output_put(&handle, mmap_event->min);
> +			perf_output_put(&handle, mmap_event->ino);
> +			perf_output_put(&handle, mmap_event->ino_generation);
> +		}
>  		perf_output_put(&handle, mmap_event->prot);
>  		perf_output_put(&handle, mmap_event->flags);
>  	}
> @@ -8124,6 +8143,9 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
>  
>  	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
>  
> +	if (atomic_read(&nr_build_id_events))
> +		build_id_parse(vma, mmap_event->build_id, &mmap_event->build_id_size);
> +
>  	perf_iterate_sb(perf_event_mmap_output,
>  		       mmap_event,
>  		       NULL);
> @@ -11060,6 +11082,8 @@ static void account_event(struct perf_event *event)
>  		inc = true;
>  	if (event->attr.mmap || event->attr.mmap_data)
>  		atomic_inc(&nr_mmap_events);
> +	if (event->attr.build_id)
> +		atomic_inc(&nr_build_id_events);
>  	if (event->attr.comm)
>  		atomic_inc(&nr_comm_events);
>  	if (event->attr.namespaces)
> -- 
> 2.26.2
> 

-- 

- Arnaldo
