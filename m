Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A275E2C40E0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgKYNEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:04:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39151 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbgKYNEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:04:52 -0500
Received: by mail-lj1-f196.google.com with SMTP id o24so2195247ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 05:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pra5ZrIQqd1Oiv+0TYsFn59xDF603RB5u+WuK/ZbQTg=;
        b=K3Gy8PElETHXn/DjHutmVfJHao31IE++UQfehEnqrUx1oM641w3OZajXzt6p9UNas9
         uG4R346Wme+2xS4QJ7ISr1pwjURtK0dCy7RIDq4kH2qsyr1m1lF+JbN17YkXIFvSgIpb
         odZnUP0EiUaBSrWwYH5FoT2ofi1LjU2LzpSZ9VHSULnzVCcVUgE0gaGO/fs44t8jYEwF
         uVzjBykmVQzv8ukxe7OvXxGN3OPkI4ucFyvbolX4Z6xQkdl9tSkzL2A7jvZrkfnuC51Q
         hJk5xHjVlEdgN/9k4GlJ9cBTo6fedKLsrn6185wkvBZPiMkPhO5KzYshEQDnpGS9j5jA
         avxw==
X-Gm-Message-State: AOAM532YHjdVZEb3CLECrbv95Ij3BcECWl4+9Fl4uqp170AuvzC2uBe8
        IGclR7/Ie5H2VPvdAKMmIXRvIbJh44foIved2MQ=
X-Google-Smtp-Source: ABdhPJwejlhgoCxOlru0GT+PvUFNNM+q4iA2Gv5ZPJrsXobVsYcz7BW0B80N/CFUi+zlSxipwozRI2SpBJ/t1K3gdRw=
X-Received: by 2002:a2e:7a04:: with SMTP id v4mr1295457ljc.191.1606309489963;
 Wed, 25 Nov 2020 05:04:49 -0800 (PST)
MIME-Version: 1.0
References: <20201123230512.2097312-1-jolsa@kernel.org> <20201123230512.2097312-23-jolsa@kernel.org>
 <CAM9d7cgiCJeUx3tTBq+EHpCY-ycifXXn8ZW32F+F9br3CoOiSA@mail.gmail.com>
In-Reply-To: <CAM9d7cgiCJeUx3tTBq+EHpCY-ycifXXn8ZW32F+F9br3CoOiSA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 25 Nov 2020 22:04:38 +0900
Message-ID: <CAM9d7ch5Fncu1ddKcAur_H91H36e+R52J=90Z8R5vZHs8bQMQA@mail.gmail.com>
Subject: Re: [PATCH 22/25] perf buildid-cache: Add support to add build ids
 from perf data
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Wed, Nov 25, 2020 at 10:00 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Nov 24, 2020 at 8:06 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> > index a25411926e48..0bfb54ee1e5e 100644
> > --- a/tools/perf/builtin-buildid-cache.c
> > +++ b/tools/perf/builtin-buildid-cache.c
> > @@ -29,6 +29,11 @@
> >  #include "util/probe-file.h"
> >  #include <linux/string.h>
> >  #include <linux/err.h>
> > +#include <linux/zalloc.h>
> > +#include <sys/stat.h>
> > +#ifdef HAVE_DEBUGINFOD_SUPPORT
> > +#include <elfutils/debuginfod.h>
> > +#endif
> >
> >  static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
> >  {
> > @@ -348,6 +353,205 @@ static int build_id_cache__show_all(void)
> >         return 0;
> >  }
> >
> > +#ifdef HAVE_DEBUGINFOD_SUPPORT
>
> I think this part belongs to the next patch...?
>
> Thanks,
> Namhyung

Oh, I've missed we already have the debuginfod support.

Thanks,
Namhyung
