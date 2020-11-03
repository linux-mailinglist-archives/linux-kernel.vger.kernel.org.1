Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD22A59C6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 23:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbgKCWKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 17:10:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45012 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbgKCWKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 17:10:09 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604441407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8fYu6MuaJ0Ok/Y49A6p/r2wWyaAYSztubvJXZfAJjx8=;
        b=kSOrZCkd+5bm3VUzBCKp+nXf6Jm7gHJqEst/8Y8Y7kCKavfTO6EsO6Fbfu5IWFm7Yh0rOh
        ViOh1ai4o5f0PzkGC6gnQU0hccQS3A0dsAu6zIpTriXCVe8LYJKI0b83pLLX4BemllgEQ6
        +IQR9J0bMajTKl5Wq0d2SPBn9SWwC3qrE+PB++4G0G8IfyOx9BoLgfM6EkEutRo8WTxhwq
        MlO0X8D6Jsn2qbEWzgvUE1Zb1jqzlTRrYhfELhwbbtuWglFP6/4tTy4CG7I7hp5vG+2T3N
        IPrsCMkaOm0iBHMsLlRmPUmfvf6Gy5W+vaq7iru3s8Ka7+yMQ3SgEgROjA8WHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604441407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8fYu6MuaJ0Ok/Y49A6p/r2wWyaAYSztubvJXZfAJjx8=;
        b=0XFyqK39HcF4/ENuNbZFJU0QS3/l+9z7UfPcGscjnLvY1kuRMumepPSyYBcqHw+YIi3h5E
        hih5bXfXsCTgC8Cw==
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Elliot Berman <eberman@codeaurora.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Trilok Soni <tsoni@codeaurora.org>,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] smp: Add bootcpus parameter to boot subset of CPUs
In-Reply-To: <20201030174531.ywwkcntq4ge33lrh@bogus>
References: <1603404243-5536-1-git-send-email-eberman@codeaurora.org> <87v9f04n8r.fsf@nanos.tec.linutronix.de> <a6d7f84679240fcf580520230a88c058@codeaurora.org> <20201026171224.GV2611@hirez.programming.kicks-ass.net> <a9fa1f8d-52c7-adca-9087-160b1ecda6b8@codeaurora.org> <20201028145516.23lm66mora5b3wqr@e107158-lin> <20201028151558.odxwolnwbes2gihi@bogus> <cb175d84-7a89-344d-0dd8-76bf4ece9e3b@codeaurora.org> <20201030174531.ywwkcntq4ge33lrh@bogus>
Date:   Tue, 03 Nov 2020 23:10:06 +0100
Message-ID: <871rha148x.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30 2020 at 17:45, Sudeep Holla wrote:
> On Thu, Oct 29, 2020 at 02:37:06PM -0700, Elliot Berman wrote:
>> In the case where commercial device is using feature for thermal, device
>> should boot multiple small cores. Booting only one core means we would not
>> be able to use all possible cores to maximum extent possible in this thermal
>> case.
>
> I understood that point. But you haven't responded on my logical vs physical
> number argument. I am clearly NACKing this patch as is for just usage of
> logical CPU IDs in the command line while your intention is to control
> the physical CPUs. So once again, NACK for that reason.

Correct. And no, we are not going to add a command line option to select
physical CPU ids.

There are two ways to solve that:

  1) The firmware can tell the kernel whether a CPU should be brought up
     or not, e.g. by failing the bootup request.

  2) The kernel has a way to figure out the current thermal and/or power
     budget early in the boot process and sorts out which and how many
     CPUs fit into that limit.

Thanks,

        tglx

