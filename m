Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A0C2C19E6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgKXAWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:22:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39356 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgKXAWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:22:18 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606177336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6lNWG1qtA7G9hsXhDsP3MLyuLVDI6XyrC+5IMdQxT6I=;
        b=GnsHHxDVlgVk9jhbfel6mUdbSJviiStSsYo8URmgtLjUwigsSaEnFEZVczVC9zmZx9bLsk
        qw25m4y6TgB1ZeXycueSktHBq26BiSEIvCd2KSJIoAvJiEbG6erl60+Ikvl4P4XcIy4V0N
        SD4BOfGbwXB6RLWXYfnoEzY4AGhaI5VpFBZJ+7omzKLIh5fuZOgox/raDnxgXngOdEAcWS
        +23U8DIcpeANt0FBdY2n2RikNrgGZKGfW5V43WqEoyVKjm8IW1Mudr6JsWItXH+rf71ZRo
        mlFudGebOnhpdGuFgMzmhzdimfucYMEkIW1zOzBhZax23CJRM7IiSnLdkDEDjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606177336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6lNWG1qtA7G9hsXhDsP3MLyuLVDI6XyrC+5IMdQxT6I=;
        b=R5Nrqf5gfiZGYJaIxbHMfpdUIrkuH70SVcO+mrIvTHKAoADJPzDVJZb2ure/dUCXkzLuEJ
        gYnuVRoafusac5DA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch 14/19] softirq: Make softirq control and processing RT aware
In-Reply-To: <20201124001350.GF1751@lothringen>
References: <20201113140207.499353218@linutronix.de> <20201113141734.324061522@linutronix.de> <20201123134437.GA95787@lothringen> <87r1ojnaai.fsf@nanos.tec.linutronix.de> <20201123235801.GE1751@lothringen> <87wnyblitk.fsf@nanos.tec.linutronix.de> <20201124001350.GF1751@lothringen>
Date:   Tue, 24 Nov 2020 01:22:16 +0100
Message-ID: <87r1ojli2v.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic,

On Tue, Nov 24 2020 at 01:13, Frederic Weisbecker wrote:
> On Tue, Nov 24, 2020 at 01:06:15AM +0100, Thomas Gleixner wrote:
>> Good point. Haven't thought about that. Let me have a look again.
>
> But I'm cooking a patchset which moves account_irq_enter_time() after
> HARDIRQ_OFFSET or SOFTIRQ_OFFSET is incremented. This will allow us to move
> tick_irq_enter() under this layout:
>
> 		 preempt_count_add(HARDIRQ_OFFSET)
> 		 lockdep_hardirq_enter()
> 		 tick_irq_enter()
> 		 account_irq_enter_time()
>
> This way tick_irq_enter() can be correctly handled by lockdep and we can remove
> the nasty hack which temporarily disables softirqs around it.
>
> And as a side effect it should also fix your issue.
>
> I should have that ready soonish.

Sounds to good to be true :)

Looking forward to it!

Thanks for taking care of that!

       tglx
