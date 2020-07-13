Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232B3219C7D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 11:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgGIJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 05:42:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35504 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgGIJmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:42:43 -0400
Date:   Thu, 9 Jul 2020 11:42:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594287761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tv8JpSeZXcMnPyOcvS3LIZo/plB16DDrs7eh/Dbn2NE=;
        b=KAnYRExauboyU3r6nTaiA/r+xYLp+5YXkBeQ6qAyAl/CfngMpXl8i/suBI2W1TnN4C+oPQ
        hwjqvrBo61PRvB9YuWDwA/P7sBWYmFwJa9+9UIheZyOuHWouJVCuPpBcy1L3HgKU81pxDW
        kRxcpwkLcWk/G5ijbjPOhfikwxUQv2QyWOWUkjNQDbgSMw1JW9mEwzA8V+U05WsK9FLnsg
        LpPzveqn+AKdSqR6PJHqLt5SpfQ59BLDWB6xprJnR1TSV2YtjqGXTrxLeVkq8n8q43/fUh
        4+Dsy7vmAR/P/Fjfzq2UIaMf5hfIviKQAosFA+c21Tabkt/+0tdSTM26g/AJ9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594287761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tv8JpSeZXcMnPyOcvS3LIZo/plB16DDrs7eh/Dbn2NE=;
        b=NyOsSDHsWGfbfMDjtlixUGbS4/NFLx5p726DirUgeE+QrxamOrBPPRsgwN2OpupZ8jUgR3
        cz53UMlgUcvPV+BQ==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, Stable <stable@kernel.org>
Subject: Re: [PATCH] timer: Prevent base->clk from moving backward
In-Reply-To: <20200703010657.2302-1-frederic@kernel.org>
Message-ID: <alpine.DEB.2.21.2007091139470.4020@somnus>
References: <20200703010657.2302-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 3 Jul 2020, Frederic Weisbecker wrote:

> When a timer is enqueued with a negative delta (ie: expiry is below
> base->clk), it gets added to the wheel as expiring now (base->clk).
> 
> Yet the value that gets stored in base->next_expiry, while calling
> trigger_dyntick_cpu(), is the initial timer->expires value. The
> resulting state becomes:
> 
> 	base->next_expiry < base->clk
> 
> On the next timer enqueue, forward_timer_base() may accidentally
> rewind base->clk. As a possible outcome, timers may expire way too
> early, the worst case being that the highest wheel levels get spuriously
> processed again.
> 
> To prevent from that, make sure that base->next_expiry doesn't get below
> base->clk.
> 
> Fixes: a683f390b93f ("timers: Forward the wheel clock whenever possible")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> ---

Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Thanks,

	Anna-Maria

