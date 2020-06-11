Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C581F6CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 19:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgFKRha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 13:37:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20565 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726813AbgFKRha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591897048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qARvwf693xBRNl1VlWzwavSivQ9sYO1lqX5q74rCOLw=;
        b=NifLkEO9qjDxRyD4Gl5k9DprKflITZJkndiVqP56eH1EFeejKfM0/8xtjuer7JkpuR/6CJ
        PBSpcAz5hzDUgQczWEdDGqyZJZJ62XlFscvjhTxAvouGMtHZi6GDL+ZceL2pFAGF32g/Oo
        tnECK/cjl2IqNBxCdY7b6S/SrT8WFwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-oC86CCcHPn6iGBvzdtU87g-1; Thu, 11 Jun 2020 13:37:24 -0400
X-MC-Unique: oC86CCcHPn6iGBvzdtU87g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FBB81B18BC5;
        Thu, 11 Jun 2020 17:37:21 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D5051A8EA;
        Thu, 11 Jun 2020 17:37:20 +0000 (UTC)
Subject: Re: [PATCH v2] x86/split_lock: Sanitize userspace and guest error
 output
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20200608122114.13043-1-prarit@redhat.com>
 <20200608171552.GB8223@linux.intel.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <b83ff48b-f590-f0f5-de64-d153ef376124@redhat.com>
Date:   Thu, 11 Jun 2020 13:37:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200608171552.GB8223@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/20 1:15 PM, Sean Christopherson wrote:
> On Mon, Jun 08, 2020 at 08:21:14AM -0400, Prarit Bhargava wrote:
>> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
>> index 166d7c355896..e02ec81fe1eb 100644
>> --- a/arch/x86/kernel/cpu/intel.c
>> +++ b/arch/x86/kernel/cpu/intel.c
>> @@ -1074,10 +1074,17 @@ static void split_lock_init(void)
>>  	split_lock_verify_msr(sld_state != sld_off);
>>  }
>>  
>> -static void split_lock_warn(unsigned long ip)
>> +static bool split_lock_warn(unsigned long ip, int fatal_no_warn)
>>  {
>> -	pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
>> -			    current->comm, current->pid, ip);
>> +	if (fatal_no_warn)
>> +		return false;
> 
> This misses the point Xiaoyao was making.  If EFLAGS.AC=1 then the #AC is a
> legacy alignment check fault and should not be treated as a split-lock #AC.
> The basic premise of the patch makes sense, but the end result is confusing
> because incorporating "fatal" and the EFLAGS.AC state into split_lock_warn()
> bastardizes both the "split_lock" and "warn" aspects of the function.
> 
> E.g. something like this yields the same net effect, it's just organized
> differently.  If so desired, the "bogus" message could be dropped via
> Xiaoyao's prep patch[*] so that this change would only affect the sld_fatal
> messages.
> 
> [*] https://lkml.kernel.org/r/20200509110542.8159-3-xiaoyao.li@intel.com
> 
> 

Sean, I will just take your patch to make things easy.  I will add you as a
Signed-off-by.

/me is testing the patch right now

P.

> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 23fd5f319908..1aad0b8e394c 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -1071,11 +1071,14 @@ static void split_lock_init(void)
>         split_lock_verify_msr(sld_state != sld_off);
>  }
> 
> -static void split_lock_warn(unsigned long ip)
> +static bool handle_split_lock(unsigned long ip)
>  {
>         pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
>                             current->comm, current->pid, ip);
> 
> +       if (sld_state != sld_warn)
> +               return false;
> +
>         /*
>          * Disable the split lock detection for this task so it can make
>          * progress and set TIF_SLD so the detection is re-enabled via
> @@ -1083,18 +1086,13 @@ static void split_lock_warn(unsigned long ip)
>          */
>         sld_update_msr(false);
>         set_tsk_thread_flag(current, TIF_SLD);
> +       return true;
>  }
> 
>  bool handle_guest_split_lock(unsigned long ip)
>  {
> -       if (sld_state == sld_warn) {
> -               split_lock_warn(ip);
> +       if (handle_split_lock(ip))
>                 return true;
> -       }
> -
> -       pr_warn_once("#AC: %s/%d %s split_lock trap at address: 0x%lx\n",
> -                    current->comm, current->pid,
> -                    sld_state == sld_fatal ? "fatal" : "bogus", ip);
> 
>         current->thread.error_code = 0;
>         current->thread.trap_nr = X86_TRAP_AC;
> @@ -1105,10 +1103,10 @@ EXPORT_SYMBOL_GPL(handle_guest_split_lock);
> 
>  bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>  {
> -       if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
> +       if (regs->flags & X86_EFLAGS_AC)
>                 return false;
> -       split_lock_warn(regs->ip);
> -       return true;
> +
> +       return handle_split_lock(regs->ip);
>  }
> 
>  /*
> 
> 
>> +
>> +	pr_warn_ratelimited("#AC: %s/%d %ssplit_lock trap at address: 0x%lx\n",
>> +			    current->comm, current->pid,
>> +			    sld_state == sld_fatal ? "fatal " : "", ip);
>> +
>> +	if (sld_state == sld_fatal)
>> +		return false;
>>  
>>  	/*
>>  	 * Disable the split lock detection for this task so it can make
>> @@ -1086,18 +1093,13 @@ static void split_lock_warn(unsigned long ip)
>>  	 */
>>  	sld_update_msr(false);
>>  	set_tsk_thread_flag(current, TIF_SLD);
>> +	return true;
>>  }
>>  
>>  bool handle_guest_split_lock(unsigned long ip)
>>  {
>> -	if (sld_state == sld_warn) {
>> -		split_lock_warn(ip);
>> +	if (split_lock_warn(ip, 0))
>>  		return true;
>> -	}
>> -
>> -	pr_warn_once("#AC: %s/%d %s split_lock trap at address: 0x%lx\n",
>> -		     current->comm, current->pid,
>> -		     sld_state == sld_fatal ? "fatal" : "bogus", ip);
>>  
>>  	current->thread.error_code = 0;
>>  	current->thread.trap_nr = X86_TRAP_AC;
>> @@ -1108,10 +1110,7 @@ EXPORT_SYMBOL_GPL(handle_guest_split_lock);
>>  
>>  bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>>  {
>> -	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
>> -		return false;
>> -	split_lock_warn(regs->ip);
>> -	return true;
>> +	return split_lock_warn(regs->ip, regs->flags & X86_EFLAGS_AC);
>>  }
>>  
>>  /*
>> -- 
>> 2.21.3
>>
> 

