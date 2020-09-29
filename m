Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A1327D1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgI2OuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgI2OuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:50:02 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5FEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 07:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QfNS7kmBNQ3K4ORpreZAzPxbXwgj+XL6qIvXBNr08X4=; b=mGxGxYrOkYHUlLWtDhpJ8xBYx9
        pW03Xet+BVe68mn0pBWEvEIyPLTM+nOqaZK6NrB1m9VOliWy8wN57iX1Qz4wQmLNwAMfy+RRlIAsl
        DR4/GKkinJWXw4N42fn/y3xqv8bf9WW+PCkpCvF+FaSbrxLRfOHjllw5mo0ps1CaJr0F4KqX6BK5J
        VB+UhLDubUktXzqkRmC4MSv7HYCSfuiSfjQsNoCSXX49oIC9CCDcG/aUEpVYhrZT0J3KT3rOmIudh
        5PBdctEt1hGBi2WQbNfBWJyuVhXM506d6dKg/XteURiJAVeLkMP8KCwD2PS3GLRxApFaiUxWdLDyq
        zNSIEUHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNGx1-0006R1-PW; Tue, 29 Sep 2020 14:49:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5ACA0300F7A;
        Tue, 29 Sep 2020 16:49:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED7F5210E84D0; Tue, 29 Sep 2020 16:49:53 +0200 (CEST)
Date:   Tue, 29 Sep 2020 16:49:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Paul McKenney <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, kim.phillips@amd.com
Subject: Re: [PATCH] rcu,ftrace: Fix ftrace recursion
Message-ID: <20200929144953.GP2628@hirez.programming.kicks-ass.net>
References: <20200929113340.GN2628@hirez.programming.kicks-ass.net>
 <20200929103620.06762622@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929103620.06762622@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:36:20AM -0400, Steven Rostedt wrote:

> > +notrace bool rcu_is_watching(void)
> >  {
> >  	bool ret;
> >  
> 
> I think the patch I suggested is more suitable.

Both, with only your patch we'd still take the pointless mcount call,
which is then pure overhead.
