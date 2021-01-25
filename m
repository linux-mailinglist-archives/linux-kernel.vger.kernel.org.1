Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6144F302C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbhAYUR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732163AbhAYTxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:53:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335FEC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:52:30 -0800 (PST)
Date:   Mon, 25 Jan 2021 20:52:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611604348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UUaH29QvFzHMxxdgneJABumqEjM9Ye+hRF7dMyP5oOo=;
        b=Ek4SQjld7lp8AFjhOKVogD8IrRgVQI0t73up02ikbSsCVUs4UFh3K0WClYTqLUe7COaPVn
        RXZEeOjVwCj0ljXE5HQm4Y6Br6QQ/aHEEso/URTKVJUAWYMzGV2nJysPB3YWqJpEPMdEeR
        3vJWTZ6IVHwIhYmCvPTDfOaKbq3A3tovQ75oRHRkpGeilkZIwImHr9f27+DgmPst60brmm
        qb+uLWemz4FdrwELPOr3ZIT2WGIwphUsfokH9yvS59tdf/2GKajW6Hu40QCVIe1BbC/Pjs
        xP0+TCvYfMeT9dxhgyAicZ755N0GXVTgKspd67lNcq74AuDQQeR8eKabTd67nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611604348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UUaH29QvFzHMxxdgneJABumqEjM9Ye+hRF7dMyP5oOo=;
        b=8MmG0FBlOfP+HNMGGPCjl5BfNm4n/BpAh636bMOJvYS1y7xmzMyWAMxqn9jtQZVFaKY+4v
        XXquQHpI0bX6jEDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] tracing: Merge irqflags + preempt counter.
Message-ID: <20210125195228.ydtrixn4v3hb4lmj@linutronix.de>
References: <20210112230057.2374308-1-bigeasy@linutronix.de>
 <20210112230057.2374308-2-bigeasy@linutronix.de>
 <20210122170750.600b2372@gandalf.local.home>
 <20210125140551.hlpbreks4f7ytuza@linutronix.de>
 <20210125140323.6b1ff20c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125140323.6b1ff20c@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-25 14:03:23 [-0500], Steven Rostedt wrote:
> 
> I was thinking about the inlining for two reasons. One was to consolidate
> the logic in the header file, as they are small functions. And two, inlined
> functions tend to be faster than non-inlined functions. Thus, I wasn't
> looking at this from a size point of view, but since this is called by all
> events, including function tracer, being efficient is a requirement.

In the ftrace_syscall_enter() example I made, flags were not evaluated
three times but only once. This should do more in terms of performance
compare to simply inline it.

> > I can post the irqflags-merge and the inlinining as two seprate patches
> > and you can then decide if you merge the two patches or drop the
> > inlining.
> 
> Feel free to send it as separate patches. I'd like to have the inlining.

Just sent as an extra patch. In case you have a benchmark, I'm curious
;)

> Thanks!
> 
> -- Steve

Sebastian
