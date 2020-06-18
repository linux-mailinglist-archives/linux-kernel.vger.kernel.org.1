Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EA61FDAA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 02:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgFRA7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 20:59:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44017 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgFRA7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 20:59:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49nNr75wQ5z9sRk;
        Thu, 18 Jun 2020 10:59:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1592441975;
        bh=qmXRTmD0XXQMfKVo3pxn2oPU3y5lkMj8sRZH20/xwX0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mnAhUsrRANY7fLC+sIrDajU2ch9kH6NkcN22LweN7aABIXwDIjKDUGX1dk+D3bfAK
         b6DvE8HJLNF+hwc5A79MuZcn1bl3zdw75XnBKEMTcE/UEr3MHvNkkEIjNlpQ3joZEN
         X8z8fFYRDOZkMd5QHqNdobc5492ibwBzM1sKJy2NWVIMjaxyKcEJ54Ig2x/KvSlU29
         VoH5DggE42uB7QqH3HcONKaCpPw6oNE2FY6S8XUcxUmAq2sOsZ+p5TMfkvRdBFUq1C
         wHdWguf+r9APXCk7EulwVmiGYHt5ckGIqzn8wR/VPg9J3kT8NSbxTmJfO/vC8rlEdP
         eI/JkJeeYoVKw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/3] powerpc/8xx: Provide ptep_get() with 16k pages
In-Reply-To: <0bb024ce-11aa-80dc-c7d8-d5acc5329f25@csgroup.eu>
References: <cover.1592225557.git.christophe.leroy@csgroup.eu> <341688399c1b102756046d19ea6ce39db1ae4742.1592225558.git.christophe.leroy@csgroup.eu> <20200615132244.GR2531@hirez.programming.kicks-ass.net> <87wo45db8d.fsf@mpe.ellerman.id.au> <20200617143826.GJ2531@hirez.programming.kicks-ass.net> <0bb024ce-11aa-80dc-c7d8-d5acc5329f25@csgroup.eu>
Date:   Thu, 18 Jun 2020 11:00:05 +1000
Message-ID: <87o8phchnu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 17/06/2020 =C3=A0 16:38, Peter Zijlstra a =C3=A9crit=C2=A0:
>> On Thu, Jun 18, 2020 at 12:21:22AM +1000, Michael Ellerman wrote:
>>> Peter Zijlstra <peterz@infradead.org> writes:
>>>> On Mon, Jun 15, 2020 at 12:57:59PM +0000, Christophe Leroy wrote:
>>=20
>>>>> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
>>>>> +#define __HAVE_ARCH_PTEP_GET
>>>>> +static inline pte_t ptep_get(pte_t *ptep)
>>>>> +{
>>>>> +	pte_t pte =3D {READ_ONCE(ptep->pte), 0, 0, 0};
>>>>> +
>>>>> +	return pte;
>>>>> +}
>>>>> +#endif
>>>>
>>>> Would it make sense to have a comment with this magic? The casual read=
er
>>>> might wonder WTH just happened when he stumbles on this :-)
>>>
>>> I tried writing a helpful comment but it's too late for my brain to form
>>> sensible sentences.
>>>
>>> Christophe can you send a follow-up with a comment explaining it? In
>>> particular the zero entries stand out, it's kind of subtle that those
>>> entries are only populated with the right value when we write to the
>>> page table.
>>=20
>> static inline pte_t ptep_get(pte_t *ptep)
>> {
>> 	unsigned long val =3D READ_ONCE(ptep->pte);
>> 	/* 16K pages have 4 identical value 4K entries */
>> 	pte_t pte =3D {val, val, val, val);
>> 	return pte;
>> }
>>=20
>> Maybe something like that?
>
> This should work as well. Indeed nobody cares about what's in the other=20
> three. They are only there to ensure that ptep++ increases the ptep=20
> pointer by 16 bytes. Only the HW require 4 identical values, that's=20
> taken care of in set_pte_at() and pte_update().

Right, but it seems less error-prone to have the in-memory
representation match what we have in the page table (well that's
in-memory too but you know what I mean).

> So we should use the most efficient. Thinking once more, maybe what you=20
> propose is the most efficient as there is no need to load another=20
> register with value 0 in order to write it in the stack.

On 64-bit I'd say it makes zero difference, the only thing that's going
to matter is the load from ptep->pte. I don't know whether that's true
on the 8xx cores though.

cheers
