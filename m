Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8F42CDB38
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgLCQ3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:29:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbgLCQ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607012886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jRVA3W7T/pVqUV/EjG25mXlusVZvncykEwttIb9bhjQ=;
        b=i29keSEe6ZZaoIBAdLM0CSsI8M2RaxTi60xgT7tJJ2Usy0THGX5CDTdpV8I0lfSP6s1Oui
        WWW1NmoLFjU2VL/KsHQLSc4fr1qU2J0SuUkFt+/sJF/u4kwQbSN94akcX2JhYs+4VIUOGZ
        oqm13Zlbs0ALVoDEl93HbScQIH8yPBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-W2WSu9giO4W3Z0shG1n8lQ-1; Thu, 03 Dec 2020 11:28:04 -0500
X-MC-Unique: W2WSu9giO4W3Z0shG1n8lQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A04F100671C;
        Thu,  3 Dec 2020 16:28:02 +0000 (UTC)
Received: from [10.36.113.250] (ovpn-113-250.ams2.redhat.com [10.36.113.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97CF110013C0;
        Thu,  3 Dec 2020 16:28:01 +0000 (UTC)
Subject: Re: [PATCH v2] mm/page_isolation: do not isolate the max order page
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
References: <20201203162237.21885-1-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <46fcf0c1-7c38-723b-8905-953d72f1d6bc@redhat.com>
Date:   Thu, 3 Dec 2020 17:28:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203162237.21885-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.12.20 17:22, Muchun Song wrote:
> The max order page has no buddy page and never merge to other order.
> So isolating and then freeing it is pointless. And if order == MAX_ORDER
> - 1, then the buddy can actually be a !pfn_valid() in some corner case?
> pfn_valid_within(buddy_pfn) that follows would only catch it on archs
> with holes in zone. Then is_migrate_isolate_page(buddy) might access an
> invalid buddy. So this is also a bug fix.
> 
> Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")

As just replied to v1, I don't think this is required and the patch
description can be simplified - e.g., stating that we have/had not such
users.


-- 
Thanks,

David / dhildenb

