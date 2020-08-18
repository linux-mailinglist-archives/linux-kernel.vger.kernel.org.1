Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194AE248803
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgHROnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 10:43:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59738 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHROnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:43:17 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597761795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SppHSehsQnzHNR4Hp31ymdWpJXvQcn4y9IMbNmCLF/o=;
        b=f3Eeeieg1bgFpw7sMFjJEVif5jIWoAGf1dr0jSz592v2nZWW37NQgIMtsom2qNI9MJEhKT
        wDOmjoUZ3tisb40VPAHypTkfNpB3fIj3eTWpPm1A9oLITY/HK4BCARXTOuCPL+CNB5jrJS
        PA4bLz9V0qG49VACLa88yiGFl9wiCDoAnuBY9FVA2Fh2RM/zEt9dZQBKclxNtJHtH7W3Rm
        9wJuyW6/DQ7rdF15DUzCzkouWEMp5MhigzDxWKLCe+dLV8TLwB5o0v0iLwFQ5bUOqKVgh3
        ltPKEcEvGq/nlOUFqdwtOKoilwOGqHE5oXzKdorStaDucXXTn/9A9zMjKFMusQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597761795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SppHSehsQnzHNR4Hp31ymdWpJXvQcn4y9IMbNmCLF/o=;
        b=bo7hO/Wxpq0YYb29xOt44+QJFstf3JBH+zt2rbE97glkrxXCHF2IuBhZyu+Z7Bn8On6+ki
        dZIIv++UHFiKo8BA==
To:     paulmck@kernel.org, Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
In-Reply-To: <20200818135327.GF23602@paulmck-ThinkPad-P72>
References: <20200814161106.GA13853@paulmck-ThinkPad-P72> <20200814174924.GI3982@worktop.programming.kicks-ass.net> <20200814180224.GQ4295@paulmck-ThinkPad-P72> <875z9lkoo4.fsf@nanos.tec.linutronix.de> <20200814204140.GT4295@paulmck-ThinkPad-P72> <20200814215206.GL3982@worktop.programming.kicks-ass.net> <20200816225655.GA17869@pc636> <20200817082849.GA28270@dhcp22.suse.cz> <20200817222803.GE23602@paulmck-ThinkPad-P72> <20200818074344.GL28270@dhcp22.suse.cz> <20200818135327.GF23602@paulmck-ThinkPad-P72>
Date:   Tue, 18 Aug 2020 16:43:14 +0200
Message-ID: <87o8n8hv5p.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18 2020 at 06:53, Paul E. McKenney wrote:
> On Tue, Aug 18, 2020 at 09:43:44AM +0200, Michal Hocko wrote:
>> Thomas had a good point that it doesn't really make much sense to
>> optimize for flooders because that just makes them more effective.
>
> The point is not to make the flooders go faster, but rather for the
> system to be robust in the face of flooders.  Robust as in harder for
> a flooder to OOM the system.
>
> And reducing the number of post-grace-period cache misses makes it
> easier for the callback-invocation-time memory freeing to keep up with
> the flooder, thus avoiding (or at least delaying) the OOM.

Throttling the flooder is incresing robustness far more than reducing
cache misses.

Thanks,

        tglx


