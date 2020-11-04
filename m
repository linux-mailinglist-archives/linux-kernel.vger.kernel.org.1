Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7B2A5E38
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgKDGog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:44:36 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:23788 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgKDGof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:44:35 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CQxw02z0rz9tyPY;
        Wed,  4 Nov 2020 07:44:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dDuwbj7axkAB; Wed,  4 Nov 2020 07:44:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CQxw01tGMz9tyPX;
        Wed,  4 Nov 2020 07:44:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F1118B7E0;
        Wed,  4 Nov 2020 07:44:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pT5JxX0as3Cj; Wed,  4 Nov 2020 07:44:33 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CF2908B75E;
        Wed,  4 Nov 2020 07:44:32 +0100 (CET)
Subject: Re: [PATCH] powerpc/32s: Setup the early hash table at all time.
To:     Serge Belyshev <belyshev@depni.sinp.msu.ru>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <b8f8101c368b8a6451844a58d7bd7d83c14cf2aa.1601566529.git.christophe.leroy@csgroup.eu>
 <87wnz8vizm.fsf@igel.home> <87y2jouw8k.fsf@mpe.ellerman.id.au>
 <87v9esaxlv.fsf@igel.home>
 <20201030140047.Horde.TJJqKGzG9vSGbMRNIj-MPg7@messagerie.c-s.fr>
 <87pn4zc0zl.fsf@igel.home> <1f8494cd-36db-e3a2-8ea4-28fb976468e7@csgroup.eu>
 <875z6mmfna.fsf@depni.sinp.msu.ru>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5acd7caf-99e9-9cb5-ed24-578d2e0a5ee1@csgroup.eu>
Date:   Wed, 4 Nov 2020 07:44:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <875z6mmfna.fsf@depni.sinp.msu.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/11/2020 à 19:58, Serge Belyshev a écrit :
>> Would you mind checking that with that patch reverted, you are able to
>> boot a kernel built with CONFIG_KASAN ?
> 
> I can reproduce the same problem on a powerbook G4, and no,
> CONFIG_KASAN=y kernel with that patch reverted also does not boot with
> the same symptom: white screen at the bootloader right after "Booting Linux
> via __start() @ 0x0140000 ..."
> 

Thanks for the test Serge.

To be sure we are not in front of a long lasting bug, could you try CONFIG_KASAN=y on v5.9 ?

Christophe
