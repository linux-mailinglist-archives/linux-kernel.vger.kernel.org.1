Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA20221337E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 07:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgGCF1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 01:27:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:16684 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCF1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 01:27:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49yk4X4kGBz9tyNx;
        Fri,  3 Jul 2020 07:27:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 2XeHCBp9pS9h; Fri,  3 Jul 2020 07:27:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49yk4X3tDtz9tyNw;
        Fri,  3 Jul 2020 07:27:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AB22E8BB2C;
        Fri,  3 Jul 2020 07:27:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WlNZi18th2PB; Fri,  3 Jul 2020 07:27:41 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9AB0D8BB2A;
        Fri,  3 Jul 2020 07:27:40 +0200 (CEST)
Subject: Re: objtool clac/stac handling change..
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
 <20200701184131.GI2786714@ZenIV.linux.org.uk>
 <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
 <20200701195914.GK2786714@ZenIV.linux.org.uk>
 <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au>
 <8be7cf19-9fc9-ce9c-091f-c8824a01a3c8@csgroup.eu>
 <87h7up70e5.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a449e55b-7a8d-5acd-fc2f-acd1eb9ae252@csgroup.eu>
Date:   Fri, 3 Jul 2020 07:27:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87h7up70e5.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/07/2020 à 05:17, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> Le 02/07/2020 à 15:34, Michael Ellerman a écrit :
>>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>>> On Wed, Jul 1, 2020 at 12:59 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>>> On Wed, Jul 01, 2020 at 12:04:36PM -0700, Linus Torvalds wrote:
>>>>>>
>>>>>> That's actually for the access granting. Shutting the access down ends
>>>>>> up always doing the same thing anyway..
>>>>>
>>>>> #define user_read_access_end            prevent_current_read_from_user
>>>>> #define user_write_access_end           prevent_current_write_to_user
>>>>> static inline void prevent_current_read_from_user(void)
>>>>> {
>>>>>           prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_READ);
>>>>> }
>>>>>
>>>>> static inline void prevent_current_write_to_user(void)
>>>>> {
>>>>>           prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_WRITE);
>>>>> }
>>>>>
>>>>> and prevent_user_access() has instances that do care about the direction...
>>>>
>>>> Go and look closer.
>>>>
>>>> There are three cases:
>>>>
>>>>    (a) the 32-bit book3s case. It looks like it cares, but when you look
>>>> closer, it ends up not caring about the read side, and saving the
>>>> "which address to I allow user writes to" in current->thread.kuap
>>>>
>>>>    (b) the nohash 32-bit case - doesn't care
>>>>
>>>>    (c) the 64-bit books case - doesn't care
>>>>
>>>> So yes, in the (a) case it does make a difference between reads and
>>>> writes, but at least as far as I can tell, it ignores the read case,
>>>> and has code to avoid the unnecessary "disable user writes" case when
>>>> there was only a read enable done.
>>>
>>> Yeah that's my understanding too.
>>>
>>> Christophe is the expert on that code so I'll defer to him if I'm wrong.
>>>
>>>> Now, it's possible that I'm wrong, but the upshot of that is that even
>>>> on powerpc, I think that if we just made the rule be that "taking a
>>>> user exception should automatically do the 'user_access_end()' for us"
>>>> is trivial.
>>>
>>> I think we can do something to make it work.
>>>
>>> We don't have an equivalent of x86's ex_handler_uaccess(), so it's not
>>> quite as easy as whacking a user_access_end() in there.
>>
>> Isn't it something easy to do in bad_page_fault() ?
> 
> We'd need to do it there at least.
> 
> But I'm not convinced that's the only place we'd need to do it. We could
> theoretically take a machine check on a user access, and those are
> handled differently on each sub-(sub-sub)-platform, and I think all or
> most of them don't call bad_page_fault().

Indeed, it needs to be done everywhere we do

	regs->nip = extable_fixup(entry)

There are half a dozen of places that do that, in additional of 
bad_page_fault() that's mainly machine checks, also kprobe.

I think we can create a fixup_exception() function which takes regs and 
entry as parameters and does the nip fixup and kuap closuse.

> 
>> Not exactly a call to user_access_end() but altering regs->kuap so that
>> user access is not restored on exception exit.
> 
> Yes.
> 
>>> Probably the simplest option for us is to just handle it in our
>>> unsafe_op_wrap(). I'll try and come up with something tomorrow.
>>
>> unsafe_op_wrap() is not used anymore for unsafe_put_user() as we are now
>> using asm goto.
> 
> Sure, but we could change it back to use unsafe_op_wrap().

But the whole purpose of using goto in unsafe_???_user() is to allow the 
use of asm goto. See explanations in commit 
https://github.com/linuxppc/linux/commit/1bd4403d86a1c06cb6cc9ac87664a0c9d3413d51#diff-eba084de047bb8a9087dac10c06f44bc


> 
> I did a quick hack to do that and see no difference in the generated
> code, but your commit adding put_user_goto() did show better code
> generation, so possibly it depends on compiler version, or my example
> wasn't complicated enough (filldir()).

Yes as explained above it should remove the error checking in the caller 
so your exemple was most likely too trivial.

Christophe
