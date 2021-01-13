Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAB22F4695
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbhAMIcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbhAMIcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610526669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YLp4vxk+82Jz6Cr9tpUqUqEbN1T5xSL04lBhhKhpD84=;
        b=IE1PU57/qH5jbcEmhBJWIjPQXUYbF5lQ9VAcstTLwaeOoeqRz+KCM6vXTZiZgorakh2/r4
        7Q5Jd3nl5m1GRIWuTtI2ZzRGnU2imuVMVoEfNDRQS89qZcg6t1l/jbn7vjkhgGz9tfXBVK
        u8RynaKb4L55fXZnyiq5cy0g61OTi4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-Iphjah_0POy8mBshrFSi2g-1; Wed, 13 Jan 2021 03:31:05 -0500
X-MC-Unique: Iphjah_0POy8mBshrFSi2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D6238066E2;
        Wed, 13 Jan 2021 08:31:04 +0000 (UTC)
Received: from [10.36.114.135] (ovpn-114-135.ams2.redhat.com [10.36.114.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DAA45D9DD;
        Wed, 13 Jan 2021 08:31:02 +0000 (UTC)
Subject: Re: [PATCH v3 5/6] mm: Fix memory_failure() handling of dax-namespace
 metadata
To:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        vishal.l.verma@intel.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
References: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161052334425.1805594.17861842381807251887.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4664e9f3-5c2d-4c51-2bcd-9d03ef9c4fed@redhat.com>
Date:   Wed, 13 Jan 2021 09:31:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <161052334425.1805594.17861842381807251887.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.21 08:35, Dan Williams wrote:
> Given 'struct dev_pagemap' spans both data pages and metadata pages be
> careful to consult the altmap if present to delineate metadata. In fact
> the pfn_first() helper already identifies the first valid data pfn, so
> export that helper for other code paths via pgmap_pfn_valid().
> 
> Other usage of get_dev_pagemap() are not a concern because those are
> operating on known data pfns having been looking up by get_user_pages().
> I.e. metadata pfns are never user mapped.
> 
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/memremap.h |    6 ++++++
>  mm/memory-failure.c      |    6 ++++++
>  mm/memremap.c            |   15 +++++++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 79c49e7f5c30..f5b464daeeca 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -137,6 +137,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
>  void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
>  struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>  		struct dev_pagemap *pgmap);
> +bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
>  
>  unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
>  void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns);
> @@ -165,6 +166,11 @@ static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>  	return NULL;
>  }
>  
> +static inline bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
> +{
> +	return false;
> +}
> +
>  static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
>  {
>  	return 0;
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 78b173c7190c..541569cb4a99 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1308,6 +1308,12 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  		 */
>  		put_page(page);
>  
> +	/* device metadata space is not recoverable */
> +	if (!pgmap_pfn_valid(pgmap, pfn)) {
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
>  	/*
>  	 * Prevent the inode from being freed while we are interrogating
>  	 * the address_space, typically this would be handled by
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 16b2fb482da1..2455bac89506 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -80,6 +80,21 @@ static unsigned long pfn_first(struct dev_pagemap *pgmap, int range_id)
>  	return pfn + vmem_altmap_offset(pgmap_altmap(pgmap));
>  }
>  
> +bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
> +{
> +	int i;
> +
> +	for (i = 0; i < pgmap->nr_range; i++) {
> +		struct range *range = &pgmap->ranges[i];
> +
> +		if (pfn >= PHYS_PFN(range->start) &&
> +		    pfn <= PHYS_PFN(range->end))
> +			return pfn >= pfn_first(pgmap, i);
> +	}
> +
> +	return false;
> +}
> +
>  static unsigned long pfn_end(struct dev_pagemap *pgmap, int range_id)
>  {
>  	const struct range *range = &pgmap->ranges[range_id];
> 

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

