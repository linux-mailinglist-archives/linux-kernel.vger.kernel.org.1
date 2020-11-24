Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE562C2D88
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390682AbgKXQ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:56:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbgKXQ4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:56:22 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3EF9206D8;
        Tue, 24 Nov 2020 16:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606236982;
        bh=tLrka8nxaKUEtt9+F6qlTOzBV2bzpNmC5eWDUQqTESc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F3xY49qwcv1JZpU9jG/Qld5skJ2Y7RozDs0g2qHZZ/YQiH4duUheMEqu0lgACMrcn
         KupzQRhzAPlT82Uj9mgO1Q6mJCJe/2StBJur3tkvJzcJu6j5CMHmBnaf9ELgXQvTGI
         TIA1gLSC6eyqug4LCI6JSITfZRNONlziYBz553lc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1khbc3-00DJCV-PE; Tue, 24 Nov 2020 16:56:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Nov 2020 16:56:19 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 2/6] genirq: Allow an interrupt to be marked as 'raw'
In-Reply-To: <20201124162609.GK2414@hirez.programming.kicks-ass.net>
References: <20201124141449.572446-1-maz@kernel.org>
 <20201124141449.572446-3-maz@kernel.org>
 <20201124162609.GK2414@hirez.programming.kicks-ass.net>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <8235a7217b88bc0192eb387ee2be005d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: peterz@infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, tglx@linutronix.de, Valentin.Schneider@arm.com, mark.rutland@arm.com, linux@arm.linux.org.uk, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-24 16:26, Peter Zijlstra wrote:
> On Tue, Nov 24, 2020 at 02:14:45PM +0000, Marc Zyngier wrote:
>> Some interrupts (such as the rescheduling IPI) rely on not going 
>> through
>> the irq_enter()/irq_exit() calls. To distinguish such interrupts, add
>> a new IRQ flag that allows the low-level handling code to sidestep the
>> enter()/exit() calls.
> 
> Well, not quite. The scheduler_ipi() function is perfectly fine being
> called with irq_enter/irq_exit. As per this very series, that's your
> current reality.
> 
> The function just doesn't need it.

Yup, definitely a very bad choice of words here.
/me goes and repaint the commit message.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
