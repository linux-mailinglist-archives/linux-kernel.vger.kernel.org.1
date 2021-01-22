Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696192FFC60
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 06:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbhAVFwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 00:52:20 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:12310 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbhAVFwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 00:52:18 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DMT0K0zXRzB09ZQ;
        Fri, 22 Jan 2021 06:51:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id WBL27sZgFqmM; Fri, 22 Jan 2021 06:51:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DMT0J6P6BzB09ZP;
        Fri, 22 Jan 2021 06:51:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0652E8B776;
        Fri, 22 Jan 2021 06:51:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WfxlCzxB0EEj; Fri, 22 Jan 2021 06:51:28 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 65F3E8B773;
        Fri, 22 Jan 2021 06:51:26 +0100 (CET)
Subject: Re: [PATCH] powerpc/8xx: export 'cpm_setbrg' for modules
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20210122010819.30986-1-rdunlap@infradead.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <91159e78-4eea-c645-9171-a5b90271710f@csgroup.eu>
Date:   Fri, 22 Jan 2021 06:51:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122010819.30986-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/01/2021 à 02:08, Randy Dunlap a écrit :
> Fix missing export for a loadable module build:
> 
> ERROR: modpost: "cpm_setbrg" [drivers/tty/serial/cpm_uart/cpm_uart.ko] undefined!
> 
> Fixes: 4128a89ac80d ("powerpc/8xx: move CPM1 related files from sysdev/ to platforms/8xx")

I don't understand. Before that commit cpm_setbrg() wasn't exported either.

For me, it fixes the commit that brought the capability to build the cpm uart driver as a module, 
that is commit 1da177e4c3f4 ("Linux-2.6.12-rc")

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: clang-built-linux@googlegroups.com
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>   arch/powerpc/platforms/8xx/cpm1.c |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- linux-next-20210121.orig/arch/powerpc/platforms/8xx/cpm1.c
> +++ linux-next-20210121/arch/powerpc/platforms/8xx/cpm1.c
> @@ -280,6 +280,7 @@ cpm_setbrg(uint brg, uint rate)
>   		out_be32(bp, (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
>   			      CPM_BRG_EN | CPM_BRG_DIV16);
>   }
> +EXPORT_SYMBOL(cpm_setbrg);
>   
>   struct cpm_ioport16 {
>   	__be16 dir, par, odr_sor, dat, intr;
> 
