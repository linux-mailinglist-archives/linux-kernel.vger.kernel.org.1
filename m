Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135F22F6B13
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbhANTgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbhANTgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:36:24 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB9FC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:35:44 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4DGvg13yKMz1ytN;
        Thu, 14 Jan 2021 20:35:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1610652941; bh=de+pBzXAzJwepONbQjP7iqSuI2JkLmJmg7UuVBCtgEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From:To:CC:
         Subject;
        b=CZGo7964rVXfUvV8hBXZdZVMG7OmG9MvjtECoilmjCG1fi874FlOm21MHNFFeAt7Q
         jdU+qVNxQ7jFMVULiqMvZPtVwRC5cQuUroYdtj7jdOLIpNiqOjS7pqucVPFbkGj35R
         +q09Y/+r57Fcvw+UolAeOljLhDq8/gd+R9QHZqR65v4JfalaGSXA5j7lRWYq4NavBN
         1+bMHDxbv1yDRP2zI23rgpIb4dT/GK387GfVtX8QvuEVllgb9sI7+pB0tm5k1IbzFY
         G1yNhZtI0yuNV1a+5iZ9VjuN+CXwQOBGbTVYQfRBzXquLa53mLKmyMKW+ccmRnA2Jr
         gzDQkQTB6nkPQ==
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.11.37
Received: from faumail.fau.de (smtp-auth.uni-erlangen.de [131.188.11.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX195D09qed3669YEWw4lZvkQBCaebwwsxvI=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4DGvfz047Kz1yKf;
        Thu, 14 Jan 2021 20:35:38 +0100 (CET)
Received: from
 4XWkPblvWqRm7TCp/1hlK7xrRM4vHXx22i8FjIPxy6I47i8YKhF4HLmQ9lSNsJScVvQ+MNw2lDH4LwJPNIBlrw==
 by faumail.uni-erlangen.de
 with HTTP (HTTP/1.1 POST); Thu, 14 Jan 2021 20:35:38 +0100
MIME-Version: 1.0
Date:   Thu, 14 Jan 2021 20:35:38 +0100
From:   "Hack, Vanessa" <vanessa.hack@fau.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: objtool/ORC generation for noreturn functions
In-Reply-To: <20210113184131.yh4zh4olfkdpydv7@treble>
References: <daf04159-a458-4f0d-9f29-d8ef5a63fae6@email.android.com>
 <20210113184131.yh4zh4olfkdpydv7@treble>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <126f2c2ccadebcba37864453135d95d7@fau.de>
X-Sender: vanessa.hack@fau.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-01-13 19:41, schrieb Josh Poimboeuf:
> On Wed, Jan 13, 2021 at 11:44:22AM +0100, vanessa.hack@fau.de wrote:
>>    Hi,
>>    I am currently writing my final thesis at university on the topic 
>> of stack
>>    unwinding. My goal is to implement and evaluate stack unwinders for
>>    research operating system ports to x86 32 and 64 bit architectures 
>> and
>>    SPARC V8. 
>>    For the x86 ports I chose ORC as unwinding format due to its 
>> simplicity
>>    and reliability. So far, it works quite well (although I've ran 
>> into some
>>    minor issues with objtool as the research OS is written in C++). 
>>    But now I have some problems with functions that are explicitly 
>> marked as
>>    noreturn with the [[noreturn]] attribute, all following unwinding 
>> steps
>>    are unreliable. I have read in the objtool documentation that such
>>    functions have to be added to the objtool global_noreturn array.
>>    Unfortunately, I do not understand the purpose of that array and 
>> the
>>    intended ORC behaviour for noreturn functions. Are the unwinding 
>> steps
>>    that follow a noreturn intended to be unreliable? 
> 
> Hi Vanessa,
> 
> Nice thesis!  I'm impressed (and a little surprised) that objtool/ORC 
> is
> working in a non-Linux environment.  They were designed to be general
> purpose, but we've added some Linux-isms to them over the years.
> Congrats on getting that working.

Hi Josh,

thank you for your fast and very helpful answer! It actually worked 
quite well, the biggest problems occured due to C++ name mangling and 
relative switch jump tables. It is a lot clearer to me now.

> 
> What compiler is the OS built with?

It has to be built with gcc, but no specific version is required. In my 
case, I used gcc 8.3.0.

> 
> As you've found, noreturn functions can be problematic.  But they can 
> be
> unwinded through correctly, if handled carefully.
> 
> 
> 1) Objtool impact
> 
> Consider the following code pattern, generated by a C compiler:
> 
> func_A:
> 	...
> 	...
> 	call some_noreturn_func
> 
> func_B:
> 
> If some_noreturn_func() were to return, func_A() would fall through to
> func_B(), resulting in possibly disastrous undefined behavior.  But
> since some_noreturn_func() doesn't return, that can't happen.  The
> compiler knows it can't happen because of the noreturn attribute.
> 
> But if objtool doesn't know about the noreturn attribute, it assumes 
> the
> call can return, and execution can continue after it, resulting in the
> fallthrough:
> 
>   warning: objtool: func_A() falls through to next function func_B()
> 
> So that's the reason for the global_noreturn array.  It lets objtool
> know that execution doesn't continue after the call, so objtool can
> follow the code flow intended by the compiler.
> 
> Note that in addition, objtool tries to detect calls to noreturn
> functions in the same .o file, even if they don't have the noreturn
> attribute.  This matches GCC behavior, which automatically marks them 
> as
> noreturn even if they're missing the annotation.
> 
> 
> 2) ORC impact
> 
> Usually, an address on the stack is placed there by a call instruction,
> which pushes the return address on the stack before jumping to the
> called function.  The return address is the instruction *after* the 
> call
> instruction.  If you use that address to lookup the ORC entry, it will
> be right most of the time, because the call instruction doesn't change
> the stack layout, so the next instruction usually has the same stack
> layout as the call instruction.
> 
> However, if the call is to a noreturn function, then the next
> instruction might not have the same stack layout.  For example, in the
> above scenario with the call to some_noreturn_func().  After the call,
> the address placed on the stack will be that of func_B(), because that
> happens to be the instruction after the call.  But func_B() probably 
> has
> a different layout, so passing the address of func_B() to the ORC 
> lookup
> will corrupt the unwind.
> 
> What you really want to use for the lookup is the address of the call
> instruction itself.  In the case of ORC you can just subtract one from
> the address on the stack.
> 
> This is described in orc_unwind.c:
> 
> 	 * For a call frame (as opposed to a signal frame), state->ip points 
> to
> 	 * the instruction after the call.  That instruction's stack layout
> 	 * could be different from the call instruction's layout, for example
> 	 * if the call was to a noreturn function.  So get the ORC data for 
> the
> 	 * call instruction itself.
> 	 */
> 	orc = orc_find(state->signal ? state->ip : state->ip - 1);
> 
> Notice there's one edge case where you *don't* subtract one from the
> address.  That's when the address is placed on the stack for a reason
> *other* than a call.
> 
> That can happen in a "signal" frame, where an interrupt/signal handler
> places the preempted task's registers on the stack.  In that case the
> ORC type is UNWIND_HINT_TYPE_REGS and the address is retrieved from
> regs->sp, which is used as-is (without subtracting one), because there
> was no call.
> 
> 
> I hope that makes sense.  Let me know if you have any more questions.

Substracting 1 from the instruction pointer made it work :-) Thank you 
again! The unwinder now seems to figure out reliable and unreliable 
stack addresses for 'standard' call chains that only consist of regular 
calls.

> 
> Also, please let me know when the paper is available to read :-)

Of course, I will send you a link when the thesis is finished.

Regards,
Vanessa
