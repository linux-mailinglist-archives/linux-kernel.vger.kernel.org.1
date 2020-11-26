Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774652C4E16
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 05:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbgKZEtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 23:49:43 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39409 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbgKZEtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 23:49:42 -0500
Received: by mail-qk1-f196.google.com with SMTP id q22so620940qkq.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 20:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XMSpQDvOLBCrWc9cN7r0+tuqM412AuYZKYEtfQYteA=;
        b=gEiqTHJ5PTUXz7K9kBxl3uoCat1srxYvB5lthD1RQbOgiWzu8t6yHF+6Z9MfK8akO1
         /swms68VYzmIvxnoMhCGIZ2jaBAQZYHJHB/bLjpJdqt9Z0aeybZ3283jRd5KDODZxxAd
         2dUOyGlovwxN4a7BCFBGOGHS4rylvfXhs9KlRbiTCPor3AymmJ0dRFOkjNWKO8tRmCaC
         KqCECvcX4Agsu17sC62YEdxGcOOlNQvejOphRUL2lZiNdMapfEIqnCDgDiD/FyzJ0Ve3
         JBZ1muyJGsXtyTD2dmDQNC/WvzB9ljDY8x3yNlQ/5hWJnS5+4YZnjtahpALw/eUgKXQa
         a0hw==
X-Gm-Message-State: AOAM531Vssa1JHj2oeZk6gJk0/HfL4ycZKHufQAmuuAwTofryJlqCi/t
        Ch3lJzWtp9gIqc0/cOayTXAhGbAEEs1Jjha9Kno=
X-Google-Smtp-Source: ABdhPJyWiu+10+MnM8SryBpFJ1TlJMcwMsRFP+VN6jcFnnDjqQXfFxyD4VM+N8kLm0Z7UhF8VGLowdokTYISmmMwyeE=
X-Received: by 2002:a05:620a:990:: with SMTP id x16mr1508150qkx.316.1606366181844;
 Wed, 25 Nov 2020 20:49:41 -0800 (PST)
MIME-Version: 1.0
References: <20201123230512.2097312-1-jolsa@kernel.org> <20201123230512.2097312-23-jolsa@kernel.org>
 <CAM9d7cgiCJeUx3tTBq+EHpCY-ycifXXn8ZW32F+F9br3CoOiSA@mail.gmail.com> <20201125163626.GJ2164284@krava>
In-Reply-To: <20201125163626.GJ2164284@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 26 Nov 2020 13:49:29 +0900
Message-ID: <CAM9d7ciEGMbtMhr7dLof2VHwiBSHWNr8AbH+RYnsL=z-x5zkdg@mail.gmail.com>
Subject: Re: [PATCH 22/25] perf buildid-cache: Add support to add build ids
 from perf data
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 1:36 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Nov 25, 2020 at 10:00:10PM +0900, Namhyung Kim wrote:
> > On Tue, Nov 24, 2020 at 8:06 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Adding support to specify perf data file as -a option file
> > > argument,
> > >
> > > If the file is detected to be perf data file, it is processed
> > > and all dso objects with sample hit are stored to the build
> > > id cache.
> > >
> > >   $ DEBUGINFOD_URLS=http://192.168.122.174:8002 perf buildid-cache -a perf.data
> > >   OK   5dcec522abf136fcfd3128f47e131f2365834dd7 /home/jolsa/.debug/.build-id/5d/cec522abf136fcfd3128f47e131f2365834dd7/elf
> > >   OK   5784f813b727a50cfd3363234aef9fcbab685cc4 /lib/modules/5.10.0-rc2speed+/kernel/fs/xfs/xfs.ko
> > >
> > > By default we store only dso with hits, but it's possible to
> > > specify 'all' to store all dso objects, like:
> > >     -a perf.data,all
> >
> > I think we can add -A/--add-all like we have -p and -P.
>
> hm, the thing is that 'all' is specific for perf data file: '-a perf.data'
> hence -A 'file' would make no sense, only for '-A perf.data', so the current
> 'all' parameter seems less confusing to me

Yeah, I also thought about the '-A perf.data' form.
But I won't insist on it strongly, it's up to you. :)

Thanks,
Namhyung
