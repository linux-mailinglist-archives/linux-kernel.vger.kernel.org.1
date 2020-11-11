Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FE12AF87A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKKSqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:46:45 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:7155 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKSqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1605120404;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=z3jhtaJZLiN9XVyLCAwhBQIKtAh04ByTPeZi01LbSUQ=;
  b=LF6ZKEz37MPew3dAhlvFkvjTpfNJrKQDlaSycvC5Dvh3mgNvlpHBsK82
   W6SpkGUopYcHmv5RvnLhNzfRqNq0FBKpYkACivOZLyVRUteiinG2T2YZs
   XS2Y11czkY0c6TMrPFlhK2HeGm374L8c6QfyIFtDqsNLS59YKPX2nDdu/
   c=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: HDLk/AZWty5ZNWjWZNb8koA65e8K14mJtddMeDa99tsiYspklG0uMbgO1sx5MqHSqZ2CKVqVnL
 0cgaiFw1h+jEju4ehE157KOYrPs8UQ9e5Tbrj3s8eBm1NbSCLkpKwkiHdq2UpmXLRXGoRYvwJb
 9hs7Nf2VyA83/rQzIGQ6dLewSxFdwOUn77kZCKEQy8zct+pBwWgflPEkBxWTunR6qYV0fj7H16
 3R1N+0EmYhhvoM47XES0t8GV+kVz5OVUqgqnWu9wRTDGmU5KyqkAwTdYVUxsDrgcCmuxrgAxan
 OkQ=
X-SBRS: None
X-MesageID: 30975574
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,470,1596513600"; 
   d="scan'208";a="30975574"
Subject: Re: WARNING: can't access registers at asm_common_interrupt
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, <jgross@suse.com>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201111170536.arx2zbn4ngvjoov7@treble>
 <20201111174736.GH2628@hirez.programming.kicks-ass.net>
 <20201111181328.mbxcz2uap2vnqpxq@treble>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
Date:   Wed, 11 Nov 2020 18:46:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111181328.mbxcz2uap2vnqpxq@treble>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 FTLPEX02CL04.citrite.net (10.13.108.177)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2020 18:13, Josh Poimboeuf wrote:
> On Wed, Nov 11, 2020 at 06:47:36PM +0100, Peter Zijlstra wrote:
>> This is PARAVIRT_XXL only, which is a Xen special. My preference, as
>> always, is to kill it... Sadly the Xen people have a different opinion.
> That would be soooo nice... then we could get rid of paravirt patching
> altogether and replace it with static calls.
>
>>> Objtool doesn't know about the pushf/pop paravirt patch, so ORC gets
>>> confused by the changed stack layout.
>>>
>>> I'm thinking we either need to teach objtool how to deal with
>>> save_fl/restore_fl patches, or we need to just get rid of those nasty
>>> patches somehow.  Peter, any thoughts?
>> Don't use Xen? ;-)
>>
>> So with PARAVIRT_XXL the compiler will emit something like:
>>
>>   "CALL *pvops.save_fl"
>>
>> Which we then overwrite at runtime with "pushf; pop %[re]ax" and a few
>> NOPs.
>>
>> Now, objtool understands alternatives, and ensures they have the same
>> stack layout, it has no chance in hell of understanding this, simply
>> because paravirt_patch.c is magic.
>>
>> I don't have any immediate clever ideas, but let me ponder it a wee bit.

Well...

static_calls are a newer, and more generic, form of pvops.  Most of the
magic is to do with inlining small fragments, but static calls can do
that now too, IIRC?

>> ....
>>
>> Something really disguisting we could do is recognise the indirect call
>> offset and emit an extra ORC entry for RIP+1. So the cases are:
>>
>> 	CALL *pv_ops.save_fl	-- 7 bytes IIRC
>> 	CALL $imm;		-- 5 bytes
>> 	PUSHF; POP %[RE]AX	-- 2 bytes
>>
>> so the RIP+1 (the POP insn) will only ever exist in this case. The
>> indirect and direct call cases would never land on that IP.
> I had a similar idea, and a bit of deja vu - we may have talked about
> this before.  At least I know we talked about doing something similar
> for alternatives which muck with the stack.

The main complexity with pvops is that the

    CALL *pv_ops.save_fl

form needs to be usable from extremely early in the day (pre general
patching), hence the use of function pointers and some non-standard ABIs.

For performance reasons, the end result of this pvop wants to be `pushf;
pop %[re]ax` in then native case, and `call xen_pv_save_fl` in the Xen
case, but this doesn't mean that the compiled instruction needs to be a
function pointer to begin with.

Would objtool have an easier time coping if this were implemented in
terms of a static call?

~Andrew
