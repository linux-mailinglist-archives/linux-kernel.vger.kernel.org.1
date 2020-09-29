Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F5C27BC62
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 07:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgI2FW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 01:22:28 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15732 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI2FW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 01:22:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C0nnq3k18z9txQT;
        Tue, 29 Sep 2020 07:22:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lnYKuqP2bhMx; Tue, 29 Sep 2020 07:22:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C0nnq1fnkz9txQS;
        Tue, 29 Sep 2020 07:22:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 484198B7A0;
        Tue, 29 Sep 2020 07:22:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ojAmBESzPYes; Tue, 29 Sep 2020 07:22:24 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C94318B79F;
        Tue, 29 Sep 2020 07:22:23 +0200 (CEST)
Subject: Re: [PATCH v2 23/25] powerpc/signal: Create 'unsafe' versions of
 copy_[ck][fpr/vsx]_to_user()
To:     "Christopher M. Riedl" <cmr@informatik.wtf>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <C5ZHGD1JVX0H.1UI1PWMZN73UX@geist>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a14a82a6-74c2-cc0a-8c6b-46e571cadb7d@csgroup.eu>
Date:   Tue, 29 Sep 2020 07:22:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <C5ZHGD1JVX0H.1UI1PWMZN73UX@geist>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/09/2020 à 04:04, Christopher M. Riedl a écrit :
> On Tue Aug 18, 2020 at 12:19 PM CDT, Christophe Leroy wrote:
>> For the non VSX version, that's trivial. Just use unsafe_copy_to_user()
>> instead of __copy_to_user().
>>
>> For the VSX version, remove the intermediate step through a buffer and
>> use unsafe_put_user() directly. This generates a far smaller code which
>> is acceptable to inline, see below:
>>
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>> arch/powerpc/kernel/signal.h | 53 ++++++++++++++++++++++++++++++++++++
>> 1 file changed, 53 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
>> index f610cfafa478..2559a681536e 100644
>> --- a/arch/powerpc/kernel/signal.h
>> +++ b/arch/powerpc/kernel/signal.h
>> @@ -32,7 +32,54 @@ unsigned long copy_fpr_to_user(void __user *to,
>> struct task_struct *task);
>> unsigned long copy_ckfpr_to_user(void __user *to, struct task_struct
>> *task);
>> unsigned long copy_fpr_from_user(struct task_struct *task, void __user
>> *from);
>> unsigned long copy_ckfpr_from_user(struct task_struct *task, void __user
>> *from);
>> +
>> +#define unsafe_copy_fpr_to_user(to, task, label) do { \
>> + struct task_struct *__t = task; \
>> + u64 __user *buf = (u64 __user *)to; \
>> + int i; \
>> + \
>> + for (i = 0; i < ELF_NFPREG - 1 ; i++) \
>> + unsafe_put_user(__t->thread.TS_FPR(i), &buf[i], label); \
>> + unsafe_put_user(__t->thread.fp_state.fpscr, &buf[i], label); \
>> +} while (0)
>> +
> 
> I've been working on the PPC64 side of this "unsafe" rework using this
> series as a basis. One question here - I don't really understand what
> the benefit of re-implementing this logic in macros (similarly for the
> other copy_* functions below) is?

Not sure either.

The whole purpose is to not manage the error through a local var but exclusively use labels.
However, GCC is probably smart enough to understand it and drop the local var while inlining.

One important thing however is to make sure we won't end up with an outline function, otherwise you 
completely loose the benefit of the label stuff. And you get a function call inside a user access, 
which is what we want to avoid.

> 
> I am considering  a "__unsafe_copy_*" implementation in signal.c for
> each (just the original implementation w/ using the "unsafe_" variants
> of the uaccess stuff) which gets called by the "safe" functions w/ the
> appropriate "user_*_access_begin/user_*_access_end". Something like
> (pseudo-ish code):

Good idea, however ...

> 
> 	/* signal.c */
> 	unsigned long __unsafe_copy_fpr_to_user(...)
> 	{
> 		...
> 		unsafe_copy_to_user(..., bad);
> 		return 0;
> 	bad:
> 		return 1; /* -EFAULT? */
> 	}

This __unsafe_copy_fpr_to_user() has to be in signal.h and must be tagged 'static __always_inline' 
for the reasons explained above.

> 
> 	unsigned long copy_fpr_to_user(...)
> 	{
> 		unsigned long err;
> 		if (!user_write_access_begin(...))
> 			return 1; /* -EFAULT? */
> 
> 		err = __unsafe_copy_fpr_to_user(...);
> 
> 		user_write_access_end();
> 		return err;
> 	}
> 
> 	/* signal.h */
> 	unsigned long __unsafe_copy_fpr_to_user(...);
> 	#define unsafe_copy_fpr_to_user(..., label) \
> 		unsafe_op_wrap(__unsafe_copy_fpr_to_user(...), label)
> 
> This way there is a single implementation for each copy routine "body".
> The "unsafe" wrappers then just exist as simple macros similar to what
> x86 does: "unsafe_" macro wraps "__unsafe" functions for the goto label.

Yes, good point.

Christophe
