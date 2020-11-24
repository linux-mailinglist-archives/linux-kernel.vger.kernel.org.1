Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FC82C316D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgKXTvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:51:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28841 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726799AbgKXTvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606247481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IBdeFHfdPwQHcGBojesoPCwJHSb7KaOli7Ptx4I5FwM=;
        b=a6U6NLqxzjIps0iZOgGpQIGsAihZpKRr4nY3APngRLx/9ZwYgz0j4d8wi6vB3SPeYNDAp2
        AxgGyqGQzuypM4bT5oNAD7s8wXGoLrSHoIQ/mypU4Ug0O9Vnj/8jrGfjLn2oNmJwW9kj/+
        9ClpXX3nET+NxJaO99+c0LNHKrn5ejw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-FazsZlJ5NUaLYGT7qnU7iQ-1; Tue, 24 Nov 2020 14:51:12 -0500
X-MC-Unique: FazsZlJ5NUaLYGT7qnU7iQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FE2E1074640;
        Tue, 24 Nov 2020 19:51:11 +0000 (UTC)
Received: from krava (unknown [10.40.192.200])
        by smtp.corp.redhat.com (Postfix) with SMTP id 54EDE5C1A1;
        Tue, 24 Nov 2020 19:51:09 +0000 (UTC)
Date:   Tue, 24 Nov 2020 20:51:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [RFC 2/2] perf-stat: enable counting events for BPF programs
Message-ID: <20201124195108.GB2164284@krava>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119045046.1491106-3-songliubraving@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 08:50:46PM -0800, Song Liu wrote:

SNIP

> +static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu,
> +					    int fd)
> +{
> +	struct bpf_prog_profiler_bpf *skel = evsel->bpf_counter.skel;
> +
> +	return bpf_map_update_elem(bpf_map__fd(skel->maps.events),
> +				   &cpu, &fd, BPF_ANY);
> +}
> +
> +struct bpf_counter_ops bpf_program_profiler_ops = {
> +	.load       = bpf_program_profiler__load,
> +	.enable	    = bpf_program_profiler__enable,
> +	.read       = bpf_program_profiler__read,
> +	.destroy    = bpf_program_profiler__destroy,
> +	.install_pe = bpf_program_profiler__install_pe,
> +};

hum, what's the point of this ops? you plan some other ops?
we could just define stat callbacks right?

> +SEC("fentry/XXX")
> +int BPF_PROG(fentry_XXX)
> +{
> +	u32 key = bpf_get_smp_processor_id();
> +	struct bpf_perf_event_value reading;
> +	struct bpf_perf_event_value *ptr;
> +	u32 zero = 0;
> +	long err;
> +
> +	/* look up before reading, to reduce error */
> +	ptr = bpf_map_lookup_elem(&fentry_readings, &zero);
> +	if (!ptr)
> +		return 0;
> +
> +	err = bpf_perf_event_read_value(&events, key, &reading,
> +					sizeof(reading));
> +	if (err)
> +		return 0;
> +
> +	*ptr = reading;
> +	return 0;
> +}

so currently it's one extra bpf program for each event,
but it seems bad for multiple events stat.. could we
just have one program that would read and process all events?

thanks,
jirka

