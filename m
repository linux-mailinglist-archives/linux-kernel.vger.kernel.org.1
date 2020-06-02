Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D00C1EB379
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 04:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgFBCre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 22:47:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38254 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgFBCrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 22:47:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id f185so1481711wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 19:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erjAI2JPHijWEZ2WbZhv+07BB2LF2XoxFe7c2aYCT4U=;
        b=jOW+x4tMOElPYA9j7v66vLCgsyW66FUxIBRlAOEHhDF8ZhRcKIp/8qo3ycYhQwNXld
         jZnXSyAl4siLRWQVDuMWtbvgJ2rr8DvdjEc7BidgmqHUtPaUaTsmBqyOA36zv0dUv6zQ
         kgRbQ7FMSyelOs8uhFsOWbQiHAbGJPuu90lGSqE+4RhsyLq6tu+sjRoqJnuZGJ3O7wki
         ZQkQ2jNC8cQUtmSCQb/msNvKYrdvvqhl3h/HILmNovAZYqE4jfxEZqV79WKJBCvLfkAA
         bJeEthEAfQpTCUhsoKnP2EhNch7qrYmHeULutkHg7dTiifwVY8AjZA0gtkJMXgADJjNF
         q7Zg==
X-Gm-Message-State: AOAM532NtE0doyAgTctP7DBIRqpI3QYyksqZYQJZxfw+O8e8XU/V0Jm+
        Bq1TepA+S2XslSKEIYVNge9HT+5EI7WhhcZdBzU=
X-Google-Smtp-Source: ABdhPJwd7aO+kkiiZOd7DS7choqqL7rk9Tk1ZwsE7uOr4Nj8rvnlRajAd2KrN7pfDaPkDZqO0HxEUL/HhMxsBO1xS1k=
X-Received: by 2002:a05:600c:280c:: with SMTP id m12mr2089590wmb.92.1591066050876;
 Mon, 01 Jun 2020 19:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200531162206.911168-1-jolsa@kernel.org> <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
 <20200601082027.GF881900@krava> <CAP-5=fWLp8qyVjwVuQCTEoz=SY5FFtEEZyH5=L-5cAEeN4_5uw@mail.gmail.com>
In-Reply-To: <CAP-5=fWLp8qyVjwVuQCTEoz=SY5FFtEEZyH5=L-5cAEeN4_5uw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 2 Jun 2020 11:47:19 +0900
Message-ID: <CAM9d7cgw+h9xC08hEErnQnqZjfN1bJWu8psGsUVicWoXWSWcLQ@mail.gmail.com>
Subject: Re: [PATCHv2] perf stat: Ensure group is defined on top of the same
 cpu mask
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 1:21 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Jun 1, 2020 at 1:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Jin Yao reported the issue (and posted first versions of this change)
> > with groups being defined over events with different cpu mask.
> >
> > This causes assert aborts in get_group_fd, like:
> >
> >   # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
> >   perf: util/evsel.c:1464: get_group_fd: Assertion `!(fd == -1)' failed.
> >   Aborted
> >
> > All the events in the group have to be defined over the same
> > cpus so the group_fd can be found for every leader/member pair.
> >
> > Adding check to ensure this condition is met and removing the
> > group (with warning) if we detect mixed cpus, like:
> >
> >   $ sudo perf stat -e '{power/energy-cores/,cycles},{instructions,power/energy-cores/}'
> >   WARNING: event cpu maps do not match, disabling group:
> >     anon group { power/energy-cores/, cycles }
> >     anon group { instructions, power/energy-cores/ }
> >
> > Ian asked also for cpu maps details, it's displayed in verbose mode:
> >
> >   $ sudo perf stat -e '{cycles,power/energy-cores/}' -v
> >   WARNING: group events cpu maps do not match, disabling group:
> >     anon group { power/energy-cores/, cycles }
> >        power/energy-cores/: 0
> >        cycles: 0-7
> >     anon group { instructions, power/energy-cores/ }
> >        instructions: 0-7
> >        power/energy-cores/: 0
>
> This is great! A nit, would 'grouped events cpus do not match' read
> better? I think the cpu map is more of an internal naming convention.

Allowed cpus?

Thanks
Namhyung
