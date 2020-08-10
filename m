Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9736C24018F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 06:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgHJEhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 00:37:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:57732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgHJEhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 00:37:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DAF34ABE2;
        Mon, 10 Aug 2020 04:37:19 +0000 (UTC)
Subject: Re: [PATCH v3 2/7] x86/xen: eliminate xen-asm_64.S
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20200807083826.16794-1-jgross@suse.com>
 <20200807083826.16794-3-jgross@suse.com>
 <b0c1c8cf-7a7e-33be-2b83-7895bcb9c36b@oracle.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <7358d7c4-37a6-c304-e569-bd7069884681@suse.com>
Date:   Mon, 10 Aug 2020 06:36:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b0c1c8cf-7a7e-33be-2b83-7895bcb9c36b@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.20 04:04, Boris Ostrovsky wrote:
> On 8/7/20 4:38 AM, Juergen Gross wrote:
>> With 32-bit pv-guest support removed xen-asm_64.S can be merged with
>> xen-asm.S
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
> 
> except for
> 
> 
>> diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
>> index c59d077510bf..d1272a63f097 100644
>> --- a/arch/x86/xen/xen-asm.S
>> +++ b/arch/x86/xen/xen-asm.S
>> @@ -6,12 +6,19 @@
>>    * operations here; the indirect forms are better handled in C.
>>    */
>>   
>> +#include <asm/errno.h>
>>   #include <asm/asm-offsets.h>
>>   #include <asm/percpu.h>
>>   #include <asm/processor-flags.h>
>> +#include <asm/segment.h>
>> +#include <asm/thread_info.h>
>> +#include <asm/asm.h>
>>   #include <asm/frame.h>
>>   #include <asm/asm.h>
> 
> 
> asm/asm.h included twice now.

Right, will drop that.


Juergen
