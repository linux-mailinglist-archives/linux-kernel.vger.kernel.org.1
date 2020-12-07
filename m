Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBD42D17E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgLGRvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:51:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38042 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLGRvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:51:38 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607363456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WZkxWx3dqEeG9KCgsu9gCbIfrrCZRYUaB6wimcMvWSw=;
        b=uB7mdrkgfNQjaMn0PZuu8iG6oGc8NMBUqkRIfCgJX17oWZSAqU8Ek1d/WTXCc9N5nNVxGJ
        7Bym6iQVb3V7WYcpjaHyNOQXwITBS4YlTB99t+ZKa4pSSsjlB1cV39BRuJKaiZYHoPGSea
        oq2TsszUQqDG98V+xIrN1O6hhpI+79R1ycdsUgpGBbv26ad2zCug7aJH9uFQnQxYsT7gju
        gz31tvJDLdlwu5sqEA+pQGHku1ueBUbhKd6Ahq6z/DZgaGOwzaQkn9nwhOBskKKy6xVIFL
        oBw86wGTLvOX7XtZeTm5uEN1tp83AkyzvMIfkI/kVPbWChgW+jAbLyQ64cEs0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607363456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WZkxWx3dqEeG9KCgsu9gCbIfrrCZRYUaB6wimcMvWSw=;
        b=gb2qyc43ufeKBhzvZwn6go49ogsdbrfONjTl6Ccs+rwbhR7ENMTUvArHbf69L9R1rWTu/l
        T66SUvG457Hb6CBw==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [patch V2 9/9] tasklets: Prevent kill/unlock_wait deadlock on RT
In-Reply-To: <87v9dd4ic9.fsf@nanos.tec.linutronix.de>
References: <20201204170151.960336698@linutronix.de> <20201204170805.627618080@linutronix.de> <20201207114743.GK3040@hirez.programming.kicks-ass.net> <20201207140040.yrxsu4v4xz43szkk@linutronix.de> <87tusx63q8.fsf@nanos.tec.linutronix.de> <20201207153908.5orqlhp3v5xoat63@linutronix.de> <87v9dd4ic9.fsf@nanos.tec.linutronix.de>
Date:   Mon, 07 Dec 2020 18:50:56 +0100
Message-ID: <87r1o14i9r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07 2020 at 18:49, Thomas Gleixner wrote:

> On Mon, Dec 07 2020 at 16:39, Sebastian Andrzej Siewior wrote:
>> On 2020-12-07 16:22:07 [+0100], Thomas Gleixner wrote:
>>> On Mon, Dec 07 2020 at 15:00, Sebastian Andrzej Siewior wrote:
>>> > So we keep the RT part as-is and replace the non-RT bits with this?
>>> 
>>> No. It would work for both.
>>
>> So instead of boosting our way through we simply wait until the tasklet
>> completes. Given that canceling is usually done on start/stop events, it
>> shouldn't matter if the RT priority is lost.
>
> That was my reasoning. The only thing we need to figure out whether
> there are callers on !RT which invoke that muck from non-sleepable
> context.

The kill() variant is fine. It must be called from sleepable
context. The otherone can be invoked everywhere except hard interrupt
context IIRC.

Thanks,

        tglx
