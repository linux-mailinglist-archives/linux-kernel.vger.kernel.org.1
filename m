Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E258A272126
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgIUKbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:31:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52273 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726544AbgIUKbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600684293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JS7GmvqJ3w9qW30JWeF98oiqa2xHXXEuNEaj6k8y0Uk=;
        b=MBnVmidJ/1Xx0sQKY3254IpTkEynfew3ryzl4ZUBtd1g58tU1ydyjpNmqlH9saecgosqDx
        LyhOWJQu30Z9MIUNjnz8t3MOSVa0HsR4GWBKL0GAAvz67LXBesVDz/Wsa0Z7xVk2VR3ehI
        OzdyNddTS/pAZFR+KOHbXmLA31HkTo4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-69yhrJ_ROk-WMrgCkk6Lwg-1; Mon, 21 Sep 2020 06:31:30 -0400
X-MC-Unique: 69yhrJ_ROk-WMrgCkk6Lwg-1
Received: by mail-wr1-f72.google.com with SMTP id v5so5630191wrs.17
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JS7GmvqJ3w9qW30JWeF98oiqa2xHXXEuNEaj6k8y0Uk=;
        b=J050LZej/SxzBkJ8GyoSh/RmSJvHHqT2JCY7ecGv/t6zsfqXlEVBluse6jue2yolQg
         rhntXe0Yu2bzDLq37KdyN1mUnCxS6eF1FYDrQagensTxfEKCsMblhCxPu5q76z37srVV
         5mCb0irKDJ6gbBwZ9G2ezC77Zz60Sl/dXb0YZmjBDnN5oFzinEyy+wsGTT6/wjtr2SrW
         cssXdhFKyXceKRfygTxNtitMnXQhPWw2z5kSxB49Yi1ab4iZHeR85L+w3SvZjZhFu8Fy
         HcLXFtvpcLuFGOJZEftK5vnMCav3Ex7YXINTcu9ezullUvOfaiv01VKQW2V5cgmQ/0ES
         O9bA==
X-Gm-Message-State: AOAM5322RWm/t/xfNr+exC7+nQ3afXDJcMSMqsbTJNyfpTPU5SBX1Az6
        0WOi+ZBxT/oZ4NEg8C3ab1t5BBuN1cVgOJkOFOdO1XQJ46yrcvvGXoasYndjErfio5Lr/CtTzLO
        1zBIhiZBvnve4ejHDmv2coh0g
X-Received: by 2002:adf:ef45:: with SMTP id c5mr29286849wrp.384.1600684289713;
        Mon, 21 Sep 2020 03:31:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvSfhxwrnYUJ1J2yNMJIE67LZdRTMqjtalcDhGU38r+yxBCeSHywzQGXXZGDqCgHx1tF9J+w==
X-Received: by 2002:adf:ef45:: with SMTP id c5mr29286835wrp.384.1600684289553;
        Mon, 21 Sep 2020 03:31:29 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id v204sm19240113wmg.20.2020.09.21.03.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:31:29 -0700 (PDT)
Subject: Re: [PATCH 3/3] objtool: check: Make SP memory operation match
 PUSH/POP semantics
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
References: <20200915081204.9204-1-jthierry@redhat.com>
 <20200915081204.9204-4-jthierry@redhat.com>
 <20200918214318.2d7msla53ysxkbaz@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <249188d0-d65e-c862-7cb9-7e1db05361c6@redhat.com>
Date:   Mon, 21 Sep 2020 11:31:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918214318.2d7msla53ysxkbaz@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/20 10:43 PM, Josh Poimboeuf wrote:
> On Tue, Sep 15, 2020 at 09:12:04AM +0100, Julien Thierry wrote:
>> Architectures without PUSH/POP instructions will always access the stack
>> though memory operations (SRC/DEST_INDIRECT). Make those operations have
>> the same effect on the CFA as PUSH/POP, with no stack pointer
>> modification.
>>
>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
>> ---
>>   tools/objtool/check.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>> index f45991c2db41..7ff87fa3caec 100644
>> --- a/tools/objtool/check.c
>> +++ b/tools/objtool/check.c
>> @@ -2005,6 +2005,13 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
>>   			break;
>>   
>>   		case OP_SRC_REG_INDIRECT:
>> +			if (!cfi->drap && op->dest.reg == cfa->base) {
> 
> && op->dest.reg == CFI_BP ?
> 

Does it matter? My unstandig was that the register used to point to the 
CFA is getting overwritten, so we need to fallback to something known 
which is the offset from the stack pointer.

Was that not the case?

>> +
>> +				/* mov disp(%rsp), %rbp */
>> +				cfa->base = CFI_SP;
>> +				cfa->offset = cfi->stack_size;
>> +			}
>> +
>>   			if (cfi->drap && op->src.reg == CFI_BP &&
>>   			    op->src.offset == cfi->drap_offset) {
>>   
>> @@ -2026,6 +2033,11 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
>>   				/* mov disp(%rbp), %reg */
>>   				/* mov disp(%rsp), %reg */
>>   				restore_reg(cfi, op->dest.reg);
>> +			} else if (op->src.reg == CFI_SP &&
> 
> An empty line above the else would help readability.
> 
>> +				   op->src.offset == regs[op->dest.reg].offset + cfi->stack_size) {
>> +
>> +				/* mov disp(%rsp), %reg */
>> +				restore_reg(cfi, op->dest.reg);
> 
>>   			}
>>   
>>   			break;
>> @@ -2103,6 +2115,11 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
>>   			/* mov reg, disp(%rsp) */
>>   			save_reg(cfi, op->src.reg, CFI_CFA,
>>   				 op->dest.offset - cfi->cfa.offset);
>> +		} else if (op->dest.reg == CFI_SP) {
> 
> Same here.
> 

I'll add those.

>> +
>> +			/* mov reg, disp(%rsp) */
>> +			save_reg(cfi, op->src.reg, CFI_CFA,
>> +				 op->dest.offset - cfi->stack_size);
>>   		}
>>   
>>   		break;
>> -- 
>> 2.21.3
>>
> 

-- 
Julien Thierry

