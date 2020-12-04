Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614892CF6B1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 23:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgLDWUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 17:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLDWUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 17:20:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB1CC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 14:19:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607120358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fuyf313TSKEerkQxZYAgmzHEekYqNSigaPkaHoUUMYE=;
        b=2WZzRmZcQPGLY8R5TRJUVwXRbRh3Wc3PWtfozt3f7A8e38FqSzV+47LkWPfCRf8rX4UTU1
        CllSimmMR2XoU6VJrV1VAAL8D+BQrVQqQzLMp9mGPK9YODbFdOSHzXEYD3LhOzzsclQhqQ
        SZOiKklTlna6HpL6nrS5EcNIiNJyQDGciCODEL3jLdD/ED6gBkny6W4OMJmsoNUjf4gvU2
        4M4fNVne5+reegEYGaT3aauAAMsI32hFDFxr0SgQsdAq6/fa7Kvb6N5wdfHh/15841yhhi
        QjrTkSqgxrfo8k7DYxwVyHTe+THWAaLN8e6WRe2ed8kFaIoeJMmoZhD7vKnKLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607120358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fuyf313TSKEerkQxZYAgmzHEekYqNSigaPkaHoUUMYE=;
        b=RfUGWhWP6DG1TcptaEjTATuqzvd+VmKhvZlrZtrRJnyPgWGM+gF16HU5QOUbv/eMh8qFlZ
        F7jiMZjyB7ulBCCQ==
To:     Balbir Singh <sblbir@amazon.com>, mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, jpoimboe@redhat.com, tony.luck@intel.com,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com,
        thomas.lendacky@amd.com, torvalds@linux-foundation.org,
        Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v3 4/5] prctl: Hook L1D flushing in via prctl
In-Reply-To: <20201127065938.8200-5-sblbir@amazon.com>
References: <20201127065938.8200-1-sblbir@amazon.com> <20201127065938.8200-5-sblbir@amazon.com>
Date:   Fri, 04 Dec 2020 23:19:17 +0100
Message-ID: <87eek59pui.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir,

On Fri, Nov 27 2020 at 17:59, Balbir Singh wrote:
> +enum l1d_flush_out_mitigations {
> +	L1D_FLUSH_OUT_OFF,
> +	L1D_FLUSH_OUT_ON,
> +};
> +
> +static enum l1d_flush_out_mitigations l1d_flush_out_mitigation __ro_after_init = L1D_FLUSH_OUT_ON;

Why default on and why stays it on when the CPU is not affected by L1TF ...

>  /* Default mitigation for TAA-affected CPUs */
>  static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
>  static bool taa_nosmt __ro_after_init;
> @@ -379,6 +386,18 @@ static void __init taa_select_mitigation(void)
>  	pr_info("%s\n", taa_strings[taa_mitigation]);
>  }
>  
> +static int __init l1d_flush_out_parse_cmdline(char *str)
> +{
> +	if (!boot_cpu_has_bug(X86_BUG_L1TF))
> +		return 0;

... while here you check for L1TF.

Also shouldn't it be default off and enabled via command line?

> +static int l1d_flush_out_prctl_get(struct task_struct *task)
> +{
> +	int ret;
> +
> +	if (l1d_flush_out_mitigation == L1D_FLUSH_OUT_OFF)
> +		return PR_SPEC_FORCE_DISABLE;
> +
> +	ret = test_ti_thread_flag(&task->thread_info, TIF_SPEC_L1D_FLUSH);

That ret indirection is pointless. Just make it if (test_....)

> +static int l1d_flush_out_prctl_set(struct task_struct *task, unsigned long ctrl)
> +{
> +
> +	if (l1d_flush_out_mitigation == L1D_FLUSH_OUT_OFF)
> +		return -EPERM;

So here you check for off and then...

>  int enable_l1d_flush_for_task(struct task_struct *tsk)
>  {
> +	/*
> +	 * Do not enable L1D_FLUSH_OUT if
> +	 * b. The CPU is not affected by the L1TF bug
> +	 * c. The CPU does not have L1D FLUSH feature support
> +	 */
> +
> +	if (!boot_cpu_has_bug(X86_BUG_L1TF) ||
> +			!boot_cpu_has(X86_FEATURE_FLUSH_L1D))
> +		return -EINVAL;

... you check for the feature bits with a malformatted condition at some
other place. It's not supported when these conditions are not there. So
why having this check here?

> +
>  	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
>  	return 0;
>  }

Aside of that, why is this in tlb.c and not in bugs.c? There is nothing
tlb specific in these enable/disable functions. They just fiddle with
the TIF bit.

> +/*
> + * Sent to a task that opts into L1D flushing via the prctl interface
> + * but ends up running on an SMT enabled core.
> + */
> +static void l1d_flush_kill(struct callback_head *ch)
> +{
> +	force_sig(SIGBUS);
> +}
> +
>  static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
>  {
>  	unsigned long next_tif = task_thread_info(next)->flags;
>  	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
> +	unsigned long next_mm;
>  
>  	BUILD_BUG_ON(TIF_SPEC_L1D_FLUSH != TIF_SPEC_IB + 1);
> -	return (unsigned long)next->mm | spec_bits;
> +	next_mm = (unsigned long)next->mm | spec_bits;
> +
> +	if ((next_mm & LAST_USER_MM_L1D_FLUSH) && this_cpu_read(cpu_info.smt_active)) {

Wheeee. Yet more unconditional checks on every context switch.

> +		clear_ti_thread_flag(&next->thread_info, TIF_SPEC_L1D_FLUSH);
> +		next->l1d_flush_kill.func = l1d_flush_kill;
> +		task_work_add(next, &next->l1d_flush_kill, true);

int task_work_add(struct task_struct *task, struct callback_head *twork,
                  enum task_work_notify_mode mode);

true is truly not a valid enum constant ....

> +	}

So you really want to have:

DEFINE_STATIC_KEY_FALSE(l1dflush_enabled);
static bool l1dflush_mitigation __init_data;

and then with the command line option you set l1dflush_mitigation and in
check_bugs() you invoke l1dflush_select_mitigation() which does:

       if (!l1dflush_mitigation || !boot_cpu_has_bug(X86_BUG_L1TF) ||
       	   !boot_cpu_has(X86_FEATURE_FLUSH_L1D))
                return;

       static_branch_enable(&l1dflush_enabled);

and then in l1d_flush_out_prctl_set()

       if (!static_branch_unlikely(&l1dflush_enabled))
       		return -ENOTSUPP;

Then make the whole switch machinery do:

      if (static_branch_unlikely(&l1dflush_enabled)) {
            if (unlikely((next_mm | prev_mm) & LAST_USER_MM_L1D_FLUSH))
                 l1dflush_evaluate(next_mm, prev_mm);
      }
                    
and l1dflush_evaluate()

     if (prev_mm & LAST_USER_MM_L1D_FLUSH)
     	  l1d_flush();

     if ((next_mm & LAST_USER_MM_L1D_FLUSH) &&
         this_cpu_read(cpu_info.smt_active)) {

          clear_ti_thread_flag(&next->thread_info, TIF_SPEC_L1D_FLUSH);
          next->l1d_flush_kill.func = l1d_flush_kill;
	  task_work_add(next, &next->l1d_flush_kill, TWA_RESUME);
     }

That way the overhead is on systems where the admin decides to enable it
and if enabled the evaluation of prev_mm and next_mm is pushed out of
line.

Hmm?

Thanks,

        tglx
