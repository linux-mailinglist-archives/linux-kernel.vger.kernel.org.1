Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001052C5BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 19:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404869AbgKZSSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 13:18:48 -0500
Received: from foss.arm.com ([217.140.110.172]:42936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404410AbgKZSSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:18:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A24A91516;
        Thu, 26 Nov 2020 10:18:47 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 508043F23F;
        Thu, 26 Nov 2020 10:18:46 -0800 (PST)
References: <20201124141449.572446-1-maz@kernel.org> <20201124141449.572446-7-maz@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 6/6] genirq: Rename IRQ_HIDDEN to IRQ_IPI
In-reply-to: <20201124141449.572446-7-maz@kernel.org>
Date:   Thu, 26 Nov 2020 18:18:44 +0000
Message-ID: <jhj5z5sugl7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

On 24/11/20 14:14, Marc Zyngier wrote:
> IRQ_HIDDEN was probably the wrong name, so let's rename it to IRQ_IPI,
> which more accurately describe an IPI with special arch code handling.
>

From the (new) name I would expect this to be set for IRQs requested via
irq_reserve_ipi(), but that wouldn't be correct: MIPs uses that interface,
but doesn't have our arch_show_interrupts() IPI faffery.

With that in mind, perhaps the current name isn't so bad...
