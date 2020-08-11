Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A34B241D74
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgHKPnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 11:43:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59704 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgHKPnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:43:18 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597160596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Y8wKgLFG/BB38s4C+mIP9XqAuHjOkKcj6UCnkVK68w=;
        b=xC/kPOyFICzX+/DqLxf4qDnyIsUn+RJHbjTmGdh/IuE9OjfBlhAtRmfzWbaaaDKglABKOI
        AaVz3AvajZJntEW5ZWAuXZDAjD+5FcyJMMZ6PtpbEft3HBxWSzuAZkBQFRjXkQN83hsBtt
        7Q1baAzcdYNTNy4RQfcqMVrFkG3mvDxGTFDVndVN7be3k5iro0yMG7ITtQa+Xf3Ot/CnAE
        u+UhZJOBDz0BjuIXLFF0yAbS9ipObwVLyzRs46I7pSqVyZgHFDzGytbEXEI6vrygbLNcTT
        8PoMSowNYURNmwoBAIK8jXaGypiCTuZIeQ7BQqdbvYoE/dVrySU26GePTD/Bwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597160596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Y8wKgLFG/BB38s4C+mIP9XqAuHjOkKcj6UCnkVK68w=;
        b=N2bSrMLXJ9rTsShDyvIvw4dO2c6WDCQdjtjkKblf8yaYb74SCiqksA5/vA3fBGMpBC8bwh
        KlDoMDpvC5/Y05DA==
To:     paulmck@kernel.org
Cc:     Michal Hocko <mhocko@suse.com>,
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
In-Reply-To: <20200811153327.GW4295@paulmck-ThinkPad-P72>
References: <20200809204354.20137-1-urezki@gmail.com> <20200809204354.20137-2-urezki@gmail.com> <20200810123141.GF4773@dhcp22.suse.cz> <20200810160739.GA29884@pc636> <20200810192525.GG4773@dhcp22.suse.cz> <87pn7x6y4a.fsf@nanos.tec.linutronix.de> <20200811153327.GW4295@paulmck-ThinkPad-P72>
Date:   Tue, 11 Aug 2020 17:43:16 +0200
Message-ID: <87h7t96ve3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:
> On Tue, Aug 11, 2020 at 04:44:21PM +0200, Thomas Gleixner wrote:
>> Now RCU creates a new thing which enforces to make page allocation in
>> atomic context possible on RT. What for?
>> 
>> What's the actual use case in truly atomic context for this new thing on
>> an RT kernel?
>
> It is not just RT kernels.  CONFIG_PROVE_RAW_LOCK_NESTING=y propagates
> this constraint to all configurations, and a patch in your new favorite
> subsystem really did trigger this lockdep check in a non-RT kernel.
>
>> The actual RCU code disabling interrupts is an implementation detail
>> which can easily be mitigated with a local lock.
>
> In this case, we are in raw-spinlock context on entry to kfree_rcu().

Where?
