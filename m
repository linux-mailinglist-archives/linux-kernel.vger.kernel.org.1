Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BEE243D14
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 18:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgHMQOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 12:14:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59600 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgHMQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:14:34 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597335272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=66uJUorK5q7WBNWrxkKSEUxXZkFJ2RBMqFNCx+IQFx0=;
        b=oOFjRBHzQlN+As6SH+DyrVe2USN0vtJQnp/6vhWsa/D39lvLO+wMMkw/+jjXidC4Ds24z+
        jacAuqJvVEt0fkLYUVB17Av9dZ7LhgnLHViGhioFTBzKNaaN9VuTzvOB5zOLMnq0XJPvgU
        9IlMNOXi2hdniFIZkh9hQSh9QGCJyCbf45wM0veye3MXLnuH2vQNJog8rH4rgfKnhm+PJp
        lLarHvRldgIMM8mxAK5JhDGR3quYK5gKTGvJZfcnSVlx7OrVjrpsaDRbX6dkg4FsA+Y+nn
        ZIwI6RnzKcMNtvpYXKlH7Of/wEBG1SnwQlo8j1qN74j2QePz/7xf+ZqnO8Jz+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597335272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=66uJUorK5q7WBNWrxkKSEUxXZkFJ2RBMqFNCx+IQFx0=;
        b=qJcUozzxZ0Wmz6U+FNL0TGmzZm/M4UNNZ+yBk0JAXDJFCk5RJoj2tuGkXcYLTj2ouTm3cm
        54nJ4Z4S13mbrfAQ==
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
In-Reply-To: <20200813143221.GI17456@casper.infradead.org>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72> <874kp87mca.fsf@nanos.tec.linutronix.de> <20200813075027.GD9477@dhcp22.suse.cz> <20200813095840.GA25268@pc636> <20200813111505.GG9477@dhcp22.suse.cz> <871rkallqk.fsf@nanos.tec.linutronix.de> <20200813143221.GI17456@casper.infradead.org>
Date:   Thu, 13 Aug 2020 18:14:32 +0200
Message-ID: <87pn7uttef.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:
> On Thu, Aug 13, 2020 at 03:27:15PM +0200, Thomas Gleixner wrote:
>> And guarding it with RT is not working either because then you are back
>> to square one with the problem which triggered the discussion in the
>> first place:
>> 
>> raw_spin_lock()
>>   alloc()
>>     if (RT && !preemptible())  <- False because RT == false
>>     	goto bail;
>> 
>>     spin_lock(&zone->lock)  --> LOCKDEP complains
>> 
>> So either you convince Paul not to do that or you need to do something
>> like I suggested in my other reply.
>
> I'd like to throw in the possibility that we do something like:
>
>   raw_spin_lock()
>     alloc()
>       if (!spin_trylock(&zone->lock))
>         if (RT && !preemptible())
>           goto bail;
>         spin_lock(&zone->lock);
>
> would that make us feel more comfortable about converting zone->lock to
> a raw spinlock?

Even if that could cure that particular problem of allocations in deep
atomic context, making zone->lock raw brings back the problem of
zone->lock being held/contended for hundreds of microseconds with
interrupts disabled which is causing RT tasks to miss their deadlines by
big margins.

Thanks,

        tglx
