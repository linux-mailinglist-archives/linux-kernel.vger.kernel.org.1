Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79D82C2052
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgKXIoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:44:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730492AbgKXIop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606207484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rFvnWingY7PrQj77qBtBNXevIVda9mBy5RjtelX8LV0=;
        b=bj9z1LSwFtCLMkC4aDDYWJhIWfuqq2ZsL89Ni1FBKdXgSswo+J2QIQjkZd4j6jSRpChUwX
        1YxgVjQjVNH3bNIJo6gA2gNu0FVw7B5PUdTSKhA/JRE9QtczFtgyxq6KJQHHBOq3QwmBPG
        migboDKC9eG5uDeUol1buDEfh1HfPoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-yaL4ZV1cMG2YOctfOi8C2A-1; Tue, 24 Nov 2020 03:44:40 -0500
X-MC-Unique: yaL4ZV1cMG2YOctfOi8C2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A6C51007293;
        Tue, 24 Nov 2020 08:44:37 +0000 (UTC)
Received: from [10.36.113.167] (ovpn-113-167.ams2.redhat.com [10.36.113.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A77615D71D;
        Tue, 24 Nov 2020 08:44:34 +0000 (UTC)
Subject: Re: Pinning ZONE_MOVABLE pages
To:     Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, sthemmin@microsoft.com,
        John Hubbard <jhubbard@nvidia.com>
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
 <d668b0f2-2644-0f5e-a8c1-a6b8f515e9ab@suse.cz>
 <CA+CK2bBuEhH7cSEZUKTYE_g9mw_rwEG-v1Jk4BL6WuLWK824Aw@mail.gmail.com>
 <20201124084350.GU27488@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <43922bf4-c818-e675-2369-10097c460ac4@redhat.com>
Date:   Tue, 24 Nov 2020 09:44:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201124084350.GU27488@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.11.20 09:43, Michal Hocko wrote:
> On Mon 23-11-20 11:31:59, Pavel Tatashin wrote:
> [...]
>> Also, we still need to take care of the fault scenario.
> 
> Forgot to reply to this part. I believe you mean this to be fault at gup
> time, right? Then the easiest way forward would be to either add yet
> another scoped flag or (maybe) better to generalize memalloc_nocma_* to
> imply that the allocated memory is going to be unmovable so drop
> __GFP_MOVABLE and also forbid CMA. I have to admit that I do not
> remember why long term pin on CMA pages is ok to go to movable but I
> strongly suspect this is just shifting problem around.

Agreed.


-- 
Thanks,

David / dhildenb

