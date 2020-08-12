Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29492428D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 13:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHLLij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 07:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgHLLij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 07:38:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04570C06174A;
        Wed, 12 Aug 2020 04:38:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597232315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y2rZT2cxtrg0Kg6rhVZsjk/yBTEz7j8kir5nfqAJhcE=;
        b=p/bGv3BbO6JIPPoBx/asQQySa8mRBvK1GfMgknrvjm1Nd3VyZudDTxZyys5JQl0og1yOSh
        whbHR6mMsOZf2wwvghTpPH+UJYrLiHriddiksRXMnhCb81BqVNkProumwg0AH3eWsC8ZN8
        ZDVujhEn+J+ZFedD9XtMGXrwO/Toxr8sPvbJQ5skT+2sUXx28XCOHPNdI4YBAKTgUu35Hv
        RfQ1baiIiCesXlL0nKZsq52MiIcI4UA9OwvvLyuGutRR7iEYiK8ju58Z/BEASJKL3kicPM
        LEAzk4RFdU2TgPaHvD5NsnBqOpEJFat+GuX2mBlTEuDtfukdLD8T/UVQxqcfdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597232315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y2rZT2cxtrg0Kg6rhVZsjk/yBTEz7j8kir5nfqAJhcE=;
        b=SD8voxuAKHjVeWQmzSvKyXeYwZahG8+8+rUcdpYKNKee8SHmSB0k0+JWcZNf8lO/UzidVG
        qlXzlhY7QCwgGDCw==
To:     Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
In-Reply-To: <87k0y56wc1.fsf@nanos.tec.linutronix.de>
References: <20200809204354.20137-1-urezki@gmail.com> <20200809204354.20137-2-urezki@gmail.com> <20200810123141.GF4773@dhcp22.suse.cz> <20200810160739.GA29884@pc636> <20200810192525.GG4773@dhcp22.suse.cz> <87pn7x6y4a.fsf@nanos.tec.linutronix.de> <87k0y56wc1.fsf@nanos.tec.linutronix.de>
Date:   Wed, 12 Aug 2020 13:38:35 +0200
Message-ID: <87mu305c1w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> Michal Hocko <mhocko@suse.com> writes:
>>> zone->lock should be held for a very limited amount of time.
>>
>> Emphasis on should. free_pcppages_bulk() can hold it for quite some time
>> when a large amount of pages are purged. We surely would have converted
>> it to a raw lock long time ago otherwise.
>>
>> For regular enterprise stuff a few hundred microseconds might qualify as
>> a limited amount of time. For advanced RT applications that's way beyond
>> tolerable..
>
> Sebastian just tried with zone lock converted to a raw lock and maximum
> latencies go up by a factor of 7 when putting a bit of stress on the
> memory subsytem. Just a regular kernel compile kicks them up by a factor
> of 5. Way out of tolerance.
>
> We'll have a look whether it's solely free_pcppages_bulk() and if so we
> could get away with dropping the lock in the loop.

So even on !RT and just doing a kernel compile the time spent in
free_pcppages_bulk() is up to 270 usec.

It's not only the loop which processes a large pile of pages, part of it
is caused by lock contention on zone->lock. Dropping the lock after a
processing a couple of pages does not make it much better if enough CPUs
are contending on the lock.

Thanks,

        tglx
