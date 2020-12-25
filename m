Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774A12E2A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 08:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgLYHGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 02:06:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9992 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgLYHGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 02:06:18 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D2Hxt5Y66zhy0w;
        Fri, 25 Dec 2020 15:04:50 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 25 Dec 2020 15:05:28 +0800
Subject: Re: [PATCH] arm64/smp: Remove unused irq variable in
 arch_show_interrupts()
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Gavin Shan <gshan@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <wanghaibin.wang@huawei.com>
References: <20201215103026.2872532-1-geert+renesas@glider.be>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <12e192f7-cef5-5dc1-32e4-75a97e77e9c6@huawei.com>
Date:   Fri, 25 Dec 2020 15:05:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201215103026.2872532-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/15 18:30, Geert Uytterhoeven wrote:
>      arch/arm64/kernel/smp.c: In function ‘arch_show_interrupts’:
>      arch/arm64/kernel/smp.c:808:16: warning: unused variable ‘irq’ [-Wunused-variable]
>        808 |   unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
> 	  |                ^~~
> 
> The removal of the last user forgot to remove the variable.
> 
> Fixes: 2f516e34383d0e97 ("arm64/smp: Use irq_desc_kstat_cpu() in arch_show_interrupts()")

This is in mainline now and the commit id is 5089bc51f81f.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> One more issue in irq-core-2020-12-14.
> 
>   arch/arm64/kernel/smp.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 3aef3bc22d3250b5..10b39328268687e3 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -805,7 +805,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>   	unsigned int cpu, i;
>   
>   	for (i = 0; i < NR_IPI; i++) {
> -		unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
>   		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
>   			   prec >= 4 ? " " : "");
>   		for_each_online_cpu(cpu)

And I guess we have the same problem on 32-bit ARM. 'irq' in
show_ipi_list() is no longer used since commit 88c637748e31
("ARM: smp: Use irq_desc_kstat_cpu() in show_ipi_list()").


Thanks,
Zenghui
