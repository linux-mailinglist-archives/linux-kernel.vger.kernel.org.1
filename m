Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017EE2F0FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbhAKKIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:08:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37620 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbhAKKIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:08:16 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610359654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DMcTklkFECBtCz6WzvXmoCZ2fnunKElUnnX4YPk2mtc=;
        b=3CXuLpCZNk4OmA9XyWsGjvVk79vYLdDpsutKx3BaMSC2hFnDltlmB5gZNYfbJeDAh2tyYy
        Wvlo47NtoR5fZofc3oXq9j+reFo7nJfQ07M3FcXVO1cgGvSPu+Gm3Yduc+QeoZIz9q4d+W
        GbpwycXhnL4TOUi2mV6CDdcilAviMbb985DhVm7PszVbyWOB8BAO1IfkrICk8tkfizc7zv
        194bQlUmVZoHlVxeUvqEw0bg5HbftMxpQdpY16ECrIq5yvxE/vfrOzNsttbJp/2VQ4wpOS
        gtGEQas03NvW7UM9HcKf+OFDDrTIHPaD5xsAxxEtrB1cjGBHZBrfe42scOKAVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610359654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DMcTklkFECBtCz6WzvXmoCZ2fnunKElUnnX4YPk2mtc=;
        b=eGTpwMNXCENdjqkYo2dEnlhw8gaK1t51cFwtPnj3DUHpeTTMH4Ft0aHjmAq1X4hyRLEhr1
        s2RiUNViYJVgUfCg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paul McKenney <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
In-Reply-To: <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
References: <20201226025117.2770-1-jiangshanlai@gmail.com> <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
Date:   Mon, 11 Jan 2021 11:07:34 +0100
Message-ID: <87o8hv7pnd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08 2021 at 12:46, Peter Zijlstra wrote:
> On Sat, Dec 26, 2020 at 10:51:08AM +0800, Lai Jiangshan wrote:
>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>> 
>> 06249738a41a ("workqueue: Manually break affinity on hotplug")
>> said that scheduler will not force break affinity for us.
>
> So I've been looking at this the past day or so, and the more I look,
> the more I think commit:
>
>   1cf12e08bc4d ("sched/hotplug: Consolidate task migration on CPU unplug")
>
> is a real problem and we need to revert it (at least for now).
>
> Let me attempt a brain dump:
>
>  - the assumption that per-cpu kernel threads are 'well behaved' on
>    hot-plug has, I think, been proven incorrect, it's far worse than
>    just bounded workqueue. Therefore, it makes sense to provide the old
>    semantics.

I disagree. Per-cpu kernel threads which are magically stopped during
hotplug and then migrated to a random other CPU are just wrong.

We really need to fix that and not proliferate the sloppy and ill
defined behaviour.

Thanks,

        tglx
