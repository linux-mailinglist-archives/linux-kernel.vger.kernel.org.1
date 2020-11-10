Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453072AD14D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgKJI3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJI3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:29:10 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B579C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 00:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MTClELRHKyU2TjgtYpv32+wHm9fs7/69FtLMOSW87OI=; b=ExwHlle+8ryYuDlhYtI8il6gZA
        W5sf/VIy3hA6RqG9cPxd0vMYKUb2uZWMRKyPwu5/QnZaNFAIhPCXi8aide0yTdMLQlZBtZJFdlFlo
        t8LokaOBXe2RP6FrDpFSBL93Fe1hb2YQKWE+SQpZn1woeDjrHHCc6VC3drWOMU+B2RzBNVAB37VEs
        KsEF6lM7nZxVOLdlMtHRCsA1VfJZVhURpVyXtKEQkdXJy5rAblCdrVIbtc78SJoxETmN6YJ5JT9Eh
        25MmG52WBaLkXVFUFgYVx41GyXXGZtaYAx2SwWsU1WlJE96JbMWw9d40nzkpsO0LedfX+ktLZOan/
        oJcR/bPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcP1M-0005IP-IQ; Tue, 10 Nov 2020 08:28:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C2CE300455;
        Tue, 10 Nov 2020 09:28:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04DD72B81AABD; Tue, 10 Nov 2020 09:28:51 +0100 (CET)
Date:   Tue, 10 Nov 2020 09:28:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <20201110082851.GV2594@hirez.programming.kicks-ass.net>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109215415.400153-4-jolsa@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 10:53:54PM +0100, Jiri Olsa wrote:
> There's new misc bit for mmap2 to signal there's build
> id data in it:
> 
>   #define PERF_RECORD_MISC_BUILD_ID              (1 << 14)

PERF_RECORD_MISC_MMAP_BUILD_ID would be consistent with the existing
PERF_RECORD_MISC_MMAP_DATA naming.

Also, AFAICT there's still a bunch of unused bits in misc.

	012	    CDEF
	|||---------||||

Where:
	0-2	CPUMODE_MASK

	C	PROC_MAP_PARSE_TIMEOUT
	D	MMAP_DATA / COMM_EXEC / FORK_EXEC / SWITCH_OUT
	E	EXACT_IP / SCHED_OUT_PREEMPT
	F	(reserved)

Maybe we should put in a comment to keep track of the hole ?

Also, perhaps it is time to use F to indicate that @size is in 8 instead
of 1 ? That would increase our max entry size to 512K, people seem to
hit his 64K limit (insane as it is).
