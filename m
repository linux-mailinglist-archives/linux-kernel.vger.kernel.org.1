Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9364C27A949
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgI1IGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgI1IGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:06:30 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21E5C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nSb+Zj16S/95FquhSwPKCI8PgeOwt43+2Fh6BPMBmGY=; b=CLA0jGvlYBclgRTcwwuxVFFBgn
        AfbbKySnhTOmpEUZyMMAXItCD6H6/45h94bicfeJ1PrRm+JUuOMfyH/IROHwZZyfWpXx7DQVqZdD9
        ZSioSKOUr+JcD1JbXY3o1SCcuEVFmACh0WDjSF/fHd5rDFfB/3veji9cJk7dEkS0q/BJM4MCz171A
        n/FOGLdbIXzJiL92DN4RC8Agp86fqImQOtOI3NcaZukH5CYndYm4/vO0bLKzSXyMiJ0bRMYIkpRQJ
        Ggbuy84EDRWa/ah0qPMDiIHXtGw7rmFawYCGeSIYSTAlXP2Fl4uiBwgNnArm/WXzj4YN7nSEbkleI
        VI1hGdLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMoAp-0002BI-3z; Mon, 28 Sep 2020 08:06:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA292302753;
        Mon, 28 Sep 2020 10:06:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D0A7200D90B3; Mon, 28 Sep 2020 10:06:13 +0200 (CEST)
Date:   Mon, 28 Sep 2020 10:06:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, songmuchun@bytedance.com
Subject: Re: [PATCH 2/2] sched: mark PRINTK_DEFERRED_CONTEXT_MASK in
 __schedule()
Message-ID: <20200928080613.GB2651@hirez.programming.kicks-ass.net>
References: <20200927161130.33172-1-zhouchengming@bytedance.com>
 <20200927161130.33172-2-zhouchengming@bytedance.com>
 <20200928073202.GA2611@hirez.programming.kicks-ass.net>
 <0e8e87e25c90339fe790252626855cbb47bc2c08.camel@perches.com>
 <20200928080022.GD2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928080022.GD2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:00:22AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 28, 2020 at 12:52:44AM -0700, Joe Perches wrote:
> > On Mon, 2020-09-28 at 09:32 +0200, Peter Zijlstra wrote:
> > > On Mon, Sep 28, 2020 at 12:11:30AM +0800, Chengming Zhou wrote:
> > > > The WARN_ON/WARN_ON_ONCE with rq lock held in __schedule() should be
> > > > deferred by marking the PRINTK_DEFERRED_CONTEXT_MASK, or will cause
> > > > deadlock on rq lock in the printk path.
> > []
> > > NAK printk_deferred is an abomination, kill that.
> > 
> > Didn't you introduce it?
> > Should you be complaining to yourself?
> 
> Yeah. I should've hacked around it then I suppose. Still, no reason to
> proliferate that crap. Afaik the new printk should be able to deal with
> this at some point.
> 
> The thing we're not going to do it add a cache-miss to schedule just
> because.

Also, using deferred for WARN/BUG is fundamentally wrong, you want that
splat _NOW_, there might not be a later.
