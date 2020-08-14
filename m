Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B072447E5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 12:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgHNKXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 06:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgHNKXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:23:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5B9C061383;
        Fri, 14 Aug 2020 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2bzdVcEaOY9NKXRzVCZZ4sATksY3jrzQirPEzdSYgjQ=; b=Udj4hUqe3bw8kl4v/Dp54CIPsr
        VKWn8vvCTPIkIW3fOq5z/jLcbdNMwEZjGL5Zk0p1oqRioYu6vFdl1mTvx+aOvxkVdrNrVxJ6PDAkd
        9lhbIE2yRRNy6r7Msr8RJgZw7BbyB19SveC/v/wpYEFXzKd7GyiG6BxYK4dhTK2/nE+mjbA5F57/g
        sceZyYLg5bsFsPVP9MWZ6WbmoIBd/EWjNYLkQOGtVdXNlm7cCrvRNTQmBeTaTkklKspqHBtfpKfTG
        S+ZwaZONPYo6oUM9Qd/RDf4IFlONJapXDj8ZTlmmJNrI2fbxbkyPPcJICA7q1H1a1W0QeSjRR+eZh
        S7Vbdeig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6Wrb-0003QY-DE; Fri, 14 Aug 2020 10:23:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D5F030066E;
        Fri, 14 Aug 2020 12:23:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 497C22C33E600; Fri, 14 Aug 2020 12:23:06 +0200 (CEST)
Date:   Fri, 14 Aug 2020 12:23:06 +0200
From:   peterz@infradead.org
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200814102306.GK35926@hirez.programming.kicks-ass.net>
References: <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813182618.GX2674@hirez.programming.kicks-ass.net>
 <20200813185257.GF4295@paulmck-ThinkPad-P72>
 <20200813220619.GA2674@hirez.programming.kicks-ass.net>
 <875z9m3xo7.fsf@nanos.tec.linutronix.de>
 <20200814083037.GD3982@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814083037.GD3982@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 10:30:37AM +0200, Peter Zijlstra wrote:
> > > 1.	Prohibit invoking allocators from raw atomic context, such
> > >	as when holding a raw spinlock.
> > 
> >   Clearly the simplest solution but not Pauls favourite and
> >   unfortunately he has a good reason.
> 
> Which isn't actually stated anywhere I suppose ?

Introduce raw_kfree_rcu() that doesn't do the allocation, and fix the
few wonky callsites.
