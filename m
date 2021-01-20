Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6C82FD120
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389603AbhATNF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:05:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732532AbhATMRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:17:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF773206FA;
        Wed, 20 Jan 2021 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611144984;
        bh=FNb87Sq1yBJ8QdD3c0Vz+RCJmfo1KDxkPSW8JqoMCPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nsx1v+5WSI9ZKBfeSazsU7DDun7VzeXG35C+MneiOskuBMWSPzyS9hRRhfnZJ6Owe
         qU4MzNjTLkOFQkLt38H1U6G7UTD+uVFZxPHA050ebNFSXb43jxGtueCKVqYnQUotJL
         Gq1sLT7xxw2sSSUQTjz74b2F6rrVZqugwdgy0HExfA1PdwYEc+Okg+8K6eNDX2fLz9
         vD4gC5HE5+v+HkRaiYCCiMjRdJiC5GaoTGkuStGJxS1hz144E7n4NFqTauKM/iLhVc
         hMQu8sOIr+SL8K88AiqyAI3MU7lF26hIWZ51qodq580VIdwvT1xWM9GRWYyTGWmNZZ
         w0jssMrK4T9Lw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 72B2D40CE2; Wed, 20 Jan 2021 09:16:21 -0300 (-03)
Date:   Wed, 20 Jan 2021 09:16:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Alexey Alexandrov <aalexand@google.com>
Subject: Re: [PATCH] perf/core: Emit PERF_RECORD_LOST for pinned events
Message-ID: <20210120121621.GQ12699@kernel.org>
References: <20210118034323.427029-1-namhyung@kernel.org>
 <YAVezkTtAkIAImzx@hirez.programming.kicks-ass.net>
 <CAM9d7cgr+Vxq_SnEkSO5zU0QN-X6-LLJDKUfE4C72Nomnrr=+Q@mail.gmail.com>
 <YAWFkU+roDyMCgla@hirez.programming.kicks-ass.net>
 <CAM9d7cg_Agin3C0iuigDzQjZEZNtVXPe9z9eaDZsdyNoVa_wxA@mail.gmail.com>
 <20210119024657.GA3526@tassilo.jf.intel.com>
 <CAM9d7chk5qC7er5EVmmrHZtP2PB6Y9EikfGYxYibE4HZpCOmbQ@mail.gmail.com>
 <CAM9d7cgE+Q-AfL2Fdi4rnv8rpTgi_qW0+iZVjG-0hL0sq+OouA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgE+Q-AfL2Fdi4rnv8rpTgi_qW0+iZVjG-0hL0sq+OouA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 20, 2021 at 08:53:48PM +0900, Namhyung Kim escreveu:
> On Tue, Jan 19, 2021 at 12:11 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Andi,
> >
> > On Tue, Jan 19, 2021 at 11:47 AM Andi Kleen <ak@linux.intel.com> wrote:
> > >
> > > > > I don't think I object to having an even in the stream, but your LOST
> > > > > event is unfortunate in that it itself can get lost when there's no
> > > > > space in the buffer (which arguably is unlikely, but still).
> > > > >
> > > > > So from that point of view, I think overloading LOST is not so very nice
> > > > > for this.
> > > >
> > > > But anything can get lost in case of no space.
> > > > Do you want to use something other than the LOST event?
> > >
> > > Could always reserve the last entry in the ring buffer for a LOST event,
> > > that would guarantee you can always get one out.
> >
> > A problem is that we can have more than one event that failed.
> >
> > In my understanding, we keep the lost count and add a LOST event
> > when there's a space later.  So probably we can keep a list of the
> > failed events and do similar for each event.  Or just use a single
> > event to notify some number of events were failed.
> 
> Stephane suggested emitting an event for poll() like EPOLLERR or
> EPOLLHUP.  I'll take a look at that.

Looks sane, that way the poll returns immediately when we start seeing
lost events, so tools can warn the user and then, if/when space becomes
available, tell how many events were lost.

- Arnaldo
