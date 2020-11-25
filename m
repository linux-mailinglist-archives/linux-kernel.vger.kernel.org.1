Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9903D2C4586
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbgKYQoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:44:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730291AbgKYQoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606322650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1x5ldeypHKqgSD2erJagGTCtFUho7Af4kwDff883iVQ=;
        b=TMRdnRBISkVCLqlxwxEaHNDUomc9gijivPuQHd/dLv8A89iDS10tXtuBaW+39UsJVgDyNn
        3Kc75m5DKOTL6dYrZ4nNad2cQbEJaR8wLnWdJTiMP0KB4SPKMjH7QHnT50R2p+3AbhKNL1
        94FzBu1xjb4e6mEIQeJuTJwoLlvHMl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-8ZAIy8PbPY6Ht9RfYmeCUg-1; Wed, 25 Nov 2020 11:44:01 -0500
X-MC-Unique: 8ZAIy8PbPY6Ht9RfYmeCUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B946107ACE3;
        Wed, 25 Nov 2020 16:44:00 +0000 (UTC)
Received: from krava (unknown [10.40.192.200])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0789160BE2;
        Wed, 25 Nov 2020 16:43:57 +0000 (UTC)
Date:   Wed, 25 Nov 2020 17:43:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [RFC 2/2] perf-stat: enable counting events for BPF programs
Message-ID: <20201125164357.GN2164284@krava>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-3-songliubraving@fb.com>
 <20201124195108.GB2164284@krava>
 <3331CA57-F1EE-4C66-8E79-E5A7DA91F880@fb.com>
 <AA26382B-BF8C-4768-A9C5-0E7476197447@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AA26382B-BF8C-4768-A9C5-0E7476197447@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 12:02:13AM +0000, Song Liu wrote:
> 
> 
> > On Nov 24, 2020, at 3:43 PM, Song Liu <songliubraving@fb.com> wrote:
> > 
> > 
> > 
> >> On Nov 24, 2020, at 11:51 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> >> 
> >> On Wed, Nov 18, 2020 at 08:50:46PM -0800, Song Liu wrote:
> >> 
> >> SNIP
> >> 
> >>> +static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu,
> >>> +					    int fd)
> >>> +{
> >>> +	struct bpf_prog_profiler_bpf *skel = evsel->bpf_counter.skel;
> >>> +
> >>> +	return bpf_map_update_elem(bpf_map__fd(skel->maps.events),
> >>> +				   &cpu, &fd, BPF_ANY);
> >>> +}
> >>> +
> >>> +struct bpf_counter_ops bpf_program_profiler_ops = {
> >>> +	.load       = bpf_program_profiler__load,
> >>> +	.enable	    = bpf_program_profiler__enable,
> >>> +	.read       = bpf_program_profiler__read,
> >>> +	.destroy    = bpf_program_profiler__destroy,
> >>> +	.install_pe = bpf_program_profiler__install_pe,
> >>> +};
> >> 
> >> hum, what's the point of this ops? you plan some other ops?
> >> we could just define stat callbacks right?
> 
> Which callbacks do you mean here? I would like to try that as
> well. 

I meant just to drop that ops struct and have load/enable/read..
functions called from stat code

jirka

