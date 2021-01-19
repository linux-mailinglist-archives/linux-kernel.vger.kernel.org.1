Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2889A2FAE63
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 02:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392559AbhASBn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 20:43:29 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:43043 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbhASBn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 20:43:27 -0500
Received: by mail-lj1-f172.google.com with SMTP id e7so20161404ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 17:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ojqp2T2HIXLPkCDBKcmUSSjcF3qRybCSsd8tk+cfTS8=;
        b=aIu0kx0Ol6rtgagJXjJzdnDPuVQfgocOANYM6x1RmelANqrOLHssiPf/rcYWmB2ATs
         ZV4kjZARAHlO9ZvQ0p4AH0cGlSne4P0ouE15kOhHxzxAtxkCGbyN/Zeg4VDucHgtE492
         rMxIIxXnsPN3EQZqohGut1c3oDMxAIRRdSzqAocsJF69XwGf9aYde2fbJnrwDyxq0mzu
         xjY8fokQPaDelQe3Jy1yI3ziJU5989M/QyI50gB5wJEqjCUkqMTOT3YAOWtS1d63MKKg
         itBoVjmdT8QDjGrDhCh3vQni7BU3mp1gsdLYFwDcQGJsi96CRmh9m8C065lVNCskfnPw
         cSXQ==
X-Gm-Message-State: AOAM530AmufpPV417UunOeLzlIQ7T3nNImZeK+G5DYVEwYWyStUPLzti
        aZN6IbxGSuIQZubpwN0njx9c6xpaN/421PYbrZM=
X-Google-Smtp-Source: ABdhPJzYBaTnlTdGzDQ4EMXlOY1pacKrz6g5fR6rNQJLnXJ7JIk2MoblXfz4ZBrbbT7C2Nf0XnhNLWVErPPOr8G+OcE=
X-Received: by 2002:a2e:b04e:: with SMTP id d14mr847246ljl.26.1611020565655;
 Mon, 18 Jan 2021 17:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20210118034323.427029-1-namhyung@kernel.org> <YAVezkTtAkIAImzx@hirez.programming.kicks-ass.net>
 <CAM9d7cgr+Vxq_SnEkSO5zU0QN-X6-LLJDKUfE4C72Nomnrr=+Q@mail.gmail.com> <YAWFkU+roDyMCgla@hirez.programming.kicks-ass.net>
In-Reply-To: <YAWFkU+roDyMCgla@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 19 Jan 2021 10:42:34 +0900
Message-ID: <CAM9d7cg_Agin3C0iuigDzQjZEZNtVXPe9z9eaDZsdyNoVa_wxA@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Emit PERF_RECORD_LOST for pinned events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexey Alexandrov <aalexand@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 9:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jan 18, 2021 at 08:44:20PM +0900, Namhyung Kim wrote:
> > Hi Peter,
> >
> > On Mon, Jan 18, 2021 at 7:11 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Jan 18, 2021 at 12:43:23PM +0900, Namhyung Kim wrote:
> > > > As of now we silently ignore pinned events when it's failed to be
> > > > scheduled and make it error state not try to schedule it again.
> > > > That means we won't get any samples for the event.
> > > >
> > > > But there's no way for users to notice and respond to it.  Let's
> > > > emit a lost event with a new misc bit to indicate this situation.
> > >
> > > Users should get a read(2) error IIRC, does that not work?
> >
> > Ah, right.  maybe I'm too specific to perf record's perspective.
> >
> > In perf record, it doesn't use read(2) so I thought it should
> > have the information in the stream of sample data.
>
> perf-record could of course do a read() at the end, to detect this.

OK, will add that.

>
> I don't think I object to having an even in the stream, but your LOST
> event is unfortunate in that it itself can get lost when there's no
> space in the buffer (which arguably is unlikely, but still).
>
> So from that point of view, I think overloading LOST is not so very nice
> for this.

But anything can get lost in case of no space.
Do you want to use something other than the LOST event?

Thanks,
Namhyung
