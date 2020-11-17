Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA2E2B5E15
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgKQLNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 06:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKQLNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:13:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E0CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 03:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/2a/sPDlsWwmun8lGMBoMfY91XSPRk9t25Rnf1cJdJc=; b=mA7uo/bnEkMVo3K/a1r0gZBIXl
        UHXkYmV2UNP88FBH+GzBT44jzqNhXRQsteMT24FP5bETOOW2VsvFqE1ytDYezw16IWY0c62A3mFm3
        zf8JCxjuvZiXc4o/zBI3kfeOICgJ+xi0C4x0NCCUZl/BB8/0Y2Oh80vcNbthjkz7kAOzFcsXTh8v4
        0hXBP6k4O3oi/OwfchLFvatlyB7GLM/nEE5IgyldRcPDsqLiK5xsGu9B/gaR0s0cjSCL73expha5+
        W0qC15Q+8FXFkiyQrGFebYby1b2CQsb1iCKecfH01lmxawf0Hu+IadOj5EHzBL9DmGTW5Cthq3fCJ
        Ijc139PA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1keyvY-000483-Mf; Tue, 17 Nov 2020 11:13:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AA38305CC3;
        Tue, 17 Nov 2020 12:13:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E53E1200E61C9; Tue, 17 Nov 2020 12:13:34 +0100 (CET)
Date:   Tue, 17 Nov 2020 12:13:34 +0100
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
Message-ID: <20201117111334.GL3121392@hirez.programming.kicks-ass.net>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117110053.1303113-4-jolsa@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 12:00:32PM +0100, Jiri Olsa wrote:
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
> 
> Replaced maj/min/ino/ino_generation fields give us size
> of 24 bytes. We use 20 bytes for build id data, 1 byte
> for size and rest is unused.
> 
> There's new misc bit for mmap2 to signal there's build
> id data in it:
> 
>   #define PERF_RECORD_MISC_MMAP_BUILD_ID   (1 << 14)
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Seems sane enough; how do we want to route this?

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
