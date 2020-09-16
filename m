Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD2426CC07
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIPRIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgIPREy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:04:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EF2C02C29B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h194zDjKCgpYG7MPI4i/GzOkGiJq+ak7wvcj7cCoG6c=; b=Kklb/NYwp0ItvPZ3Er2HsfHWJC
        EojlcOokFLXSlMFVIzbT646Uum6wriSQS3GJolcaH2KK5urBum9a3PpZpWft5OPbZtiqENZPYl06g
        rLJ3Vohwahqo17mQJkc4FLsnDAWCTUhwHorXNv/mqJuieC3P3IINoYpCmr8Hup18FBOH5craMmPTS
        CQBqLo8WKv2f2IeDL1iUpT0l09+Oy96DBDeYraz8cdVa5sCpOxY7bcbFubxxg2eT3bK20UQR6T7oX
        sulYwraMWrUlIIeQAoUl3d17j0gZFBxpPqn+7H6fLJRHmuCHkZ6boBQr9cbLzaSAfz5HU845Qz8nO
        pb8yWQqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIZEG-0006xD-E4; Wed, 16 Sep 2020 15:20:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 909C73019CE;
        Wed, 16 Sep 2020 17:20:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 708C82B9285F2; Wed, 16 Sep 2020 17:20:13 +0200 (CEST)
Date:   Wed, 16 Sep 2020 17:20:13 +0200
From:   peterz@infradead.org
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <20200916152013.GD1362448@hirez.programming.kicks-ass.net>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-17-jolsa@kernel.org>
 <20200914160758.GK160517@kernel.org>
 <CAP-5=fV4Agxe3UMpkbWkh9CuG1tYho413w7xehy0SiMX+tPv1Q@mail.gmail.com>
 <20200916082018.GA2301783@krava>
 <20200916140744.GR720847@kernel.org>
 <20200916141700.GC1362448@hirez.programming.kicks-ass.net>
 <20200916151021.GS720847@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916151021.GS720847@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 12:10:21PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 16, 2020 at 04:17:00PM +0200, peterz@infradead.org escreveu:
> > On Wed, Sep 16, 2020 at 11:07:44AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Sep 16, 2020 at 10:20:18AM +0200, Jiri Olsa escreveu:
> > 
> > > > > IIRC BUILD_ID_SIZE is 20 bytes which is the correct size for SHA-1. A
> > > > > build ID may be 128-bits (16 bytes) if md5 or uuid hashes are used.
> > > > > Should this test just be "> 0" ?
> > > > 
> > > > ah right, will check on that
> > > 
> > > And how do you deal with this in the kernel? I.e. to inform userspace,
> > > via the PERF_RECORD_MMAP3 (or MMAP2 with that misc bit trick) the size
> > > of the build-id?
> > 
> > The union size is 24 bytes, so there's plenty space to store a length
> > field with the buildid.
> 
> So, I think we should instead use a bit in the misc field, stating the
> kind of build-id, so that we don't waste a byte for that, I think.

There's no wastage:

	u32 min, maj;
	u64 ino;
	u64 ino_generation;

is 24 bytes, buildit is 20 bytes, that leaves us 4 bytes to encode the
buildid type without growing anything.
