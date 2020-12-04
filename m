Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA8F2CF611
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 22:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgLDVVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 16:21:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49982 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbgLDVVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 16:21:51 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607116870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qsb9WqDVjcZoNvirWFcy5vOMuHCU7DuRsruv+U9n1Us=;
        b=L4+5oMqNYuyaTsZgbCK59RRPyTep9LPhJTG8jUNB9xnHTAg4yHO+/OskW3Zv3/Sg8o0PPL
        kH/d1EGnXueN7ql8hBKPCEftNA6M34REOYBU0+YwzePrx2FJ/GJQBwUVhSBhOnGc2oeQAz
        1epCW/bki9DsEhp7vh+/1geEiOAn+QtDwzMWb/Bw1ZeqEJ3sdooGoO0unCj79Ts8vpgQqk
        QA54Cgf2Z6yZr4P5Q+HNwJBNfkRoWc/t8bME7gyG67AJ2BhedY0PrbVeTU5wCdnWjLYCjD
        D9N2SVme2OgdXubmTAjCq6aGcpipTLN+LiZgZynUu5FMsBwTj9mJkE3KGcIokw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607116870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qsb9WqDVjcZoNvirWFcy5vOMuHCU7DuRsruv+U9n1Us=;
        b=3hSaWTnTM3MJbl21Kc2fYoIKLALrODaxCbpuDTshUWMsfeAL1v4vMGbz5vWqxzNAefBKuy
        uMcm6TzwEd8Hi+BA==
To:     Balbir Singh <sblbir@amazon.com>, mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, jpoimboe@redhat.com, tony.luck@intel.com,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com,
        thomas.lendacky@amd.com, torvalds@linux-foundation.org,
        Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v3 3/5] x86/mm: Optionally flush L1D on context switch
In-Reply-To: <20201127065938.8200-4-sblbir@amazon.com>
References: <20201127065938.8200-1-sblbir@amazon.com> <20201127065938.8200-4-sblbir@amazon.com>
Date:   Fri, 04 Dec 2020 22:21:09 +0100
Message-ID: <87lfed9sje.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27 2020 at 17:59, Balbir Singh wrote:
>  
> +	/*
> +	 * Flush only if SMT is disabled as per the contract, which is checked
> +	 * when the feature is enabled.
> +	 */
> +	if (sched_smt_active() && !this_cpu_read(cpu_info.smt_active) &&
> +		(prev_mm & LAST_USER_MM_L1D_FLUSH))
> +		l1d_flush_hw();

So if SMT is completely disabled then no flush? Shouldn't the logic be:

    if ((!sched_smt_active() || !this_cpu_read(cpu_info.smt_active) &&
         (prev_mm & LAST_USER_MM_L1D_FLUSH))

Hmm?

But that's bad, because it's lot's of conditions to evaluate for every
switch_mm where most of them are not interested in it at all.

Let me read through the rest of the pile.

Thanks,

        tglx


