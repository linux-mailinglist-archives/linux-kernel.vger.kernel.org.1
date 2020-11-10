Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CFA2ADA5F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbgKJPZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:25:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730231AbgKJPZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:25:50 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3004120797;
        Tue, 10 Nov 2020 15:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605021949;
        bh=+6ef0br250e/7DhBKSu+ZFyLg4W13gH4UJV+liaN8Uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EytIZ8/qiHJlrUph/VtRiZHWCsj88RS+ImuquAn2pwlJpqwRJin565tlDdqnH0mM7
         erpduzI7BOKqZXx5yA0LJ6jIDCOwext4xH/zVyDNvLRts1Fpl+7j5lsnInsy76cagA
         r+hmout4KPoDyf5KQWjIxrSpaCFIMKKtmPalOLAM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C2560411D1; Tue, 10 Nov 2020 12:25:46 -0300 (-03)
Date:   Tue, 10 Nov 2020 12:25:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
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
Message-ID: <20201110152546.GB348806@kernel.org>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-4-jolsa@kernel.org>
 <20201110080716.GU2594@hirez.programming.kicks-ass.net>
 <20201110115426.GA348806@kernel.org>
 <20201110122232.GH2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110122232.GH2594@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 10, 2020 at 01:22:32PM +0100, Peter Zijlstra escreveu:
> On Tue, Nov 10, 2020 at 08:54:26AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Nov 10, 2020 at 09:07:16AM +0100, Peter Zijlstra escreveu:
> > > On Mon, Nov 09, 2020 at 10:53:54PM +0100, Jiri Olsa wrote:
> > > > Adding support to carry build id data in mmap2 event.

> > > > The build id data replaces maj/min/ino/ino_generation
> > > > fields, whichc are also used to identify map's binary,
> > > > so it's ok to replace them with build id data:

> > > >   union {
> > > >           struct {
> > > >                   u32       maj;
> > > >                   u32       min;
> > > >                   u64       ino;
> > > >                   u64       ino_generation;
> > > >           };
> > > >           struct {
> > > >                   u8        build_id[20];
> > > >                   u8        build_id_size;

> > > What's the purpose of a size field for a fixed size array? Also, I'd
> > > flip the order of these fields, first have the size and then the array.

> > There can be different types of build-ids, with different sizes,
> > flipping the order of the fields is indeed sensible, as we could then
> > support even larger build_ids if the need arises :)

> 3 whole bytes.. whooo!

Hey, I agreed with you, flip the order of the fields, right? :-)

- Arnaldo
