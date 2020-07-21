Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B508227AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 10:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgGUIhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 04:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgGUIhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:37:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5F5C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9566pXjDKQ/e1TSy9oLcSt9KWqbep/OwEK2Cd/sia7E=; b=PYfBH+PJejw3T+W3ysif5Yj+Db
        +kpLycVGkONunbzDJBrlLWRikeXoFq8CrvQ0x2BNodM73g7GJtsn6hpH+Fxsd0YC95IIpKu2Egj0b
        /1U0nCeAGqNchn2JYPNpQeWWsM51b2G/mvMXB0kWAYByKw+4MNo7qFQ/M1+shEas2JAegSDJjKs6Z
        O0WGBIQTFx3+YgFKAX5V2NBha3pbajO6GW4AqL3iru58Ei5TIdYBt0QNXpBZYxtCjUf8ZtZjVe8yL
        UYDRKfLnQSdsVBh5pN5E5LGN3xo+E2cz8fstCfynWC3yYQ2UXIz0jeSqra/PtlrlzHIj+5GINibot
        Yz3+83+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxnlZ-0007Rd-0e; Tue, 21 Jul 2020 08:36:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43F00300446;
        Tue, 21 Jul 2020 10:36:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E062B23426BA1; Tue, 21 Jul 2020 10:36:43 +0200 (CEST)
Date:   Tue, 21 Jul 2020 10:36:43 +0200
From:   peterz@infradead.org
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, sfr@canb.auug.org.au
Subject: Re: [tip:sched/fifo 44/45] ERROR: modpost: "sched_setscheduler"
 undefined!
Message-ID: <20200721083643.GG119549@hirez.programming.kicks-ass.net>
References: <202006192249.AYnVBGCH%lkp@intel.com>
 <20200709124505.GT597537@hirez.programming.kicks-ass.net>
 <20200709115818.36a956a4@oasis.local.home>
 <20200720214918.GM5523@worktop.programming.kicks-ass.net>
 <20200720181943.7d8efc65@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720181943.7d8efc65@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 06:19:43PM -0400, Steven Rostedt wrote:
> On Mon, 20 Jul 2020 23:49:18 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Steve, would this work for you, or would you prefer renaming the
> > parameters as well?
> > 
> 
> Yeah, that's fine. You don't have any sched_fifo_high() ?

Thanks! and no.

I'll go write a Changelog and add it to tip/sched/fifo, so that
hopefully, sfr can stop complaining about this build fail ;-)

I've even argued we should rename fifo_low() to something else, but
failed to come up with a sensible name. The intended case is for when
you want something above normal but don't particularly care about RT at
all.

The thing is, once you start adding priorities, even low,med,high, we're
back to where we were. And the whole argument is that the kernel cannot
set priorities in any sensible fashion.
