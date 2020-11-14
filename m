Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3F2B29E3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 01:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgKNAcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 19:32:09 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38309 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgKNAcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 19:32:08 -0500
Received: by mail-lf1-f66.google.com with SMTP id 74so16719267lfo.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 16:32:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOLzg0ZSt4/KhJ2kIXr2eXLSfzX9WXSjA/Uf7QZ42gs=;
        b=byf91IWL86woUEOFQMzifoLf6HyD/BBuI6ZZOgONmzr1XUZYZPpU+Uf0xA7GJ02XsD
         xKxKuK8GZN3HGvg61qzymMBG0VkSE1zzuMty8Be1pNZ63uVSeu1n5qfhJnfgS1oWdhwd
         t6ri06PZ5ya1wnP5g4A9i5Ihq4bvI8QlHfMoQziWnjJua/WA+IUe+KYNxHsl2sGkH45H
         8vwnY/slhF7ElSp3rO/W3dX8xle9Sx6r0rdYUjF0Qijazpgl1TwukdFkP2EiWT+1kl2N
         RPNsVApHByyrKqE9EUzVRv5KuM4rYk/rNcX7lqagyo7/mrrvJTCci1YxXY2RxjLY4/F8
         dY3Q==
X-Gm-Message-State: AOAM532dxIwncRZ0qJm6Zyk/E8UpOwPp8Th55DrZtAbUMb/wMXlro3HC
        yWfMJDmSmFjuE1elhbzT+vAXAwPwbB9hno8UREg=
X-Google-Smtp-Source: ABdhPJySVFSQpAPkse4bLkBD6mYDg4bmJPGwGilx7jyQ+dy95Urb/4ydPiVSSMxlbs5+uzrOw0SUgpiHNcVajSLUMv0=
X-Received: by 2002:a19:8b84:: with SMTP id n126mr1735391lfd.555.1605313926395;
 Fri, 13 Nov 2020 16:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20201109215415.400153-1-jolsa@kernel.org> <20201109215415.400153-25-jolsa@kernel.org>
 <20201113044000.GC167797@google.com> <20201113110926.GE753418@krava>
In-Reply-To: <20201113110926.GE753418@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 14 Nov 2020 09:31:56 +0900
Message-ID: <CAM9d7chgFfJXXtfUMVVbzLNvhLL2xHAomZjdf-DhPmdn5E2Omg@mail.gmail.com>
Subject: Re: [PATCH 24/24] perf record: Add --buildid-mmap option to enable
 mmap's build id
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

On Fri, Nov 13, 2020 at 8:09 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Nov 13, 2020 at 01:40:00PM +0900, Namhyung Kim wrote:
> > On Mon, Nov 09, 2020 at 10:54:15PM +0100, Jiri Olsa wrote:
> > > Adding --buildid-mmap option to enable build id in mmap2 events.
> > > It will only work if there's kernel support for that and it disables
> > > build id cache (implies --no-buildid).
> > >
> > > It's also possible to enable it permanently via config option
> > > in ~.perfconfig file:
> > >
> > >   [record]
> > >   build-id=mmap
> >
> > You also need to update the documentation.
>
> right, forgot doc for the config option
>
> SNIP
>
> > >                 "append timestamp to output filename"),
> > >     OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
> > > @@ -2657,6 +2662,21 @@ int cmd_record(int argc, const char **argv)
> > >
> > >     }
> > >
> > > +   if (rec->buildid_mmap) {
> > > +           if (!perf_can_record_build_id()) {
> > > +                   pr_err("Failed: no support to record build id in mmap events, update your kernel.\n");
> > > +                   err = -EINVAL;
> > > +                   goto out_opts;
> > > +           }
> > > +           pr_debug("Enabling build id in mmap2 events.\n");
> > > +           /* Enable mmap build id synthesizing. */
> > > +           symbol_conf.buildid_mmap2 = true;
> > > +           /* Enable perf_event_attr::build_id bit. */
> > > +           rec->opts.build_id = true;
> > > +           /* Disable build id cache. */
> > > +           rec->no_buildid = true;
> >
> > I'm afraid this can make it miss some build-id in the end because of
> > the possibility of the failure.
>
> with following fix (already merged):
>   b33164f2bd1c bpf: Iterate through all PT_NOTE sections when looking for build id
>
> I could see high rate of build id being retrieved
>
> I'll make new numbers for next version, but I think we can neglect
> the failure, considering that we pick only 'hit' objects out of all
> of them
>
> also enabling the build id cache for this would go against the
> purpose why I'd like to have this.. so hopefuly the numbers
> will be convincing ;-)

Yeah, I think it'd be ok for most cases but we cannot guarantee..
What about checking the dso list at the end of a record session
and check all of them having build-id?  Then we can safely skip
the build-id collecting stage.  Hmm.. but it won't work for the pipe.

Thanks,
Namhyung
