Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE02822CB40
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 18:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGXQoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 12:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXQoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:44:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7A9C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 09:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PjcxzhlVOVKgouwOgGeW8VbRm5cEnHWAj2nzc1FyWx4=; b=VYUy4oUwD+OJVaQZ3u6zDecK32
        eu3c34lP4xrakg8ntLpFNKUPxXECA8q0YH3cUxWJuCz/nPMPvswXUvRvCy/UKv0lYEDl7SDg8xWqt
        h8DF1s66qqkfBaGuHXSkxHkKTTbEYxR6GYHZaufxO5IzcqFBnh5OIiajxLxcqVLFwjT8J4GATaaTt
        GJISDILCsm3NDw5KyUC1oE4yVxvXn3V0onO9UEIMd29iE+Wbvbt1q+Ty6BvFdS0APvtE/rZtvoSqz
        vnoIhcWFnctFq/Ynt3SLzGfLpK4f1FOM2pYr74+Z7/rg5usNAsfzcJt2A2/K7jSb3m97t0SlhdkoG
        /bFVi48g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jz0nd-0003Lw-Em; Fri, 24 Jul 2020 16:43:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E6A6300446;
        Fri, 24 Jul 2020 18:43:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AE2C23645598; Fri, 24 Jul 2020 18:43:56 +0200 (CEST)
Date:   Fri, 24 Jul 2020 18:43:56 +0200
From:   peterz@infradead.org
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH V7 07/14] perf/core: Add a new PERF_EV_CAP_COEXIST event
 capability
Message-ID: <20200724164356.GL43129@hirez.programming.kicks-ass.net>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-8-kan.liang@linux.intel.com>
 <20200724105543.GV119549@hirez.programming.kicks-ass.net>
 <20200724114628.GJ43129@hirez.programming.kicks-ass.net>
 <0d33a25c-cfe4-af7f-c915-a98dba17b53b@linux.intel.com>
 <20200724135412.GA10769@hirez.programming.kicks-ass.net>
 <e04f1708-e8c0-3787-1572-443f03ab73ca@linux.intel.com>
 <20200724143258.GB10769@hirez.programming.kicks-ass.net>
 <20200724144632.GE1180481@tassilo.jf.intel.com>
 <20200724145934.GD10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724145934.GD10769@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 04:59:34PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 24, 2020 at 07:46:32AM -0700, Andi Kleen wrote:
> > > Something that seems to 'work' is:
> > > '{cycles,cpu/instructions,period=50000/}', so maybe you can make the
> > > group modifier :S use any sampling event if there is one, and otherwise
> > > designate the leader.
> > > 
> > > Then you can write things like:
> > > 
> > >   '{slots, metric1, metric2, cpu/cycles,freq=50000/}:S'
> > > 
> > > and then since cycles is specified as a sampling event, it will use
> > > that.
> > 
> > Okay possible, but it makes things more complicated
> > for the user to understand and requires special documentation.
> > Hopefully it's worth it the internal simplification.
> 
> You already require special documentation for this metrics stuff. We
> already need to state that SLOTS cannot be a sampling event, so you
> already need to pay attention to this anyway.
> 
> A shortcut could be a :s event modifier, then you can write:
> 
>  '{slots, metric1, metric2, cycles:s}:S'
> 
> and have the tool select the :s tagged one.

Having slots as leader also would allow doing something like
FORMAT_METRIC, where we return sibling/leader in some fashion.

That also makes sense for instructions, because, IIRC,
instructions/slots is the better IPC.

And we should probably consider FORMAT_RESET.
