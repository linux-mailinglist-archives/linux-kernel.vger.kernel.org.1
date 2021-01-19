Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8442FAF0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 04:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394839AbhASDMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 22:12:54 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:38614 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388715AbhASDMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 22:12:52 -0500
Received: by mail-lj1-f172.google.com with SMTP id n11so20321832lji.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 19:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvUY/VeZrCIqhPzWRGIVqTe2E15aU4shIkqn8ZCXmHU=;
        b=bqrcoTUeOTikx5GXliofWp3nO2iIIts/ytTgrB+tmECTI1kA5iVUGcL8O6Rr7TmD3V
         QuWR6GxBriikXtt7ejNQaGsg8uIRJ+yWdeI2NZlG+a0nJOg7zKQurRYJcxsw/33Pjgje
         moaUeB4ooCD2/3htqr5nawWn7ubfCgWui6vUODB5ibk4WV2ug1jx/g8kzDh4neqgpAom
         JEYHgapF5USuzVEMpG9YGnzPGQWoig6OYUjvJMbq35/B4XpajHYI/XzMk6sFYSYyGmUY
         qVtiRMrPRSz1ILhingj5MBBarMrrxkhOE7E3hpsSeyXo5kT5AvG/zEfrbMpKwgt7u39I
         U1PQ==
X-Gm-Message-State: AOAM530hfr2YJtU1s1bqlCgksC26bidvRvTmqLF/icCR17Q6HfpW4ZVK
        s46xXvRYBZu5+Aq+Z7LGh3DgI31N/cJbLYUeUtI=
X-Google-Smtp-Source: ABdhPJyrONS9eH8DW3LnoewIHYBwQc/PiImfSRjUAHqCz7fOTyXSxcIwq410BJgaakBlyu+ZNUC119ojJhtBlidzmdo=
X-Received: by 2002:a2e:b04e:: with SMTP id d14mr965124ljl.26.1611025929836;
 Mon, 18 Jan 2021 19:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20210118034323.427029-1-namhyung@kernel.org> <YAVezkTtAkIAImzx@hirez.programming.kicks-ass.net>
 <CAM9d7cgr+Vxq_SnEkSO5zU0QN-X6-LLJDKUfE4C72Nomnrr=+Q@mail.gmail.com>
 <YAWFkU+roDyMCgla@hirez.programming.kicks-ass.net> <CAM9d7cg_Agin3C0iuigDzQjZEZNtVXPe9z9eaDZsdyNoVa_wxA@mail.gmail.com>
 <20210119024657.GA3526@tassilo.jf.intel.com>
In-Reply-To: <20210119024657.GA3526@tassilo.jf.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 19 Jan 2021 12:11:58 +0900
Message-ID: <CAM9d7chk5qC7er5EVmmrHZtP2PB6Y9EikfGYxYibE4HZpCOmbQ@mail.gmail.com>
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

Hi Andi,

On Tue, Jan 19, 2021 at 11:47 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> > > I don't think I object to having an even in the stream, but your LOST
> > > event is unfortunate in that it itself can get lost when there's no
> > > space in the buffer (which arguably is unlikely, but still).
> > >
> > > So from that point of view, I think overloading LOST is not so very nice
> > > for this.
> >
> > But anything can get lost in case of no space.
> > Do you want to use something other than the LOST event?
>
> Could always reserve the last entry in the ring buffer for a LOST event,
> that would guarantee you can always get one out.

A problem is that we can have more than one event that failed.

In my understanding, we keep the lost count and add a LOST event
when there's a space later.  So probably we can keep a list of the
failed events and do similar for each event.  Or just use a single
event to notify some number of events were failed.

Thanks,
Namhyung
