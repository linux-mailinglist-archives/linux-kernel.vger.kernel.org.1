Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B3B21FB99
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 21:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgGNTDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 15:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730825AbgGNTC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:02:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF07DC061755;
        Tue, 14 Jul 2020 12:02:56 -0700 (PDT)
Date:   Tue, 14 Jul 2020 21:02:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594753375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D5hF4twVv5HhwhE7NRxkaBM2XMg1Sfjm24WE5eOk48k=;
        b=mghMUxtJm8hieMhzxLu5CerE0Pb2DYjrakx+pa3Am3jPdlCvZUIrG6FHe8zemEN3OgSGsL
        oaTpO4Lnjb9Suti0+9hwP/Xh2pRPwpQKKYmEruzKcgvU0ACEDi3qh8OGLUwiNXC466ZTnm
        HNvr1S1YCv/rLVPWYQk9iogWGyYZBHwbUI2fmUSYoQHmcpYaDa+Qh4/OqsRLSaF0/1xrE9
        ZEbkvsgCLulWMuH1QSHjorYrJNSYidUd/iL4rdeXO47C18SUNqdA4Skif8FpDzZzb35yHI
        ngfYroqncdmsGZMna5vXqTOnWEOwWqWijnzHjt6PEzC2Pic3RHKxD/F3GqIBUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594753375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D5hF4twVv5HhwhE7NRxkaBM2XMg1Sfjm24WE5eOk48k=;
        b=pLUMCIIOM723c3dWn2+rwO0l91r2lz11nnKA1HLCnh5e9PJtpBvMKx0tE3gNPsduT6GvIu
        7UV0830Gzi0alABg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, arnd@arndb.de, elver@google.com, ethp@qq.com,
        frederic@kernel.org, jbi.octave@gmail.com, joel@joelfernandes.org,
        lihaoliang@google.com, madhuparnabhowmik10@gmail.com,
        mchehab+huawei@kernel.org, peter.enderborg@sony.com,
        rdunlap@infradead.org, richard.weiyang@linux.alibaba.com,
        urezki@gmail.com, zou_wei@huawei.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU commits for v5.9
Message-ID: <20200714190253.ylqjif7frqs2rq7x@linutronix.de>
References: <20200714172701.GA31369@paulmck-ThinkPad-P72>
 <20200714181426.hhguqzrcqdubyvae@linutronix.de>
 <20200714182732.GU9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200714182732.GU9247@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-14 11:27:32 [-0700], Paul E. McKenney wrote:
> I believe that Ulad and Joel are working on an update.

I expressed multiple times that I am unhappy with the raw_spinlock_t
which both want to keep. It is important to be future proof but at the
same time I am not sure if they know how many in-hardirq kmalloc() or
kfree() invocation we have as of today in PREEMPT_RT.
I also had a patch in my series to keep the lock/unlock path symmetrical
and it I think that I the only one that is missing it.

> 							Thanx, Paul

Sebastian
