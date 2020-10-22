Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5799A2955DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 02:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894524AbgJVA62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 20:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894516AbgJVA62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 20:58:28 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139F1C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 17:58:28 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q25so5179964ioh.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 17:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zeZvoKbrgIVhevjxOiOYNvRjeI72W6AtF3ciDXxGwJQ=;
        b=G0PIvqJuZsR5epI8IijrEuUisk9liNNUla92pT/N31hyikKZ+t4bY1CC9QaLoVrNKV
         I2bkIa/YgOY4oSKbtLqIZ3I8wRWgxiztUdjj5Ae9k6VyP6m5T2EaX7PLlBmdvc1AcOWw
         NBcu552r8cjGCPUvGmgdc0AYNzP+r1R5vLQOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zeZvoKbrgIVhevjxOiOYNvRjeI72W6AtF3ciDXxGwJQ=;
        b=k8rn2aYVZz8p0xjEhuvtvIhqpmClqlTeZOurCSSWjPL733oiocSH+YS8g+MZHJtYWr
         YDmL3yIG+gZqEHK3QuWQ0DoQNTSN3O5FWqW7BzdEmdUbxcogknqT8QSqON+XX4ZIZcLc
         6QNUEY72d/d3ImOGZKzDxk7x+C0yvmCgaJ9QHTzIBBMsUFTv7OovWOAR+Os3f4cZtTiT
         BgRsHj05fPdiTgEp9k1DDqcSW/rZJJwY5RYpc7ufnqySBTssAGo+HqwbwohJZ9Mud9RQ
         ejj0TGP4Qt+nnD+ClxPpyV1B56QWeVKyQm6hBqIW2QyyYlWgWnDh975dawm+gqDnk1NT
         6hMQ==
X-Gm-Message-State: AOAM531/8nCXT6/xp7LmTN+fQSSFwbaJ1yMCHhF72q2cpDiqhbTTWNaw
        V9fCLAoDZKt0/dpuNLWOqaFj3spOmKw0Va/pVsEV
X-Google-Smtp-Source: ABdhPJyXh89UkF3m+LRLbYtN+p6n3th/chRNGXK1eOu+gpcJZ9EHvtP/n3gMnEqZ+TXNbuVZfSbgH/FiwoE0s53D6ws=
X-Received: by 2002:a5d:84c6:: with SMTP id z6mr171793ior.0.1603328307250;
 Wed, 21 Oct 2020 17:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201021073839.43935-1-zong.li@sifive.com>
In-Reply-To: <20201021073839.43935-1-zong.li@sifive.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 21 Oct 2020 17:58:15 -0700
Message-ID: <CAOnJCU+Qr-Avs7HnOfsPC6yKDNzTCEbm_ZhZ3b2V809iHfFSpQ@mail.gmail.com>
Subject: Re: [PATCH] stop_machine: Mark functions as notrace
To:     Zong Li <zong.li@sifive.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        vincent.whitchurch@axis.com, Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Guo Ren <guoren@kernel.org>, mhiramat@kernel.org,
        Greentime Hu <greentime.hu@sifive.com>,
        Colin Ian King <colin.king@canonical.com>,
        rcu@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 12:38 AM Zong Li <zong.li@sifive.com> wrote:
>
> Like the commit cb9d7fd51d9f ("watchdog: Mark watchdog touch functions
> as notrace"), some architectures assume that the stopped CPUs don't make
> function calls to traceable functions when they are in the stopped
> state. For example, it causes unexpected kernel crashed when switching
> tracer on RISC-V.
>
> The following patches added calls to these two functions, fix it by
> adding the notrace annotations.
>
> Fixes: 4ecf0a43e729 ("processor: get rid of cpu_relax_yield")
> Fixes: 366237e7b083 ("stop_machine: Provide RCU quiescent state in
> multi_cpu_stop()")
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  kernel/rcu/tree.c     | 2 +-
>  kernel/stop_machine.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 06895ef85d69..2a52f42f64b6 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -409,7 +409,7 @@ bool rcu_eqs_special_set(int cpu)
>   *
>   * The caller must have disabled interrupts and must not be idle.
>   */
> -void rcu_momentary_dyntick_idle(void)
> +notrace void rcu_momentary_dyntick_idle(void)
>  {
>         int special;
>
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index 865bb0228ab6..890b79cf0e7c 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -178,7 +178,7 @@ static void ack_state(struct multi_stop_data *msdata)
>                 set_state(msdata, msdata->state + 1);
>  }
>
> -void __weak stop_machine_yield(const struct cpumask *cpumask)
> +notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
>  {
>         cpu_relax();
>  }
> --
> 2.28.0
>

Thanks for the fix. FWIW,

Tested-by: Atish Patra <atish.patra@wdc.com>

Can you update the bugzilla as well ?

https://bugzilla.kernel.org/show_bug.cgi?id=209317


--
Regards,
Atish
