Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E49B294B90
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441839AbgJUK6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:58:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34522 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410469AbgJUK6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:58:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id i1so2633288wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 03:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PDU9OtKKx2cuis6ZYr3lGtMOcs2YpkAp530qhMluO7Q=;
        b=YBkZyaot2gYd1NHgSGKKmNd1bcFdJTrVn002Cj9z9pEMXQHviAVLsdPc6sXgJ1nZuz
         +h2/UkB1KM4Q8LzffkdcnO6AjtFIrYYozTdqILVdkRdqDUeTeXhaHJaHIzZoNRdfqYcY
         S9edAaDbU5RcZOsi86XR4nHDlEy7l61jET1NIF74VAQHifJZmkWu2at99dzE1k7baxbi
         WBSB1Cjr2NNHlu4I5ckIHg0xPAZMVLUfAyerguX4Zce5X6dC/o5Ayng1FeG/dKAtU40R
         CcuYzyYxP/8+DY1VZ7MxLdOumhgEDQAzr50lEe2DgwSjV3892cu/iOppxZ/UVJrkOSIp
         ssqA==
X-Gm-Message-State: AOAM532VGTLqxl+vtU94d92e61ut0YFqb0udTggVQGtGiJFLLMprgGTn
        YjPRSuXkE//VwZIB+Tmprqxor1XZeZr8FeXR0WM=
X-Google-Smtp-Source: ABdhPJwZAOeEzOH5IRxGiajee4MGN6XXXrAjQChyGALO2OUjS+vCNOR6PqaIPiMEIdD8TYQNpTPtJIn+34Y+dAA2bH8=
X-Received: by 2002:adf:94c6:: with SMTP id 64mr4000495wrr.8.1603277884771;
 Wed, 21 Oct 2020 03:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <39cf6164-f3be-ae34-292a-94faef32fdb9@linux.intel.com> <20201012160921.GD466880@tassilo.jf.intel.com>
 <8f90c785-8bdc-e7cd-a6d9-7eed0fb2c6b3@linux.intel.com> <7216a411-a635-4fcc-b10d-afe1f75509d3@linux.intel.com>
 <CAM9d7cjJzHr7BZ2LVFuG4dnk=i+LmP_TCb9J8FTO0w1w=KG1WQ@mail.gmail.com> <351d6f3a-7c2a-85d7-4b07-4b0468e6c887@linux.intel.com>
In-Reply-To: <351d6f3a-7c2a-85d7-4b07-4b0468e6c887@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Oct 2020 19:57:53 +0900
Message-ID: <CAM9d7ciRu09bRNLbR19m2BjuM46vN6ubf7CUFELeR5-W61O3yA@mail.gmail.com>
Subject: Re: [PATCH v1 06/15] perf session: load data directory into tool
 process memory
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 7:25 PM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> On 21.10.2020 9:54, Namhyung Kim wrote:
> > Hi,
> >
> > On Tue, Oct 13, 2020 at 8:30 PM Alexey Budankov
> > <alexey.budankov@linux.intel.com> wrote:
> >> On 12.10.2020 19:49, Alexey Budankov wrote:
> >>> On 12.10.2020 19:09, Andi Kleen wrote:
> >>>> On Mon, Oct 12, 2020 at 11:58:58AM +0300, Alexey Budankov wrote:
> >>>>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> >>>>> index 6afc670fdf0c..0752eec19813 100644
> >>>>> --- a/tools/perf/util/session.c
> >>>>> +++ b/tools/perf/util/session.c
> >>>>> @@ -2212,6 +2212,17 @@ reader__process_events(struct reader *rd, struct perf_session *session,
> >>>>>             goto more;
> >>>>>
> >>>>>  out:
> >>>>> +   if (rd->unmap_file) {
> >>>>> +           int i;
> >>>>> +
> >>>>> +           for (i = 0; i < NUM_MMAPS; i++) {
> >>>>> +                   if (mmaps[i]) {
> >>>>> +                           munmap(mmaps[i], mmap_size);
> >>>>> +                           mmaps[i] = NULL;
> >>>>
> >>>> Okay so where is the mmap? Would make more sense to put that
> >>>> into the same patch as who adds the mmap. Or is the mmap
> >>>> code already in the perf source? In that case it should
> >>>> probably be some common helper with the existing users.
> >>>
> >>> That mmap is already in the code. Agree, this part of the patch
> >>> can be applied prior the whole patch set.
> >>
> >> I take it back. Single trace file can't be unmapped yet since it also
> >> contains not only compressed records but also other records backing
> >> the data for aggregated analysis.
> >
> > Are you talking about the auxtrace?
> >
> > I thought everything will be compressed when it's enabled.
> > But if it's only for the auxtrace, maybe we can unmap them
> > with checking it as it's not the common case?
>
> I am about primary trace file. Together with PERF_RECORD_COMPRESSED
> records it contains the other records with uncompressed data (MMAP,
> FORk, COMM etc.) so it is still unsafe to unmap the trace file after
> loading.

Oh, I think all the events coming from the kernel share the mmap
buffer so they will be compressed with SAMPLEs.  Note that
synthesized events have 0 timestamp which means that they
are not queued in the ordered events and processed immediately.

IIUC, here we unmap the original mmap buffer and the actual data
in MMAP/FORK/... is kept in the decomp data buffer, no?

Thanks
Namhyung
