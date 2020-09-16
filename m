Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C9E26C940
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgIPTFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbgIPRqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:46:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 033DD2223F;
        Wed, 16 Sep 2020 15:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600269024;
        bh=6A4V/iLKJFPMj+LflCxy83lHYDrSIcPmZ7b5SmaqOsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SpkLIwde4Pa5CfLhOdBi988rdtFxhMusqHs4uTo3XYZzlPI54vkzRvN8F3J+Le8/N
         l0Ztdzd8WD6GPRQn2C3yjImtUBAEVmjHeCBjPIS7IVGr91ckGK2eNZOkTHxYEo71y+
         dENohCk/WgVHU00Z0z+c/iE8Dq6ZGMpIrubWBnVA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 10680400E9; Wed, 16 Sep 2020 12:10:22 -0300 (-03)
Date:   Wed, 16 Sep 2020 12:10:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     peterz@infradead.org
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
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
Message-ID: <20200916151021.GS720847@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-17-jolsa@kernel.org>
 <20200914160758.GK160517@kernel.org>
 <CAP-5=fV4Agxe3UMpkbWkh9CuG1tYho413w7xehy0SiMX+tPv1Q@mail.gmail.com>
 <20200916082018.GA2301783@krava>
 <20200916140744.GR720847@kernel.org>
 <20200916141700.GC1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916141700.GC1362448@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 16, 2020 at 04:17:00PM +0200, peterz@infradead.org escreveu:
> On Wed, Sep 16, 2020 at 11:07:44AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Sep 16, 2020 at 10:20:18AM +0200, Jiri Olsa escreveu:
> 
> > > > IIRC BUILD_ID_SIZE is 20 bytes which is the correct size for SHA-1. A
> > > > build ID may be 128-bits (16 bytes) if md5 or uuid hashes are used.
> > > > Should this test just be "> 0" ?
> > > 
> > > ah right, will check on that
> > 
> > And how do you deal with this in the kernel? I.e. to inform userspace,
> > via the PERF_RECORD_MMAP3 (or MMAP2 with that misc bit trick) the size
> > of the build-id?
> 
> The union size is 24 bytes, so there's plenty space to store a length
> field with the buildid.

So, I think we should instead use a bit in the misc field, stating the
kind of build-id, so that we don't waste a byte for that, I think.

- Arnaldo
