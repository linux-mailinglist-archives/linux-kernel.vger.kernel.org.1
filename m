Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9992D364F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 23:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbgLHWbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 17:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgLHWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 17:31:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A3CC0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 14:30:46 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607466645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=75XIg+ZJ7vXwfOxh4mfZVbFzoFN2Q4G9QbYqnFjSG9E=;
        b=A1Nz0fwN0RmE7nkQCeVtAdRK9Fp5J/cc0VItqE+6Y7ssc5nfSb29Z/8sL6eNiF2I9vmFKy
        0dnrrhMqEcv/tQR4USLUQrGVKit9lqQ0Ig5IckSZ2j5JTPjJo1cQ2HLA6sfYwdeYY7tJ+S
        3ggfNRJfP6/R6kiGBH5Mfzs/4+E55KzFoNRME0kzLGQ0vfwgDVbze+lJYpaKp/3h/6yC/o
        ZxwvGUyBtaWHLQxkvOy1q/TLSrRH6qCeKjclQEW231NMhGOLuxqxQFAcGKL1hlhhMGsDrV
        D9XUaHzrbeWSxy9B5oXPic1voW29EtSNLmsUcLzpfrFs2sVEWEyLTBGL+KOVqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607466645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=75XIg+ZJ7vXwfOxh4mfZVbFzoFN2Q4G9QbYqnFjSG9E=;
        b=lxQ6PPi8VY3UiDkGHT3VY5H8IEHbdv5lVgE58r7eJjHqq8tm8fP1GrwUG9ziPkfjV+v4sC
        +NNZZFN62//vMrBA==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
In-Reply-To: <X8/jS9k/eMIL+Acw@jagdpanzerIV.localdomain>
References: <20201201205341.3871-1-john.ogness@linutronix.de> <20201201205341.3871-3-john.ogness@linutronix.de> <X8n9a2DWUFE/giyB@alley> <X8/jS9k/eMIL+Acw@jagdpanzerIV.localdomain>
Date:   Tue, 08 Dec 2020 23:36:44 +0106
Message-ID: <875z5c9bhn.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-09, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>> Sigh, atomic64_read() uses a spin lock in the generic implementation
>> that is used on some architectures.
>
> Oh... So on those archs prb is not lockless in fact, it actually
> takes the spin_lock each time we read the descriptor state?
>
> 	desc_read()
> 	  atomic_long_read(state_var)
> 	    atomic64_read()
> 	      raw_spin_lock_irqsave(lock, flags)
> 	        << NMI panic >>
>
> Am I missing something?

For the state variable we chose atomic_long_t instead of atomic64_t for
this reason. atomic_long_t operations are available atomically on all
architectures. However, for clear_seq we need 64-bit (even on 32-bit
machines). The seqcount_latch is an excellent solution here since
clear_seq does not require lockless writers.

John Ogness
