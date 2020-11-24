Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC022C2CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390358AbgKXQ00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390017AbgKXQ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:26:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30329C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ff4szs+CLuwlL8iKrPqFlBDU9tu8u7cwkJkWRBVFhQY=; b=EFgp9xAjAOcjcmKpnfeK0oIsrS
        iY7uO+H/fNGYyIpoK7KHPgPE4ZkahlyoEMfBB1p2bapqfHrtJI3nzPEpMHH1cSrAe+bi7MUlPFLEC
        MjgUsvlJ8gvqqyrA6EuBzjOIGoga5Ynhi2+3TAgUVy9KOiQqIrbOZenOPvtOtOnQO3hlfOak5wdzy
        vUHWqlUEdB5DMOXCopWhibf9fBzVN/jAZwREifDm4XqDPa2R8u5HFLZQHJ+NDtHiHem4R/gYqgTWS
        vAg73NAoSykmVvd1dcDuPxb2CZrK5kGTcrh9upZRLQR3Sg5DZbjsFJExGnGWqZLOk97wRlNI6Y0Pq
        JHbTZkrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khb8r-0002es-Re; Tue, 24 Nov 2020 16:26:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 57E4C3012DF;
        Tue, 24 Nov 2020 17:26:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 362B72B09D6B7; Tue, 24 Nov 2020 17:26:09 +0100 (CET)
Date:   Tue, 24 Nov 2020 17:26:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marc Zyngier <maz@kernel.org>
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
Message-ID: <20201124162609.GK2414@hirez.programming.kicks-ass.net>
References: <20201124141449.572446-1-maz@kernel.org>
 <20201124141449.572446-3-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124141449.572446-3-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:14:45PM +0000, Marc Zyngier wrote:
> Some interrupts (such as the rescheduling IPI) rely on not going through
> the irq_enter()/irq_exit() calls. To distinguish such interrupts, add
> a new IRQ flag that allows the low-level handling code to sidestep the
> enter()/exit() calls.

Well, not quite. The scheduler_ipi() function is perfectly fine being
called with irq_enter/irq_exit. As per this very series, that's your
current reality.

The function just doesn't need it.
