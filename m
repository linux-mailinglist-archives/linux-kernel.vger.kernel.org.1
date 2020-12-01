Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314522CA0F3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgLALK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgLALK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:10:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1141C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 03:09:46 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606820985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7yEy47MB100mmuwphhCKWZCuPQblXI1mQGNNE1xKOq8=;
        b=rKAVGUQUoPtmaq5HiQbmz+WO0fFpIhqot689y7zDhV7w0UB8ef9jHVoumQXH1v/9UWKDXT
        WGxyMRuY5KRhc0ZsLjJV+FlKG6W6hAaYlXsB/Na7C0YRduJngT6bvm9dZXSG1Bzsa7nx4a
        F8LSRWgvHCbQLOHW+5wRRrkXqQwfov+uWCMX2S3368n1dH6gz/lieoffaARwPa41fKhYsh
        26surxBlhOMJ8EEJDQyAfU5SV0ABFr65XmL+Z4bcU44VR25uy2+IWXpNAl44P2oVPovL47
        pKA1sCGJNeYC1+56rcNMdxr2GhLjaQV6G7SuKNX23cB+Uyr8D7VWRWEF/BhKrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606820985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7yEy47MB100mmuwphhCKWZCuPQblXI1mQGNNE1xKOq8=;
        b=G5oR9DuUgceMKEgQEClFrOblnWhEmDUo+kkFmSGr6fz6zlvNDIMVBa42y8T6q2E+Q2SkqZ
        oiH5cbaLwmyB0IDQ==
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, hca@linux.ibm.com,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] entry: split lockdep and syscall work functions
In-Reply-To: <20201201083553.50996-2-svens@linux.ibm.com>
References: <20201201083553.50996-1-svens@linux.ibm.com> <20201201083553.50996-2-svens@linux.ibm.com>
Date:   Tue, 01 Dec 2020 12:09:45 +0100
Message-ID: <87lfehhjeu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven,

On Tue, Dec 01 2020 at 09:35, Sven Schnelle wrote:
> On s390, we can not call one function which sets lockdep
> state and do the syscall work at the same time. There add
> make enter_from_user_mode() and exit_to_user_mode() public, and
> add syscall_exit_to_user_mode1() which does the same as
> syscall_exit_to_user_mode() but skips the final exit_to_user_mode().

the explanation in the "cover letter" made at least sense, but the above
is unparseable word salad.

> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  include/linux/entry-common.h |  4 +++-
>  kernel/entry/common.c        | 35 +++++++++++++++++++++++++++--------
>  2 files changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 474f29638d2c..496c9a47eab4 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -124,7 +124,7 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
>   * to be done between establishing state and handling user mode entry work.
>   */
>  void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
> -
> +void enter_from_user_mode(struct pt_regs *regs);

You might have noticed, that all of these function prototypes have
proper kernel documentation. So just glueing this on to the previous
prototype does not cut it. enter_from/exit_to_user_mode() want to go
together into a seperate section.

>  /**
>   * syscall_enter_from_user_mode_work - Check and handle work before invoking
>   *				       a syscall
> @@ -311,6 +311,8 @@ static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
>   *     arch_exit_to_user_mode() to handle e.g. speculation mitigations
>   */
>  void syscall_exit_to_user_mode(struct pt_regs *regs);
> +void syscall_exit_to_user_mode1(struct pt_regs *regs);

Same here and as you mentioned ...mode1() is a pretty horrible name.

     syscall_exit_to_user_mode_work() perhaps?

> +void exit_to_user_mode(void);
>  
>  /**
>   * irqentry_enter_from_user_mode - Establish state before invoking the irq handler
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index e9e2df3f3f9e..3ad462ebfa15 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -18,7 +18,7 @@
>   * 2) Invoke context tracking if enabled to reactivate RCU
>   * 3) Trace interrupts off state
>   */
> -static __always_inline void enter_from_user_mode(struct pt_regs *regs)
> +static __always_inline void __enter_from_user_mode(struct pt_regs
>  *regs)

Can you please split the renaming into a seperate preparatory patch?

> +__visible noinstr void syscall_exit_to_user_mode1(struct pt_regs *regs)

What's the point of marking this function noinstr? Everything it does is
instrumentable.

Thanks,

        tglx
