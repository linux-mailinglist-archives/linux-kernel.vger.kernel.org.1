Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8C229A2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410118AbgJ0C75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 22:59:57 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:42236 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729206AbgJ0C75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 22:59:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06900273|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0230261-0.00797704-0.968997;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=fuyao@allwinnertech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.Iotm-GP_1603767592;
Received: from localhost(mailfrom:fuyao@allwinnertech.com fp:SMTPD_---.Iotm-GP_1603767592)
          by smtp.aliyun-inc.com(10.147.44.129);
          Tue, 27 Oct 2020 10:59:52 +0800
Date:   Tue, 27 Oct 2020 10:59:52 +0800
From:   fuyao <fuyao@allwinnertech.com>
To:     liush <liush@allwinnertech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, penberg@kernel.org,
        akpm@linux-foundation.org, peterx@redhat.com, vbabka@suse.cz,
        walken@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?6bqm6ZSu5qif?= <maijianzhang@allwinnertech.com>,
        =?utf-8?B?6buE6Ie754Kc?= <huangzhenwei@allwinnertech.com>
Subject: Re: [PATCH v4] riscv: fix pfn_to_virt err in do_page_fault().
Message-ID: <20201027025952.GK9517@g8Exdroid64>
Mail-Followup-To: liush <liush@allwinnertech.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, penberg@kernel.org,
        akpm@linux-foundation.org, peterx@redhat.com, vbabka@suse.cz,
        walken@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?6bqm6ZSu5qif?= <maijianzhang@allwinnertech.com>,
        =?utf-8?B?6buE6Ie754Kc?= <huangzhenwei@allwinnertech.com>
References: <1603716368-29896-1-git-send-email-liush@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603716368-29896-1-git-send-email-liush@allwinnertech.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

have you seen the main line?

it already corrected.

On Mon, Oct 26, 2020 at 08:46:08PM +0800, liush wrote:
> From: Shaohua Liu <liush@allwinnertech.com>
> 
> The argument to pfn_to_virt() should be pfn not the value of CSR_SATP.
> 
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: liush <liush@allwinnertech.com>
> ---
>  arch/riscv/mm/fault.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 1359e21..3c8b9e4 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -86,6 +86,7 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
>  	pmd_t *pmd, *pmd_k;
>  	pte_t *pte_k;
>  	int index;
> +	unsigned long pfn;
>  
>  	/* User mode accesses just cause a SIGSEGV */
>  	if (user_mode(regs))
> @@ -100,7 +101,8 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
>  	 * of a task switch.
>  	 */
>  	index = pgd_index(addr);
> -	pgd = (pgd_t *)pfn_to_virt(csr_read(CSR_SATP)) + index;
> +	pfn = csr_read(CSR_SATP) & SATP_PPN;
> +	pgd = (pgd_t *)pfn_to_virt(pfn) + index;
>  	pgd_k = init_mm.pgd + index;
>  
>  	if (!pgd_present(*pgd_k)) {
> -- 
> 2.7.4

-- 
Nimflorie frostades seda!
