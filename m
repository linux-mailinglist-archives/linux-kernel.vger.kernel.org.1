Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6161A2D462E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbgLIP5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:57:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731477AbgLIP52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607529361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uFaK2xHbBrVxZ0l3Z3kyZu5KCrvdAykdVCt3rt7oNiI=;
        b=BRKN+eg2eFy3fEcQQKr8JKrj6O2nA9tBdK3vyQzqPD9KNVedI5SGCB05E2YzqsZtrtg6hg
        RpddphcP3CaHbehMAYju1aLFmTd5HWk+uFIc6uat4QToITkbVv0nd7wT3G8X7eTVkwawI3
        ngG/US7fjPStEddopwXPDXze73AdKzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-vgW0b2qZMw-rswXel0oqEw-1; Wed, 09 Dec 2020 10:55:57 -0500
X-MC-Unique: vgW0b2qZMw-rswXel0oqEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A01CD879500;
        Wed,  9 Dec 2020 15:55:55 +0000 (UTC)
Received: from krava (unknown [10.40.195.176])
        by smtp.corp.redhat.com (Postfix) with SMTP id B15FA60BF1;
        Wed,  9 Dec 2020 15:55:53 +0000 (UTC)
Date:   Wed, 9 Dec 2020 16:55:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v2 2/2] perf-stat: enable counting events for BPF programs
Message-ID: <20201209155552.GC69683@krava>
References: <20201204061310.3196812-1-songliubraving@fb.com>
 <20201204061310.3196812-3-songliubraving@fb.com>
 <20201207220703.GA4116109@krava>
 <C94864E9-CE05-4AEA-A986-731BFC0C95FF@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C94864E9-CE05-4AEA-A986-731BFC0C95FF@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 01:36:57AM +0000, Song Liu wrote:

SNIP

> > SNIP
> > 
> >> +static int bpf_program_profiler__read(struct evsel *evsel)
> >> +{
> >> +	int num_cpu = evsel__nr_cpus(evsel);
> >> +	struct bpf_perf_event_value values[num_cpu];
> >> +	struct bpf_counter *counter;
> >> +	int reading_map_fd;
> >> +	__u32 key = 0;
> >> +	int err, cpu;
> >> +
> >> +	if (list_empty(&evsel->bpf_counter_list))
> >> +		return -EAGAIN;
> >> +
> >> +	for (cpu = 0; cpu < num_cpu; cpu++) {
> >> +		perf_counts(evsel->counts, cpu, 0)->val = 0;
> >> +		perf_counts(evsel->counts, cpu, 0)->ena = 0;
> >> +		perf_counts(evsel->counts, cpu, 0)->run = 0;
> >> +	}
> >> +	list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> >> +		struct bpf_prog_profiler_bpf *skel = counter->skel;
> >> +
> >> +		reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
> >> +
> >> +		err = bpf_map_lookup_elem(reading_map_fd, &key, values);
> >> +		if (err) {
> >> +			fprintf(stderr, "failed to read value\n");
> >> +			return err;
> >> +		}
> >> +
> >> +		for (cpu = 0; cpu < num_cpu; cpu++) {
> >> +			perf_counts(evsel->counts, cpu, 0)->val += values[cpu].counter;
> >> +			perf_counts(evsel->counts, cpu, 0)->ena += values[cpu].enabled;
> >> +			perf_counts(evsel->counts, cpu, 0)->run += values[cpu].running;
> >> +		}
> > 
> > so we sum everything up for all provided bpf IDs,
> > should we count/display them separately?
> 
> I think that's the default behavior with --pid x,y,z or --cpu a,b,c. 
> Do we need to separate them?

ah right, and we have --per-thread that splits the output
for specified pids

I think we should add something like that for bpf, so we
could see stats for specific programs

it's ok to do this as a follow up patch in future

thanks,
jirka

