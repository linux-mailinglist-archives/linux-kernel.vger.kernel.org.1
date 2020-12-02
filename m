Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD852CC269
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbgLBQc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:32:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728160AbgLBQc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606926693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZuq9zNQNZWZqW7QqYOIN/hMUk1I0GLr8ZdMBenG6bo=;
        b=gYzsZKCEBpaJdmOn6l/5CK07YEX/ghVD7q7Efot+O1PsEJmDruUmJtlWX/zie46x8o2qRi
        mPtlX1V2sxWZPoZTWRV4XrZPxJBxnPY42yVWDoFzGWQIqflSwhmfGL2SPBHWTKhwdVlkRL
        6LShq01oQO4JWxfv33/C8IWMHnwtKS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-UJedGppcMUaBSkBDZT-wfA-1; Wed, 02 Dec 2020 11:31:29 -0500
X-MC-Unique: UJedGppcMUaBSkBDZT-wfA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 102E6106F6F9;
        Wed,  2 Dec 2020 16:31:26 +0000 (UTC)
Received: from [10.36.114.61] (ovpn-114-61.ams2.redhat.com [10.36.114.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F10CB10027AA;
        Wed,  2 Dec 2020 16:31:18 +0000 (UTC)
Subject: Re: [PATCH 2/6] mm/gup: don't pin migrated cma pages in movable zone
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        osalvador@suse.de, dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-3-pasha.tatashin@soleen.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <27224254-7e8d-cf4f-aebc-1ffe32ca65be@redhat.com>
Date:   Wed, 2 Dec 2020 17:31:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201202052330.474592-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.12.20 06:23, Pavel Tatashin wrote:
> In order not to fragment CMA the pinned pages are migrated. However,
> they are migrated to ZONE_MOVABLE, which also should not have pinned pages.
> 
> Remove __GFP_MOVABLE, so pages can be migrated to zones where pinning
> is allowed.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  mm/gup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index cdb8b9eeb016..3a76c005a3e2 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1610,7 +1610,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>  	long ret = nr_pages;
>  	struct migration_target_control mtc = {
>  		.nid = NUMA_NO_NODE,
> -		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN,
> +		.gfp_mask = GFP_USER | __GFP_NOWARN,
>  	};
>  
>  check_again:
> 


Looks like the right thing to me, thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

