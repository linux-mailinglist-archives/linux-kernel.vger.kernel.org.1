Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C07E27710B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgIXMba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgIXMba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:31:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00489C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:31:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600950688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5z81b0l/ou8a1NGQIAUTYGK50fEsB6aV5MR6+jiqW8U=;
        b=V6bjnZooJtr1WM7nDsx5fWI6vLi1VItA1R8bQtqGIu+sXQ4Lmo1QTicCjetO8yhFWKz7O2
        ZiyxJ7kdRoqONsYfpj72YajZE7muZGfmTGOxu37qF1Du0YJxyIAEko8xLvyart5pZfPlxC
        UD0fi2YmXJxL1XEEmOvGnXCznP8eivd0qi8/A9PqC5yA1wd26FOIZczlhyYRNfMYfbgHD5
        UvoO4oEhZVuqmtoNBpiuhSKczs3X04WKeLjZH6Y3Ud2xinlZQtfgpenMJFhBZ5p7pD1FgD
        FhQJJkZ6ht9N76CTz6zDpJjyQj6NQh5bN2ZLzp5iMk+VeamNyvmEjw/FeI7fQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600950688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5z81b0l/ou8a1NGQIAUTYGK50fEsB6aV5MR6+jiqW8U=;
        b=Ix8Ykr+c5+mW05+gua7Jy3Ryh1WB3CFcHLWhygzt0KwubfPERGmDX2CXFuy37l3gLFjXGB
        B0hmn48tl7KeyBDQ==
To:     qianjun.kernel@gmail.com, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Cc:     laoar.shao@gmail.com, qais.yousef@arm.com, urezki@gmail.com,
        jun qian <qianjun.kernel@gmail.com>
Subject: Re: [PATCH V7 2/4] softirq: Factor loop termination condition
In-Reply-To: <87v9g38tcc.fsf@nanos.tec.linutronix.de>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com> <20200915115609.85106-3-qianjun.kernel@gmail.com> <87v9g38tcc.fsf@nanos.tec.linutronix.de>
Date:   Thu, 24 Sep 2020 14:31:27 +0200
Message-ID: <87r1qr8ig0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24 2020 at 10:36, Thomas Gleixner wrote:

> On Tue, Sep 15 2020 at 19:56, qianjun kernel wrote:
>>  asmlinkage __visible void __softirq_entry __do_softirq(void)
>>  {
>>  	u64 start = sched_clock();
>>  	unsigned long old_flags = current->flags;
>> -	int max_restart = MAX_SOFTIRQ_RESTART;
>> +	unsigned int max_restart = MAX_SOFTIRQ_RESTART;
>
> And this change is related to making the timeout check a function in
> which way?

Aside of that looking at:

      https://lore.kernel.org/r/20200911155555.GX2674@hirez.programming.kicks-ass.net

Peter gave you a series of patches, granted they are untested and
lacking proper changelogs. But you go and repost them mostly unmodified
and taking authorship of them.

This not the way it works. You cannot claim authorship of something you
did not write yourself. See Documentation/process/ for detailed
explanation how to handle patches which you got from someone else.

Thanks,

        tglx


