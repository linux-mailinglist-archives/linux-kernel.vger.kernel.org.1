Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527BD2CA921
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392204AbgLAQ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:57:21 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:49911 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388821AbgLAQ5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:57:20 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4ClpCl6dGbz9v3p7;
        Tue,  1 Dec 2020 17:56:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id aAkh48jFRr4H; Tue,  1 Dec 2020 17:56:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4ClpCl58BYz9v3nc;
        Tue,  1 Dec 2020 17:56:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C8E668B7C1;
        Tue,  1 Dec 2020 17:56:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ItWmq8r7Upbe; Tue,  1 Dec 2020 17:56:35 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 97D2C8B7B9;
        Tue,  1 Dec 2020 17:56:33 +0100 (CET)
Subject: Re: [PATCH v9 4/6] kasan: Document support on 32-bit powerpc
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, christophe.leroy@c-s.fr,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
References: <20201201161632.1234753-1-dja@axtens.net>
 <20201201161632.1234753-5-dja@axtens.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <421d8685-afef-eaa8-5207-280d951be594@csgroup.eu>
Date:   Tue, 1 Dec 2020 17:56:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201161632.1234753-5-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/12/2020 à 17:16, Daniel Axtens a écrit :
> KASAN is supported on 32-bit powerpc and the docs should reflect this.
> 
> Document s390 support while we're at it.
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

My new address is <christophe.leroy@csgroup.eu>

> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>   Documentation/dev-tools/kasan.rst |  7 +++++--
>   Documentation/powerpc/kasan.txt   | 12 ++++++++++++
>   2 files changed, 17 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/powerpc/kasan.txt
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 2b68addaadcd..eaf868094a8e 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -19,7 +19,8 @@ out-of-bounds accesses for global variables is only supported since Clang 11.
>   Tag-based KASAN is only supported in Clang.
>   
>   Currently generic KASAN is supported for the x86_64, arm64, xtensa, s390 and
> -riscv architectures, and tag-based KASAN is supported only for arm64.
> +riscv architectures. It is also supported on 32-bit powerpc kernels. Tag-based
> +KASAN is supported only on arm64.
>   
>   Usage
>   -----
> @@ -255,7 +256,9 @@ CONFIG_KASAN_VMALLOC
>   ~~~~~~~~~~~~~~~~~~~~
>   
>   With ``CONFIG_KASAN_VMALLOC``, KASAN can cover vmalloc space at the
> -cost of greater memory usage. Currently this is only supported on x86.
> +cost of greater memory usage. Currently this supported on x86, s390
> +and 32-bit powerpc. It is optional, except on 32-bit powerpc kernels
> +with module support, where it is required.
>   
>   This works by hooking into vmalloc and vmap, and dynamically
>   allocating real shadow memory to back the mappings.
> diff --git a/Documentation/powerpc/kasan.txt b/Documentation/powerpc/kasan.txt
> new file mode 100644
> index 000000000000..26bb0e8bb18c
> --- /dev/null
> +++ b/Documentation/powerpc/kasan.txt
> @@ -0,0 +1,12 @@
> +KASAN is supported on powerpc on 32-bit only.
> +
> +32 bit support
> +==============
> +
> +KASAN is supported on both hash and nohash MMUs on 32-bit.
> +
> +The shadow area sits at the top of the kernel virtual memory space above the
> +fixmap area and occupies one eighth of the total kernel virtual memory space.
> +
> +Instrumentation of the vmalloc area is optional, unless built with modules,
> +in which case it is required.
> 
