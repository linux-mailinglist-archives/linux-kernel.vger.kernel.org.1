Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3693D2F592A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbhANDUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:20:30 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:40238 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbhANDU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:20:29 -0500
Received: by mail-lf1-f51.google.com with SMTP id m12so5990489lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHgj6fqTcyYVyvhb3CttMpyOA6XhM8+E0qYg5lwnegw=;
        b=s9b6tlFqCGWGHnHIGNNtXBaNGWHaKVc/khJGg+Y9MiSkjmMdcHlCUenNwNedlOn0hs
         GX8BxQ5YXFIU2tIj9V/4iH8VHgShOV/RwxvKmzoYSE2Z19vuw/Zq2enddqQzJtWurOhF
         lURrveyGgBfIQh5wyyx76npaeThLQZxobmQZL6bSbn5hLtOC+7+FUK+a7630wo3XNWK/
         Y/bmhfBG7+0YhKagXfkfKjT+PXspp//Lwz1bhfmeDQphKUI/DjhjnIzGqI3yP9Yux6iS
         iT4mDoXJLcq17vJ6/2wIUzy5BiolGVudATvAUAQq9r2/f5AZwHh8Tep1harhNbIGA5qc
         cWZw==
X-Gm-Message-State: AOAM531/tcGU7ZqmO2egpdQRRq8G5+cEYfb+tU9OWMZE41B7rCSg83/V
        y9m1ZxR6YnN6OOoz6KYj0KcaAIAdteFrgYTBCSg=
X-Google-Smtp-Source: ABdhPJxoUCdh9nPMs+Ep3cFym5ktCHDEVOJ9HdAu282SWy+PawKSblPQDClkBluYme26jqq9bNxCZOPANFdRS2qGd9A=
X-Received: by 2002:ac2:5981:: with SMTP id w1mr2476379lfn.374.1610594381870;
 Wed, 13 Jan 2021 19:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20210108074712.947223-1-namhyung@kernel.org> <20210112093016.GB1252618@krava>
 <c0d1ac9ce2bf43029c1c97bfcc9029c4@AcuMS.aculab.com>
In-Reply-To: <c0d1ac9ce2bf43029c1c97bfcc9029c4@AcuMS.aculab.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 14 Jan 2021 12:19:30 +0900
Message-ID: <CAM9d7ciDHwbU4q=CxxMY2etknKExpFbPb+erSmx0N5k=RHxBsQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix shadow stat test for non-bash shells
To:     David Laight <David.Laight@aculab.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jan 12, 2021 at 8:17 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Jiri Olsa
> > Sent: 12 January 2021 09:30
> >
> > On Fri, Jan 08, 2021 at 04:47:12PM +0900, Namhyung Kim wrote:
> > > It was using some bash-specific features and failed to parse when
> > > running with a different shell like below:
> ...
>
> You don't need a temporary file, one option is:
>
> > > index 249dfe48cf6a..e2c7ac4ed91d 100755
> > > --- a/tools/perf/tests/shell/stat+shadow_stat.sh
> > > +++ b/tools/perf/tests/shell/stat+shadow_stat.sh
> ...
> > >     perf stat -a -A --no-big-num -e cycles,instructions sleep 1  2>&1 | \
> > >     grep ^CPU | \
> > >     while read cpu num evt hash ipc rest
> > >     do
> ...
> > > +           if [ "$evt" = "cycles" ]; then
> > > +                   echo $cpu $num >> $results
>
>                         results="$results $cpu:$num"
>
> > >                     continue
> > >             fi
> > >
> > >             # skip if no cycles
> > > -           local cyc=${results[$cpu]}
> > > -           if [[ -z $cyc ]]; then
> > > +           local cyc=$(grep $cpu $results | cut -d' ' -f2)
>
>                 cyc=${results##* $cpu:}
>                 cyc=$(cyc%% *}
>
> > > +           if [ -z "$cyc" ]; then
> > >                     continue
> > >             fi
>
> I can't remember when 'local' was invented.
> You may find shells that don't support it.
> In any case, since this is a small standalone file I'd
> remove them just in case.

Thanks for your review, I'll make the change.

Thanks,
Namhyung
