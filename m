Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62501DAD93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 10:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgETIfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 04:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETIfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:35:04 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA23C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:35:02 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id k4so963660uaq.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWNedqNnVtkL4N7byTSlokMrFbSA5zwuR7gFzJJl128=;
        b=SQ8tNiZzYxLY/RgB9wgZbKb9kRZtd7l6++VUIpcM7KSkiCnFJ6rOUTbB9+JNqDalyg
         VtT5pVWvDD24RyAcVlcmk8Swttc3W2dUxQ8kZgts7obn7g/tusrN8OAzxH3dG1zT7AmH
         LhoM3a3xh01QnBJixtvWvWuQK+7yZ8vNPcn8ba6+GCz8JZBzhS+rMN5Gier5m9WMSMUO
         eLK9YgwO3BV4fQcHA3cpOwMbIUY7xoCH5uc5un8zMDshWkfr1ViBBKbOsbkoSIXBtVLf
         IlgoGYbnnz2+tFDnenBXwoF+t6aD8HydHUZnQYW005nbx3FTBWC6EINrMuwQnochqcTT
         Ychw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWNedqNnVtkL4N7byTSlokMrFbSA5zwuR7gFzJJl128=;
        b=F5MI6BGE3pLHel4WCqb4AUwuoWTusyipgKClh8K3g+tEfd6yF92cD1Nn4cfAKKUu03
         xAQBHI2ULmu+sCq1PqNDbTsiblcYW8hSoVGzMCRq/iCYZRo4FLHCt83ebdckp4BuQ2xm
         ISnt8DbnYItbxqxcrzWmYFBcVFGu8SIf4umtdkdzCpm3LO5PEu3xryyavK6/8cqljDEL
         4ixIPQehwzMQjyKl5mQLIBDCO/yINB+IyNORKyQAsamvi5ZjQgBLcixARLFMlxlfTpd6
         tJdbCOfPi2UY/pj7k9ox8SaNxMSQFrhR2AoXlI2XulqRUZBKOSWgdXLyQmWWZe4iOqzd
         We7Q==
X-Gm-Message-State: AOAM533yeEq8wCPmyXCSzUPBtdAtUWxvPxfUht8Ipkf1aBcudZS3eJxQ
        fB2WBYFsluG5qqNiSlsgWRCwXIZcRZoAfBX5fAZhXKyI
X-Google-Smtp-Source: ABdhPJyI3Gn+nNzHHNK2zZ1fNR0XMFLxv+NLCld5BRYpbCwQGl+JYwXpI0IDp4BL1sE21fuCNpU1mkctdqGnFSMUP8Q=
X-Received: by 2002:ab0:53d5:: with SMTP id l21mr2532776uaa.134.1589963701780;
 Wed, 20 May 2020 01:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200515215733.20647-1-eranian@google.com> <20200515215733.20647-4-eranian@google.com>
 <20200518093402.GB277222@hirez.programming.kicks-ass.net> <CABPqkBQt0a7Pi7X2cLz601TJEqasDXrOZcwuBhDCjcZ+ishPMw@mail.gmail.com>
In-Reply-To: <CABPqkBQt0a7Pi7X2cLz601TJEqasDXrOZcwuBhDCjcZ+ishPMw@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 20 May 2020 01:34:50 -0700
Message-ID: <CABPqkBQ8esgB1QiLGi68YM6CNxwY-78E7MHNtrxDjZNAhiSw0g@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf/x86/rapl: add AMD Fam17h RAPL support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu,
        Ian Rogers <irogers@google.com>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 18, 2020 at 1:16 PM Stephane Eranian <eranian@google.com> wrote:
>
> On Mon, May 18, 2020 at 2:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, May 15, 2020 at 02:57:33PM -0700, Stephane Eranian wrote:
> >
> > > +static struct perf_msr amd_rapl_msrs[] = {
> > > +     [PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, NULL},
> > > +     [PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr },
> > > +     [PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   NULL},
> > > +     [PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   NULL},
> > > +     [PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL},
> > > +};
> >
> > Why have those !PKG things initialized? Wouldn't they default to 0
> > anyway? If not, surely { 0, } is sufficient.
>
> Yes, but that assumes that perf_msr_probe() is fixed to not expect a grp.
> I think it is best to fix perf_msr_probe(). I already fixed one
> problem, I'll fix this one as well.

Well, now I remember what I did it the way it is in the patch. This
grp is going to sysfs, i.e., visible vs. not_visible callback.
Even if I fix the handling of NULL grp in perf_msr_probe(), the rest
of the rapl code pushes every event to sysfs and if the visible
callback is set to NULL this means the event is visible for sysfs! We
can fix that in init_rapl_pmus() but that is not pretty or leave it
as is, your call.
