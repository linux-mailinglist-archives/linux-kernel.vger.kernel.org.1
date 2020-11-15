Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1263C2B38F7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 21:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgKOUI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 15:08:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36858 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgKOUI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 15:08:27 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605470905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rslwn3VsOrVpjh0Wl9Gc/WPY+sOX5olDIoKD/htyL4U=;
        b=lOXVAyExlfj2ZScRm1CXWrYFvxUd62pEQIUmwANEmZcflBzfhVwa+BZ/FZbMW1hUlSrvTj
        Uyy2ApqaC5FZWk7jQC0J7xVNu6yy2uJ2AKcCwXsxhOfvXREKe8uxzwnK2S0lxL9z0G3c23
        0NQhjtyOp6i7VAy+xJwpYV5fzm1WSv/FTqQ43zqUQ6UJTtcvv9YLgpYOn2wAlUN/gGaZ9n
        RgT6+nP87IMTq0wqvzhI3K0QnmOy8KtReDYqmSW6wmxwvnxavAwmXHEGKvYgM8sVYsfLrl
        3CkLBNipEwCf3Sq81f+CrI7pkiXtbuOFoUVI65Dy/6Bzf+r9v1KQ6IeKWzOElg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605470905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rslwn3VsOrVpjh0Wl9Gc/WPY+sOX5olDIoKD/htyL4U=;
        b=LBc/cNLoamn6DuIHRbzKwGYogU1lre6JgC6iHZ2xq+tNPJFu8Q4f9CHDChD1qmREtdshiL
        tauz7d6OjrTbP+AA==
To:     Alex Shi <alex.shi@linux.alibaba.com>, john.stultz@linaro.org
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] timekeeping: add missed kernel-doc marks for 'tkf'
In-Reply-To: <1605252275-63652-2-git-send-email-alex.shi@linux.alibaba.com>
References: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com> <1605252275-63652-2-git-send-email-alex.shi@linux.alibaba.com>
Date:   Sun, 15 Nov 2020 21:08:25 +0100
Message-ID: <87eeku8jt2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13 2020 at 15:24, Alex Shi wrote:

> Fix the kernel-doc markup and remove the following warning:
> kernel/time/timekeeping.c:415: warning: Function parameter or member
> 'tkf' not described in 'update_fast_timekeeper'
> kernel/time/timekeeping.c:464: warning: Function parameter or member
> 'tkf' not described in '__ktime_get_fast_ns'
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index daa0ff017819..d0f7cd1b8823 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -399,6 +399,7 @@ static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 c
>  /**
>   * update_fast_timekeeper - Update the fast and NMI safe monotonic timekeeper.
>   * @tkr: Timekeeping readout base from which we take the update
> + * @tkf: NMI safe timekeeper
>   *
>   * We want to use this from any context including NMI and tracing /
>   * instrumenting the timekeeping code itself.
> @@ -430,6 +431,7 @@ static void update_fast_timekeeper(const struct tk_read_base *tkr,
>  
>  /**
>   * ktime_get_mono_fast_ns - Fast NMI safe access to clock monotonic
> + * @tkf: NMI safe timekeeper
>   *
>   * This timestamp is not guaranteed to be monotonic across an update.
>   * The timestamp is calculated by:

That's wrong. The documentation is for ktime_get_mono_fast_ns() which
does not have an argument, but due to an oversight the documentation is
now above __ktime_get_mono_fast_ns() which takes an argument.

I'm fixing it up.
