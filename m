Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B832FBFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbhASTZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:25:38 -0500
Received: from foss.arm.com ([217.140.110.172]:46374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391760AbhASTNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:13:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15599D6E;
        Tue, 19 Jan 2021 11:12:46 -0800 (PST)
Received: from bogus (unknown [10.57.35.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABF833F719;
        Tue, 19 Jan 2021 11:12:44 -0800 (PST)
Date:   Tue, 19 Jan 2021 19:12:42 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, catalin.marinas@arm.com,
        guohanjun@huawei.com, rui.xiang@huawei.com, houtao1@huawei.com,
        will@kernel.org
Subject: Re: [PATCH] arm64: kernel: Make IPI_WAKEUP under control of
 CONFIG_ARM64_ACPI_PARKING_PROTOCOL
Message-ID: <20210119191242.mna6ieiwjuyzol6j@bogus>
References: <20210119140609.106420-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119140609.106420-1-chenjun102@huawei.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 02:06:09PM +0000, Chen Jun wrote:
> since commit 5e89c55e4ed81d7abb1ce8828db35fa389dc0e90
> ("arm64: kernel: implement ACPI parking protocol")
> 
> On arm64, IPI 6 will be wasted without setting
> CONFIG_ARM64_ACPI_PARKING_PROTOCOL.
> 
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> ---
>  arch/arm64/kernel/smp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index ad00f99ee9b0..8b494ad1c61e 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -73,7 +73,9 @@ enum ipi_msg_type {
>  	IPI_CPU_CRASH_STOP,
>  	IPI_TIMER,

Going by that logic, IPI_TIMER is used only when
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y and

>  	IPI_IRQ_WORK,

IPI_IRQ_WORK when CONFIG_IRQ_WORK=y

Not sure if we what to go down that path as it may result in confusion
about IPI number and what OS is using it for. I am not against this, just
want to know others opinion on this.

> +#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
>  	IPI_WAKEUP,
> +#endif

Just out of curiosity, are you changing this only by code inspection or
or you running short of IPI with some downstream patches. It will be
interesting to know how you are using then if you are as it may break if
kernel decides to you them in future for its own use.

-- 
Regards,
Sudeep
