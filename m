Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A02924018E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 06:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgHJEgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 00:36:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:57676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgHJEgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 00:36:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11E5CABE2;
        Mon, 10 Aug 2020 04:36:54 +0000 (UTC)
Subject: Re: [PATCH v3 1/7] x86/xen: remove 32-bit Xen PV guest support
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20200807083826.16794-1-jgross@suse.com>
 <20200807083826.16794-2-jgross@suse.com>
 <893bc936-81bf-1e86-8423-a61fbfb5dc02@oracle.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <8dc06c59-54a5-8716-5e26-ec1442aaadd4@suse.com>
Date:   Mon, 10 Aug 2020 06:36:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <893bc936-81bf-1e86-8423-a61fbfb5dc02@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.20 04:01, Boris Ostrovsky wrote:
> On 8/7/20 4:38 AM, Juergen Gross wrote:
>>   
>>   void __init xen_reserve_top(void)
>>   {
>> -#ifdef CONFIG_X86_32
>> -	unsigned long top = HYPERVISOR_VIRT_START;
>> -	struct xen_platform_parameters pp;
>> -
>> -	if (HYPERVISOR_xen_version(XENVER_platform_parameters, &pp) == 0)
>> -		top = pp.virt_start;
>> -
>> -	reserve_top_address(-top);
>> -#endif	/* CONFIG_X86_32 */
>>   }
>>   
> 
> 
> We should be able now to get rid of xen_reserve_top() altogether.

Oh, yes.

> 
> 
> Other than that
> 
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Thanks,

Juergen
