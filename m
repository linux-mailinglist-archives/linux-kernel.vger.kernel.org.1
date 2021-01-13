Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3679D2F4685
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbhAMIag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:30:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726546AbhAMIaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610526549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnkNq7WMI2CVWcX/yAHgyPl0w9p5JWaNoF5mq+QCvB0=;
        b=JWaw/395giL7SrqN1yqJBJL5Ttl96cL/DO9EcBFuomRltIz+NUNZLUrYVvPwA9luADsCch
        BebzMpRgWveM+rsNHln5iqX658zkkNRbrlMz7a0uPVwjEkEWDUorTdX9ERwfmLS/yH5cPg
        7H4RecTcE9lm6Uz80oMIpXd4/BtfijE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-XqfY1E7jNbO_kaHy5Xz8Hg-1; Wed, 13 Jan 2021 03:29:05 -0500
X-MC-Unique: XqfY1E7jNbO_kaHy5Xz8Hg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAD7A801F98;
        Wed, 13 Jan 2021 08:29:03 +0000 (UTC)
Received: from [10.36.114.135] (ovpn-114-135.ams2.redhat.com [10.36.114.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C095F7046A;
        Wed, 13 Jan 2021 08:29:01 +0000 (UTC)
Subject: Re: [PATCH v3 2/6] mm: Teach pfn_to_online_page() to consider
 subsection validity
To:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org
Cc:     Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161052332755.1805594.9846390935351758277.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <230efa36-9192-fe52-b8b6-16b2feafb70b@redhat.com>
Date:   Wed, 13 Jan 2021 09:29:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <161052332755.1805594.9846390935351758277.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.21 08:35, Dan Williams wrote:
> pfn_section_valid() determines pfn validity on subsection granularity
> where pfn_valid() may be limited to coarse section granularity.
> Explicitly validate subsections after pfn_valid() succeeds.
> 
> Fixes: b13bc35193d9 ("mm/hotplug: invalid PFNs from pfn_to_online_page()")
> Cc: Qian Cai <cai@lca.pw>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/memory_hotplug.c |   24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 55a69d4396e7..9f37f8a68da4 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -308,11 +308,27 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
>  struct page *pfn_to_online_page(unsigned long pfn)
>  {
>  	unsigned long nr = pfn_to_section_nr(pfn);
> +	struct mem_section *ms;
> +
> +	if (nr >= NR_MEM_SECTIONS)
> +		return NULL;
> +
> +	ms = __nr_to_section(nr);
> +	if (!online_section(ms))
> +		return NULL;
> +
> +	/*
> +	 * Save some code text when online_section() +
> +	 * pfn_section_valid() are sufficient.
> +	 */
> +	if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID))
> +		if (!pfn_valid(pfn))
> +			return NULL;

Nit:

if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) &&
    !pfn_valid(pfn))

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

