Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91311C7743
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 18:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgEFQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 12:56:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40734 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729414AbgEFQ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:56:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id e16so3046274wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UAR3StJ1tjRjcPQPguO3q+ZrNyaW8mBxV+t84vp3JQk=;
        b=rSLvDT7BsJgnXX5dFt/bCCv3rjkp9POk9u5jEh3iYBaRd6P3l6J2Y1nuVUPxpqbc/+
         vTypRN4VUv5xQLMBiaIc5tcvWw4ZqXM3M1jHSsvxqXmaXsvxyalG8iLtie3mKfWv7qh8
         xtEP8WqpVy0AuKd1odWrDndGR6iXer0XSGwoK/y3ym2vbhNEheIePIjUaKYCYyK7HWgT
         sn305svfZ75xR0RjVp2aYOvpRDOthIdRgISBqrQYz+JDda3vrE0Vx4z64cajeUdB9HC+
         +0+tkd8IR2NUdoms3Sl3j1LwzziFZEz0c55qdbow9MGbb1KCnctbonPSzrSCfHAlJvzH
         OGDA==
X-Gm-Message-State: AGi0PuaTtS1IBOGMneasGYc/h/H9VqmacJbFzDf5GIjzgizHYImz90r/
        OFGG8MlG65+R3WwmnXBgRYk=
X-Google-Smtp-Source: APiQypKZ0cJ4el/27ukSaL29mvN14Cb9ejX5GlSiZbyH+oRs0LbgOJNJeFatIDPQ8ZENpLYMBt/yUA==
X-Received: by 2002:a5d:6b8a:: with SMTP id n10mr10193186wrx.36.1588784215607;
        Wed, 06 May 2020 09:56:55 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v5sm3638531wrr.93.2020.05.06.09.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 09:56:55 -0700 (PDT)
Date:   Wed, 6 May 2020 16:56:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch V4 part 5 22/31] x86/entry: Convert various hypervisor
 vectors to IDTENTRY_SYSVEC
Message-ID: <20200506165653.ttxa33llcynokaq2@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <20200505135341.730586321@linutronix.de>
 <20200505135830.298201197@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505135830.298201197@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:54:03PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Convert various hypervisor vectors to IDTENTRY_SYSVEC
>   - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
>   - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
>   - Remove the ASM idtentries in 64bit
>   - Remove the BUILD_INTERRUPT entries in 32bit
>   - Remove the old prototypes
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Cc: Jason Chen CJ <jason.cj.chen@intel.com>
> Cc: Zhao Yakui <yakui.zhao@intel.com>
> 
> ---
>  arch/x86/entry/entry_32.S       |   14 --------------
>  arch/x86/entry/entry_64.S       |   17 -----------------
>  arch/x86/hyperv/hv_init.c       |    9 +++------
>  arch/x86/include/asm/acrn.h     |   11 -----------
>  arch/x86/include/asm/apic.h     |   20 --------------------
>  arch/x86/include/asm/idtentry.h |   10 ++++++++++
>  arch/x86/include/asm/mshyperv.h |   13 -------------
>  arch/x86/kernel/cpu/acrn.c      |    9 ++++-----
>  arch/x86/kernel/cpu/mshyperv.c  |   22 ++++++++++------------
>  9 files changed, 27 insertions(+), 98 deletions(-)
> 
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1342,20 +1342,6 @@ BUILD_INTERRUPT3(xen_hvm_callback_vector
>  		 xen_evtchn_do_upcall)
>  #endif
>  

You seem to have missed the Xen entry.

> -
> -#if IS_ENABLED(CONFIG_HYPERV)
> -
> -BUILD_INTERRUPT3(hyperv_callback_vector, HYPERVISOR_CALLBACK_VECTOR,
> -		 hyperv_vector_handler)
> -
> -BUILD_INTERRUPT3(hyperv_reenlightenment_vector, HYPERV_REENLIGHTENMENT_VECTOR,
> -		 hyperv_reenlightenment_intr)
> -
> -BUILD_INTERRUPT3(hv_stimer0_callback_vector, HYPERV_STIMER0_VECTOR,
> -		 hv_stimer0_vector_handler)
> -
> -#endif /* CONFIG_HYPERV */
> -
>  SYM_CODE_START_LOCAL_NOALIGN(handle_exception)
>  	/* the function address is in %gs's slot on the stack */
>  	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1078,23 +1078,6 @@ apicinterrupt3 HYPERVISOR_CALLBACK_VECTO
>  	xen_hvm_callback_vector xen_evtchn_do_upcall
>  #endif
>  

Ditto.

Wei.
