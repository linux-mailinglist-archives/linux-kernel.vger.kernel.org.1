Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1474A2D1CCB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgLGWIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:08:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60501 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgLGWIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607378836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=47h9tcuANlZBA5p2y/h4NAp3Z22VkAj67mf9y07u6Ik=;
        b=bnsagwf1aAcxhmITkCyp0Fc02T0OKkirwWU6jolErfZXrcScyYt8e1IK5xr7Ld3PraEY4k
        v3MWX3o8IqY2/4IM2AzCTO5yXNE1UtGMwzzhsZMq7/JBs6OPwlJczSGY1d6RqODMOpHY5P
        ZhXlC2eggT3sEXAm3dqRKsW1aVvgcFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-cSJfraUlOlWB8o3PXVGI-g-1; Mon, 07 Dec 2020 17:07:07 -0500
X-MC-Unique: cSJfraUlOlWB8o3PXVGI-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAD54107ACE4;
        Mon,  7 Dec 2020 22:07:05 +0000 (UTC)
Received: from krava (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id 03B135D9C6;
        Mon,  7 Dec 2020 22:07:03 +0000 (UTC)
Date:   Mon, 7 Dec 2020 23:07:03 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH v2 2/2] perf-stat: enable counting events for BPF programs
Message-ID: <20201207220703.GA4116109@krava>
References: <20201204061310.3196812-1-songliubraving@fb.com>
 <20201204061310.3196812-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204061310.3196812-3-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 10:13:10PM -0800, Song Liu wrote:

SNIP

> +#include "bpf_skel/bpf_prog_profiler.skel.h"
> +
> +static inline void *u64_to_ptr(__u64 ptr)
> +{
> +	return (void *)(unsigned long)ptr;
> +}
> +
> +static void set_max_rlimit(void)
> +{
> +	struct rlimit rinf = { RLIM_INFINITY, RLIM_INFINITY };
> +
> +	setrlimit(RLIMIT_MEMLOCK, &rinf);
> +}
> +
> +static inline struct bpf_counter *bpf_counter_alloc(void)

why is this inlined?

SNIP

> +static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_id)
> +{
> +	struct bpf_prog_profiler_bpf *skel;
> +	struct bpf_counter *counter;
> +	struct bpf_program *prog;
> +	char *prog_name;
> +	int prog_fd;
> +	int err;
> +
> +	prog_fd = bpf_prog_get_fd_by_id(prog_id);
> +	if (prog_fd < 0) {
> +		pr_debug("Failed to open fd for bpf prog %u\n", prog_id);
> +		return -1;
> +	}
> +	counter = bpf_counter_alloc();
> +	if (!counter)
> +		return -1;
> +
> +	skel = bpf_prog_profiler_bpf__open();
> +	if (!skel) {
> +		pr_debug("Failed to load bpf skeleton\n");

I'm still getting

[root@dell-r440-01 perf]# ./perf stat -b 38
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
libbpf: XXX is not found in vmlinux BTF
libbpf: failed to load object 'bpf_prog_profiler_bpf'
libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
...

with id 38 being:

38: tracepoint  name sys_enter  tag 03418b72a610af75  gpl
        loaded_at 2020-12-07T22:54:05+0100  uid 0
        xlated 272B  jited 153B  memlock 4096B  map_ids 1

how is this supposed to work when there's XXX in the
program's section? libbpf is trying to find XXX in
kernel BTF and fails of course


> +		free(counter);
> +		return -1;
> +	}
> +	skel->rodata->num_cpu = evsel__nr_cpus(evsel);
> +
> +	bpf_map__resize(skel->maps.events, evsel__nr_cpus(evsel));
> +	bpf_map__resize(skel->maps.fentry_readings, 1);
> +	bpf_map__resize(skel->maps.accum_readings, 1);
> +

SNIP

> +static int bpf_program_profiler__read(struct evsel *evsel)
> +{
> +	int num_cpu = evsel__nr_cpus(evsel);
> +	struct bpf_perf_event_value values[num_cpu];
> +	struct bpf_counter *counter;
> +	int reading_map_fd;
> +	__u32 key = 0;
> +	int err, cpu;
> +
> +	if (list_empty(&evsel->bpf_counter_list))
> +		return -EAGAIN;
> +
> +	for (cpu = 0; cpu < num_cpu; cpu++) {
> +		perf_counts(evsel->counts, cpu, 0)->val = 0;
> +		perf_counts(evsel->counts, cpu, 0)->ena = 0;
> +		perf_counts(evsel->counts, cpu, 0)->run = 0;
> +	}
> +	list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> +		struct bpf_prog_profiler_bpf *skel = counter->skel;
> +
> +		reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
> +
> +		err = bpf_map_lookup_elem(reading_map_fd, &key, values);
> +		if (err) {
> +			fprintf(stderr, "failed to read value\n");
> +			return err;
> +		}
> +
> +		for (cpu = 0; cpu < num_cpu; cpu++) {
> +			perf_counts(evsel->counts, cpu, 0)->val += values[cpu].counter;
> +			perf_counts(evsel->counts, cpu, 0)->ena += values[cpu].enabled;
> +			perf_counts(evsel->counts, cpu, 0)->run += values[cpu].running;
> +		}

so we sum everything up for all provided bpf IDs,
should we count/display them separately?

SNIP

> +SEC("fentry/XXX")
> +int BPF_PROG(fentry_XXX)
> +{
> +	__u32 key = bpf_get_smp_processor_id();
> +	struct bpf_perf_event_value reading;
> +	struct bpf_perf_event_value *ptr;
> +	__u32 zero = 0;
> +	long err;
> +
> +	/* look up before reading, to reduce error */
> +	ptr = bpf_map_lookup_elem(&fentry_readings, &zero);
> +	if (!ptr)
> +		return 0;
> +
> +	err = bpf_perf_event_read_value(&events, key, &reading,
> +					sizeof(reading));

can't we read directly to ptr in here?

SNIP

>  	/* THREAD and SYSTEM/CPU are mutually exclusive */
>  	if (target->per_thread && (target->system_wide || target->cpu_list)) {
>  		target->per_thread = false;
> @@ -109,6 +137,10 @@ static const char *target__error_str[] = {
>  	"PID/TID switch overriding SYSTEM",
>  	"UID switch overriding SYSTEM",
>  	"SYSTEM/CPU switch overriding PER-THREAD",
> +	"BPF switch overriding CPU",
> +	"BPF switch overriding PID/TID",
> +	"BPF switch overriding UID",
> +	"BPF switch overriding THREAD",
>  	"Invalid User: %s",
>  	"Problems obtaining information for user %s",
>  };
> @@ -134,7 +166,7 @@ int target__strerror(struct target *target, int errnum,
>  
>  	switch (errnum) {
>  	case TARGET_ERRNO__PID_OVERRIDE_CPU ...
> -	     TARGET_ERRNO__SYSTEM_OVERRIDE_THREAD:

hum, this should stay, no?

thanks,
jirka

> +	     TARGET_ERRNO__BPF_OVERRIDE_THREAD:
>  		snprintf(buf, buflen, "%s", msg);
>  		break;
>  
> diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h

SNIP

