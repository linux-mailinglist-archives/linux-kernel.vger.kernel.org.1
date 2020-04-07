Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 325BB1A18E7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 01:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgDGXwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 19:52:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48689 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgDGXwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:52:37 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jLy18-00079O-QP; Wed, 08 Apr 2020 01:52:30 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 5500F10069D; Wed,  8 Apr 2020 01:52:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, tony.luck@intel.com, keescook@chromium.org,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com,
        Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v2 3/4] arch/x86: Optionally flush L1D on context switch
In-Reply-To: <20200406031946.11815-4-sblbir@amazon.com>
References: <20200406031946.11815-1-sblbir@amazon.com> <20200406031946.11815-4-sblbir@amazon.com>
Date:   Wed, 08 Apr 2020 01:52:30 +0200
Message-ID: <87v9maj1kx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir,

Balbir Singh <sblbir@amazon.com> writes:
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 6f66d841262d..69e6ea20679c 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -172,7 +172,7 @@ struct tlb_state {
>  	/* Last user mm for optimizing IBPB */
>  	union {
>  		struct mm_struct	*last_user_mm;
> -		unsigned long		last_user_mm_ibpb;
> +		unsigned long		last_user_mm_spec;
  
> -static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
> +static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)

> -static void cond_ibpb(struct task_struct *next)
> +static void cond_mitigation(struct task_struct *next)
>  {
> +	unsigned long prev_mm, next_mm;
> +
>  	if (!next || !next->mm)
>  		return;

can you please split out these preparatory changes into a separate
patch?

Thanks,

        tglx
