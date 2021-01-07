Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3542ECFCD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbhAGMc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:32:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbhAGMc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610022661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=URK/ursWdkuftdKkzSOXBWKsd1KzSb1xcPRs1K398PI=;
        b=Q2Al2Opr2z57ygsEDaFYTF1Wn8XDoltTYHR75YAg2qM87DMD19ymcQ1Jl0v62RMdA+DfLj
        TqnJkxAnBWpanWTAV67FokPya6ej4MibksQf0yrziuNTcRkXXWYO1vrte2lAtLpJm26jYA
        fROdHgjG2Rd5mBZLCVvo5kIXlEtUc98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-S3Rp4NFnMBSnZwP0-6y_wg-1; Thu, 07 Jan 2021 07:30:59 -0500
X-MC-Unique: S3Rp4NFnMBSnZwP0-6y_wg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0742C107ACE6;
        Thu,  7 Jan 2021 12:30:58 +0000 (UTC)
Received: from [10.36.114.161] (ovpn-114-161.ams2.redhat.com [10.36.114.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC7DA5C8AA;
        Thu,  7 Jan 2021 12:30:56 +0000 (UTC)
Subject: Re: [PATCH 1/1] arm64: make section size configurable for memory
 hotplug
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1609895500.git.sudaraja@codeaurora.org>
 <66f79b0c06602c22df4da8ff4a5c2b97c9275250.1609895500.git.sudaraja@codeaurora.org>
 <055b0aca-af60-12ad-cd68-e15440ade64b@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d0e627fd-390f-5915-c218-e2137aef3eb4@redhat.com>
Date:   Thu, 7 Jan 2021 13:30:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <055b0aca-af60-12ad-cd68-e15440ade64b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.01.21 07:11, Anshuman Khandual wrote:
> Hi Sudershan,
> 
> This patch (and the cover letter) does not copy LAKML even though the
> entire change here is arm64 specific. Please do copy all applicable
> mailing lists for a given patch.
> 
> On 1/6/21 6:58 AM, Sudarshan Rajagopalan wrote:
>> Currently on arm64, memory section size is hard-coded to 1GB.
>> Make this configurable if memory-hotplug is enabled, to support
>> more finer granularity for hotplug-able memory.
> 
> Section size has always been decided by the platform. It cannot be a
> configurable option because the user would not know the constraints
> for memory representation on the platform and besides it also cannot
> be trusted.
> 
>>
>> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
>> ---
>>  arch/arm64/Kconfig                 | 11 +++++++++++
>>  arch/arm64/include/asm/sparsemem.h |  4 ++++
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 6d232837cbee..34124eee65da 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -294,6 +294,17 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
>>  config SMP
>>  	def_bool y
>>  
>> +config HOTPLUG_SIZE_BITS
>> +	int "Memory hotplug block size(29 => 512MB 30 => 1GB)"

"Memory hotplug block size" and "HOTPLUG_SIZE_BITS" is confusing. It's
the section size. Please use that terminology.

(if at all, it would have to be "minimum memory hot(un)plug
granularity", but even that is somewhat misleading)

"SECTION_SIZE_BITS"

But I agree that letting the user configure it is sub-optimal.

>> +	depends on SPARSEMEM
>> +	depends on MEMORY_HOTPLUG
>> +	range 28 30
> 
> 28 would not work for 64K pages.

@Anshuman, what's your feeling about changing this to 128 MB for 4k/16k
base pages (as we have on x86-64 right now) and 512 MB for 64k as
default for now?

(If we worry about the number of section bits in page->flags, we could
glue it to vmemmap support where that does not matter)


-- 
Thanks,

David / dhildenb

