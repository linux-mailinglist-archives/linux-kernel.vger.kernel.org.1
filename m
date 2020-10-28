Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5384129D922
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389170AbgJ1Woc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:44:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41078 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbgJ1Wmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:42:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id l24so1150851edj.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nTu8HSZPYQi/ur9eY3P0aVQ8opJHrdSYJq3buXy8FI=;
        b=i3SUBDTEj2cYN+cn9ZwsnzmU5zfnF6RYGr83PDJsKs+BxH8bhNULJ2orAbl9aZ23md
         qsRmDcMXI1CgdwN8mY2C8kLmhQ4VLc8kBnFl3YHBdyNImeEQ23pozB6ND2BRIKZBdzP5
         XNjsh/aTx4Gda7Lsj/qsRSPsz+Au2st1+BFKvaLm+ugXDxZoMe2uZlbNHepUAcQLNCsp
         81KWkHpURKr4jaHAhRiWu7AYO6SDtuLEckz3RC4Y/r0yKlKmaAjb9CiAMCrO0U8fUurI
         dG9O/K85UNX45n3xLF6GkDMcEZ9bTXLAJbXGXmpG4zk3qTwyfY3fRTWV8lZt42ZWfNLB
         cqFQ==
X-Gm-Message-State: AOAM532CePqiNI58RB31TDwFAuvKw/Yj8CxobgXdTMPo0o6aOzidpzU3
        VAzkKizWtgyafjQ8L4jrH1mL08oqKgxN8kfV+va8AWEg
X-Google-Smtp-Source: ABdhPJy08Z73TPw2xMg74bnTFF5RuTnoAMnLfECxeI6k0XGNzXFqgjjeZkL6uadJS+9aIKFbaT0dM7akQjVI2e98JNk=
X-Received: by 2002:adf:a553:: with SMTP id j19mr6978128wrb.349.1603868911044;
 Wed, 28 Oct 2020 00:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <20201024154309.GA2589351@krava> <01bad2c4-4188-f5f5-452e-a0ea0672a187@linux.intel.com>
 <20201027121013.GE2900849@krava> <9c76b415-2610-14f8-37d4-461d0d5c078b@linux.intel.com>
In-Reply-To: <9c76b415-2610-14f8-37d4-461d0d5c078b@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 28 Oct 2020 16:08:20 +0900
Message-ID: <CAM9d7checZ0j9BfpXhoH27GVB-OnGvjWCDnsai_Bu5VgAeuZeA@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] Introduce threaded trace streaming for basic
 perf record operation
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 28, 2020 at 1:02 AM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> On 27.10.2020 15:10, Jiri Olsa wrote:
> > On Mon, Oct 26, 2020 at 08:59:01PM +0300, Alexey Budankov wrote:
> >>
> >> On 24.10.2020 18:43, Jiri Olsa wrote:
> >>> On Wed, Oct 21, 2020 at 06:52:43PM +0300, Alexey Budankov wrote:
> >>>>
> >>>> Changes in v2:
> >>>> - explicitly added credit tags to patches 6/15 and 15/15,
> >>>>   additionally to cites [1], [2]
> >>>> - updated description of 3/15 to explicitly mention the reason
> >>>>   to open data directories in read access mode (e.g. for perf report)
> >>>> - implemented fix for compilation error of 2/15
> >>>> - explicitly elaborated on found issues to be resolved for
> >>>>   threaded AUX trace capture
> >>>>
> >>>> v1: https://lore.kernel.org/lkml/810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com/
> >>>>
> >>>> Patch set provides threaded trace streaming for base perf record
> >>>> operation. Provided streaming mode (--threads) mitigates profiling
> >>>> data losses and resolves scalability issues of serial and asynchronous
> >>>> (--aio) trace streaming modes on multicore server systems. The patch
> >>>> set is based on the prototype [1], [2] and the most closely relates
> >>>> to mode 3) "mode that creates thread for every monitored memory map".
> >>>
> >>> so what I liked about the previous code was that you could
> >>> configure how the threads would be created
> >>>
> >>> default --threads options created thread for each cpu like
> >>> in your change:
> >>>
> >>>   $ perf record -v --threads ...
> >>>   ...
> >>>   thread 0 monitor: 0 allowed: 0
> >>>   thread 1 monitor: 1 allowed: 1
> >>>   thread 2 monitor: 2 allowed: 2
> >>>   thread 3 monitor: 3 allowed: 3
> >>>   thread 4 monitor: 4 allowed: 4
> >>>   thread 5 monitor: 5 allowed: 5
> >>>   thread 6 monitor: 6 allowed: 6
> >>>   thread 7 monitor: 7 allowed: 7
> >>
> >> Yes, it is configurable in the prototype. Even though this patch set
> >> doesn't implement that parameters for --thread option, just because
> >> VTune doesn't have use cases for that yet, it has still been designed
> >> and implemented with that possible extension in mind so it could then
> >> be easily added on top of it.
> >
> > I'm not sure about vtune extensions, but if we are going to
> > have --threads option I believe we should make it configurable
> > at least to the extend descibed below
>
> It employs --threads mode only and there are no use cases
> observed so far beyond this mode. Do you have or see such
> use cases?

I don't know about vtune and other users, but it's an important
feature for better performance so I agree with Jiri's opinion to
make it flexible for the system requirement.

Thanks
Namhyung
