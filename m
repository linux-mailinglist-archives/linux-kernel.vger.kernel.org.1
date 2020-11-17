Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560802B6902
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgKQPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:46:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbgKQPqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605628011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBRmGBhgNm5FfbhT75FD7IeQ1qhvmL460Gefj3SG1R4=;
        b=cvbEflrWQKU+hfQVBj15KzazpR/jMGhzxFNvecqbcDQ71r1l8P3yw3hCHVsI050p+Hn0l0
        8offOO5Vtk+3imyo9evxiNX8p1o2B4xN36CBgn+mv4VWVZsGY81LbzuLNimUkvwVrbkY0v
        dHxmzvXgJ4lGFT1CIlQkYl+nR905yFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-wYOif9G6MPaT8cDgk148ow-1; Tue, 17 Nov 2020 10:46:46 -0500
X-MC-Unique: wYOif9G6MPaT8cDgk148ow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8725C186DD2C;
        Tue, 17 Nov 2020 15:46:44 +0000 (UTC)
Received: from [10.36.114.99] (ovpn-114-99.ams2.redhat.com [10.36.114.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA5035C1CF;
        Tue, 17 Nov 2020 15:46:41 +0000 (UTC)
Subject: Re: [PATCH v2 4/8] powerpc/mm: protect linear mapping modifications
 by a mutex
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201111145322.15793-1-david@redhat.com>
 <20201111145322.15793-5-david@redhat.com> <20201117153750.GD15987@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <274264b2-9ec8-bde0-5725-184c8fd5f05e@redhat.com>
Date:   Tue, 17 Nov 2020 16:46:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201117153750.GD15987@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.20 16:37, Oscar Salvador wrote:
> On Wed, Nov 11, 2020 at 03:53:18PM +0100, David Hildenbrand wrote:
>> @@ -144,7 +147,9 @@ void __ref arch_remove_linear_mapping(u64 start, u64 size)
>>   	start = (unsigned long)__va(start);
>>   	flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
>>   
>> +	mutex_lock(&linear_mapping_mutex);
>>   	ret = remove_section_mapping(start, start + size);
>> +	mutex_unlock(&linear_mapping_mutex);
>>   	WARN_ON_ONCE(ret);
> 
> My expertise in this area is low, so bear with me.
> 
> Why we do not need to protect flush_dcache_range_chunked and
> vm_unmap_aliases?
> 

vm_unmap_aliases does own locking and can handle concurrent calls.


flush_dcache_range_chunked()->flush_dcache_range() ends up as a sequence 
of memory barriers paired with dcbf instructions.

dcbf: Copies modified cache blocks to main storage and invalidates the 
copy in the data cache.

It's called from various places and no global variables seem to be 
involved, so it looks like it doesn't need any kind of locking.

-- 
Thanks,

David / dhildenb

