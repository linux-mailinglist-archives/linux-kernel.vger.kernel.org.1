Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10287240192
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 06:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHJEhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 00:37:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:57806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgHJEhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 00:37:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57B1FABE2;
        Mon, 10 Aug 2020 04:37:54 +0000 (UTC)
Subject: Re: [PATCH v3 3/7] x86/xen: drop tests for highmem in pv code
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200807083826.16794-1-jgross@suse.com>
 <20200807083826.16794-4-jgross@suse.com>
 <60f40558-a3a8-2c1e-2c32-09f93bfca724@oracle.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <a7ba056c-bbf0-5855-e0c3-fd835e1d6792@suse.com>
Date:   Mon, 10 Aug 2020 06:37:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <60f40558-a3a8-2c1e-2c32-09f93bfca724@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.20 04:22, Boris Ostrovsky wrote:
> On 8/7/20 4:38 AM, Juergen Gross wrote:
>> With support for 32-bit pv guests gone pure pv-code no longer needs to
>> test for highmem. Dropping those tests removes the need for flushing
>> in some places.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
> 
> with a suggestion
> 
> 
>> ---
>>   arch/x86/xen/enlighten_pv.c |  11 ++-
>>   arch/x86/xen/mmu_pv.c       | 138 ++++++++++++++----------------------
>>   2 files changed, 57 insertions(+), 92 deletions(-)
>>
>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>> index 7d90b3da8bb4..9fec952f84f3 100644
>> --- a/arch/x86/xen/enlighten_pv.c
>> +++ b/arch/x86/xen/enlighten_pv.c
>> @@ -347,6 +347,7 @@ static void set_aliased_prot(void *v, pgprot_t prot)
>>   	unsigned long pfn;
>>   	struct page *page;
>>   	unsigned char dummy;
>> +	void *av;
> 
> 
> to rename this to va since you are modifying those lines anyway.

Yes.


Juergen
