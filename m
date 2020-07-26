Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1678122DFB1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 16:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgGZO1r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 26 Jul 2020 10:27:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28638 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgGZO1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 10:27:46 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BF4yz68Hxz9v1qF;
        Sun, 26 Jul 2020 16:27:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 2zRZtQ7hFE-t; Sun, 26 Jul 2020 16:27:39 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BF4yz57Pnz9v1qD;
        Sun, 26 Jul 2020 16:27:39 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 1FEAB2487; Sun, 26 Jul 2020 16:29:02 +0200 (CEST)
Received: from 37-166-97-133.coucou-networks.fr
 (37-166-97-133.coucou-networks.fr [37.166.97.133]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Sun, 26 Jul 2020 16:29:02 +0200
Date:   Sun, 26 Jul 2020 16:29:02 +0200
Message-ID: <20200726162902.Horde.TCqHYaODbkzEpM-rFzDd8A2@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] powerpc: delete duplicated words
In-Reply-To: <20200726003809.20454-1-rdunlap@infradead.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> a écrit :

> Drop duplicated words in arch/powerpc/ header files.

How did you detect them ? Do you have some script for tgat, or you  
just read all comments ?

>
> Cc: Michael Ellerman <mpe@ellerman.id.au>

You say you Cc Michael, but in fact you don't ... Allthough he is the  
powerpc maintainer

Christophe

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
>
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |    2 +-
>  arch/powerpc/include/asm/book3s/64/radix-4k.h |    2 +-
>  arch/powerpc/include/asm/cputime.h            |    2 +-
>  arch/powerpc/include/asm/epapr_hcalls.h       |    4 ++--
>  arch/powerpc/include/asm/hw_breakpoint.h      |    2 +-
>  arch/powerpc/include/asm/ppc_asm.h            |    2 +-
>  arch/powerpc/include/asm/reg.h                |    2 +-
>  arch/powerpc/include/asm/smu.h                |    2 +-
>  arch/powerpc/platforms/powernv/pci.h          |    2 +-
>  9 files changed, 10 insertions(+), 10 deletions(-)


