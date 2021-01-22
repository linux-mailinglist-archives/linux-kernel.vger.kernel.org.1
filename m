Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF7E300244
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbhAVL7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:59:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727284AbhAVL7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:59:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C384622C9F;
        Fri, 22 Jan 2021 11:58:21 +0000 (UTC)
Date:   Fri, 22 Jan 2021 11:58:19 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v5 4/6] arm64: mte: Enable async tag check fault
Message-ID: <20210122115818.GA8567@gaia>
References: <20210121163943.9889-1-vincenzo.frascino@arm.com>
 <20210121163943.9889-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121163943.9889-5-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 04:39:41PM +0000, Vincenzo Frascino wrote:
> MTE provides a mode that asynchronously updates the TFSR_EL1 register
> when a tag check exception is detected.
> 
> To take advantage of this mode the kernel has to verify the status of
> the register at:
>   1. Context switching
>   2. Return to user/EL0 (Not required in entry from EL0 since the kernel
>   did not run)
>   3. Kernel entry from EL1
>   4. Kernel exit to EL1
> 
> If the register is non-zero a trace is reported.
> 
> Add the required features for EL1 detection and reporting.
> 
> Note: ITFSB bit is set in the SCTLR_EL1 register hence it guaranties that
> the indirect writes to TFSR_EL1 are synchronized at exception entry to
> EL1. On the context switch path the synchronization is guarantied by the
> dsb() in __switch_to().
> The dsb(nsh) in mte_check_tfsr_exit() is provisional pending
> confirmation by the architects.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
