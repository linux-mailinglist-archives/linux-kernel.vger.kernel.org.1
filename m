Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B9E2BBE8E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 11:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgKUKzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 05:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgKUKzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 05:55:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBC7C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 02:55:50 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605956148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BCkWsAO8HdXHPUv8yMTxZeqvlxBLR/7KyglJTpA140M=;
        b=LvrqpzvFMxfGQrnOYU6RV8401R0k3mk35JAMQiXO+6FgKtmDIHQ6lw+iWlnc18A/zH1tA4
        gTKCx146Zo1QGNGfohFBfZWNWAVPoSmkX/mr4cGE/m/q/6YD05hwhUFnRbXLD/lQNRnAmz
        pqciF1Bi5Cy8EKzuic+hvFkrW5xe+Bzsd6ZPa25E4KsPKIbtzVEw2xS0mYkQGZ0eKUsHs/
        MndscG0bgF5eZgIY+9v79ZBjC29EAk7fQ8SzrVC5linarRRmhJ+wmlOmw5dbV7h9FBH0L1
        eJ+P2LV9ZRPWnMRT5MtQNmo9wOOXRMtGBlBRtmw2IJCursyBzyIkLjLezABmvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605956148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BCkWsAO8HdXHPUv8yMTxZeqvlxBLR/7KyglJTpA140M=;
        b=wLDMdlXtFR+13DEhxVJ7xMQSFCXDvvzENNBd12lIPcVYscOSugCSuX5Vqcw7N+odBzd/Kc
        ieqmFDQVKZGA5cAg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Mike Galbraith <efault@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] kthread: Move prio/affinite change into the newly created thread
In-Reply-To: <20201117124503.GI3121406@hirez.programming.kicks-ass.net>
References: <20201110113848.801379-1-bigeasy@linutronix.de> <20201110113848.801379-2-bigeasy@linutronix.de> <20201117124503.GI3121406@hirez.programming.kicks-ass.net>
Date:   Sat, 21 Nov 2020 11:55:48 +0100
Message-ID: <87a6vbnfm3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17 2020 at 13:45, Peter Zijlstra wrote:
> On Tue, Nov 10, 2020 at 12:38:47PM +0100, Sebastian Andrzej Siewior wrote:
>
> Moo... yes this is certainly the easiest solution, because nouveau is a
> horrible rats nest. But when I spoke to Greg KH about this, he suggested
> nouveau ought to be fixed.
>
> Ben, I got terminally lost when trying to untangle nouvea init, is there
> any chance this can be fixed to not hold that nvkm_device::mutex thing
> while doing request_irq() ?

OTOH, creating a dependency chain vs. cpuset_rwsem and whatever lock is
held by the caller via request_irq() or kthread_create() is not
necessarily restricted to the nivea driver. struct device::mutex (not
the nkvm_device::mutex) is always held when a driver is probed.

The cpuset_rwsem -> mmap_lock dependency is a given, so we're one step
away from a circular dependency vs. mmap_lock.

That was my reasoning to move the stuff out into the thread context.

Thanks,

        tglx



