Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C852D78C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392344AbgLKPFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406543AbgLKPFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:05:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52798C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 07:04:28 -0800 (PST)
Date:   Fri, 11 Dec 2020 16:04:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607699066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/xiKtzJHIgYgE49zlVbEbtWb2jQqRpY7QvZxeq5+WwY=;
        b=atFAzQuJ+rqM8PFt4lk3AnrCiTFkhLJhyz9VkDyNgF+zBzdQRKkDhvvZdu3tC7uFrSwSgG
        oqH5DHsI2FQ8OWEQk12GvYb/Pr/WOIMq6qpAjelz33bZ3k+14UsojPZ54zYwfy4YzS03k+
        kn5JMFp6VTCOKgiR8ONzbW3uXTvjbxpHsa/o5luemcfigDAShmpB4AwJn4+J+/H0c9iEqt
        KO9S6XdnK91o7uEOuKfJb3jE4cL1xTaN+G2cWuyDURxCTPvUrcCmbhVTgsBQbjjWPdrsTi
        s0o6uJmKlCTfD1vDdkwEHaxQJiMyQ2arT4Jtg6NkaLmvzJIiPUVfIt4GgLDikw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607699066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/xiKtzJHIgYgE49zlVbEbtWb2jQqRpY7QvZxeq5+WwY=;
        b=ih1EwkoPUmexxeUrO9kUeVNRvbkAqwbtz3PT6JVR5LMnFyLJ17EaPoU/v5FkUl9nN9zAOS
        g+5eQdnMFgCvEFDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: timers: Move clearing of base::timer_running under base::lock
Message-ID: <20201211150425.pjpydbmo7k7j6vtv@linutronix.de>
References: <87lfea7gw8.fsf@nanos.tec.linutronix.de>
 <20201207130753.kpxf2ydroccjzrge@linutronix.de>
 <87a6up7kpt.fsf@nanos.tec.linutronix.de>
 <20201207152533.rybefuzd57kxxv57@linutronix.de>
 <20201207160648.GF2657@paulmck-ThinkPad-P72>
 <20201208085049.vnhudd6qwcsbdepl@linutronix.de>
 <87sg8ch0k4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sg8ch0k4.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-11 15:36:27 [+0100], Thomas Gleixner wrote:
> So the change at hand does not make things worse, right?

Correct. This *ping*-*pong* was there before this patch because
->running_timer is always cleared after the callback finishes.

I was just curious why out of a sudden there are *that* many users of
the corner case. 

> Thanks,
> 
>         tglx

Sebastian
