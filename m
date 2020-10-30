Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F202A060A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgJ3M6R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Oct 2020 08:58:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22337 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJ3M6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:58:17 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CN2RS2Hrdz9vCxr;
        Fri, 30 Oct 2020 13:58:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id g-TNzz5dYdfZ; Fri, 30 Oct 2020 13:58:12 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CN2RS1156z9vCxm;
        Fri, 30 Oct 2020 13:58:12 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 7996D24BA; Fri, 30 Oct 2020 14:00:47 +0100 (CET)
Received: from 37-171-46-117.coucou-networks.fr
 (37-171-46-117.coucou-networks.fr [37.171.46.117]) by messagerie.c-s.fr
 (Horde Framework) with HTTP; Fri, 30 Oct 2020 14:00:47 +0100
Date:   Fri, 30 Oct 2020 14:00:47 +0100
Message-ID: <20201030140047.Horde.TJJqKGzG9vSGbMRNIj-MPg7@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/32s: Setup the early hash table at all time.
References: <b8f8101c368b8a6451844a58d7bd7d83c14cf2aa.1601566529.git.christophe.leroy@csgroup.eu>
 <87wnz8vizm.fsf@igel.home> <87y2jouw8k.fsf@mpe.ellerman.id.au>
 <87v9esaxlv.fsf@igel.home>
In-Reply-To: <87v9esaxlv.fsf@igel.home>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> a écrit :

> On Okt 30 2020, Michael Ellerman wrote:
>
>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>> On Okt 01 2020, Christophe Leroy wrote:
>>>
>>>> At the time being, an early hash table is set up when
>>>> CONFIG_KASAN is selected.
>>>>
>>>> There is nothing wrong with setting such an early hash table
>>>> all the time, even if it is not used. This is a statically
>>>> allocated 256 kB table which lies in the init data section.
>>>>
>>>> This makes the code simpler and may in the future allow to
>>>> setup early IO mappings with fixmap instead of hard coding BATs.
>>>>
>>>> Put create_hpte() and flush_hash_pages() in the .ref.text section
>>>> in order to avoid warning for the reference to early_hash[]. This
>>>> reference is removed by MMU_init_hw_patch() before init memory is
>>>> freed.
>>>
>>> This breaks booting on the iBook G4.
>>
>> Do you get an oops or anything?
>
> Nope, nothing at all.
>

Under qemu it was working.

Can you share your .config, or are you using one of the defconfig ?

Christophe

