Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C606329EA27
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgJ2LKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:10:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52666 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbgJ2LJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:09:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id c18so1961185wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 04:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E147n9198UMr0pGyJ/l6H9LfIY39W0QHpKT+riAQINo=;
        b=gewZdn5uGKtDgCeCZPLZIB9SS12pFJKHvb9ljlu4oDyDI91XVPUkT/s6Meb0vx2GNK
         TtgDnqPRxNFhTM6vJOQPgUHXLVpz0pjbuGD82bwccvp/WiLMG1U9nOoy/8MCIkrbBszm
         T52+ZUkEwwWl2bI4Xss48/d/bwixGtmutgEcvnMkxkvFo3hr0k0hINTEhpX6bn0vqYAR
         Q1IcX+fg/7gX0KRLN2rrp2wknl4mrC1PILNP4OFyayyIcGqYfx8lxgkBbQ6y5i060t91
         7s8dYZEH1++8difOZfsPqJ5A4Jy926uWPvVIKbaF3h3pjbb7ffDQmUKpSgpBO5rSBVua
         xZrQ==
X-Gm-Message-State: AOAM530EVteHLLdJ/tz+ojATCVDqA+XwHgmtSG8MLF2ZTkLvkd1VSVlk
        xKzz9pX4kUPngDtWdO7VHdVDhNrDQ9HwVkFRRCnfD47zHaM=
X-Google-Smtp-Source: ABdhPJy8fZOVZ18ouJzDZ1y+uMcUgtZXK8GJmINucB9B8q4iIbiX+8mk8c9Yuku8RMIfc1L4EG+F5yKXlGDJaOijEGE=
X-Received: by 2002:a1c:7c09:: with SMTP id x9mr3804363wmc.181.1603969265636;
 Thu, 29 Oct 2020 04:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <d28243e3-3178-d7cd-7b96-7ed63fd83493@linux.intel.com> <20201024154349.GC2589351@krava>
 <43d5e54f-b56e-729f-d08e-2c6b6799c797@linux.intel.com> <20201027122154.GF2900849@krava>
 <872f5052-788b-fe6d-d0ac-82e9639910d2@linux.intel.com> <CAM9d7cifhL--aYn05dYABmqoxGXX6xRC9W+Q+cWSnKqGUPPvzA@mail.gmail.com>
 <20201028153959.GN2900849@krava>
In-Reply-To: <20201028153959.GN2900849@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 29 Oct 2020 20:00:54 +0900
Message-ID: <CAM9d7ciP48Z5-cAoANXFviykTO8agKbVJCpQYxj60_ARWFB4cQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] perf session: load data directory into tool
 process memory
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
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

Hi Jiri,

On Thu, Oct 29, 2020 at 12:40 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Oct 28, 2020 at 04:22:49PM +0900, Namhyung Kim wrote:
> > On Tue, Oct 27, 2020 at 11:43 PM Alexey Budankov
> > <alexey.budankov@linux.intel.com> wrote:
> > >
> > >
> > > On 27.10.2020 15:21, Jiri Olsa wrote:
> > > > On Tue, Oct 27, 2020 at 10:37:58AM +0300, Alexey Budankov wrote:
> > > >> I agree perf report OOM issue can exist on really-big servers but data
> > > >> directories support for report mode for not-so-big servers and desktops
> > > >> is already enabled with this smaller change. Also really-big-servers
> > > >> come with really-big amount of memory and collection could possibly be
> > > >> limited to only interesting phases of execution so the issue could likely
> > > >> be avoided. At the same time threaded trace streaming could clarify on
> > > >> real use cases that are blocked by perf report OOM issue and that would
> > > >> clarify on exact required solution. So perf report OOM issue shouldn't
> > > >> be the showstopper for upstream of threaded trace streaming.
> > > >
> > > > so the short answer is no, right? ;-)
> > >
> > > Answer to what question? Resolve OOM in perf report for data directories?
> > > I don't see a simple solution for that. The next issue after OOM is resolved
> > > is a very long processing of data directories. And again there is no simple
> > > solution for that as well. But it still need progress in order to be resolved
> > > eventually.
> >
> > I think we should find a better way than just adding all events to the
> > ordered events queue in memory then processing them one by one.
> >
> > Separating tracking events (FORK/MMAP/...) might be the first step.
>
> I recall seeing this change before for threaded perf report,
> maybe even from you, right? ;-)

Yes, I did it a couple of years ago.  The last version is here:

https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git/log/?h=perf/threaded-v5

Thanks
Namhyung
