Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71562FCB1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 07:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbhATGhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 01:37:50 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:41937 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730312AbhATGc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 01:32:29 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DLFzh1gjnz9v0KG;
        Wed, 20 Jan 2021 07:31:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id qL9e-0ptTvus; Wed, 20 Jan 2021 07:31:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DLFzh0Jf6z9v0KF;
        Wed, 20 Jan 2021 07:31:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E93E88B7DF;
        Wed, 20 Jan 2021 07:31:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bh3Vqo3ktCbr; Wed, 20 Jan 2021 07:31:44 +0100 (CET)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C92398B75F;
        Wed, 20 Jan 2021 07:31:44 +0100 (CET)
Subject: Re: [PATCH] powerpc/47x: Disable 256k page size
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <2fed79b1154c872194f98bac4422c23918325e61.1611039590.git.christophe.leroy@csgroup.eu>
 <87h7ncqhz1.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <19acabee-3a6d-d2d0-db7a-b637bd162069@csgroup.eu>
Date:   Wed, 20 Jan 2021 07:31:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <87h7ncqhz1.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 20/01/2021 à 06:45, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> PPC47x_TLBE_SIZE isn't defined for 256k pages, so
>> this size of page shall not be selected for 47x.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Fixes: e7f75ad01d59 ("powerpc/47x: Base ppc476 support")
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 107bb4319e0e..a685e42d3993 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -772,7 +772,7 @@ config PPC_64K_PAGES
>>   
>>   config PPC_256K_PAGES
>>   	bool "256k page size"
>> -	depends on 44x && !STDBINUTILS
>> +	depends on 44x && !STDBINUTILS && !PPC_47x
> 
> Do we still need this STDBINUTILS thing?
> 
> It's pretty gross, and I notice we have zero defconfigs which disable
> it, meaning it's only randconfig builds that will ever test 256K pages.
> 
> Can we just drop it and say if you enable 256K pages you need to know
> what you're doing?

I guess we can, yes. I'll send a patch for that.

Christophe

> 
