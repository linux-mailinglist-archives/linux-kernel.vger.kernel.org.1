Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9F22C1E01
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgKXGNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:13:49 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:23346 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgKXGNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:13:48 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgDHD3xkbz9tySZ;
        Tue, 24 Nov 2020 07:13:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GVaSvkZmdBEL; Tue, 24 Nov 2020 07:13:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgDHD32l6z9tyST;
        Tue, 24 Nov 2020 07:13:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 389128B7A3;
        Tue, 24 Nov 2020 07:13:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RQwagSNH0AtJ; Tue, 24 Nov 2020 07:13:45 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 349678B79F;
        Tue, 24 Nov 2020 07:13:44 +0100 (CET)
Subject: Re: [PATCH v2 05/19] elf: Remove compat_arch_setup_additional_pages()
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20201124002932.1220517-1-dima@arista.com>
 <20201124002932.1220517-6-dima@arista.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <77b23c00-13a2-a8bb-6b9e-72980c5d6fca@csgroup.eu>
Date:   Tue, 24 Nov 2020 07:13:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201124002932.1220517-6-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/11/2020 à 01:29, Dmitry Safonov a écrit :
> Now that all users rely on detecting bitness of new-born task checking
> personality, remove compat_arch_setup_additional_pages() macro,
> simplifying the code.

I understand from cover that you wanted to reword "new-born" ?

> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>   fs/compat_binfmt_elf.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
> index 3606dd3a32f5..da8ee4d6e451 100644
> --- a/fs/compat_binfmt_elf.c
> +++ b/fs/compat_binfmt_elf.c
> @@ -115,11 +115,6 @@
>   #define START_THREAD		COMPAT_START_THREAD
>   #endif
>   
> -#ifdef	compat_arch_setup_additional_pages
> -#undef	arch_setup_additional_pages
> -#define	arch_setup_additional_pages compat_arch_setup_additional_pages
> -#endif
> -
>   #ifdef	compat_elf_read_implies_exec
>   #undef	elf_read_implies_exec
>   #define	elf_read_implies_exec compat_elf_read_implies_exec
> 
