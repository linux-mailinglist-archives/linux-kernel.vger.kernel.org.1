Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2047D2AD0D7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgKJIHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJIHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:07:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41500C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 00:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MYqhpQhpO1EPrZMOyFGekxouXW512pEZk99394zds0o=; b=gxiN0KipDaUah/Ku4ZkABeXmue
        Rpn6RjWob3rN06zhVuTsTQd6bHqAk/F15khVK85ov7ydBPPmOXleieYYhaVetfbFA8+mnmzW/pgf7
        XKy9YLUEa4wMooG2l+F1x1XKX47ik0IZgEpQrK40905qYkVeFTD6AjxaGsZXRzKMTAdmKo/IdinfX
        yXwZ8OPkw9nAR32ULg2RDVTKfY9n4GIWL1Tn6UuAWUiRH4vHqbaWp1l0busPT0qEeJBUzYYHga2dN
        Nsb78ScR3BubZievXm1U8/tUn3+k84MiM/46uZ1lF9GTFbcQqKvUQ8a3M3Ypfh4MyHQWo8QA+mzpQ
        SJszm9eA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcOgP-0005ZC-SA; Tue, 10 Nov 2020 08:07:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 05479300455;
        Tue, 10 Nov 2020 09:07:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8D932C09A80A; Tue, 10 Nov 2020 09:07:16 +0100 (CET)
Date:   Tue, 10 Nov 2020 09:07:16 +0100
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
Message-ID: <20201110080716.GU2594@hirez.programming.kicks-ass.net>
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
> Adding support to carry build id data in mmap2 event.
> 
> The build id data replaces maj/min/ino/ino_generation
> fields, whichc are also used to identify map's binary,
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
>                   u8        build_id[20];
>                   u8        build_id_size;

What's the purpose of a size field for a fixed size array? Also, I'd
flip the order of these fields, first have the size and then the array.

>                   u8        __reserved_1;
>                   u16       __reserved_2;
>           };
>   };
> 
> Replaced maj/min/ino/ino_generation fields give us size
> of 24 bytes. We use 20 bytes for build id data, 1 byte
> for size and rest is unused.
