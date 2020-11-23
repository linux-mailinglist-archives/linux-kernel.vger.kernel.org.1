Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7498F2C047E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgKWL0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:26:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729077AbgKWL0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606130796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+pCiLdTGxCPYJ07FGHkZsU/hiul3gL9ALTDtjNP6fw=;
        b=JH7AShhq4HGsuynQDyhAWz+EVooNBo8MS/LddBVziuIZ2Ryt0dI1bUPpQomxsvhvOZhrsg
        q7InPTD1+Qo1s2JXdcpwi4+FX4E4UZZiLle72+fiW5nFEVtjoeh8Cg6XzVxUfHyLMdXZw6
        d1LNcGgQn/px/233OGRxscR8Uhtmrpk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-IxTYuGkaM5utEfRvRgsIeA-1; Mon, 23 Nov 2020 06:26:32 -0500
X-MC-Unique: IxTYuGkaM5utEfRvRgsIeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15D8C10054FF;
        Mon, 23 Nov 2020 11:26:31 +0000 (UTC)
Received: from [10.36.114.57] (ovpn-114-57.ams2.redhat.com [10.36.114.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F30B65D6D7;
        Mon, 23 Nov 2020 11:26:28 +0000 (UTC)
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com> <X7lwT2+uSVGKRApQ@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4e551b29-9bc6-3c4b-4b40-cf68ecb7b6f1@redhat.com>
Date:   Mon, 23 Nov 2020 12:26:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X7lwT2+uSVGKRApQ@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.20 20:53, Andrea Arcangeli wrote:
> On Sat, Nov 21, 2020 at 02:45:06PM -0500, Andrea Arcangeli wrote:
>> +					if (likely(!PageReserved(page)))
> 
> NOTE: this line will have to become "likely(page &&
> !PageReserved(page))" to handle the case of non contiguous zones,
> since pageblock_pfn_to_page might return NULL in that case.. I noticed
> right after sending, but I'll wait some feedback before resending the
> correction in case it gets fixed in another way.

With that fixed, this looks sane to me.


-- 
Thanks,

David / dhildenb

