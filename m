Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595912CA8C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390586AbgLAQuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:50:21 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:13973 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387673AbgLAQuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:50:20 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Clp3g5df3z9v3p8;
        Tue,  1 Dec 2020 17:49:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id j-uq1QKA259Q; Tue,  1 Dec 2020 17:49:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Clp3g3h6dz9v3nc;
        Tue,  1 Dec 2020 17:49:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 419D68B7B9;
        Tue,  1 Dec 2020 17:49:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iO0R35pfVlZL; Tue,  1 Dec 2020 17:49:35 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B2D858B7BD;
        Tue,  1 Dec 2020 17:49:29 +0100 (CET)
Subject: Re: [PATCH v9 1/6] kasan: allow an architecture to disable inline
 instrumentation
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, christophe.leroy@c-s.fr,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
References: <20201201161632.1234753-1-dja@axtens.net>
 <20201201161632.1234753-2-dja@axtens.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c091e596-acfb-2d26-1c27-4388c22988cf@csgroup.eu>
Date:   Tue, 1 Dec 2020 17:49:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201161632.1234753-2-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/12/2020 à 17:16, Daniel Axtens a écrit :
> For annoying architectural reasons, it's very difficult to support inline
> instrumentation on powerpc64.
> 
> Add a Kconfig flag to allow an arch to disable inline. (It's a bit
> annoying to be 'backwards', but I'm not aware of any way to have
> an arch force a symbol to be 'n', rather than 'y'.)
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>   lib/Kconfig.kasan | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 542a9c18398e..31a0b28f6c2b 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -9,6 +9,9 @@ config HAVE_ARCH_KASAN_SW_TAGS
>   config	HAVE_ARCH_KASAN_VMALLOC
>   	bool
>   
> +config HAVE_ARCH_NO_KASAN_INLINE

Maybe a better name could be: ARCH_DISABLE_KASAN_INLINE

> +	def_bool n
> +
>   config CC_HAS_KASAN_GENERIC
>   	def_bool $(cc-option, -fsanitize=kernel-address)
>   
> @@ -108,6 +111,7 @@ config KASAN_OUTLINE
>   
>   config KASAN_INLINE
>   	bool "Inline instrumentation"
> +	depends on !HAVE_ARCH_NO_KASAN_INLINE
>   	help
>   	  Compiler directly inserts code checking shadow memory before
>   	  memory accesses. This is faster than outline (in some workloads
> 
