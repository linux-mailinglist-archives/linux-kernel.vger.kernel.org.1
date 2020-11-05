Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C461C2A77C6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgKEHKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:10:37 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:57641 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgKEHKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:10:36 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CRZRY3PwRz9v117;
        Thu,  5 Nov 2020 08:10:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PuUCBQNMDmSo; Thu,  5 Nov 2020 08:10:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CRZRY17TXz9v116;
        Thu,  5 Nov 2020 08:10:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 115AD8B819;
        Thu,  5 Nov 2020 08:10:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id P1iQ9jSrgLaD; Thu,  5 Nov 2020 08:10:34 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AAD948B764;
        Thu,  5 Nov 2020 08:10:33 +0100 (CET)
Subject: Re: [PATCH 31/36] powerpc: asm: hvconsole: Move 'hvc_vio_init_early's
 prototype to shared location
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-32-lee.jones@linaro.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <d2a23842-631e-cd5e-84ec-48485328ba52@csgroup.eu>
Date:   Thu, 5 Nov 2020 08:10:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201104193549.4026187-32-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 04/11/2020 à 20:35, Lee Jones a écrit :
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/tty/hvc/hvc_vio.c:385:13: warning: no previous prototype for ‘hvc_vio_init_early’ [-Wmissing-prototypes]
>   385 | void __init hvc_vio_init_early(void)
>   | ^~~~~~~~~~~~~~~~~~
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/powerpc/include/asm/hvconsole.h     | 3 +++
>   arch/powerpc/platforms/pseries/pseries.h | 3 ---
>   arch/powerpc/platforms/pseries/setup.c   | 1 +
>   3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hvconsole.h b/arch/powerpc/include/asm/hvconsole.h
> index 999ed5ac90531..936a1ee1ac786 100644
> --- a/arch/powerpc/include/asm/hvconsole.h
> +++ b/arch/powerpc/include/asm/hvconsole.h
> @@ -24,5 +24,8 @@
>   extern int hvc_get_chars(uint32_t vtermno, char *buf, int count);
>   extern int hvc_put_chars(uint32_t vtermno, const char *buf, int count);
>   
> +/* Provided by HVC VIO */
> +extern void hvc_vio_init_early(void);
> +

Declaring a prototype 'extern' is pointless. Don't add new misuse of 'extern' keyword.


>   #endif /* __KERNEL__ */
>   #endif /* _PPC64_HVCONSOLE_H */
> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> index 13fa370a87e4e..7be5b054dfc36 100644
> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -43,9 +43,6 @@ extern void pSeries_final_fixup(void);
>   /* Poweron flag used for enabling auto ups restart */
>   extern unsigned long rtas_poweron_auto;
>   
> -/* Provided by HVC VIO */
> -extern void hvc_vio_init_early(void);
> -
>   /* Dynamic logical Partitioning/Mobility */
>   extern void dlpar_free_cc_nodes(struct device_node *);
>   extern void dlpar_free_cc_property(struct property *);
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 633c45ec406da..6999b83f06612 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -71,6 +71,7 @@
>   #include <asm/swiotlb.h>
>   #include <asm/svm.h>
>   #include <asm/dtl.h>
> +#include <asm/hvconsole.h>
>   
>   #include "pseries.h"
>   #include "../../../../drivers/pci/pci.h"
> 

Christophe
