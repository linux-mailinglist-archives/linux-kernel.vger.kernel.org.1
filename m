Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3052E944B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbhADLuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:50:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbhADLuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:50:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64F29221E5;
        Mon,  4 Jan 2021 11:49:20 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] arm64/smp: Remove unused irq variable in arch_show_interrupts()
Date:   Mon,  4 Jan 2021 11:49:18 +0000
Message-Id: <160976092100.24483.3558010019560199863.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215103026.2872532-1-geert+renesas@glider.be>
References: <20201215103026.2872532-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 11:30:26 +0100, Geert Uytterhoeven wrote:
>     arch/arm64/kernel/smp.c: In function ‘arch_show_interrupts’:
>     arch/arm64/kernel/smp.c:808:16: warning: unused variable ‘irq’ [-Wunused-variable]
>       808 |   unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
> 	  |                ^~~
> 
> The removal of the last user forgot to remove the variable.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/smp: Remove unused irq variable in arch_show_interrupts()
      https://git.kernel.org/arm64/c/42e85f90171a

Also adjusted the Fixes tag (before seeing that you posted a v2).

-- 
Catalin

