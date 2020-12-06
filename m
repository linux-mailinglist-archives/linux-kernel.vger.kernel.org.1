Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E01D2D07A3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 23:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgLFWSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 17:18:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60700 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgLFWSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 17:18:04 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607293042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ipzVzcw1Rul4OI8CigsTMIYDObqN/WIDxB2eMNXupzY=;
        b=jquKGHkkReUuBh2eyWdAH8ux80UA80hwI+Jp46uEWyD6hVgS4fajJszPTk73efLBGmQckS
        Fug8EQqQvpjMwxXxz8vb2aUj809aRnrHE4DXSgKmyolyYRhWUMNaeZvidu/GbHZOdzCQ7T
        HD1uG7jEVbhKHhsacmz9c5SVgl+LGjmQMpU9nyFQVbYCjRBBjNaL6v2XFctxdD5BivryIY
        G/P0YCTaRveZwZS6CBQJnyLdd9d3NDDpP6J0znwVI6/QM98jwY/0CqmBl58ZcTf9FuEmjm
        V3+6C4IQCEnW9/iXF37MmSZkjPsUmCKN86MDlBzrD9R6NIlMSbR7z3De49Xifw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607293042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ipzVzcw1Rul4OI8CigsTMIYDObqN/WIDxB2eMNXupzY=;
        b=39nLphRxi3T77Kuvta+LvmCyYegIX5efaZXOCVM6BQ6o81dcQZAH2PcH0oK3u4hDEHOy/O
        6fFTSb89vrKG0VBw==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: recursion handling: Re: [PATCH next v2 3/3] printk: remove logbuf_lock, add syslog_lock
In-Reply-To: <X8tVsaFUwAxsIVaO@jagdpanzerIV.localdomain>
References: <20201201205341.3871-1-john.ogness@linutronix.de> <20201201205341.3871-4-john.ogness@linutronix.de> <X8pfX/qPBuY360k/@alley> <X8tVsaFUwAxsIVaO@jagdpanzerIV.localdomain>
Date:   Sun, 06 Dec 2020 23:23:22 +0106
Message-ID: <87mtyqmvf1.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-05, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>> One reason is the use of per-cpu variables. Alternative solution would
>> be to store printk_context into task_struct.
>
> We can keep per-CPU, disable preemption and have counters for
> every context (task, soft/hard irq, NMI). Shouldn't be a problem

These contexts are difficult to track correctly for all the preemption
models (especially when PREEMPT_RT is included). But I will look into
this idea. It would be nice to keep interrupts enabled for that first
vsnprintf() in vprintk_store().

John Ogness
