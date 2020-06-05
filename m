Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3435B1EFE28
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 18:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgFEQm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 12:42:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50572 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725961AbgFEQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591375374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bdEGpZ06r/Y0nQCCHtiMh+9RZsiujmklfqlTK0kVMWY=;
        b=C8r73mxW26ju2I5z6ra4baQ3CTWB+HOr9bT0Tt+En3AIsd9jQMe5enfAEakHI8O91GOWZ9
        Yq1ny3QitH7jN+UBGsu9niWDd5cK4MNedqsnXWOaskXhTyO0JkC+m7jdZLYcBHp+ngFgLV
        lYgmb+sf7MpHFHe+mITc17XYDMnWwsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-1-nvlzMDPPOd3JyJIWPl1w-1; Fri, 05 Jun 2020 12:42:50 -0400
X-MC-Unique: 1-nvlzMDPPOd3JyJIWPl1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E36A107ACF5;
        Fri,  5 Jun 2020 16:42:48 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EF8C19C58;
        Fri,  5 Jun 2020 16:42:45 +0000 (UTC)
Subject: Re: [PATCH] x86/split_lock: Sanitize userspace and guest error output
To:     Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20200605114459.22200-1-prarit@redhat.com>
 <96b5c5fa-6b4e-a5f4-34cc-682477a27370@intel.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <3e1f1fac-fa46-7a2a-1424-d5c931e521d7@redhat.com>
Date:   Fri, 5 Jun 2020 12:42:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <96b5c5fa-6b4e-a5f4-34cc-682477a27370@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/20 11:29 AM, Xiaoyao Li wrote:
> On 6/5/2020 7:44 PM, Prarit Bhargava wrote:
>> There are two problems with kernel messages in fatal mode that
>> were found during testing of guests and userspace programs.
>>
>> The first is that no kernel message is output when the split lock detector
>> is triggered with a userspace program.  As a result the userspace process
>> dies from receiving SIGBUS with no indication to the user of what caused
>> the process to die.
>>
>> The second problem is that only the first triggering guest causes a kernel
>> message to be output because the message is output with pr_warn_once().
>> This also results in a loss of information to the user.
>>
>> While fixing these I noticed that the same message was being output
>> three times so I'm cleaning that up too.
>>
>> Fix fatal mode output, and use consistent messages for fatal and
>> warn modes for both userspace and guests.
>>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: x86@kernel.org
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
>> Cc: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
>> Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> ---
>>   arch/x86/kernel/cpu/intel.c | 24 ++++++++++--------------
>>   1 file changed, 10 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
>> index 166d7c355896..463022aa9b7a 100644
>> --- a/arch/x86/kernel/cpu/intel.c
>> +++ b/arch/x86/kernel/cpu/intel.c
>> @@ -1074,10 +1074,14 @@ static void split_lock_init(void)
>>       split_lock_verify_msr(sld_state != sld_off);
>>   }
>>   -static void split_lock_warn(unsigned long ip)
>> +static bool split_lock_warn(unsigned long ip, int fatal)
>>   {
>> -    pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
>> -                current->comm, current->pid, ip);
>> +    pr_warn_ratelimited("#AC: %s/%d %ssplit_lock trap at address: 0x%lx\n",
>> +                current->comm, current->pid,
>> +                sld_state == sld_fatal ? "fatal " : "", ip);
>> +
>> +    if (sld_state == sld_fatal || fatal)
>> +        return false;
>>         /*
>>        * Disable the split lock detection for this task so it can make
>> @@ -1086,18 +1090,13 @@ static void split_lock_warn(unsigned long ip)
>>        */
>>       sld_update_msr(false);
>>       set_tsk_thread_flag(current, TIF_SLD);
>> +    return true;
>>   }
>>     bool handle_guest_split_lock(unsigned long ip)
>>   {
>> -    if (sld_state == sld_warn) {
>> -        split_lock_warn(ip);
>> +    if (split_lock_warn(ip, 0))
>>           return true;
>> -    }
>> -
>> -    pr_warn_once("#AC: %s/%d %s split_lock trap at address: 0x%lx\n",
>> -             current->comm, current->pid,
>> -             sld_state == sld_fatal ? "fatal" : "bogus", ip);
>>         current->thread.error_code = 0;
>>       current->thread.trap_nr = X86_TRAP_AC;
>> @@ -1108,10 +1107,7 @@ EXPORT_SYMBOL_GPL(handle_guest_split_lock);
>>     bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>>   {
>> -    if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
>> -        return false;
>> -    split_lock_warn(regs->ip);
>> -    return true;
>> +    return split_lock_warn(regs->ip, regs->flags & X86_EFLAGS_AC);
> 
> It's incorrect. You change the behavior that it will print the split lock
> warning even when CPL 3 Alignment Check is turned on.

Do you want the message to be displayed in the fatal case of CPL 3 Alignment check?

P.

