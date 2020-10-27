Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A18B29A3CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 06:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505588AbgJ0FAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 01:00:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35433 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436452AbgJ0FAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 01:00:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id n15so402713wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 22:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXPt7C+f3W4WvPcu+w1HOqYJwVh5MZK/Q2VH9P6oCkY=;
        b=nMz7dR9SEyveVBMENt2z1vTZNdb2zzWQfzOeZdLs06vnxhGlQN4HANPQHsG9mJYTzJ
         rYAvhSZlIUq1nnzfpYVPArG1MiN0QsLk8g3WiE4QxK3iiYcZvFI+ga468ePb39+FGG6M
         yRErDg8Bfm6wHcgheGMG5Hs6R2ljCo3VDLU6zaS/iJ/AKzEMb470a6kEqaKwGzmmzZwE
         9VuYYZwf1ZUCTU6+dahE77MpIL4D6UgXInGG9t0/y7NnALspkADM87luGytX1TtXhct+
         KNouwltEniMlPuIDidJZQOgdJnLmEqGmnLZ+AE132UxoTMPDL8RMwPb8lJVl+5jyBhyb
         JDPg==
X-Gm-Message-State: AOAM532UvhEM3iu/zyEybNc/Cx+w9HSJZzpu78+hGIs6bw522F71a34e
        LdwqslzEKfS4kGIUuhVARGkMRjK3QnerDDKk/5c=
X-Google-Smtp-Source: ABdhPJxPiq9QcBJihfpWptE/+LU7XGpxmep0igw+qJBas4bEJCcD3/dwVhI7rR94TGMvh/vwdyeO5/MBo1OSk2NViIs=
X-Received: by 2002:adf:a345:: with SMTP id d5mr521340wrb.55.1603774844067;
 Mon, 26 Oct 2020 22:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201024025918.453431-1-namhyung@kernel.org> <20201024025918.453431-2-namhyung@kernel.org>
 <20201026114009.GD2726983@krava> <CAM9d7chdStkY7-tRjw9Fo+3wKdhrDYAkbNT0b-g6ftGoaZfMDQ@mail.gmail.com>
 <20201026175349.GA2449445@kernel.org>
In-Reply-To: <20201026175349.GA2449445@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 27 Oct 2020 14:00:33 +0900
Message-ID: <CAM9d7ciYY-b6e24W=ZsUdaLmjn=dYWxBg6BMm4TxosckbcGrmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf stat: Support regex pattern in --for-each-cgroup
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Oct 27, 2020 at 2:53 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Oct 26, 2020 at 09:32:34PM +0900, Namhyung Kim escreveu:
> > Hi Jiri,
> >
> > On Mon, Oct 26, 2020 at 8:40 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > also perhaps we want to warn if there's no match found:
> > >
> > >         $ sudo ./perf stat -a -e cpu-clock,cycles --for-each-cgroup ^foo sleep 1
> > >
> > >          Performance counter stats for 'system wide':
> > >
> > >
> > >                1.002375575 seconds time elapsed
> > >
> >
> > Right, will check this case.
>
> Hum, I thought that could be done on top of this one, but then, the
> ambiguity of:
>
> 1. No samples for a cgroups matching that expression
>
> 2. No cgroups match that expression
>
> Is real and warrants a warning for the 'no cgroups match the
> --for-each-group regexp' case.

The 1 will be handled by perf stat showing <not counted> and
I'll add a warning for the item 2 like below:

  # perf stat -a -e cycles --for-each-cgroup ^foo sleep 1
  no cgroup matched: ^foo

   Usage: perf stat [<options>] [<command>]

        --for-each-cgroup <name>
                          expand events for each cgroup

Thanks
Namhyung
