Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA16272125
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIUKba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:31:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58688 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726341AbgIUKb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600684288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=582LE91wvOb0dxTks9KY6oGgH9j0IEwNP4vk4LiNEM0=;
        b=do/7AnE2z9DJz2efGohD+L0A3HKc066YKPEtgJe9C7WL4gZiVAn3aOMt4OoKu1IQnq5ukR
        44ax8bqO459lBM6nPTc24F7tYpGBMh6EUoojHLjLFib0I9k01FxFdVH331sriMV0zHljcI
        FrSw6Q89CLS7jGLPwqEAiMwp+f+8AhM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-BTMFpYtJMjieods1IS0NYg-1; Mon, 21 Sep 2020 06:31:26 -0400
X-MC-Unique: BTMFpYtJMjieods1IS0NYg-1
Received: by mail-wr1-f71.google.com with SMTP id o6so5671230wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=582LE91wvOb0dxTks9KY6oGgH9j0IEwNP4vk4LiNEM0=;
        b=ney9YGEkGdud+LAF20Uf3UIfNL/12YHhiNhVGyOZYHYr+YpUi5Xa6nNJAxdj+bqMh1
         oQmqpK8sA3SQ8cssYfjcy2I6ftw4SEexf7piAKP6eRPrriSKeQfDv6NTltdbp4aFMiZl
         DyRKiru8ALoPZCBI1C0Vqg7lloSudPSe9L1xEHnpC3585ICHKSLGZv8QQCYZy3oNk4Qj
         F++9EsMmqLHrACHhS/eSXeRrFWRbOYGNOJXr7zDR2wisJtnuWq+Q5hyj82O7jZBe+Ant
         Qa/udxt6Mgw7U9L0LQKDEbocTp2YRT6BdrVVC1HFkHjzpolaXn/BuXD33bgGkfFvI0Jb
         POPg==
X-Gm-Message-State: AOAM530nmuYoiwWbpu3OiT0rUDlitV3/z3Aw+/0QeP8tbLwlJkqcqgHA
        ZKc0KAvXVxQ4eB5i6vZxTN64ZzDyHORzT7k0Vdivkj24TaQs2eGXKuxSvl/c/57cn3GKWjucZLp
        XvG0quP/HUxKTI7JPpLDDrGRT
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr55387410wrn.394.1600684285250;
        Mon, 21 Sep 2020 03:31:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycP1N/HM5wIR1OYX4OjK6K29hjDH+m0qfV3W8vhnxsjtNcAEjDCZMTz1sRGRMAOhyNpF8I2Q==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr55387392wrn.394.1600684285070;
        Mon, 21 Sep 2020 03:31:25 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j10sm20740145wrn.2.2020.09.21.03.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:31:24 -0700 (PDT)
Subject: Re: [PATCH 1/3] objtool: check: Fully validate the stack frame
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
References: <20200915081204.9204-1-jthierry@redhat.com>
 <20200915081204.9204-2-jthierry@redhat.com>
 <20200918205641.6nvnsib2paqa6xyn@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <9a40f898-8f6a-2ba0-1954-0d06be5e2ef8@redhat.com>
Date:   Mon, 21 Sep 2020 11:31:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918205641.6nvnsib2paqa6xyn@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/20 9:56 PM, Josh Poimboeuf wrote:
> On Tue, Sep 15, 2020 at 09:12:02AM +0100, Julien Thierry wrote:
>> A valid stack frame should contain both the return address and the
>> previous frame pointer value.
>>
>> On x86, the return value is placed on the stack by the calling
>> instructions. On other architectures, the callee need to explicitly
>> save the return value on the stack.
> 
> s/return value/return address/g
> 
>>
>> Add the necessary checks to verify a function properly sets up the all
> 
> s/the all/all the/
> 
>> the elements of the stack frame.
>>
>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
>> ---
>>   tools/objtool/arch/x86/include/cfi_regs.h |  4 ++++
>>   tools/objtool/check.c                     | 17 +++++++++++++----
>>   2 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/objtool/arch/x86/include/cfi_regs.h b/tools/objtool/arch/x86/include/cfi_regs.h
>> index 79bc517efba8..19b75b8b8439 100644
>> --- a/tools/objtool/arch/x86/include/cfi_regs.h
>> +++ b/tools/objtool/arch/x86/include/cfi_regs.h
>> @@ -22,4 +22,8 @@
>>   #define CFI_RA			16
>>   #define CFI_NUM_REGS		17
>>   
>> +#define CFA_SIZE	16
> 
> If I remember correctly, CFA (stolen from DWARF) is "Caller Frame
> Address".  It's the stack address of the caller, before the call.
> 

Ok, so maybe I'm mixing Call Frame and Stack Frame (frame pointer + 
return address).

> I get the feeling CFA_SIZE is the wrong name, because CFA is an address,
> and its size isn't 16 bytes.  But I'm not quite sure what this is
> supposed to represent.  Is it supposed to be the size of the frame
> pointer + return address?  Isn't that always going to be 16 bytes for
> both arches?
> 

For arm64 and x86_64 it is. Maybe it is a bit early to consider it might 
differ for other arches (e.g. 32bit arches?).

>> +#define CFA_BP_OFFSET	-16
>> +#define CFA_RA_OFFSET	-8
>> +
>>   #endif /* _OBJTOOL_CFI_REGS_H */
>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>> index 500f63b3dcff..7db6761d28c2 100644
>> --- a/tools/objtool/check.c
>> +++ b/tools/objtool/check.c
>> @@ -1669,12 +1669,20 @@ static bool has_modified_stack_frame(struct instruction *insn, struct insn_state
>>   	return false;
>>   }
>>   
>> +static bool check_reg_frame_pos(const struct cfi_reg *reg, int cfa_start,
>> +				int expected_offset)
>> +{
>> +	return reg->base == CFI_CFA &&
>> +	       reg->offset == cfa_start + expected_offset;
>> +}
>> +
>>   static bool has_valid_stack_frame(struct insn_state *state)
>>   {
>>   	struct cfi_state *cfi = &state->cfi;
>>   
>> -	if (cfi->cfa.base == CFI_BP && cfi->regs[CFI_BP].base == CFI_CFA &&
>> -	    cfi->regs[CFI_BP].offset == -16)
>> +	if (cfi->cfa.base == CFI_BP && cfi->cfa.offset >= CFA_SIZE &&
> 
> Why '>=' rather than '=='?
> 

Because on arm64 the stack frame is not necessarily the first thing put 
on the stack by the callee. The callee is free to create the stack frame 
where it wants (on its part of the stack of course) as long as it 
appropriately sets the frame pointer before making a call.

You could have something like:

+------------+
|            |
|            |
+------------+----> f1() called
|            |
| some callee|
| saved regs |
|            |
+------------+
|     RA     |
+------------+
|     BP/FP  |
+------------+----> Set new BP/FP value


>> +	    check_reg_frame_pos(&cfi->regs[CFI_BP], -cfi->cfa.offset + CFA_SIZE, CFA_BP_OFFSET) &&
>> +	    check_reg_frame_pos(&cfi->regs[CFI_RA], -cfi->cfa.offset + CFA_SIZE, CFA_RA_OFFSET))
> 
> Isn't '-cfi->cfa.offset + CFA_SIZE' always going to be zero?
> 

For x86 yes, for arm64 it cfa.offset can be > 16.

-- 
Julien Thierry

