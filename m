Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C462528BFF7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgJLSrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgJLSrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:47:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26BCF20838;
        Mon, 12 Oct 2020 18:47:18 +0000 (UTC)
Date:   Mon, 12 Oct 2020 14:47:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Richard Weinberger <richard@sigma-star.at>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] h8300: Make irq disable and enable a compiler barrier
Message-ID: <20201012144716.2a6b20df@gandalf.local.home>
In-Reply-To: <20200918152507.711865ce@gandalf.local.home>
References: <20200918152507.711865ce@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping!

(Warning 3: is this architecture still maintained?)

I think, if there's no response in two more weeks, we can assume this is
unmaintained, and remove h8300 from Linux.

-- Steve

On Fri, 18 Sep 2020 15:25:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> In a conversation on #linux-rt, it was asked if the irq disabling and
> enabling functions were a compiler barrier, and reads wont happen outside
> these functions from where they were in the call.
> 
> I stated that they most definitely need to be, otherwise we would have bugs
> all over the place if not. And just to confirm, I looked at the
> implementation on x86 which had "memory" as a constraint to the asm, and
> that is a compiler barrier. As that was just one arch, I looked at others,
> and all the other archs do the same but one. H8300 seems to fail here. And
> that is most definitely a bug.
> 
> Add the compiler barrier to the enabling and disabling of interrupts on
> H8300. As this is a really critical bug, I'm starting to wonder how much
> this arch is really used. Let's see how quickly this patch gets added to
> the arch, and if it is not applied or responded to within a month, I think
> we can safely state that this arch is not maintained.
> 
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/arch/h8300/include/asm/irqflags.h b/arch/h8300/include/asm/irqflags.h
> index 48756b7f405e..477cb9d7785f 100644
> --- a/arch/h8300/include/asm/irqflags.h
> +++ b/arch/h8300/include/asm/irqflags.h
> @@ -15,12 +15,12 @@ static inline h8300flags arch_local_save_flags(void)
>  
>  static inline void arch_local_irq_disable(void)
>  {
> -	__asm__ volatile ("orc  #0xc0,ccr");
> +	__asm__ volatile ("orc  #0xc0,ccr" : : : "memory");
>  }
>  
>  static inline void arch_local_irq_enable(void)
>  {
> -	__asm__ volatile ("andc #0x3f,ccr");
> +	__asm__ volatile ("andc #0x3f,ccr" : : : "memory");
>  }
>  
>  static inline h8300flags arch_local_irq_save(void)
> @@ -28,13 +28,13 @@ static inline h8300flags arch_local_irq_save(void)
>  	h8300flags flags;
>  
>  	__asm__ volatile ("stc ccr,%w0\n\t"
> -		      "orc  #0xc0,ccr" : "=r" (flags));
> +		      "orc  #0xc0,ccr" : "=r" (flags) : : "memory");
>  	return flags;
>  }
>  
>  static inline void arch_local_irq_restore(h8300flags flags)
>  {
> -	__asm__ volatile ("ldc %w0,ccr" : : "r" (flags) : "cc");
> +	__asm__ volatile ("ldc %w0,ccr" : : "r" (flags) : "memory", "cc");
>  }
>  
>  static inline int arch_irqs_disabled_flags(unsigned long flags)
> @@ -55,13 +55,13 @@ static inline h8300flags arch_local_save_flags(void)
>  
>  static inline void arch_local_irq_disable(void)
>  {
> -	__asm__ volatile ("orc #0x80,ccr\n\t");
> +	__asm__ volatile ("orc #0x80,ccr\n\t" : : : "memory");
>  }
>  
>  static inline void arch_local_irq_enable(void)
>  {
>  	__asm__ volatile ("andc #0x7f,ccr\n\t"
> -		      "andc #0xf0,exr\n\t");
> +		      "andc #0xf0,exr\n\t" : : : "memory");
>  }
>  
>  static inline h8300flags arch_local_irq_save(void)
> @@ -71,7 +71,7 @@ static inline h8300flags arch_local_irq_save(void)
>  	__asm__ volatile ("stc ccr,%w0\n\t"
>  		      "stc exr,%x0\n\t"
>  		      "orc  #0x80,ccr\n\t"
> -		      : "=r" (flags));
> +		      : "=r" (flags) : : "memory");
>  	return flags;
>  }
>  
> @@ -79,7 +79,7 @@ static inline void arch_local_irq_restore(h8300flags flags)
>  {
>  	__asm__ volatile ("ldc %w0,ccr\n\t"
>  		      "ldc %x0,exr"
> -		      : : "r" (flags) : "cc");
> +		      : : "r" (flags) : "memory", "cc");
>  }
>  
>  static inline int arch_irqs_disabled_flags(h8300flags flags)

