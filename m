Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E122FA09C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391912AbhARM7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391962AbhARM5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:57:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A557FC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 04:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CPFbDEJ4anKjbDRG1spWGGNge5leysn3Sb0uEuAXe/k=; b=R7FPYtLTC1BSQOon7pbdZBpLel
        1okmV0itamIZ2oYe4Qean2HZ2l4+eZZyniaZWWqi3roQYcO5HGPVYNXChKwD9JNhcmhhh3cJFUbDG
        KoAYvyTh9wodAphUTWWjuQmUZlSehr6OUVJokv9HxcAaPSxx92TZJWtEj3Y/rEYi8HnyvdM2Ao6NV
        SVBK8/RcKEYqHXV8DcviNbfWIfNkPKwiLUdo2i49nMJFygJt2Ll408pEHrWhaX4hmlp6JFp4RS8y4
        23TpZPmnaUZqn9LXF9vp2XE9thB0Mvnv72PYZjhZyWiwQHRiEA59w8+XejfTYp5mabXTHctjDIz7q
        dgPLzHvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l1U5R-00Cq4E-RL; Mon, 18 Jan 2021 12:56:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39470300F7A;
        Mon, 18 Jan 2021 13:56:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E94C2023AA22; Mon, 18 Jan 2021 13:56:49 +0100 (CET)
Date:   Mon, 18 Jan 2021 13:56:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexey Alexandrov <aalexand@google.com>
Subject: Re: [PATCH] perf/core: Emit PERF_RECORD_LOST for pinned events
Message-ID: <YAWFkU+roDyMCgla@hirez.programming.kicks-ass.net>
References: <20210118034323.427029-1-namhyung@kernel.org>
 <YAVezkTtAkIAImzx@hirez.programming.kicks-ass.net>
 <CAM9d7cgr+Vxq_SnEkSO5zU0QN-X6-LLJDKUfE4C72Nomnrr=+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgr+Vxq_SnEkSO5zU0QN-X6-LLJDKUfE4C72Nomnrr=+Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:44:20PM +0900, Namhyung Kim wrote:
> Hi Peter,
> 
> On Mon, Jan 18, 2021 at 7:11 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jan 18, 2021 at 12:43:23PM +0900, Namhyung Kim wrote:
> > > As of now we silently ignore pinned events when it's failed to be
> > > scheduled and make it error state not try to schedule it again.
> > > That means we won't get any samples for the event.
> > >
> > > But there's no way for users to notice and respond to it.  Let's
> > > emit a lost event with a new misc bit to indicate this situation.
> >
> > Users should get a read(2) error IIRC, does that not work?
> 
> Ah, right.  maybe I'm too specific to perf record's perspective.
> 
> In perf record, it doesn't use read(2) so I thought it should
> have the information in the stream of sample data.

perf-record could of course do a read() at the end, to detect this.

I don't think I object to having an even in the stream, but your LOST
event is unfortunate in that it itself can get lost when there's no
space in the buffer (which arguably is unlikely, but still).

So from that point of view, I think overloading LOST is not so very nice
for this.
