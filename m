Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D257C27744F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgIXOus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgIXOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:50:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68B4C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2lUiJbXVuPS/X3uezMazV19nz/vWtVBuqC8qQTeRTSA=; b=VSpMV9qGL0zbtY+4j5BOsCh+2b
        jXtc+4O+L0UzzT92iKGzjkK2D6LAfq0KrNCuIaicWg1ktmvNjSilFs+InFnK0j0kzEeSrTgmXdZSc
        LdSDINgXeYUxQujT4UcWVav4PnMRjjDGliK+1NdHfP38aVQYT62Mk747iKXY+tJkFme0CvsL1w4qX
        e/q2E2/VKBW5xDWCvFNXZ1WAE1fyjLmk2EKzUbm3U+fGmd7nCKzvC5BGNJ6essSKJZYO+Mkj0EKQT
        pwAaIayrUs3CwkzuhglxudCk94xzUSq7HMwBo67HHaKnKRaJGawBkEiG83OcWD3kbR1LPArv5NAw4
        2w1AqwbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLSa2-0007N6-Nl; Thu, 24 Sep 2020 14:50:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E7A3305C10;
        Thu, 24 Sep 2020 16:50:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A8CF2010B5FA; Thu, 24 Sep 2020 16:50:41 +0200 (CEST)
Date:   Thu, 24 Sep 2020 16:50:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: Re: sched: rq->nr_iowait transiently going negative after the recent
 p->on_cpu optimization
Message-ID: <20200924145041.GP2628@hirez.programming.kicks-ass.net>
References: <20200918172759.GA4247@mtj.thefacebook.com>
 <20200924115042.GG2628@hirez.programming.kicks-ass.net>
 <20200924142751.GF4268@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924142751.GF4268@mtj.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 10:27:51AM -0400, Tejun Heo wrote:
> Hello,
> 
> On Thu, Sep 24, 2020 at 01:50:42PM +0200, Peter Zijlstra wrote:
> > Hurmph.. I suppose you're right :/ And this is an actual problem?
> 
> Yeah, this got exposed to userspace as a full 64bit number which overflowed
> u32 conversion in the rust procfs library which aborted a program I was
> working on multiple times over several months.
> 
> On a more theoretical side, it might also surprise nr_iowait_cpu() users.
> However, a real problem that may be.
> 
> > I think the below should cure that, but blergh, not nice. If you could
> > confirm, I'll try and think of something nicer.
> 
> Rik suggested that it'd be sufficient to return 0 on underflow especially
> given that 0 is actually the right number to describe the state. So, maybe
> that can be a nicer code-wise?

I worry about things where one CPU has a positive value and one or more
(other) CPUs have a temporary negative value.


