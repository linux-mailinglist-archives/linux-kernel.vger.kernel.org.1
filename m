Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1001F2DD316
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 15:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgLQOha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 09:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgLQOha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:37:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02290C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 06:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GZ8XbNv0CIlv/NFTpiSEk/Ha6//hxckGWkxS0NPcTGw=; b=Xm4GaH5KEZi859AtW2OXtAk4m6
        bAe+o0gad3lNIPEcb+g1eLDpiYveE5h4dFeEFHLEvpoqOdPmnxQmRS1V1D3R5Du4M/xZX3uVgrp9q
        /2zUBcEA+C5ZfXqzWxlOtl3bHscqWHuyHOA2/WmM0tJS6cyEDbWdoZYwyB8eK64lhMrjuhdmEUDNq
        rc1U17TtVR+i5m/K20nUUIQudDfRkBK8m6NJaLlwpvZ7//J3MAFlZMFvolZpaeCCzFTgXKLOPupba
        K9a2zeNLNq0vjLqPruH3rDGGQv3tKAHRmzkQXXMZ6mNSGz1S4tQbhVozWqqJa9hdspW89SgfebYfh
        PO1B6ihA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpuOZ-0001TV-D5; Thu, 17 Dec 2020 14:36:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0609304BAE;
        Thu, 17 Dec 2020 15:36:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE9C820129575; Thu, 17 Dec 2020 15:36:40 +0100 (CET)
Date:   Thu, 17 Dec 2020 15:36:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] lockdep: report broken irq restoration
Message-ID: <20201217143640.GZ3040@hirez.programming.kicks-ass.net>
References: <20201209183337.1912-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209183337.1912-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 06:33:37PM +0000, Mark Rutland wrote:
> This means that a seuence such as:

+q

> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index 3ed4e8771b64..bca3c6fa8270 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -220,10 +220,26 @@ do {						\
>  
>  #else /* !CONFIG_TRACE_IRQFLAGS */
>  
> +#ifdef CONFIG_DEBUG_IRQFLAGS
> +extern void warn_bogus_irq_restore(bool *warned);
> +#define check_bogus_irq_restore()				\
> +	do {							\
> +		static bool __section(".data.once") __warned;	\
> +		if (unlikely(!raw_irqs_disabled()))		\
> +			warn_bogus_irq_restore(&__warned);	\
> +	} while (0)
> +#else
> +#define check_bogus_irq_restore() do { } while (0)
> +#endif
> +
>  #define local_irq_enable()	do { raw_local_irq_enable(); } while (0)
>  #define local_irq_disable()	do { raw_local_irq_disable(); } while (0)
>  #define local_irq_save(flags)	do { raw_local_irq_save(flags); } while (0)
> -#define local_irq_restore(flags) do { raw_local_irq_restore(flags); } while (0)
> +#define local_irq_restore(flags)		\
> +	do {					\
> +		check_bogus_irq_restore();	\
> +		raw_local_irq_restore(flags);	\
> +	} while (0)

Shouldn't that be in raw_local_irq_restore() ?

>  #define safe_halt()		do { raw_safe_halt(); } while (0)
>  
>  #endif /* CONFIG_TRACE_IRQFLAGS */

--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -162,6 +162,7 @@ do {						\
 #define raw_local_irq_restore(flags)			\
 	do {						\
 		typecheck(unsigned long, flags);	\
+		check_bogus_irq_restore();		\
 		arch_local_irq_restore(flags);		\
 	} while (0)
 #define raw_local_save_flags(flags)			\
@@ -235,11 +236,7 @@ extern void warn_bogus_irq_restore(bool
 #define local_irq_enable()	do { raw_local_irq_enable(); } while (0)
 #define local_irq_disable()	do { raw_local_irq_disable(); } while (0)
 #define local_irq_save(flags)	do { raw_local_irq_save(flags); } while (0)
-#define local_irq_restore(flags)		\
-	do {					\
-		check_bogus_irq_restore();	\
-		raw_local_irq_restore(flags);	\
-	} while (0)
+#define local_irq_restore(flags) do { raw_local_irq_restore(flags); } while (0)
 #define safe_halt()		do { raw_safe_halt(); } while (0)
 
 #endif /* CONFIG_TRACE_IRQFLAGS */
