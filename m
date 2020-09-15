Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D4326B067
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgIOWJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgIOUSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 16:18:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B96C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 13:18:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so4671188wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 13:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9d3ORlPeAR882gC4oV6nUcXhz3M650ABYnqtiBLMu0=;
        b=WqHVyu8Q4sCmq7ey1374ySo4PZvSixntEN2TVDdIGP80nkMc7yXnThenwrqFEMYGMN
         s6LIoDUM9wclPNVdRY4pRC2AadwzbG9sKSTgi9hN1h4dsOVYrgvbsGkGdZvLCb0/g3+z
         yjyli8DxrqD6H/VQ5AhWb0IPMwxq90o++ApITC9AUUnioUOFVFQi//lEPIOnnxmDaVMb
         fWtWILKN5R3jgRlGZSHJIbWPwwQr5X/DkLamrBCLb+pJMyhmZDuaT1IKZE/E5YyQUjWz
         60XKoJif5fdF+Nw425RlG5c+Dk6iFmZXjiH5LZbzOOAJz8dMvouaffXFK3cRSHS99DI6
         zBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9d3ORlPeAR882gC4oV6nUcXhz3M650ABYnqtiBLMu0=;
        b=FnDvPFaWJAuwIlP3iZiFrHVAJIAF4czo5achwoNeUIpbKyg0vpslLmR2TcV711j2L8
         IFonWquPS6JAErwHKU5YA7Ev5NhQRpXjFowT2fvg1giOM9nHyUP8O7lGpXm5zqkTvYtC
         qSG98YlWXvTW6nYdwLUiM+iV6TO6Umw26akmhezmd0eaUxCFyfkL9gGuAmbDXFwlFq1z
         GoxjpOhL24oQONy/w4Psf4SsT/JmdMZWMGpy6m6+BzaCp0cJDdmbmcL9Tcdqtw+nHl3n
         YXn9RA/oMCDX3HGJ6Gy+elVgqW3HVQMq32BzbxUB05AkQaoUpPEyvq5OcdKaMWMe/0hI
         5h3g==
X-Gm-Message-State: AOAM533qaPy5MStQuOj+sfi+FjtWhdMOaIAcew9vJ0SX8rql7z5V5AUu
        ZRhZn3cmVQ+P9OkQrwk2eXADT5lSiL3GQpR0Fawe7Q==
X-Google-Smtp-Source: ABdhPJxCVdxIEJHt9gwnRqxYwPAHWP+m2PiMpXjey/peGqtYZDZo2d/CSDygnX5ibHpXD0QszjCE1PCYJpLoiPY/bPw=
X-Received: by 2002:a5d:5583:: with SMTP id i3mr22372673wrv.119.1600201080279;
 Tue, 15 Sep 2020 13:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-17-jolsa@kernel.org>
 <20200914160758.GK160517@kernel.org>
In-Reply-To: <20200914160758.GK160517@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Sep 2020 13:17:44 -0700
Message-ID: <CAP-5=fV4Agxe3UMpkbWkh9CuG1tYho413w7xehy0SiMX+tPv1Q@mail.gmail.com>
Subject: Re: [PATCH 16/26] perf tools: Synthesize modules with mmap3
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 9:08 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sun, Sep 13, 2020 at 11:03:03PM +0200, Jiri Olsa escreveu:
> > Synthesizing modules with mmap3 events so we can
> > get build id data for module's maps as well.
>
> Ditto as for 15/26
>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/synthetic-events.c | 37 +++++++++++++++++++-----------
> >  1 file changed, 24 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index bd6e7b84283d..6bd2423ce2f3 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -605,7 +605,7 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
> >       int rc = 0;
> >       struct map *pos;
> >       struct maps *maps = machine__kernel_maps(machine);
> > -     union perf_event *event = zalloc((sizeof(event->mmap) +
> > +     union perf_event *event = zalloc((sizeof(event->mmap3) +
> >                                         machine->id_hdr_size));
> >       if (event == NULL) {
> >               pr_debug("Not enough memory synthesizing mmap event "
> > @@ -613,8 +613,6 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
> >               return -1;
> >       }
> >
> > -     event->header.type = PERF_RECORD_MMAP;
> > -
> >       /*
> >        * kernel uses 0 for user space maps, see kernel/perf_event.c
> >        * __perf_event_mmap
> > @@ -631,17 +629,30 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
> >                       continue;
> >
> >               size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
> > -             event->mmap.header.type = PERF_RECORD_MMAP;
> > -             event->mmap.header.size = (sizeof(event->mmap) -
> > -                                     (sizeof(event->mmap.filename) - size));
> > -             memset(event->mmap.filename + size, 0, machine->id_hdr_size);
> > -             event->mmap.header.size += machine->id_hdr_size;
> > -             event->mmap.start = pos->start;
> > -             event->mmap.len   = pos->end - pos->start;
> > -             event->mmap.pid   = machine->pid;
> > -
> > -             memcpy(event->mmap.filename, pos->dso->long_name,
> > +             event->mmap3.header.type = PERF_RECORD_MMAP3;
> > +             event->mmap3.header.size = (sizeof(event->mmap3) -
> > +                                        (sizeof(event->mmap3.filename) - size));
> > +             memset(event->mmap3.filename + size, 0, machine->id_hdr_size);
> > +             event->mmap3.header.size += machine->id_hdr_size;
> > +             event->mmap3.start = pos->start;
> > +             event->mmap3.len   = pos->end - pos->start;
> > +             event->mmap3.pid   = machine->pid;
> > +
> > +             memcpy(event->mmap3.filename, pos->dso->long_name,
> >                      pos->dso->long_name_len + 1);
> > +
> > +             rc = filename__read_build_id(event->mmap3.filename, event->mmap3.buildid,
> > +                                          BUILD_ID_SIZE);
> > +             if (rc != BUILD_ID_SIZE) {

IIRC BUILD_ID_SIZE is 20 bytes which is the correct size for SHA-1. A
build ID may be 128-bits (16 bytes) if md5 or uuid hashes are used.
Should this test just be "> 0" ?

Thanks,
Ian

> > +                     if (event->mmap3.filename[0] == '/') {
> > +                             pr_debug2("Failed to read build ID for %s\n",
> > +                                       event->mmap3.filename);
> > +                     }
> > +                     memset(event->mmap3.buildid, 0x0, sizeof(event->mmap3.buildid));
> > +             }
> > +
> > +             rc = 0;
> > +
> >               if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
> >                       rc = -1;
> >                       break;
> > --
> > 2.26.2
> >
>
> --
>
> - Arnaldo
