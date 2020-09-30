Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7027E465
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgI3I5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:57:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54906 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgI3I5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:57:15 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601456234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=woD9pzgXC5ff0hRO1H3nIkWVVoLP8SqvJs5444aCGK8=;
        b=jJQp1HWbh9P2hqSrit86X0MKxZ5wyVCwlytCdVFK7ypZSgJgvuvTu6LeXz/s816ZZnlAJI
        dp0he0IxFNwC7wmw/6VM56YhYcretrjMJp5p7o0pXQ9UWZykys2X/x7fO+BBMJTgtRUMvX
        2cJIc0EGidJhentLvqI6Yo93zBJg0R8YTMosr0v18x9RSC0ZD05tFR5YKynsSTlEtkZQpn
        0WkUyNk1of5FN0NPO4USvS1t3I+96u3MxbL725q+hYXaTR5ywnU2xRfpNwUbxtVi834uTW
        RUeecMPKnW5fd15SYPmNf7aQCGwWUbiLD85VS4EaiNBfShpqErotGcGnOFMjqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601456234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=woD9pzgXC5ff0hRO1H3nIkWVVoLP8SqvJs5444aCGK8=;
        b=lh+IJ2VJM+zpZfklL6cuC+uzeTiBpndxnJeoqlBXW9PxCD4Y2M7xfIULa/PxwzSoK3tWQ4
        SX/QylVajELDHMBw==
To:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
In-Reply-To: <20200930085131.GY29288@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de> <20200922153816.5883-4-john.ogness@linutronix.de> <20200923151129.GC6442@alley> <aef3626f-56a0-9040-fc0e-224ada032d02@prevas.dk> <2c95c16b-03e7-eadd-d3af-bedc6b0b471e@prevas.dk> <20200925082822.GL29288@alley> <4e36f308-a435-f9c1-2d4f-362e797c764e@prevas.dk> <20200930085131.GY29288@alley>
Date:   Wed, 30 Sep 2020 11:03:13 +0206
Message-ID: <87o8ln1w2e.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-30, Petr Mladek <pmladek@suse.com> wrote:
>> Doubling the cost of every single printk by unconditionally doing
>> vsnprintf() twice is a bad idea.
>
> I would prefer to solve this when there are real life problems.
> printk() should not get called in performance sensitive paths in
> the first place.
>
> We could always make the code more complicated when it can be
> justified. Extra buffers is yet another layer (code and memory)
> in the processing. And the current arguments sounds theoretical.

I am preparing a v2 that avoids the memory pool.

John Ogness
