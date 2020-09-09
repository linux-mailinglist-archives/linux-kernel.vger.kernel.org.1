Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50496262718
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 08:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgIIGUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 02:20:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:58959 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgIIGUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:20:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BmX2G04lVz9v0Yn;
        Wed,  9 Sep 2020 08:20:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id yEORPIhV6Rga; Wed,  9 Sep 2020 08:20:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BmX2F6N82z9v0Ym;
        Wed,  9 Sep 2020 08:20:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B2DFA8B7D5;
        Wed,  9 Sep 2020 08:20:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9mJYFD7ibOLa; Wed,  9 Sep 2020 08:20:38 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7011A8B7D4;
        Wed,  9 Sep 2020 08:20:37 +0200 (CEST)
Subject: Re: [PATCH v1 4/5] powerpc/fault: Avoid heavy
 search_exception_tables() verification
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <7baae4086cbb9ffb08c933b065ff7d29dbc03dd6.1596734104.git.christophe.leroy@csgroup.eu>
 <b07bac7a882c69deb9e6c8f234a68b3022f29072.1596734105.git.christophe.leroy@csgroup.eu>
 <871rjb5vv4.fsf@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1ded5e11-a9e0-a98f-295c-c623e0a5ed36@csgroup.eu>
Date:   Wed, 9 Sep 2020 08:20:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <871rjb5vv4.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/09/2020 à 08:04, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> search_exception_tables() is an heavy operation, we have to avoid it.
>> When KUAP is selected, we'll know the fault has been blocked by KUAP.
>> Otherwise, it behaves just as if the address was already in the TLBs
>> and no fault was generated.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/mm/fault.c | 20 +++++---------------
>>   1 file changed, 5 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index 525e0c2b5406..edde169ba3a6 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -214,24 +214,14 @@ static bool bad_kernel_fault(struct pt_regs *regs, unsigned long error_code,
>>   	if (address >= TASK_SIZE)
>>   		return true;
>>   
>> -	if (!is_exec && (error_code & DSISR_PROTFAULT) &&
>> -	    !search_exception_tables(regs->nip)) {
>> +	// Read/write fault blocked by KUAP is bad, it can never succeed.
>> +	if (bad_kuap_fault(regs, address, is_write)) {
>>   		pr_crit_ratelimited("Kernel attempted to access user page (%lx) - exploit attempt? (uid: %d)\n",
>> -				    address,
>> -				    from_kuid(&init_user_ns, current_uid()));
>> -	}
>> -
>> -	// Fault on user outside of certain regions (eg. copy_tofrom_user()) is bad
>> -	if (!search_exception_tables(regs->nip))
>> -		return true;
> 
> We still need to keep this ? Without that we detect the lack of
> exception tables pretty late.

Is that a problem at all to detect the lack of exception tables late ?
That case is very unlikely and will lead to failure anyway. So, is it 
worth impacting performance of the likely case which will always have an 
exception table and where we expect the exception to run as fast as 
possible ?

The other architectures I have looked at (arm64 and x86) only have the 
exception table search together with the down_read_trylock(&mm->mmap_sem).

Christophe
