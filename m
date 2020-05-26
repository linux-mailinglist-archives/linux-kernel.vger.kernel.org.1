Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567731D2C33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 12:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgENKKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 06:10:11 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:44205 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgENKKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:10:11 -0400
Received: from [192.168.1.11] (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 6A02C20000B;
        Thu, 14 May 2020 10:10:04 +0000 (UTC)
Subject: Re: [PATCH 04/10] riscv: Fix print_vm_layout build error if NOMMU
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Hulk Robot <hulkci@huawei.com>
References: <20200511022001.179767-1-wangkefeng.wang@huawei.com>
 <20200511022001.179767-5-wangkefeng.wang@huawei.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <1daca195-f63c-2693-068f-6d624aa1b899@ghiti.fr>
Date:   Thu, 14 May 2020 06:10:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511022001.179767-5-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/10/20 10:19 PM, Kefeng Wang wrote:
> arch/riscv/mm/init.c: In function ‘print_vm_layout’:
> arch/riscv/mm/init.c:68:37: error: ‘FIXADDR_START’ undeclared (first use in this function);
> arch/riscv/mm/init.c:69:20: error: ‘FIXADDR_TOP’ undeclared
> arch/riscv/mm/init.c:70:37: error: ‘PCI_IO_START’ undeclared
> arch/riscv/mm/init.c:71:20: error: ‘PCI_IO_END’ undeclared
> arch/riscv/mm/init.c:72:38: error: ‘VMEMMAP_START’ undeclared
> arch/riscv/mm/init.c:73:20: error: ‘VMEMMAP_END’ undeclared (first use in this function);
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   arch/riscv/mm/init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index dfcaebc3928f..58c39c44b9c9 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -49,7 +49,7 @@ static void setup_zero_page(void)
>   	memset((void *)empty_zero_page, 0, PAGE_SIZE);
>   }
>   
> -#ifdef CONFIG_DEBUG_VM
> +#if defined(CONFIG_MMU) && defined(DEBUG_VM)


Shouldn't it be CONFIG_DEBUG_VM ?


>   static inline void print_mlk(char *name, unsigned long b, unsigned long t)
>   {
>   	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld kB)\n", name, b, t,


Alex

