Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6927028D977
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 07:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgJNFIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 01:08:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:51622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgJNFIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 01:08:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58EA5AEE6;
        Wed, 14 Oct 2020 05:08:53 +0000 (UTC)
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
References: <20201007081909.29226-1-jslaby@suse.cz>
 <20201007145450.32yrrq75csmq7vgo@treble>
From:   Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] x86/unwind/orc: fix inactive tasks with sp in sp
Message-ID: <3d0efc97-536c-c669-934a-d2d9feaa90c7@suse.cz>
Date:   Wed, 14 Oct 2020 07:08:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007145450.32yrrq75csmq7vgo@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 10. 20, 16:54, Josh Poimboeuf wrote:
> -ENOPARSE on $SUBJECT.
> 
> Also please address it to x86@kernel.org, I think the tip maintainers
> can pick up the fix directly.

Hmm, weird, I must have sent an older version as my current patch in the 
tree has:
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org

> Also it might be a good idea to Cc the live-patching mailing list, I
> presume this causes a livepatch stall?
> 
> On Wed, Oct 07, 2020 at 10:19:09AM +0200, Jiri Slaby wrote:
>> gcc-10 optimizes the scheduler code differently than its predecessors,
>> depending on DEBUG_SECTION_MISMATCH=y config -- the config sets
>> -fno-inline-functions-called-once.
> 
> Weird.  Was GCC ignoring this flag before?

gcc 7 generated the earlier mentioned prologue (push bp; mov sp,bp). So 
we extract stack pointer from bp. gcc 10 no longer generates the 
prologue in some of the standalone functions. That's the difference. So 
we started extracting stack pointer from sp which contains more than we 
expect.

And the problem also (obviously) dismisses when gcc (even 10) inlines 
the function.

>> @@ -663,7 +656,13 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
>>   	} else {
>>   		struct inactive_task_frame *frame = (void *)task->thread.sp;
>>   
>> -		state->sp = task->thread.sp;
>> +		/*
>> +		 * @ret_addr is in __schedule _before_ the @frame is pushed to
>> +		 * the stack, but @thread.sp is saved in __switch_to_asm only
>> +		 * _after_ saving the @frame, so subtract the @frame size, i.e.
>> +		 * add it to @thread.sp.
>> +		 */
>> +		state->sp = task->thread.sp + sizeof(*frame);
> 
> IMO, the code speaks for itself and the comment may be superfluous.
> 
> Otherwise it looks good to me.  Thanks for fixing it!

OK, will resend the correct and fixed version.

thanks,
-- 
js
suse labs
