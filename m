Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A5B22B0CF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 15:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgGWNxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 09:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbgGWNxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:53:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39143C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:53:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595512412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m2WEGANuJwekIljkpGcOb2AxKR0gx6rzlpQXaGfue5U=;
        b=XDP2rOd0f/2vEhIY28+86PcBu1s2zd6FnN3liEw9JKJl/jlr7zrgSA/u1gUP/JYh3swIl/
        pdIR4khTZedB1c6Spxlt5dWK6yeT2u9F0wmR1ZDvXUjlF457Pu4xJDu7aIXag1swAX8PmX
        dUlM1tmxxYSBfBIBzBaGMEwGjBjaI8NFKdyCxb0iUCxMwASh5qSpsv/bk1EPzn8Fhvka4L
        0aSuMpkWtiLaZUQg1TYTqeg/LhPqhnHP4ODjRk/eCr2pKbAVQSD2wioTB9icxouElqPy6n
        lM4Ll8il2fH0mWwXo8gL7/PSnxwLV5TczDAyTZE4kglPqXnLL2NW/As71MCQ4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595512412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m2WEGANuJwekIljkpGcOb2AxKR0gx6rzlpQXaGfue5U=;
        b=em5DVSOMnKIs9vTU/agObKyPqMvWukySZ44jV6ooWeed2FLgkBvbtvLZNVLj6iKvDYw/l5
        Lz32M7NekU+zFxCw==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH] timers: Recalculate next timer interrupt only when necessary
In-Reply-To: <20200721000556.4709-1-frederic@kernel.org>
References: <20200721000556.4709-1-frederic@kernel.org>
Date:   Thu, 23 Jul 2020 15:53:32 +0200
Message-ID: <87a6zqxrqb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:
>
> Since recalculating the next_expiry isn't a free operation, especially
> when we must climb up the last wheel level to find out that no timer
> has

I'm climbing stairs or mountains :)

> been enqueued at all, lets reuse the next expiry cache when it is
> known

lets? Come on, the changelog is about facts not what we might do.

>  	unsigned long		clk;
>  	unsigned long		next_expiry;
> +	bool			next_expiry_recalc;
>  	unsigned int		cpu;
>  	bool			is_idle;

Care to stare at the output of

     pahole -C timer_base kernel/time/timer.o

before and after?

Thanks,

        tglx
