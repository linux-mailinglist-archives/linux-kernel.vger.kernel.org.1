Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C662C1E87
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgKXGyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:54:03 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:44869 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbgKXGyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:54:02 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgF9f503cz9tyhw;
        Tue, 24 Nov 2020 07:53:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hmjPhs3s2u0p; Tue, 24 Nov 2020 07:53:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgF9f44vJz9tyhv;
        Tue, 24 Nov 2020 07:53:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E5C08B7A3;
        Tue, 24 Nov 2020 07:53:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1BWyoMS_Jinp; Tue, 24 Nov 2020 07:53:59 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C8818B79F;
        Tue, 24 Nov 2020 07:53:58 +0100 (CET)
Subject: Re: [PATCH v2 00/19] Add generic vdso_base tracking
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
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20201124002932.1220517-1-dima@arista.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5e315bf6-b03d-e66e-9557-22ece397080e@csgroup.eu>
Date:   Tue, 24 Nov 2020 07:53:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/11/2020 à 01:29, Dmitry Safonov a écrit :
> v2 Changes:
> - Rename user_landing to vdso_base as it tracks vDSO VMA start address,
>    rather than the explicit address to land (Andy)
> - Reword and don't use "new-execed" and "new-born" task (Andy)
> - Fix failures reported by build robot
> 
> Started from discussion [1], where was noted that currently a couple of
> architectures support mremap() for vdso/sigpage, but not munmap().
> If an application maps something on the ex-place of vdso/sigpage,
> later after processing signal it will land there (good luck!)
> 
> Patches set is based on linux-next (next-20201123) and it depends on
> changes in x86/cleanups (those reclaim TIF_IA32/TIF_X32) and also
> on my changes in akpm (fixing several mremap() issues).

I have a series that cleans up VDSO init on powerpc and migrates powerpc to 
_install_special_mapping() (patch 10 of the series).

https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=204396&state=%2A&archive=both

I'm wondering how we should coordinate with your series for merging.

I guess your series will also imply removal of arch_unmap() ? see 
https://elixir.bootlin.com/linux/v5.10-rc4/source/arch/powerpc/include/asm/mmu_context.h#L262

> 
> Logically, the patches set divides on:
> - patch       1: a cleanup for patches in x86/cleanups
> - patches  2-11: cleanups for arch_setup_additional_pages()
> - patches 12-13: x86 signal changes for unmapped vdso
> - patches 14-19: provide generic vdso_base in mm_struct
> 
> In the end, besides cleanups, it's now more predictable what happens for
> applications with unmapped vdso on architectures those support .mremap()
> for vdso/sigpage.
> 
> I'm aware of only one user that unmaps vdso - Valgrind [2].
> (there possibly are more, but this one is "special", it unmaps vdso, but
>   not vvar, which confuses CRIU [Checkpoint Restore In Userspace], that's
>   why I'm aware of it)
> 
> Patches as a .git branch:
> https://github.com/0x7f454c46/linux/tree/setup_additional_pages-v2
> 
> v1 Link:
> https://lore.kernel.org/lkml/20201108051730.2042693-1-dima@arista.com/
> 
> [1]: https://lore.kernel.org/linux-arch/CAJwJo6ZANqYkSHbQ+3b+Fi_VT80MtrzEV5yreQAWx-L8j8x2zA@mail.gmail.com/
> [2]: https://github.com/checkpoint-restore/criu/issues/488
> 

Christophe
