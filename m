Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7562C4C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 02:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgKZBAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 20:00:16 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7989 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgKZBAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 20:00:16 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ChKDG0pcXzhgHw;
        Thu, 26 Nov 2020 08:59:58 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Nov 2020 09:00:08 +0800
Subject: Re: [PATCH] drivers: clocksource: timer-riscv: Depend on the SBI
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        <linux-riscv@lists.infradead.org>
CC:     Palmer Dabbelt <palmerdabbelt@google.com>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>, <kernel-team@android.com>,
        <linux-kernel@vger.kernel.org>
References: <20201125195804.3780975-1-palmer@dabbelt.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <d5ce9003-b070-0dfc-042c-a2879b992959@huawei.com>
Date:   Thu, 26 Nov 2020 09:00:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201125195804.3780975-1-palmer@dabbelt.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer，  I send a same patch and have been acked from you : )

https://patchwork.kernel.org/project/linux-riscv/patch/20201028131230.72907-1-wangkefeng.wang@huawei.com/

On 2020/11/26 3:58, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
>
> Fundamentally this is an SBI timer driver, so it cannot be enabled without
> support for the RISC-V SBI.
>
> Fixes: d5be89a8d118 ("RISC-V: Resurrect the MMIO timer implementation for M-mode systems")
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>   drivers/clocksource/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 68b087bff59c..3eeaf0efba8f 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -655,6 +655,7 @@ config ATCPIT100_TIMER
>   config RISCV_TIMER
>   	bool "Timer for the RISC-V platform" if COMPILE_TEST
>   	depends on GENERIC_SCHED_CLOCK && RISCV
> +	depends on RISCV_SBI
>   	select TIMER_PROBE
>   	select TIMER_OF
>   	help
