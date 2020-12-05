Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D294C2CFEC4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 21:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgLEUVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 15:21:44 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:58575 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbgLEUVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 15:21:43 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Cp8N95t0Tz9v0WS;
        Sat,  5 Dec 2020 13:42:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Aetkluoxj2BP; Sat,  5 Dec 2020 13:42:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Cp8N94zy2z9v0KH;
        Sat,  5 Dec 2020 13:42:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7AE4A8B77F;
        Sat,  5 Dec 2020 13:41:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LW1N9ujtEu1S; Sat,  5 Dec 2020 13:41:58 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DDB928B75B;
        Sat,  5 Dec 2020 13:41:57 +0100 (CET)
Subject: Re: [PATCH] powerpc/mm: Fix KUAP warning by providing
 copy_from_kernel_nofault_allowed()
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <e559e60c43f679195bfe4c7b0a301431c6f02c7a.1607157766.git.christophe.leroy@csgroup.eu>
 <20201205084804.GA25452@lst.de>
 <0ede82c3-d4e9-6ce6-0590-6254272c3ae2@csgroup.eu>
Message-ID: <d7a9c47a-d539-d83e-7707-6b72cbcdfe93@csgroup.eu>
Date:   Sat, 5 Dec 2020 13:38:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <0ede82c3-d4e9-6ce6-0590-6254272c3ae2@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/12/2020 à 10:56, Christophe Leroy a écrit :
> 
> 
> Le 05/12/2020 à 09:48, Christoph Hellwig a écrit :
>> On Sat, Dec 05, 2020 at 08:43:06AM +0000, Christophe Leroy wrote:
>>> Since commit c33165253492 ("powerpc: use non-set_fs based maccess
>>> routines"), userspace access is not granted anymore when using
>>> copy_from_kernel_nofault()
>>>
>>> However, kthread_probe_data() uses copy_from_kernel_nofault()
>>> to check validity of pointers. When the pointer is NULL,
>>> it points to userspace, leading to a KUAP fault and triggering
>>> the following big hammer warning many times when you request
>>> a sysrq "show task":
>>
>>
>>
>>> To avoid that, copy_from_kernel_nofault_allowed() is used to check
>>> whether the address is a valid kernel address. But the default
>>> version of it returns true for any address.
>>>
>>> Provide a powerpc version of copy_from_kernel_nofault_allowed()
>>> that returns false when the address is below TASK_USER_MAX,
>>> so that copy_from_kernel_nofault() will return -ERANGE.
>>
>> Looks good.  I wonder if we should just default to the TASK_SIZE_MAX
>> check in  copy_from_kernel_nofault_allowed for architectures that select
>> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE?
> 
> Yes maybe that would be better.
> 
> Can you cook a patch an get it into 5.10 ?
> 

In fact it doesn't seem so easy because only s390, powerpc and x86 have TASK_SIZE_MAX while 
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE is selected by arm, arm64, powerpc and x86

So maybe for 5.10 we take the powerpc fix ?

Christophe
