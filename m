Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB8326679A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgIKMby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 08:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgIKM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:26:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D907C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RIzmpouUc5UeVrI53gHBLBgWs6d0kms5g/Csx94jrAU=; b=asVPCIe/GVkLtu8stF/zsMyTuy
        UUtODUTOOInRcz/7JNPhcwvVL8wnO7IsVnrUVVdZMHcoXrdyK/oWIY8EcXi4AORQ3EZRJI1KNzXbj
        qo29cGIcs/VhG+P+KnL79yUXV4StG3n89s9HrMksjdIxjeymAOGEgj/UJjrhpbSevNduXM66MjCwR
        CphTJmTi3e5d4hiTEBlSSyq1u3J/+JLq48DTc/XkjM+XTXb78OQS9+aToPvkOXkrqPUDLwT3kYpHm
        xZ4feK/NJG6M8UmgO+Ng/ghDW3llSp8JvN4LnVSxwiY1TMKiAqjNUXW34gy+xp+W185/dp6cAaEPm
        Y1bOcyGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGi7i-0001Tl-1U; Fri, 11 Sep 2020 12:25:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 118953059DD;
        Fri, 11 Sep 2020 14:25:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D73512B082747; Fri, 11 Sep 2020 14:25:47 +0200 (CEST)
Date:   Fri, 11 Sep 2020 14:25:47 +0200
From:   peterz@infradead.org
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bristot@redhat.com, swood@redhat.com
Subject: Re: [PATCH 1/2] sched: Fix balance_callback()
Message-ID: <20200911122547.GI1362448@hirez.programming.kicks-ass.net>
References: <20200911081745.214686199@infradead.org>
 <20200911082536.470013100@infradead.org>
 <jhjsgbo5wzl.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjsgbo5wzl.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 01:17:02PM +0100, Valentin Schneider wrote:
> On 11/09/20 09:17, Peter Zijlstra wrote:
> > The intent of balance_callback() has always been to delay executing
> > balancing operations until the end of the current rq->lock section.
> > This is because balance operations must often drop rq->lock, and that
> > isn't safe in general.
> >
> > However, as noted by Scott, there were a few holes in that scheme;
> > balance_callback() was called after rq->lock was dropped, which means
> > another CPU can interleave and touch the callback list.
> >
> 
> So that can be say __schedule() tail racing with some setprio; what's the
> worst that can (currently) happen here? Something like say two consecutive
> enqueuing of push_rt_tasks() to the callback list?

Yeah, but that isn't in fact the case I worry most about.

What can happen (and what I've spotted once before) is that someone
attempts to enqueue a balance_callback from a rq->lock region that
doesn't handle the calls.

Currently that 'works', that is, it will get ran _eventually_. But
ideally we'd want that to not work and issue a WARN. We want the
callbacks to be timely.

So basically all of these machinations we in order to add the WARN :-)
