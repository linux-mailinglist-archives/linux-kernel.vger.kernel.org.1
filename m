Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65D526A8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 17:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgIOPX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 11:23:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45006 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgIOOtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:49:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id s12so3606380wrw.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItQ0nM5B0+qFWtFQQEn6wTyRTgalEUArLdIK0Xz75h4=;
        b=GGiGYCHETQqZ+yaJUhjnF2t+g4+/zGyvu1o/IiMLWvCmsKd6HecrMjXU81QRHltDNe
         LB0T8FHTljX1/02Zb1Qop3NzBllOS/tfWVrTpizXYxUCqlwowDPGo5X8rB/awNvImfwA
         eUqsEboGW1nvtpd43kJgcn6+xI9qnBjj9US9ZH3JJ2IHBeq2nHiOWzDGLyi/drPkCIbE
         WjhjGQ1gRs2fzuY4ri2XGVIxCIGANrpmyPK+3TA021O9bkJZ1GF86Pzkp8VScw+7I0d6
         MOfUEZevFhQ8kZo316JVJDJCTnX89qVa4SS1t1TD4sOUONxUqOAH/5ih9cS2uYElyF4T
         DYcg==
X-Gm-Message-State: AOAM530ElfMqLfarOm/Vs6/h23orlQer8LssAzCd5TFEV86q9PxHsbeY
        Qw65Iu7zQ6DGrjv6PEbd4R39dHR4rwOfzmJAW90=
X-Google-Smtp-Source: ABdhPJy4ybeK9Lq8Ha0sVNYkZl/pY3bCdAmT1q0fSzxGDMy0IyMuGS2Tq4uv3c6qmRe5wzah5iSYk9br2Z9SX5dAzdE=
X-Received: by 2002:adf:8b48:: with SMTP id v8mr21914021wra.21.1600181393310;
 Tue, 15 Sep 2020 07:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200915031819.386559-1-namhyung@kernel.org> <CAP-5=fXejVaQa9qfW66cY77qB962+jbe8tT5bsLoOOcFmODnWQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXejVaQa9qfW66cY77qB962+jbe8tT5bsLoOOcFmODnWQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 15 Sep 2020 23:49:42 +0900
Message-ID: <CAM9d7cjTgq8CqUziS5dUskUXYB7T9z-JxiNymMWOEQ3=VRXNrQ@mail.gmail.com>
Subject: Re: [PATCHSET v2 00/11] perf tools: Fix various memory leaks
To:     Ian Rogers <irogers@google.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Tue, Sep 15, 2020 at 2:15 PM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Sep 14, 2020 at 8:18 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > I've found and fixed a bunch of memory leaks during perf pmu and
> > metric tests with address sanitizer.  Before this, the tests were
> > mostly failed due to the leaks since ASAN makes it return non-zero.
> >
> > Now I'm seeing no error with ASAN like below:
> >
> >   $ ./perf test pmu metric
> >    9: Parse perf pmu format                                 : Ok
> >   10: PMU events                                            :
> >   10.1: PMU event table sanity                              : Ok
> >   10.2: PMU event map aliases                               : Ok
> >   10.3: Parsing of PMU event table metrics                  : Skip (some metrics failed)
> >   10.4: Parsing of PMU event table metrics with fake PMUs   : Ok
> >   67: Parse and process metrics                             : Ok
> >
> > The failure in 10.3 seems due to parse errors like below:
> >
> >   Multiple errors dropping message: unknown term 'filter_opc' for pmu 'uncore_cbox_0'
> >   (valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,
> >                 branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,
> >                 nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size)
> >
> >
> >   Parse event failed metric 'DRAM_Parallel_Reads' id 'arb/event=0x80,umask=0x2,thresh=1/'
> >     expr 'arb@event\=0x80\,umask\=0x2@ / arb@event\=0x80\,umask\=0x2\,thresh\=1@'
> >   Error string 'unknown term 'thresh' for pmu 'uncore_arb'' help
> >     'valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,
> >                   branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,
> >                   nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size'
>
> The 10.3 failure seems to be a problem in the skl metric DRAM_Parallel_Reads:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json?h=perf/core#n319
> arb@event\\=0x80\\,umask\\=0x2@ / arb@event\\=0x80\\,umask\\=0x2\\,thresh\\=1@
>
> The test failure message is:
> Parse event failed metric 'DRAM_Parallel_Reads' id
> 'arb/event=0x80,umask=0x2,thresh=1/' expr
> 'arb@event\=0x80\,umask\=0x2@ /
> arb@event\=0x80\,umask\=0x2\,thresh\=1@'
> Error string 'unknown term 'thresh' for pmu 'uncore_arb'' help 'valid
> terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size'
>
> The 01.org version of this from:
> https://download.01.org/perfmon/TMA_Metrics.xlsx
> is:
> UNC_ARB_TRK_OCCUPANCY.DATA_READ / UNC_ARB_TRK_OCCUPANCY.DATA_READ:c1
>
> It seems that :c1 has been translated into thresh=1 but that thresh
> doesn't exist as a format option (just "cmask edge event inv umask"
> are present). I wonder if Andi or Jin you could look into this broken
> metric?

Thanks for the explanation. It'd be nice if Intel folks can take a look..

Thanks
Namhyung
