Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A961DF999
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 19:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbgEWRa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 13:30:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37450 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387501AbgEWRa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:30:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49Tr3M1FsRz9v0rq;
        Sat, 23 May 2020 19:30:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6AYhYT_9Gpsv; Sat, 23 May 2020 19:30:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49Tr3M0TyQz9v0rp;
        Sat, 23 May 2020 19:30:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6DCA18B876;
        Sat, 23 May 2020 19:30:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id F9Ne9NoMRqYB; Sat, 23 May 2020 19:30:25 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1121E8B86D;
        Sat, 23 May 2020 19:30:25 +0200 (CEST)
Subject: Re: Kernel bug in 5.7 for PPC32 on PowerBook G4 - bisected to commit
 697ece7
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <2c361d8e-5e2a-cdd9-da8e-aa49a4f93cfd@lwfinger.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <3e3e2343-d674-02e0-7b23-81636b472641@csgroup.eu>
Date:   Sat, 23 May 2020 19:30:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2c361d8e-5e2a-cdd9-da8e-aa49a4f93cfd@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

Le 23/05/2020 à 19:24, Larry Finger a écrit :
> Hi Christophe,
> 
> Although kernel 5.7.0-rc2 appeared to boot cleanly, it failed on my G4 
> when I tried to generate a new kernel. The following BUG message is logged:
> 

[...]

> 
> This problem was bisected to commit 697ece7 ("powerpc/32s: reorder Linux 
> PTE bits to better match Hash PTE bits").

Being reversed in new -rc , see 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/87sgfsf4hs.fsf@mpe.ellerman.id.au/

> 
> If I had done more rigorous tests earlier, I would have found the bug 
> with more time to fix it before release of 5.7, but every other problem 
> I have found happened at boot, not when the machine had to swap.
> 
> Thanks,
> 
> Larry

Christophe
