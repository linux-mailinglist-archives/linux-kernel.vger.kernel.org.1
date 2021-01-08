Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA512EF12D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbhAHLUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:20:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50314 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbhAHLUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:20:31 -0500
Date:   Fri, 8 Jan 2021 12:19:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610104789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EGoTN+fm7S6ZZgozH/cJVCBlhqOfpBkWvdai4LEBSCM=;
        b=kli1nikIRo6Do7M/lDIYLbE2zXvZ2YzshaU9C5buYzUk+Df4l+xCf5Sl9a0KD4ICchDPZ9
        D66YY1+b2thq8mg/+NfSXtYPZMIoy0TRE7LrdK9fEtibQrCsLb3qWq3nTEoRBAMlq9c7T1
        HsRefGvdcm3awmCxNpcBWIf6jyXBa/nKu6Yh2ygtjUVegZy2H8DPwvpgeaV6kAFBv4AqDT
        urCIYtTV89FExCHoB3+DcDVug2By1qkIAzjtptIISnDEBDjURtR/cNF8HO9IbWqB9AdD8N
        ZtS7U6w311r/Yv2A7MQVVeuZetr+Y1dpj9d4POJmHXjYWkVengn4hgdp3NnCCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610104789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EGoTN+fm7S6ZZgozH/cJVCBlhqOfpBkWvdai4LEBSCM=;
        b=HJWYVWKXFePZDOpizCoAuphPO8CJtMBOiCkTQjiRHopVPPwMfvb+rwwaeyp1hd7+y8UZgh
        Efwaxs9b8yveiIAg==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ran Wang <ran.wang_1@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] rt: kernel/sched/core: fix kthread_park() pending
 too long when CPU un-plugged
Message-ID: <20210108111948.g7szdc3b46hffz24@linutronix.de>
References: <20210107091841.19798-1-ran.wang_1@nxp.com>
 <X/bmU4byS7k46zWM@hirez.programming.kicks-ass.net>
 <20210107152843.gyljmpctkwybfewh@linutronix.de>
 <X/gmtIqgT27OvDX6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/gmtIqgT27OvDX6@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-08 10:32:36 [+0100], Peter Zijlstra wrote:
> It's a single task wakeup (the caller), doing that from hardirq context
> really should not be a problem, we do lots of that in RT already.

I'm not worry about that single wakeup but about an artificial case
where you manage to accumulate multiple single wake ups in a short
time frame.

Sebastian
