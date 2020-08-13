Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB5243B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 16:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMOfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 10:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgHMOfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:35:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4E7C061757;
        Thu, 13 Aug 2020 07:35:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597329298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cGR1gww3S6soUuuDFLRPw7CKS7tkn5nwoE4l+V3J1G4=;
        b=vAXzAv9YzNbly1PaIVpyuI+K246OfGFWqG7IuB4rUQ+51Vbt5vZAnF5eXBeGjAdYj2J+CC
        yvuCm4AQ3zq4RGDkIibLJ6ZVUmgGt8sneNEhdXuiy19fgK18dyKM+TL4cdkErPiEdZBh3a
        arcZw7ZiyEqHzEAmYHdp2wlHQdjXdf61LzyzYKh56zDv7+c4+h2nXVLwRBnJz4TjTptznm
        t5Y3DMV0TfVkCEC42mx9FZ9fQiFeJDUndPOyvI7Omdtsg1GOo7OlV0YdtByHjdPw0B36/4
        0q1EfBcGI+jZttPQtIP33n1IUxUrcJB/vp7jHnMUDUZhf8tLzz3f8z3RcNz1fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597329298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cGR1gww3S6soUuuDFLRPw7CKS7tkn5nwoE4l+V3J1G4=;
        b=FuOoN+kM/a9ynXkbNB0B9O0qiEp+LMDng3MIJ2Xg1K4hdRvDuZOO5I+StbrJAM+I+as7p/
        RWwJ1PQYXIxFbRBQ==
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
In-Reply-To: <20200813133308.GK9477@dhcp22.suse.cz>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72> <874kp87mca.fsf@nanos.tec.linutronix.de> <20200813075027.GD9477@dhcp22.suse.cz> <20200813095840.GA25268@pc636> <874kp6llzb.fsf@nanos.tec.linutronix.de> <20200813133308.GK9477@dhcp22.suse.cz>
Date:   Thu, 13 Aug 2020 16:34:57 +0200
Message-ID: <87sgcqty0e.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:
> On Thu 13-08-20 15:22:00, Thomas Gleixner wrote:
>> It basically requires to convert the wait queue to something else. Is
>> the waitqueue strict single waiter?
>
> I would have to double check. From what I remember only kswapd should
> ever sleep on it.

That would make it trivial as we could simply switch it over to rcu_wait.

>> So that should be:
>> 
>> 	if (!preemptible() && gfp == GFP_RT_NOWAIT)
>> 
>> which is limiting the damage to those callers which hand in
>> GFP_RT_NOWAIT.
>> 
>> lockdep will yell at invocations with gfp != GFP_RT_NOWAIT when it hits
>> zone->lock in the wrong context. And we want to know about that so we
>> can look at the caller and figure out how to solve it.
>
> Yes, that would have to somehow need to annotate the zone_lock to be ok
> in those paths so that lockdep doesn't complain.

That opens the worst of all cans of worms. If we start this here then
Joe programmer and his dog will use these lockdep annotation to evade
warnings and when exposed to RT it will fall apart in pieces. Just that
at that point Joe programmer moved on to something else and the usual
suspects can mop up the pieces. We've seen that all over the place and
some people even disable lockdep temporarily because annotations don't
help.

PeterZ might have opinions about that too I suspect.

Really, if your primary lockless caches are empty then any allocation
which comes from deep atomic context should simply always fail. Being
stuck in an interrupt handler or even deeper for 200+ microseconds
waiting for zone lock is just bonkers IMO.

Thanks,

        tglx
