Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CCF2AD333
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgKJKKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:10:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726944AbgKJKKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605003053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xTuzSICZJVOCRA//MDjncgjKleDNofqEhxM9/tQOkjA=;
        b=gjamHnqcYZSOgAxqpyfy8a8unppqCNZodHq+BKew60SWp52ZAGU0R8lvUUYiW8oZozukKr
        HaGPBZ4VB+1OJUoQ8NqK0nWHSBqXKIA1ppWgDPUZfI1RC/tFtboT6T6a3SqdD1QQCG8dOj
        cc8ZrSRtnfZdGewjfj5mcXepVx9gH2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-FBkBYW_bMcGUG2Hn2kRA1A-1; Tue, 10 Nov 2020 05:10:49 -0500
X-MC-Unique: FBkBYW_bMcGUG2Hn2kRA1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5397879522;
        Tue, 10 Nov 2020 10:10:46 +0000 (UTC)
Received: from krava (unknown [10.40.195.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id 19FC15C1C4;
        Tue, 10 Nov 2020 10:10:42 +0000 (UTC)
Date:   Tue, 10 Nov 2020 11:10:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 03/24] perf: Add build id data in mmap2 event
Message-ID: <20201110101041.GC387652@krava>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-4-jolsa@kernel.org>
 <20201110082851.GV2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110082851.GV2594@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 09:28:51AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 09, 2020 at 10:53:54PM +0100, Jiri Olsa wrote:
> > There's new misc bit for mmap2 to signal there's build
> > id data in it:
> > 
> >   #define PERF_RECORD_MISC_BUILD_ID              (1 << 14)
> 
> PERF_RECORD_MISC_MMAP_BUILD_ID would be consistent with the existing
> PERF_RECORD_MISC_MMAP_DATA naming.

ok

> 
> Also, AFAICT there's still a bunch of unused bits in misc.
> 
> 	012	    CDEF
> 	|||---------||||
> 
> Where:
> 	0-2	CPUMODE_MASK
> 
> 	C	PROC_MAP_PARSE_TIMEOUT
> 	D	MMAP_DATA / COMM_EXEC / FORK_EXEC / SWITCH_OUT
> 	E	EXACT_IP / SCHED_OUT_PREEMPT
> 	F	(reserved)
> 
> Maybe we should put in a comment to keep track of the hole ?

ook

> 
> Also, perhaps it is time to use F to indicate that @size is in 8 instead
> of 1 ? That would increase our max entry size to 512K, people seem to
> hit his 64K limit (insane as it is).

nice idea, todo updated ;-)

thanks,
jirka

