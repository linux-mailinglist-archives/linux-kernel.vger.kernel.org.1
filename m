Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5962D3FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgLIKd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbgLIKd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:33:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FDCC061794;
        Wed,  9 Dec 2020 02:32:45 -0800 (PST)
Date:   Wed, 9 Dec 2020 11:32:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607509964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LzKQzqHnyqgXWi0FI8XkH1ss7UHxBo4fD7Jw9hl39p0=;
        b=KhoVoXnDEJfhwAohGpEJifQjjCeePnVAvSPX/X6by8IHgn1xwmElfsSCXjODykoJe6l2wj
        5jq2n0p3p6B1m6FOU+Jw1JbHCgQq/DyWxW+DNcinRwPTsF/ljJjncYVqCHNsixX5nFATAX
        Vcz3eWVl64V7aHBo83ncmmJE4KUcfk7b5m+Qa1KLYH6g2kQBXMboEdWMG8vP78+8sIT8zH
        ui5FJz4EHNrEhIToUMWnB3NQ++JI3qPpdRPtHj86Dm5urCqfZcP7nLfVDHXtadmHCTudxs
        Ak3cOglDEW+6HaZlTxcAiT01Eyr4nGJY3mnxTaDV/FKXdxRxD+OtO5TZQ6D7Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607509964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LzKQzqHnyqgXWi0FI8XkH1ss7UHxBo4fD7Jw9hl39p0=;
        b=Ct6g3LZSM7017/ntvI/lg+A2kblacYV29i/2+tHFPfYCoOlVNLe2Ji5yiPKCKANmqX4099
        qiQG3T6SnoNQOsAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [RT] 5.9-rt14  softirq_ctrl.lock vs listening_hash[i].lock
 lockdep splat
Message-ID: <20201209103242.loklx4lmgqbafvhc@linutronix.de>
References: <12d6f9879a97cd56c09fb53dee343cbb14f7f1f7.camel@gmx.de>
 <X9CheYjuXWc75Spa@hirez.programming.kicks-ass.net>
 <facf3c932c05cfc0c8287465a94f7919bbf6ad58.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <facf3c932c05cfc0c8287465a94f7919bbf6ad58.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-09 11:25:34 [+0100], Mike Galbraith wrote:
> Sebastian fixed this via...

We still look if we go that road or update lockdep.

Sebastian
