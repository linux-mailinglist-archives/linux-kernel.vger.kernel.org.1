Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637282426C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHLIcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 04:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgHLIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:32:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D89EC06174A;
        Wed, 12 Aug 2020 01:32:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597221170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MAwJcfEssf3mKlF+HdVBaVk4dp6ivOrkJynhQoue1SE=;
        b=yWMINxLW+9od8/8sqEvNhnJrUK0Y+a0ar3rxTG28EJMccMKPYyKoUm4c1fyolm/zWG+0oj
        ktvAb2eTOzWNgOK8y+wv3RjQzMsW5Lwz+Z0XeUI46CXMITYURDd/2H/o5TlsSw0g+9aobB
        L2TQ5TU2ahGTrEABcrrbpvbl45/hxMZmPTFhIUCHCbb/BIx3dx3LVQ4pkpfWe2tIQcSgC9
        XlO8R1er6wKFx3z2Kg6/wQJsyQGr/nFauZwKfBfng5qlPG8VPOQ3tFUG/WvrgTJ25zT2/W
        Wdy38R8QK6UirADIlyFUL7ULLFKD+O7BuSO9ZKWmN41LcvBZZ9r2jjZ/g1ykZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597221170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MAwJcfEssf3mKlF+HdVBaVk4dp6ivOrkJynhQoue1SE=;
        b=/j3AyygAVKvcEW2Sit7ct2yF8hIlZL/rW92tWnbMxohm8wxnmzsw76/vyxqEigP3nmQElP
        4t1imSePuF/DOrBA==
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
In-Reply-To: <20200812042945.GB4295@paulmck-ThinkPad-P72>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72> <874kp87mca.fsf@nanos.tec.linutronix.de> <20200812042945.GB4295@paulmck-ThinkPad-P72>
Date:   Wed, 12 Aug 2020 10:32:50 +0200
Message-ID: <871rkc6z7x.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

"Paul E. McKenney" <paulmck@kernel.org> writes:
> On Wed, Aug 12, 2020 at 02:13:25AM +0200, Thomas Gleixner wrote:
>> That much I understood, but I somehow failed to figure the why out
>> despite the elaborate changelog. 2 weeks of 30+C seem to have cooked my
>> brain :)
>
> Ouch!!!  And what on earth is Germany doing being that warm???

The hot air exhaustion of politicians, managers and conspiracy
mythomaniacs seens to have contributed extensivly to global warming
lately.

>> But what makes me really unhappy is that my defense line against
>> allocations from truly atomic contexts (from RT POV) which was enforced
>> on RT gets a real big gap shot into it.
>
> Understood, and agreed:  We do need to keep the RT degradation in
> check.

Not only that. It's bad practice in general to do memory allocations
from such contexts if not absolutely necessary and the majority of cases
which we cleaned up over time were just from the "works for me and why
should I care and start to think" departement.

>> I can understand your rationale and what you are trying to solve. So, if
>> we can actually have a distinct GFP variant:
>> 
>>   GFP_I_ABSOLUTELY_HAVE_TO_DO_THAT_AND_I_KNOW_IT_CAN_FAIL_EARLY
>> 
>> which is easy to grep for then having the page allocator go down to the
>> point where zone lock gets involved is not the end of the world for
>> RT in theory - unless that damned reality tells otherwise. :)
>
> I have no objection to an otherwise objectionable name in this particular
> case.  After all, we now have 100 characters per line, right?  ;-)

Hehe. I can live with the proposed NO_LOCK name or anything distinct
which the mm people can agree on.

>> To make it consistent the same GFP_ variant should allow the slab
>> allocator go to the point where the slab cache is exhausted.
>
> Why not wait until someone has an extremely good reason for needing
> this functionality from the slab allocators?  After all, leaving out
> the slab allocators would provide a more robust defense line.  Yes,
> consistent APIs are very good things as a general rule, but maybe this
> situation is one of the exceptions to that rule.

Fair enough.

>> Having a distinct and clearly defined GFP_ variant is really key to
>> chase down offenders and to make reviewers double check upfront why this
>> is absolutely required.
>
> Checks for that GFP_ variant could be added to automation, though reality
> might eventually prove that to be a mixed blessing.

Did you really have to remind me and destroy my illusions before I was
able to marvel at them?

Thanks,

        tglx
