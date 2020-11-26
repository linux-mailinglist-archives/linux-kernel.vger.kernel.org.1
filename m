Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE052C5CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 21:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404172AbgKZUAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 15:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgKZUAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 15:00:21 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B15CC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 12:00:21 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so3372929wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 12:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jqIZCXoiXvJcx/9bb6q/HBfL2wVuHWkzrEwW+TfJqkk=;
        b=EQe7+1nx3K8m0dG5cFSvRk69O1bXB3EYe5+J6CUblMHfrwbyEKKKOt4AJjKrFTB6TY
         pExk8eqsffwBhxIOOV2ZpTIOMAUUO+hEEPrTUDx5GzYU7iSlCPU9wdMhhjNfJtkqgNOp
         Ckq1t46SmB2h3fFpz6E3V1LlQ51RqB4xobbokST9M51jbO3yyiwYZOpZ0nFkIQIaxseu
         M7sB62usoYSc8bMPsCqJW9SkE5aFooQkQ7xTD2LunrixNWXemjyvxVqISbolHWwgAJXr
         0BWGdQ8Q+oE1piNzSOpspyZtpegoR0pcOSVUZgfsEoKGtINb7IE5TSdUUQX4LoZWSaa/
         F4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jqIZCXoiXvJcx/9bb6q/HBfL2wVuHWkzrEwW+TfJqkk=;
        b=mmuzah/yCJ2FJ84dMVPlksvm0zk9UdVVs5791e2sZaZTUxSiqK+WyrtVHCzJBLZUqP
         JNqEYUhDF2UKexYgAvDTdKVNfaOrP7Rh9TSBGI5EJGXPtDyPEEx+rDY1rBUlcX9SotYf
         DkF3YTEN2Bqayfe2iYxJV5TatLUfSP3vZJyG7qYU0+7uJMBeM/dgcR5kHxJypj0BtPWl
         ILX3Eg4eyd6dOEyA2D8UshzzypYoSUIQYzfz8emxygPtE4FO6vygL21kWDyrtZ2unAbW
         RwJ+0I6EtGGFP6Ny4ecmY/RVDObHhJ7bOtU0OtL0JBI0ocON4nmqhW0v48OxcbNVzpDz
         uLuA==
X-Gm-Message-State: AOAM531kenx1uyoiXIDs0F2v74n8FfZPYqSmSRw5Xt5kUf5HhBByQR7x
        HWUGN+a5ro9RnZdkoTg4yurdXg==
X-Google-Smtp-Source: ABdhPJzl5/ACsCJ8kW40DVitUbhNk837WNE5xsqKqIASi9zREKaNZ7T5/s/f2Z7ZnXZ+nrZsspJgRQ==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr5900267wrl.406.1606420819767;
        Thu, 26 Nov 2020 12:00:19 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v1sm10694877wrr.48.2020.11.26.12.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 12:00:19 -0800 (PST)
Subject: Re: [PATCH v2 13/19] x86/signal: Check if vdso_image_32 is mapped
 before trying to land on it
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>
References: <20201124002932.1220517-1-dima@arista.com>
 <20201124002932.1220517-14-dima@arista.com>
 <CALCETrW3=jegCtJP-wbcKk3QrcYGTk82rJGqe-5E_RC+NQRLpw@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <462e5754-8d8a-5512-a2f9-a23991425a90@arista.com>
Date:   Thu, 26 Nov 2020 20:00:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrW3=jegCtJP-wbcKk3QrcYGTk82rJGqe-5E_RC+NQRLpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/20 11:43 PM, Andy Lutomirski wrote:
> On Mon, Nov 23, 2020 at 4:29 PM Dmitry Safonov <dima@arista.com> wrote:
>>
>> Provide current_has_vdso_image_32() helper and check it apriory landing
>> attempt on vdso vma.
>> The helper is a macro, not a static inline funciton to avoid
>> linux/sched/task_stack.h inclusion in asm/vdso.h.
> 
> Can you make this more general?  For example:
> 
> current_has_vdso(&vdso_image_whatever)

Sounds good, will do.

> 
> also:
> 
>> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
>> index 18d8f17f755c..d9ab58cc765b 100644
>> --- a/arch/x86/entry/common.c
>> +++ b/arch/x86/entry/common.c
>> @@ -142,11 +142,16 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
>>  /* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
>>  __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
>>  {
>> +       unsigned long landing_pad;
>> +
>> +       if (!current_has_vdso_image_32())
>> +               force_sigsegv(SIGSEGV);
> 
> Falling through seems incorrect here.  I would instead write 0 to rip,
> do the force_sigsegv(), and exit, making sure that exiting goes
> through the correct path.
> 

Something like this?

:       if (!current_has_vdso(&vdso_image_32)) {
:               regs->ax = -EFAULT;
:               regs->ip = 0;
:               force_sigsegv(SIGSEGV);
:               syscall_exit_to_user_mode(regs);
:       }

Thanks,
          Dmitry
