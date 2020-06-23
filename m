Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46861204D56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 11:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbgFWJDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 05:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731853AbgFWJDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:03:03 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C77020723;
        Tue, 23 Jun 2020 09:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592902983;
        bh=dwWcASt70MTuxccXh9SiyO0yx9YTgv4Fs1v9uGeJeog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIBArjKQcPyob07dgdMW1n0RPQYZmKhdnf7NDLJ9uG1vh48+wabjCoHwI6zYolY0m
         QysB5Pq1bMfO3l+UnqTrhM/Q+Xs0ksycC2hlHacWZPIYTvSxCNf3NknfQR0wETfDM4
         /4nBQyW/f6EuIdcyG2e/KuC2gNBLzUs/O26ZmIAI=
Date:   Tue, 23 Jun 2020 10:02:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH v4 6/8] arm: Break cyclic percpu include
Message-ID: <20200623090257.GA3743@willie-the-truck>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.454517573@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623083721.454517573@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:36:51AM +0200, Peter Zijlstra wrote:
> In order to use <asm/percpu.h> in irqflags.h, we need to make sure
> asm/percpu.h does not itself depend on irqflags.h.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm/include/asm/percpu.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/arch/arm/include/asm/percpu.h
> +++ b/arch/arm/include/asm/percpu.h
> @@ -10,6 +10,8 @@
>   * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
>   */
>  #if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)
> +register unsigned long current_stack_pointer asm ("sp");

If you define this unconditionally, then we can probably get rid of the
copy in asm/thread_info.h, rather than duplicate the same #define.

Will
