Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716E726CD59
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgIPU6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbgIPQdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:33:15 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 151CC22288;
        Wed, 16 Sep 2020 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600270962;
        bh=AnwlNmtnOynVuh2z7BTPG/HzLHmCwkA8RYapHph0iKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yYHsivDVhiM9Ai44rki7DnkAeYAvcS4RSXKbhNS2d2zNis4SBaaE/4lPMMgyxid0f
         adx/DMBOAqSqz3jJ3VEvDH1XlPEiLZYAiKhLCFNC+JLaHmxNDxYrjBibovURc7d0lq
         rgOfnBXUllBjmUUHmeYWRzQWquC549Of+auteO5A=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6BA1F400E9; Wed, 16 Sep 2020 12:42:39 -0300 (-03)
Date:   Wed, 16 Sep 2020 12:42:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     peterz@infradead.org, Ian Rogers <irogers@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 16/26] perf tools: Synthesize modules with mmap3
Message-ID: <20200916154239.GT720847@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-17-jolsa@kernel.org>
 <20200914160758.GK160517@kernel.org>
 <CAP-5=fV4Agxe3UMpkbWkh9CuG1tYho413w7xehy0SiMX+tPv1Q@mail.gmail.com>
 <20200916082018.GA2301783@krava>
 <20200916140744.GR720847@kernel.org>
 <20200916141700.GC1362448@hirez.programming.kicks-ass.net>
 <20200916151021.GS720847@kernel.org>
 <20200916152123.GH2301783@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916152123.GH2301783@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 16, 2020 at 05:21:23PM +0200, Jiri Olsa escreveu:
> On Wed, Sep 16, 2020 at 12:10:21PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Sep 16, 2020 at 04:17:00PM +0200, peterz@infradead.org escreveu:
> > > On Wed, Sep 16, 2020 at 11:07:44AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Wed, Sep 16, 2020 at 10:20:18AM +0200, Jiri Olsa escreveu:

> > > > > > IIRC BUILD_ID_SIZE is 20 bytes which is the correct size for SHA-1. A
> > > > > > build ID may be 128-bits (16 bytes) if md5 or uuid hashes are used.
> > > > > > Should this test just be "> 0" ?

> > > > > ah right, will check on that

> > > > And how do you deal with this in the kernel? I.e. to inform userspace,
> > > > via the PERF_RECORD_MMAP3 (or MMAP2 with that misc bit trick) the size
> > > > of the build-id?

> > > The union size is 24 bytes, so there's plenty space to store a length
> > > field with the buildid.
 
> > So, I think we should instead use a bit in the misc field, stating the
> > kind of build-id, so that we don't waste a byte for that, I think.
 
> not sure there's too many misc bits left if there would be more
> build id kinds

So, Ian mentioned a few types of build ids, if there are not that many
misc bits left for PERF_RECORD_MMAP2, then yeah, we can then use one
byte and use it as a PERF_RECORD_MMAP2 specific misc bits, me may want
to have something else in the future, like we're now reusing those ino,
etc, to instead store a build-id.

But we're closing in to a final solution, and that is good. :-)

- Arnaldo
