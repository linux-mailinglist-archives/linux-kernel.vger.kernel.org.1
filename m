Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47AC29A9EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416354AbgJ0KmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:42:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46220 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436497AbgJ0KmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:42:10 -0400
Date:   Tue, 27 Oct 2020 11:42:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603795328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2J5Vn7lq4uBMVse4v+EjvO4APamDhiXrx+ql33TLVFs=;
        b=R7lkm+gauCN528QGLFvNgMpE5zNRNqYoyVWOR0Lg69+UJjgo7fYZJPcvYaY+O+Iy+G3XdT
        vBF3BSqfiIO3FnoYTGsRfL4ORLTV6etHdwF7ssd5B3VFGlQs6XuORNn1Yfyxa+duUnOAv6
        r7soyOlMNU2tJdFjArKI7tehH3NGH+rnTMsHBh5L0ZBU9ub1vhTN+CidzhhP42dBOluiBB
        EYeUCSqDHgjfonnbkEoNuyeN/4/JGNA6t/r3jDIkIRlMMbEhho7kdi8E6ijcnwTSuzhf+2
        lDDCKIb1FaKsxD4yPYn033nahrjqdGn74wje7sgFF+Krjp18oR/6ZOE5xGncpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603795328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2J5Vn7lq4uBMVse4v+EjvO4APamDhiXrx+ql33TLVFs=;
        b=0gpJkuYyOqeNWslrzt6t+P8CC7aV7E4i2pqvmnqlPL/CdSNKV1a0v8aoSgCLzvgdYJj5L/
        V34pOdiOO3PWRLAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: [patch 2/2] x86/fpu: Make kernel FPU protection RT friendly
Message-ID: <20201027104207.ruurrumyg447egrk@linutronix.de>
References: <20201027100949.181320853@linutronix.de>
 <20201027101349.588965083@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027101349.588965083@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-27 11:09:51 [+0100], Thomas Gleixner wrote:
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -32,15 +32,27 @@ extern void fpregs_mark_activate(void);
>   *
>   * local_bh_disable() protects against both preemption and soft interrupts
>   * on !RT kernels.
> + *
> + * On RT kernels local_bh_disable() is not sufficient because it only
> + * serializes soft interrupt related sections via a local lock, but stays
> + * preemptible. Disabling preemption is the right choice here as bottom
> + * half processing is always in thread context on RT kernels so it
> + * implicitly prevents bottom half processing as well.

The important part is that kernel_fpu_begin() also disables preemption
and it may run in softirq. It does not use fpregs_lock() and
fpregs_lock() serializes against kernel_fpu_begin().

>   */
>  static inline void fpregs_lock(void)
>  {
> -	local_bh_disable();
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		local_bh_disable();
> +	else
> +		preempt_disable();

Could you please swap that to
	if (IS_ENABLED(CONFIG_PREEMPT_RT))
		preempt_disable();
	else
		local_bh_disable();

>  }
>  

Sebastian
