Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C802FD024
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389518AbhATMSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 07:18:05 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:39338 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbhATLym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:54:42 -0500
Received: by mail-lf1-f54.google.com with SMTP id h7so4485213lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 03:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NL9fVoZhOlYXsEj2VdzaNioQ9TslBUkbYBTGCKXOJV0=;
        b=eRT7OAlDQm3Yt2GQxOf+cts2+3xflkKcx/NZWeYctjlziskulJXZKBYXC24h4NKaXS
         OCrSebqAfTs/45Qnm4tKtd1ez4cdWxu4zE4ZTQaysRgAG508iE+DMTiAlDAbHcw30grB
         RwJd7izXLm8wZieHJLx246TGsCgd2QeRwtciEP3d5yDohq5FlttLIo/RSHuUCA2mfBh0
         xsxa5bSVHNhVhpNQY8xU8vCaPjcqO9Or5ouhGzvchn+t+AFmmehO6McKxmddxoRNj7ki
         lMy1u5J9EBVSHDHVeRRu48JHW0t7i1oTf65lYhDlE2g3CjHSuPyOva44Rrnm68w2w0/k
         5Qjg==
X-Gm-Message-State: AOAM5314XEoS0T0P6cpl/bR8s5RJ6LhxQypyiG5uZCXW/OqtAw0krlXp
        P1XwGIqvvSM2FFDxpZEIVBrgV0oB+jkdkYT/DJo=
X-Google-Smtp-Source: ABdhPJwF5VEGVt8+oiGPtGeBXHmwxiiyvW+/hPV0CWNUZAjB2d1FXNXYtYiJcHHmd8NGdTq9TlbX/JwXNLE27yl9g2s=
X-Received: by 2002:a19:40c7:: with SMTP id n190mr488653lfa.635.1611143639470;
 Wed, 20 Jan 2021 03:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20210118034323.427029-1-namhyung@kernel.org> <YAVezkTtAkIAImzx@hirez.programming.kicks-ass.net>
 <CAM9d7cgr+Vxq_SnEkSO5zU0QN-X6-LLJDKUfE4C72Nomnrr=+Q@mail.gmail.com>
 <YAWFkU+roDyMCgla@hirez.programming.kicks-ass.net> <CAM9d7cg_Agin3C0iuigDzQjZEZNtVXPe9z9eaDZsdyNoVa_wxA@mail.gmail.com>
 <20210119024657.GA3526@tassilo.jf.intel.com> <CAM9d7chk5qC7er5EVmmrHZtP2PB6Y9EikfGYxYibE4HZpCOmbQ@mail.gmail.com>
In-Reply-To: <CAM9d7chk5qC7er5EVmmrHZtP2PB6Y9EikfGYxYibE4HZpCOmbQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 20 Jan 2021 20:53:48 +0900
Message-ID: <CAM9d7cgE+Q-AfL2Fdi4rnv8rpTgi_qW0+iZVjG-0hL0sq+OouA@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Emit PERF_RECORD_LOST for pinned events
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Alexey Alexandrov <aalexand@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 12:11 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Andi,
>
> On Tue, Jan 19, 2021 at 11:47 AM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > > > I don't think I object to having an even in the stream, but your LOST
> > > > event is unfortunate in that it itself can get lost when there's no
> > > > space in the buffer (which arguably is unlikely, but still).
> > > >
> > > > So from that point of view, I think overloading LOST is not so very nice
> > > > for this.
> > >
> > > But anything can get lost in case of no space.
> > > Do you want to use something other than the LOST event?
> >
> > Could always reserve the last entry in the ring buffer for a LOST event,
> > that would guarantee you can always get one out.
>
> A problem is that we can have more than one event that failed.
>
> In my understanding, we keep the lost count and add a LOST event
> when there's a space later.  So probably we can keep a list of the
> failed events and do similar for each event.  Or just use a single
> event to notify some number of events were failed.

Stephane suggested emitting an event for poll() like EPOLLERR or
EPOLLHUP.  I'll take a look at that.

Thanks,
Namhyung
