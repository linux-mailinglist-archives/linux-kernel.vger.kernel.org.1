Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF0A2F2D17
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbhALKmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:42:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726876AbhALKmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610448070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=laMWYNPhqsIO491bNvJyhQH+JCab/CvNj2mGMUwymvk=;
        b=KRraZwCS+oVsB9NE2uLxqbQTL4df4XUe8+FMr2E19ER6OwebI/eL3O3OcIXxKWIGI9B2pw
        QprI3oDDjonBpV5R+8LRFbZB/KUgGiKo2Gg9U/4BbqNXMxpVTxsFn6wrKI3OVYFvnjV/pw
        tO3wVr3LlBNs+dVB1eKAbGEM+HvaJKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-oSGPyhgqMzea9iap3Xa-dQ-1; Tue, 12 Jan 2021 05:41:08 -0500
X-MC-Unique: oSGPyhgqMzea9iap3Xa-dQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E1A615720;
        Tue, 12 Jan 2021 10:41:07 +0000 (UTC)
Received: from [10.36.115.140] (ovpn-115-140.ams2.redhat.com [10.36.115.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4902E60CA7;
        Tue, 12 Jan 2021 10:41:05 +0000 (UTC)
Subject: Re: [RFC PATCH 0/3] create hugetlb flags to consolidate state
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210111210152.118394-1-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <250496a6-edfb-6a0e-9ca2-f1ceea6a0c8a@redhat.com>
Date:   Tue, 12 Jan 2021 11:41:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210111210152.118394-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.01.21 22:01, Mike Kravetz wrote:
> While discussing a series of hugetlb fixes in [1], it became evident
> that the hugetlb specific page state information is stored in a somewhat
> haphazard manner.  Code dealing with state information would be easier
> to read, understand and maintain if this information was stored in a
> consistent manner.
> 
> This RFC series uses page.private of the hugetlb head page for storing a
> set of hugetlb specific page flags.  Routines to manipulate the flags
> are copied from normal page flag manipulation code and use atomic
> operations.  This is likely overkill for the uses in hugetlb code, and
> can be changed after additional auditing of code.

Haven't looked into the code but that sounds like a good idea.

> 
> For now, only 3 state flags are added as part of this series.  However,
> the suggested fix in [2] could use another flag.  In addition, a flag
> could be used to track whether or not a huge page has been cleared to
> optimize code paths if the init_on_alloc security feature is enabled.

Right, that will be helpful: indicating pages that were either cleared
directly when allocating (init_on_alloc) or via some asynchronous
mechanism in the future.

-- 
Thanks,

David / dhildenb

