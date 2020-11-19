Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887A12B992D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgKSRUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:20:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:12009 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgKSRUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:20:13 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CcRJT281zzB09Zn;
        Thu, 19 Nov 2020 18:20:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GDt-2XrDYLSx; Thu, 19 Nov 2020 18:20:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CcRJT1FSgzB09Zm;
        Thu, 19 Nov 2020 18:20:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 32DD88B80C;
        Thu, 19 Nov 2020 18:20:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7odlXmS1EpR6; Thu, 19 Nov 2020 18:20:09 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 906408B78A;
        Thu, 19 Nov 2020 18:20:02 +0100 (CET)
Subject: Re: [PATCH v3 0/2] powerpc/ptrace: Hard wire PT_SOFTE value to 1 in
 gpr_get() too
To:     Oleg Nesterov <oleg@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20201119160154.GA5183@redhat.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <d7c3ed05-b7e7-fac0-871f-4c43c1a7e90c@csgroup.eu>
Date:   Thu, 19 Nov 2020 18:19:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201119160154.GA5183@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/11/2020 à 17:01, Oleg Nesterov a écrit :
> Can we finally fix this problem? ;)
> 
> My previous attempt was ignored, see

That doesn't seems right.

Michael made some suggestion it seems, can you respond to it ?

> 
> 	https://lore.kernel.org/lkml/20190917121256.GA8659@redhat.com/
> 
> Now that gpr_get() was changed to use membuf API we can make a simpler fix.
> 
> Sorry, uncompiled/untested, I don't have a ppc machine.

I compiled with ppc64_defconfig, that seems ok. Still untested.

Christophe

> 
> Oleg.
> 
>   arch/powerpc/kernel/ptrace/ptrace-tm.c   | 21 ++++++++++++---------
>   arch/powerpc/kernel/ptrace/ptrace-view.c | 21 ++++++++++++---------
>   include/linux/regset.h                   | 12 ++++++++++++
>   3 files changed, 36 insertions(+), 18 deletions(-)
> 
