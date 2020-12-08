Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD4D2D307A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgLHRDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgLHRDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:03:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FE3C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 09:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1P4dQy7XK4qnhLwF5yvo4boXMfG7H97b+zH7PjUVqJ0=; b=FXK8lwVH4o3g6vPqPry2eUahce
        XHuvb98/UuXPHZEMJNMjnln9PujEFpWho93/ZCP8hztGHzAGWNYpWdMN30B/xQZY/fQwoKv/wBy+t
        iOronHIJ8hN4KO8NWiXIEtDi0CHEOlKZa6GLztylKsCA2kLR/KEMD2pnwKkOPanm9KPfzUi95rykQ
        CgfqsGkNcsssz3TZkwEAYH2MKEmN5OuMVx2gZuVi7ZhY5fi97DfWgb6AiOjE7mMOXNCpkDW/AT9aE
        3vJKk7lmlWP/R55mUytjqvC9CuKP8viuxB1LNNchvU5uDIleCRYblzOC0UeE9Pi9uKaX8Y7/K5JOA
        eQfLRu1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmgNm-0003N2-8Q; Tue, 08 Dec 2020 17:02:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2249A3011F0;
        Tue,  8 Dec 2020 18:02:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15C3A21ADBEA1; Tue,  8 Dec 2020 18:02:33 +0100 (CET)
Date:   Tue, 8 Dec 2020 18:02:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2 0/5] locking/rwsem: Rework reader optimistic spinning
Message-ID: <20201208170233.GG2414@hirez.programming.kicks-ass.net>
References: <20201121041416.12285-1-longman@redhat.com>
 <20201208145743.GF2414@hirez.programming.kicks-ass.net>
 <77f74f7f-f090-ef3f-11ec-62bc89bd9a83@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77f74f7f-f090-ef3f-11ec-62bc89bd9a83@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 11:33:38AM -0500, Waiman Long wrote:
> On 12/8/20 9:57 AM, Peter Zijlstra wrote:
> > On Fri, Nov 20, 2020 at 11:14:11PM -0500, Waiman Long wrote:
> > > Waiman Long (5):
> > >    locking/rwsem: Pass the current atomic count to
> > >      rwsem_down_read_slowpath()
> > >    locking/rwsem: Prevent potential lock starvation
> > >    locking/rwsem: Enable reader optimistic lock stealing
> > >    locking/rwsem: Wake up all waiting readers if RWSEM_WAKE_READ_OWNED
> > >    locking/rwsem: Remove reader optimistic spinning
> > So I've munged the lot onto the other rwsem patches and skipped #4, I've
> > not even boot tested them (will go do so shortly).
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> > 
> I have checked the four patches in your locking/core branch. They look good
> to me. Are you planning to push the branch to tip soon so that it can be
> ready for the next merge window?

Yeah, provided the robots don't hate on it more than already reported.
