Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A764F2E93FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbhADLTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:19:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbhADLTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:19:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDF1420770;
        Mon,  4 Jan 2021 11:18:51 +0000 (UTC)
Date:   Mon, 4 Jan 2021 11:18:48 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/smp: Remove unused 'irq' variable
Message-ID: <20210104111847.GB28268@gaia>
References: <20201230154516.680413-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230154516.680413-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 04:45:04PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The only use of this variable was removed in a recent patch:
> 
> arch/arm64/kernel/smp.c:810:16: error: unused variable 'irq' [-Werror,-Wunused-variable]
>                 unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
> 
> Fixes: 5089bc51f81f ("arm64/smp: Use irq_desc_kstat_cpu() in arch_show_interrupts()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks. I applied Geert's fix already.

-- 
Catalin
