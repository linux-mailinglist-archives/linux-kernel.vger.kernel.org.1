Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E7A2B5105
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgKPTYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:24:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgKPTYn (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:24:43 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B47052225B;
        Mon, 16 Nov 2020 19:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605554682;
        bh=pnV3gWTYV5KG3s3FHVWblN1cCZpCxpWkH37G0pRehr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GbEG72eEUkAdwlc0l8ynXToFOIn2dy3UU72BjvQxf5CcoOxLbv1hF2PkStWJvKzfg
         oOfQ2VCcCfJ2oj6FwrPbfwY8SS9ji5usUM/oFJ/rLc4+qqReH+7Cj4m8nQ0BMM67nA
         3+yEZd0jB1lLeZ+tlBzW6J+suXT0l2gu/ojOO5kE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A454C40E29; Mon, 16 Nov 2020 16:24:40 -0300 (-03)
Date:   Mon, 16 Nov 2020 16:24:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Jin, Yao" <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
Subject: Re: [PATCH] perf vendor events: Update Skylake client events to v50
Message-ID: <20201116192440.GC614220@kernel.org>
References: <20201104015102.30363-1-yao.jin@linux.intel.com>
 <20201106030018.GA359712@google.com>
 <93fae76f-ce2b-ab0b-3ae9-cc9a2b4cbaec@linux.intel.com>
 <CAM9d7chhrYh1hmHkw8NKkwEHDoU0q2ArpOj3NGm0_RiQ7eSuxQ@mail.gmail.com>
 <20201116170553.GG509215@kernel.org>
 <CAP-5=fXJCqB6sN+f-eRSwc+Za3Yri+QWMpg_G7xfz=i-cTBH3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXJCqB6sN+f-eRSwc+Za3Yri+QWMpg_G7xfz=i-cTBH3A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 16, 2020 at 11:12:30AM -0800, Ian Rogers escreveu:
> On Mon, Nov 16, 2020 at 9:05 AM Arnaldo Carvalho de Melo <acme@kernel.org>
> wrote:
> 
> > Em Fri, Nov 06, 2020 at 01:21:58PM +0900, Namhyung Kim escreveu:
> > > On Fri, Nov 6, 2020 at 12:12 PM Jin, Yao <yao.jin@linux.intel.com>
> > wrote:
> > > > >> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > > >
> > > > > It seems not applied to acme/perf/core cleanly.
> > > > >
> > > > > Thanks,
> > > > > Namhyung
> > > > >
> > > >
> > > > It seems the patch mail is truncated. :(
> > > >
> > > > I attach the patch file in the mail. Sorry for inconvenience.
> > >
> > > I've checked it fixed the perf test on my laptop (skylake).
> > >
> > > Tested-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Thanks, applied.
> >
> > - Arnaldo
> >
> 
> Nit, as the code is generated, would it be possible to add the commands to
> regenerate it?
> 
> E.g. Using the code in:
> https://github.com/intel/event-converter-for-linux-perf
> And extracted perfmon_server_events_v1.4.tar from:
> https://download.01.org/perfmon/
> run:
> json-to-perf-json.py --outdir tools/perf/pmu-events/arch/arch/x86/sklylakex
> perfmon/SKX/skylakex_core_v1.24.json
 
> Looking at the download.01.org/perfmon json there are files
> like skylakex_fp_arith_inst_v1.24.json, and how these are incorporated into
> these events is less than clear.

You mean change event-converter-for-linux-perf to add this as JSON
comments at the start of the generated files?


- Arnaldo
