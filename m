Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481232ECCDE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbhAGJcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbhAGJcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610011854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=40x5DFNSq8yzK9zk7bYZVYunBOu/SmJ58y8StrIX3Nk=;
        b=bVQcF5oCHpagf8QXFu2u8Ph8QNzdmymQUMkZbG5rT1Y0+/S245DwIGr4r1RZUH53I0MPgZ
        MXndCAvopOLQ+3guaR0UvpzE29s6GjnDu/7ICVkOzeqp86fhj/P4ePEM8DWYhTj3lM19hN
        HPnzNM8qvvng0i4j1548qLZ0rgLriME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-4hITyjgKM-uHyW8tK1XIsw-1; Thu, 07 Jan 2021 04:30:52 -0500
X-MC-Unique: 4hITyjgKM-uHyW8tK1XIsw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D887180A08A;
        Thu,  7 Jan 2021 09:30:51 +0000 (UTC)
Received: from [10.36.114.161] (ovpn-114-161.ams2.redhat.com [10.36.114.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B1D171CB3;
        Thu,  7 Jan 2021 09:30:49 +0000 (UTC)
Subject: Re: [PATCH v2 0/6] Fix some bugs about HugeTLB code
To:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210106084739.63318-1-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7b44eddc-cbae-92b6-5ac7-765cad2a6326@redhat.com>
Date:   Thu, 7 Jan 2021 10:30:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210106084739.63318-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.01.21 09:47, Muchun Song wrote:
> This patch series aims to fix some bugs and add some improvements.
> 
> Changelog since v1 -> v2:
>   - Export set_page_huge_active() in patch #2 to fix.
>   - Using head[3].mapping to indicate the page is freed in patch #3.
>   - Flush @free_hpage_work in patch #4.
> 
> Muchun Song (6):
>   mm: migrate: do not migrate HugeTLB page whose refcount is one
>   mm: hugetlbfs: fix cannot migrate the fallocated HugeTLB page
>   mm: hugetlb: fix a race between freeing and dissolving the page
>   mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
>   mm: hugetlb: fix a race between isolating and freeing page
>   mm: hugetlb: remove VM_BUG_ON_PAGE from page_huge_active
> 
>  fs/hugetlbfs/inode.c    |  3 ++-
>  include/linux/hugetlb.h |  2 ++
>  mm/hugetlb.c            | 69 +++++++++++++++++++++++++++++++++++++++++++------
>  mm/migrate.c            |  6 +++++
>  4 files changed, 71 insertions(+), 9 deletions(-)
> 

Repeating my question regarding ccing stable on selected fixes.

-- 
Thanks,

David / dhildenb

