Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CDF2ACF62
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbgKJGH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:07:27 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:31411 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgKJGH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:07:26 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CVcpM5whnz9txrh;
        Tue, 10 Nov 2020 07:07:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id S-kiiN4sBykR; Tue, 10 Nov 2020 07:07:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CVcpM4TmXz9txrc;
        Tue, 10 Nov 2020 07:07:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A31A8B7CD;
        Tue, 10 Nov 2020 07:07:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id m21b2CIwh-gp; Tue, 10 Nov 2020 07:07:24 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D6B428B764;
        Tue, 10 Nov 2020 07:07:23 +0100 (CET)
Subject: Re: [PATCH] powerpc/mm: Fix comparing pointer to 0 warning
To:     xiakaixu1987@gmail.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     Kaixu Xia <kaixuxia@tencent.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1604976961-20441-1-git-send-email-kaixuxia@tencent.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9fd91aab-a418-5c48-0b0c-d657ccd2448a@csgroup.eu>
Date:   Tue, 10 Nov 2020 07:07:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <1604976961-20441-1-git-send-email-kaixuxia@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/11/2020 à 03:56, xiakaixu1987@gmail.com a écrit :
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> Fixes coccicheck warning:
> 
> ./arch/powerpc/mm/pgtable_32.c:87:11-12: WARNING comparing pointer to 0
> 
> Avoid pointer type value compared to 0.
> 
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/mm/pgtable_32.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 079159e97bca..888b9713a316 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -84,7 +84,7 @@ int __ref map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
>   		pg = pte_alloc_kernel(pd, va);
>   	else
>   		pg = early_pte_alloc_kernel(pd, va);
> -	if (pg != 0) {
> +	if (pg) {
>   		err = 0;
>   		/* The PTE should never be already set nor present in the
>   		 * hash table
> 
