Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35012A8E45
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 05:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKFEWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 23:22:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40168 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFEWL (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 23:22:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id k18so110214wmj.5
        for <Linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 20:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yaOz8rpy4YZVVYrFTQpdIbOhwzCCvaA9JIQK3PIcPlY=;
        b=CYN+OkiMc9i34Ulyeo7eFzFI4y1SEwkbWzHBdUCRug31vzUQ2nVQsgA5EEkyvIEoY/
         PW1beuKRyxypEGJFcrSZWafi0BnQ1P241BsAl4F1v8zUJoeVSLtILCltbCoEJ/uWcHVT
         8GlfC8ZEKaNVEadUAfifeB8mglBozIyeh5cDqqTa12FinHFkanXWjpvowC7cwBDBvLj4
         7X7Px5TTydZUuLCl5AT+Tu0saVM4Mbc8zbLY8DA9602TFkdGnEDMh53jcpe6P8PKRN8l
         D9mgpdEqCIbyac47XrZ6FZXmBwsjB+qQ0P327akSwXB9zrHe8YOWmf/2U5fBlwRJf9z/
         VthA==
X-Gm-Message-State: AOAM531t7Vomw/IRdj7bciwBw+fuf2HsXx562m+GctdQTFQaRs2uqLwn
        iqucDZaS65n0kgadrru6GZNaCf/St8LEXMJAYrE=
X-Google-Smtp-Source: ABdhPJyllKqrIiheuxS4r5w3yr66esEK50n6cR5cZOoOKkxaVrzihZE7AwxTKR2x+V9Y7yTV0sVNRdFjRyVlQWtsKOc=
X-Received: by 2002:a1c:9ad3:: with SMTP id c202mr232474wme.43.1604636529508;
 Thu, 05 Nov 2020 20:22:09 -0800 (PST)
MIME-Version: 1.0
References: <20201104015102.30363-1-yao.jin@linux.intel.com>
 <20201106030018.GA359712@google.com> <93fae76f-ce2b-ab0b-3ae9-cc9a2b4cbaec@linux.intel.com>
In-Reply-To: <93fae76f-ce2b-ab0b-3ae9-cc9a2b4cbaec@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 6 Nov 2020 13:21:58 +0900
Message-ID: <CAM9d7chhrYh1hmHkw8NKkwEHDoU0q2ArpOj3NGm0_RiQ7eSuxQ@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events: Update Skylake client events to v50
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, yao.jin@intel.com,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 12:12 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
>
> Hi Namhyung,
>
> On 11/6/2020 11:00 AM, Namhyung Kim wrote:
> > Hi,
> >
> > On Wed, Nov 04, 2020 at 09:51:02AM +0800, Jin Yao wrote:
> >> - Update Skylake events to v50.
> >> - Update Skylake JSON metrics from TMAM 4.0.
> >> - Fix the issue in DRAM_Parallel_Reads
> >> - Fix the perf test warning
> >>
> >> Before:
> >>
> >> root@kbl-ppc:~# perf stat -M DRAM_Parallel_Reads -- sleep 1
> >> event syntax error: '{arb/event=0x80,umask=0x2/,arb/event=0x80,umask=0x2,thresh=1/}:W'
> >>                       \___ unknown term 'thresh' for pmu 'uncore_arb'
> >>
> >> valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,percore
> >>
> >> Initial error:
> >> event syntax error: '..umask=0x2/,arb/event=0x80,umask=0x2,thresh=1/}:W'
> >>                                    \___ Cannot find PMU `arb'. Missing kernel support?
> >>
> >> root@kbl-ppc:~# perf test metrics
> >> 10: PMU events                                 :
> >> 10.3: Parsing of PMU event table metrics               : Skip (some metrics failed)
> >> 10.4: Parsing of PMU event table metrics with fake PMUs: Ok
> >> 67: Parse and process metrics                  : Ok
> >>
> >> After:
> >>
> >> root@kbl-ppc:~# perf stat -M MEM_Parallel_Reads -- sleep 1
> >>
> >>   Performance counter stats for 'system wide':
> >>
> >>           4,951,646      arb/event=0x80,umask=0x2/ #    26.30 MEM_Parallel_Reads       (50.04%)
> >>             188,251      arb/event=0x80,umask=0x2,cmask=1/                                     (49.96%)
> >>
> >>         1.000867010 seconds time elapsed
> >>
> >> root@kbl-ppc:~# perf test metrics
> >> 10: PMU events                                 :
> >> 10.3: Parsing of PMU event table metrics               : Ok
> >> 10.4: Parsing of PMU event table metrics with fake PMUs: Ok
> >> 67: Parse and process metrics                  : Ok
> >>
> >> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> >
> > It seems not applied to acme/perf/core cleanly.
> >
> > Thanks,
> > Namhyung
> >
>
> It seems the patch mail is truncated. :(
>
> I attach the patch file in the mail. Sorry for inconvenience.

I've checked it fixed the perf test on my laptop (skylake).

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
