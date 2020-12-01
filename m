Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035B22CA929
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392234AbgLAQ5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:57:47 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:8429 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392161AbgLAQ5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:57:46 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4ClpDF6nXGz9v3pB;
        Tue,  1 Dec 2020 17:57:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Fw8xU2BzxYW9; Tue,  1 Dec 2020 17:57:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4ClpDF5js3z9v3p8;
        Tue,  1 Dec 2020 17:57:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 981A68B7BD;
        Tue,  1 Dec 2020 17:57:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EFRlEYXIR7eW; Tue,  1 Dec 2020 17:57:02 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 672CA8B7B7;
        Tue,  1 Dec 2020 17:56:58 +0100 (CET)
Subject: Re: [PATCH v9 5/6] powerpc/mm/kasan: rename kasan_init_32.c to
 init_32.c
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, christophe.leroy@c-s.fr,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
References: <20201201161632.1234753-1-dja@axtens.net>
 <20201201161632.1234753-6-dja@axtens.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <459c6cf1-dd76-5d1f-e7c8-432fcbe5eef9@csgroup.eu>
Date:   Tue, 1 Dec 2020 17:56:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201161632.1234753-6-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/12/2020 à 17:16, Daniel Axtens a écrit :
> kasan is already implied by the directory name, we don't need to
> repeat it.
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>

My new address is <christophe.leroy@csgroup.eu>


> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>   arch/powerpc/mm/kasan/Makefile                       | 2 +-
>   arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} | 0
>   2 files changed, 1 insertion(+), 1 deletion(-)
>   rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)
> 
> diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
> index bb1a5408b86b..42fb628a44fd 100644
> --- a/arch/powerpc/mm/kasan/Makefile
> +++ b/arch/powerpc/mm/kasan/Makefile
> @@ -2,6 +2,6 @@
>   
>   KASAN_SANITIZE := n
>   
> -obj-$(CONFIG_PPC32)           += kasan_init_32.o
> +obj-$(CONFIG_PPC32)           += init_32.o
>   obj-$(CONFIG_PPC_8xx)		+= 8xx.o
>   obj-$(CONFIG_PPC_BOOK3S_32)	+= book3s_32.o
> diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/init_32.c
> similarity index 100%
> rename from arch/powerpc/mm/kasan/kasan_init_32.c
> rename to arch/powerpc/mm/kasan/init_32.c
> 
