Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA412FB871
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393174AbhASMkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:40:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389491AbhASM3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611059222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWWEX+tZcqi8Aed2AQBNeafP+kkMB/om7kZIB/JclL8=;
        b=Zee/6/PWKZqU4R199+2WN+UVWHnDRlGg8mbbGPEYimqd8q6Uknhcbg0oz2iHeekHitTKOy
        fSEGiTLwKNt6qvzDTt54V5gCmEwkUQon2mUJ1HRbnIKzht2rrq4/rJPw23vxA1SbTJ49fT
        i2sNGXqb+UGgXslrfd3KJMYZOLZym38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-Ma0I1oXsPsWpn3E27LhNdg-1; Tue, 19 Jan 2021 07:26:57 -0500
X-MC-Unique: Ma0I1oXsPsWpn3E27LhNdg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1C8459;
        Tue, 19 Jan 2021 12:26:55 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8412F5C8A7;
        Tue, 19 Jan 2021 12:26:53 +0000 (UTC)
Subject: Re: [PATCH V3 3/3] s390/mm: Define arch_get_mappable_range()
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com
Cc:     Oscar Salvador <osalvador@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <1610975582-12646-4-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <cbdb32af-74af-ceb2-fa68-3912ef20d784@redhat.com>
Date:   Tue, 19 Jan 2021 13:26:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1610975582-12646-4-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.21 14:13, Anshuman Khandual wrote:
> This overrides arch_get_mappabble_range() on s390 platform which will be
> used with recently added generic framework. It modifies the existing range
> check in vmem_add_mapping() using arch_get_mappable_range(). It also adds a
> VM_BUG_ON() check that would ensure that memhp_range_allowed() has already
> been called on the hotplug path.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/s390/mm/init.c |  1 +
>  arch/s390/mm/vmem.c | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 73a163065b95..97017a4bcc90 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -297,6 +297,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>  		return -EINVAL;
>  
> +	VM_BUG_ON(!memhp_range_allowed(start, size, true));
>  	rc = vmem_add_mapping(start, size);
>  	if (rc)
>  		return rc;
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index 01f3a5f58e64..afc39ff1cc8d 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -4,6 +4,7 @@
>   *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
>   */
>  
> +#include <linux/memory_hotplug.h>
>  #include <linux/memblock.h>
>  #include <linux/pfn.h>
>  #include <linux/mm.h>
> @@ -532,11 +533,23 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>  	mutex_unlock(&vmem_mutex);
>  }
>  
> +struct range arch_get_mappable_range(void)
> +{
> +	struct range memhp_range;

You could do:

memhp_range = {
	.start = 0,
	.end =  VMEM_MAX_PHYS - 1,
};

Similar in the arm64 patch.

> +
> +	memhp_range.start = 0;
> +	memhp_range.end =  VMEM_MAX_PHYS - 1;
> +	return memhp_range;
> +}
> +
>  int vmem_add_mapping(unsigned long start, unsigned long size)
>  {
> +	struct range range;
>  	int ret;
>  
> -	if (start + size > VMEM_MAX_PHYS ||
> +	range = arch_get_mappable_range();

You could do

struct range range = arch_get_mappable_range();

> +	if (start < range.start ||
> +	    start + size > range.end + 1 ||
>  	    start + size < start)
>  		return -ERANGE;
>  
> 


-- 
Thanks,

David / dhildenb

