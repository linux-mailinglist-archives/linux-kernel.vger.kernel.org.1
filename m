Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEF6301A37
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 07:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbhAXGfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 01:35:06 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:40476 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726398AbhAXGfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 01:35:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UMg2q4g_1611470034;
Received: from 30.25.221.71(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UMg2q4g_1611470034)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Jan 2021 14:33:55 +0800
Subject: Re: [PATCH v2] x86/sgx: Remove redundant if conditions in
 sgx_encl_create
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
References: <20210120035328.19868-1-tianjia.zhang@linux.alibaba.com>
 <YAhsyXahEYjV7DZ8@google.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <95913686-be5f-85e5-0cc2-91b2a100e16e@linux.alibaba.com>
Date:   Sun, 24 Jan 2021 14:33:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAhsyXahEYjV7DZ8@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/21 1:47 AM, Sean Christopherson wrote:
> On Wed, Jan 20, 2021, Tianjia Zhang wrote:
>> In this scenario, there is no case where va_page is NULL, and
>> the error has been checked. The if condition statement here is
>> redundant, so remove the condition detection.
>>
>> Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   arch/x86/kernel/cpu/sgx/ioctl.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
>> index 1c6ecf9fbeff..efad2fb61c76 100644
>> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
>> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
>> @@ -66,9 +66,12 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>>   	va_page = sgx_encl_grow(encl);
>>   	if (IS_ERR(va_page))
>>   		return PTR_ERR(va_page);
>> -	else if (va_page)
>> -		list_add(&va_page->list, &encl->va_pages);
>> -	/* else the tail page of the VA page list had free slots. */
>> +
>> +	if (WARN_ONCE(!va_page,
>> +		      "the tail page of the VA page list had free slots\n"))
> 
> IMO it's worth trimming down the message to keep this on a single line.  The
> newline isn't necessary, and this code expects a completely empty list, e.g. it
> can be reworded to something like:
> 
> 	if (WARN_ONCE(!va_page, "non-empty VA page list before ECREATE"))
> 

Thanks for your suggestion, I have resubmitted a set of patches.

Best regards,
Tianjia
