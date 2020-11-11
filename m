Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73B92AF9B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgKKUZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:25:46 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:20466 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgKKUZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1605126345;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=B8CU2tP8gxUFaVy1zF1lJfac2UVVXYDnMhU0pUnJuyo=;
  b=R1FE5Giec6er/3CF8CnhtcJikSocheNWZaMBQh/hqWKw9gRNTpd6XqsM
   fHV1HmYgQ37shiSKzHEf6JpHtUTx9x9sFQK5oR8olJwgOyoqb6iF+V9hw
   OlERkCOvKHChXaLtilLz9UgVzytp+o4mDlyqqxDBVlBwG/f2Zo92Y8vyN
   U=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: UcjWr9oFnsYXSeF/cgIZywvC3suXI20Pr7WA4jkpLaG+ZAdS5m7wGVi2eolgLjW92dUYTgEndi
 3PsfYIMCrfOx9zRlGBg42ioNYXAG8IU5C4AiIqvMjrgRSuie2I56TyCC5pqJ25xAdj65YCgLC9
 NmGn70lv8RvK3x7N5XvFUnqJiH5TPcLAvjyUnw3c/5MgDdnV2nGljTj/4zBO0MlXV9rzpoftw5
 X2MMrnqQAxmQR6zoxvYO7XjBI3K8Udep0Rnb5FAS5MzrHEYSmP15ETUXmM7nNx2mj6kxjV+C/9
 ykM=
X-SBRS: None
X-MesageID: 30952152
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,470,1596513600"; 
   d="scan'208";a="30952152"
Subject: Re: WARNING: can't access registers at asm_common_interrupt
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, <jgross@suse.com>,
        <x86@kernel.org>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201111170536.arx2zbn4ngvjoov7@treble>
 <20201111174736.GH2628@hirez.programming.kicks-ass.net>
 <20201111181328.mbxcz2uap2vnqpxq@treble>
 <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
 <20201111194206.GK2628@hirez.programming.kicks-ass.net>
 <20201111195900.2x7kfce2ejkmrzi3@treble>
 <20201111200730.GM2628@hirez.programming.kicks-ass.net>
 <20201111201506.bftpmx4svxn376tn@treble>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com>
Date:   Wed, 11 Nov 2020 20:25:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111201506.bftpmx4svxn376tn@treble>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 FTLPEX02CL04.citrite.net (10.13.108.177)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2020 20:15, Josh Poimboeuf wrote:
> On Wed, Nov 11, 2020 at 09:07:30PM +0100, Peter Zijlstra wrote:
>> On Wed, Nov 11, 2020 at 01:59:00PM -0600, Josh Poimboeuf wrote:
>>> On Wed, Nov 11, 2020 at 08:42:06PM +0100, Peter Zijlstra wrote:
>>>>> Would objtool have an easier time coping if this were implemented in
>>>>> terms of a static call?
>>>> I doubt it, the big problem is that there is no visibility into the
>>>> actual alternative text. Runtime patching fragments into static call
>>>> would have the exact same problem.
>>>>
>>>> Something that _might_ maybe work is trying to morph the immediate
>>>> fragments into an alternative. That is, instead of this:
>>>>
>>>> static inline notrace unsigned long arch_local_save_flags(void)
>>>> {
>>>> 	return PVOP_CALLEE0(unsigned long, irq.save_fl);
>>>> }
>>>>
>>>> Write it something like:
>>>>
>>>> static inline notrace unsigned long arch_local_save_flags(void)
>>>> {
>>>> 	PVOP_CALL_ARGS;
>>>> 	PVOP_TEST_NULL(irq.save_fl);
>>>> 	asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),
>>>> 					"PUSHF; POP _ASM_AX",
>>>> 					X86_FEATURE_NATIVE)
>>>> 			    : CLBR_RET_REG, ASM_CALL_CONSTRAINT
>>>> 			    : paravirt_type(irq.save_fl.func),
>>>> 			      paravirt_clobber(PVOP_CALLEE_CLOBBERS)
>>>> 			    : "memory", "cc");
>>>> 	return __eax;
>>>> }
>>>>
>>>> And then we have to teach objtool how to deal with conflicting
>>>> alternatives...
>>>>
>>>> That would remove most (all, if we can figure out a form that deals with
>>>> the spinlock fragments) of paravirt_patch.c
>>>>
>>>> Hmm?
>>> I was going to suggest something similar.  Though I would try to take it
>>> further and replace paravirt_patch_default() with static calls.
>> Possible, we just need to be _really_ careful to not allow changing
>> those static_call()s. So maybe we need DEFINE_STATIC_CALL_RO() which
>> does a __ro_after_init on the whole thing.
> But what if you want to live migrate to another hypervisor ;-)

The same as what happens currently.  The user gets to keep all the
resulting pieces ;)

>>> Either way it doesn't make objtool's job much easier.  But it would be
>>> nice to consolidate runtime patching mechanisms and get rid of
>>> .parainstructions.
>> I think the above (combining alternative and paravirt/static_call) does
>> make objtool's job easier, since then we at least have the actual
>> alternative instructions available to inspect, or am I mis-understanding
>> things?
> Right, it makes objtool's job a _little_ easier, since it already knows
> how to read alternatives.  But it still has to learn to deal with the
> conflicting stack layouts.

I suppose the needed abstraction is "these blocks will start and end
with the same stack layout", while allowing the internals to diverge.

~Andrew
