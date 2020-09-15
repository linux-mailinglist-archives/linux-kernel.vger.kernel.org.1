Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202AA269DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgIOFkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:40:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:17894 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgIOFkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:40:18 -0400
IronPort-SDR: TvqxKMP7pJhOBjTmObgDLUjgT2qmFYaaulOkts4wXdaWFShnRaGfyfD9Cw432mvYWu9law1u6x
 iDLlD6W21ogQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="146944481"
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="146944481"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 22:40:14 -0700
IronPort-SDR: EwYZcO5vjGv6521gyVrlX1KlfOwrqg5CEO76PQ2v90FEMoeZsCak0Y8VVCd9C/tmUVyy4It8eu
 jLXaqQRpoRDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="287860234"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by fmsmga008.fm.intel.com with ESMTP; 14 Sep 2020 22:40:09 -0700
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
 <20200914152841.GC160517@kernel.org> <20200914193907.GO1714160@krava>
 <20200914220014.GH166601@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d54e4304-0fea-909f-0089-9c0351341e0a@intel.com>
Date:   Tue, 15 Sep 2020 08:39:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914220014.GH166601@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/20 1:00 am, Arnaldo Carvalho de Melo wrote:
> Em Mon, Sep 14, 2020 at 09:39:07PM +0200, Jiri Olsa escreveu:
>> On Mon, Sep 14, 2020 at 12:28:41PM -0300, Arnaldo Carvalho de Melo wrote:
>>> Em Mon, Sep 14, 2020 at 02:38:27PM +0900, Namhyung Kim escreveu:
>>>> On Mon, Sep 14, 2020 at 6:03 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>>>> Add new version of mmap event. The MMAP3 record is an
>>>>> augmented version of MMAP2, it adds build id value to
>>>>> identify the exact binary object behind memory map:
>  
>>>>>   struct {
>>>>>     struct perf_event_header header;
>  
>>>>>     u32                      pid, tid;
>>>>>     u64                      addr;
>>>>>     u64                      len;
>>>>>     u64                      pgoff;
>>>>>     u32                      maj;
>>>>>     u32                      min;
>>>>>     u64                      ino;
>>>>>     u64                      ino_generation;
>>>>>     u32                      prot, flags;
>>>>>     u32                      reserved;
>  
>>> What for this reserved? its all nicely aligned already, u64 followed by
>>> two u32 (prot, flags).
>  
>>>>>     u8                       buildid[20];
>   
>>>> Do we need maj, min, ino, ino_generation for mmap3 event?
>>>> I think they are to compare binaries, then we can do it with
>>>> build-id (and I think it'd be better)..
>  
>>> Humm, I thought MMAP2 would be a superset of MMAP and MMAP3 would be a
>>> superset of MMAP2.
>  
>>> If we want to ditch useless stuff, then trow away pid, tid too, as we
>>> can select those via sample_type.
>  
>>> Having said that, at this point I don't even know if adding new
>>> PERF_RECORD_ that are an update for a preexisting one is the right way
>>> to proceed.
> 
>>> Perhaps we should attach a BPF program to point where a mmap/munmap is
>>> being done (perf_event_mmap()) and allow userspace to ask for whatever
>>> it wants?  With a kprobes there right now we can implement this MMAP3
>>> easily, no?
>  
>> hmm, I'm always woried about solutions based on kprobes,
>> because once the function is moved/removed you're screwed
>> and need to keep up with function name changes and be
>> backward compatible..
> 
> Well, I'm not advocating to have it as kprobes permanently, but we can
> implement it now using a kprobes, i.e. systems wouldn't have to have its
> kernel updated to have this feature, but once then need, for some other
> reason, to have their kernel upgraded, then perf would notice that there
> is a tracepoint for that and would happily use it.
> 
> So we would be able to use that tracepoint with things like ftrace,
> bpftrace, everything that knows about tracepoints, and perf would get
> build-ids and whatever else is needed to have a mmap record, in the
> future we could even ask for some more (or less) according to the what
> is needed for some new feature.
> 
> I.e. the point wasn't about kprobes was about using BPF to state what
> we want to collect when a mmap is being put in place.

Isn't the problem with krpobes / tracepoints etc that non-privileged users
can't use them.
