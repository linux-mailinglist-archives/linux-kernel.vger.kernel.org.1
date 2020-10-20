Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AADF293602
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405417AbgJTHon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:44:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:4714 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405401AbgJTHom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:44:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CFlyG5qpvz9tydG;
        Tue, 20 Oct 2020 09:44:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3IHYRQHHVAoQ; Tue, 20 Oct 2020 09:44:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CFlyG4bXJz9tydK;
        Tue, 20 Oct 2020 09:44:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F4BB8B7CB;
        Tue, 20 Oct 2020 09:44:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WzI1CAHp3OTQ; Tue, 20 Oct 2020 09:44:39 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B868F8B767;
        Tue, 20 Oct 2020 09:44:38 +0200 (CEST)
Subject: Re: [PATCH 3/3] powerpc: Fix pre-update addressing in inline assembly
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <5ffcb064f695d5285bf1faab91bffa3f9245fc26.1603109522.git.christophe.leroy@csgroup.eu>
 <fbcdb173cc42da62f00285dfef8c2f7d4960b5c7.1603109522.git.christophe.leroy@csgroup.eu>
 <20201019202441.GU2672@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ff158583-4e25-a5e6-5131-359423037e4f@csgroup.eu>
Date:   Tue, 20 Oct 2020 09:44:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201019202441.GU2672@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/10/2020 à 22:24, Segher Boessenkool a écrit :
> On Mon, Oct 19, 2020 at 12:12:48PM +0000, Christophe Leroy wrote:
>> In several places, inline assembly uses the "%Un" modifier
>> to enable the use of instruction with pre-update addressing,
> 
> Calling this "pre-update" is misleading: the register is not updated
> before the address is generated (or the memory access done!), and the
> addressing is exactly the same as the "non-u" insn would use.  It is
> called an "update form" instruction, because (at the same time as doing
> the memory access, logically anyway) it writes back the address used to
> the base register.
> 
>> but the associated "<>" constraint is missing.
> 
> But that is just fine.  Pointless, sure, but not a bug.

Most of those are from prehistoric code. So at some point in time it was effective. Then one day GCC 
changed it's way and they became pointless. So, not a software bug, but still a regression at some 
point.

> 
>> Use UPD_CONSTR macro everywhere %Un modifier is used.
> 
> Eww.  My poor stomach.

There are not that many :)

> 
> Have you verified that update form is *correct* in all these, and that
> we even *want* this there?

I can't see anything that would militate against it, do you ?

I guess if the elders have put %Us there, it was wanted.

Christophe
