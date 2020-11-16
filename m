Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D039D2B4E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbgKPRnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:43:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbgKPRmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:21 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605548539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AFtB0Ip6R2EINkfby885/eXKxzn7nAYtOiaas7ShpD8=;
        b=ucTY/LVv679/wmtLVFj1aWd9sEHqvK298xZYswCwYCPhN8K6/VsSRE7jSBhfryBTJ6Xaec
        iWZ1KD8vwfG36MTBmhGHCbsUbS3UqdYPBCdHIrK4tFOGGv3o73NqScfF+IuVD7Lx5wNJ4E
        ct+pvkYNxgjuYfF6W+3H6JhdZW9rLmVSMnAqbJjz3eaXA1ppi8L0brIci6nAcqGV/SzjpO
        d55eUUUn6T/bNSl1Z/8Nge63sZYpmCqmJJI8znPpt3TuS881D+s7KtqNUyS/qzsi4xUqQ4
        RlAO3412YsCCAu+hJz3yg2rDEig4KmlERzF8sx2R4lQkRAVmN9SJ/UqOp1+QOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605548539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AFtB0Ip6R2EINkfby885/eXKxzn7nAYtOiaas7ShpD8=;
        b=YP2D9OKyBiwGPh1cJ4lErNx/TU9tcJQ7nALdwz1XvcauQRzGOmay8UWLiYUNw+z1AHChep
        2mQNtCDmrth6cPAA==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
Subject: Re: [patch 10/19] preempt: Cleanup the macro maze a bit
In-Reply-To: <20201116121748.GD3121378@hirez.programming.kicks-ass.net>
References: <20201113140207.499353218@linutronix.de> <20201113141733.864469886@linutronix.de> <20201116121748.GD3121378@hirez.programming.kicks-ass.net>
Date:   Mon, 16 Nov 2020 18:42:19 +0100
Message-ID: <871rgtyz9g.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16 2020 at 13:17, Peter Zijlstra wrote:
> On Fri, Nov 13, 2020 at 03:02:17PM +0100, Thomas Gleixner wrote:
>
>> -#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK \
>> -				 | NMI_MASK))
>> +#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
>
>
>> +#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
>> -#define in_task()		(!(preempt_count() & \
>> -				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
>
> How horrible is the code-gen? Because preempt_count() is
> raw_cpu_read_4() and at least some old compilers will refuse to CSE it
> (consider the this_cpu_read_stable mess).

I looked at gcc8 and 10 output and the compilers are smart enough to
fold it for the !RT case. But yeah ...

Thanks,

        tglx


