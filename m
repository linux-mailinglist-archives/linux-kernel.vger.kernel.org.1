Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309F0274C58
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 00:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIVWmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 18:42:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38017 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVWmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:42:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id g4so18807298wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GfM0AmWvMrKQ34w2mxE57N9tsR3pe7jAxX567tM6XE=;
        b=RSYpg6SkH0nhkdZr1xFIA6w5ezUtngnDHCLyd5v3j1/ER8pnHin3S30IuP2fM7RXii
         R1+API6XRLBtrFZ6lsUdAseZfvZSBpXkYMKHfHQSCY5SUSHpkqesuEL0yMv7dFwfI3/G
         GlTLs4oR0zqB+Si274OODLVfudov/Urj1g8Ht9Zv+LAWShdeZzZa+N5upMbKCZtRSjUt
         ZkWopnJPdHwe0L3TBpYuiKtcqOOvn2WNuoOwERalpcZXPPdwvrpFllFyh8LtcgQf1D+Q
         1PABBO6q0huoFJckYrwl8MVtbOBMAiRWoBHJC3/tdXxMUB2hEPwwl2/yDdZhYjFWj083
         CKCQ==
X-Gm-Message-State: AOAM531jDQ3fjgXJO6S9rgP1iK6ntJJssiPrZE6lVd0wxq19zdeMbkEs
        mvKt+XpXdLP6jeyMLKZ6LfWduEL8hIHz/+h58rbm5i9O
X-Google-Smtp-Source: ABdhPJxM63lGLRBnkp5vgVGjXYvahaiGj8s7joRX6a/JP2PsUsAquyglpr7Qj1Mf8uGPdAGz208DVTuBGBRlXnrB8nE=
X-Received: by 2002:adf:e481:: with SMTP id i1mr7638174wrm.391.1600814572800;
 Tue, 22 Sep 2020 15:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200909055849.469612-1-namhyung@kernel.org> <20200909055849.469612-3-namhyung@kernel.org>
 <20200922204240.GB2893484@krava>
In-Reply-To: <20200922204240.GB2893484@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 23 Sep 2020 07:42:41 +0900
Message-ID: <CAM9d7cjbaijYvMJRZbhiiuK6hxx2NQpicM_82wetVsOuWOQXew@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf list: Add 'pfm' to list libpfm4 events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Wed, Sep 23, 2020 at 5:42 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Sep 09, 2020 at 02:58:49PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> >  int parse_events__is_hardcoded_term(struct parse_events_term *term)
> > diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> > index d735acb6c29c..26ae2c8c0932 100644
> > --- a/tools/perf/util/pfm.c
> > +++ b/tools/perf/util/pfm.c
> > @@ -12,6 +12,7 @@
> >  #include "util/parse-events.h"
> >  #include "util/pmu.h"
> >  #include "util/pfm.h"
> > +#include "util/string2.h"
> >
> >  #include <string.h>
> >  #include <linux/kernel.h>
> > @@ -227,7 +228,7 @@ print_libpfm_events_raw(pfm_pmu_info_t *pinfo, pfm_event_info_t *info)
> >               printf("%s::%s\n", pinfo->name, info->name);
> >  }
> >
> > -void print_libpfm_events(bool name_only, bool long_desc)
> > +void print_libpfm_events(const char *event_glob, bool name_only, bool long_desc)
> >  {
> >       pfm_event_info_t info;
> >       pfm_pmu_info_t pinfo;
> > @@ -265,6 +266,9 @@ void print_libpfm_events(bool name_only, bool long_desc)
> >                       if (ret != PFM_SUCCESS)
> >                               continue;
> >
> > +                     if (event_glob && !strglobmatch_nocase(info.name, event_glob))
> > +                             continue;
>
> you could mentioned in changelog that it also enables glob
> matching for pfm events.. but other than then looks ok

Well, I have mentioned it in the changelog.. :)
Do you want an example?

>
> Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

Thanks
Namhyung

>
> > +
> >                       if (!name_only && !printed_pmu) {
> >                               printf("%s:\n", pinfo.name);
> >                               printed_pmu = true;
> > diff --git a/tools/perf/util/pfm.h b/tools/perf/util/pfm.h
> > index 7d70dda87012..036e2d97b260 100644
> > --- a/tools/perf/util/pfm.h
> > +++ b/tools/perf/util/pfm.h
> > @@ -13,7 +13,7 @@
> >  int parse_libpfm_events_option(const struct option *opt, const char *str,
> >                       int unset);
> >
> > -void print_libpfm_events(bool name_only, bool long_desc);
> > +void print_libpfm_events(const char *event_glob, bool name_only, bool long_desc);
> >
> >  #else
> >  #include <linux/compiler.h>
> > @@ -26,7 +26,8 @@ static inline int parse_libpfm_events_option(
> >       return 0;
> >  }
> >
> > -static inline void print_libpfm_events(bool name_only __maybe_unused,
> > +static inline void print_libpfm_events(const char *event_glob __maybe_unused,
> > +                                    bool name_only __maybe_unused,
> >                                      bool long_desc __maybe_unused)
> >  {
> >  }
> > --
> > 2.28.0.526.ge36021eeef-goog
> >
>
