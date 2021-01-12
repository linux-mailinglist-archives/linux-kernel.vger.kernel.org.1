Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396EA2F2DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbhALLTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:19:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47649 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbhALLTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610450274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m3tLMcR2b3Xdvwoy4KoIFE09PvEPwOzcb5p0zUizGX0=;
        b=fYfR7ifoaKGQsBM85rd2kCm1EULsgdaqX2gLW0/meZMGG2YHWYReWhpBPdw2LtBrYe455X
        SyFO4IkO5tFWw4YO89ogyqIDmKIQBuGXT5WhDG6K4FAUnQmWQDKH60csjGyIslmyaKXSs9
        7ss5e5MswmxQtZpW4a0Y0anLj8igBjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-iGlrs6eDMHOn2VR7s1UvFQ-1; Tue, 12 Jan 2021 06:17:49 -0500
X-MC-Unique: iGlrs6eDMHOn2VR7s1UvFQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E556107ACF7;
        Tue, 12 Jan 2021 11:17:48 +0000 (UTC)
Received: from [10.36.115.140] (ovpn-115-140.ams2.redhat.com [10.36.115.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D416460BE2;
        Tue, 12 Jan 2021 11:17:46 +0000 (UTC)
Subject: Re: [PATCH 1/5] mm: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        pasha.tatashin@soleen.com
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-2-osalvador@suse.de>
 <21932014-3027-8ad9-2140-f63500c641d7@redhat.com>
 <20210112072643.GA10774@linux>
 <feef406c-105c-138a-b8af-345684876e25@redhat.com>
 <20210112111700.GA13374@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5ca78a13-98b7-0952-1c06-81284d4bc41c@redhat.com>
Date:   Tue, 12 Jan 2021 12:17:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210112111700.GA13374@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.01.21 12:17, Oscar Salvador wrote:
> On Tue, Jan 12, 2021 at 11:12:30AM +0100, David Hildenbrand wrote:
>> On 12.01.21 08:26, Oscar Salvador wrote:
>>> You mean introducing only mm/Kconfig change in this patch, and then
>>> arch/*/Kconfig changes in separate patches at the end of the series?
>>
>> Yeah, or squashing the leftovers of this patch (3 LOC) into patch #2.
> 
> Ok, makes sense.
> 
>>> I can certainly do that, not sure how much will help with the review,
>>> but it might help when bisecting.
>>
>> It's usually nicer to explicitly enable stuff per architecture, stating
>> why it works on that architecture (and in the best case, even was
>> tested!). :)
> 
> Fine by me.
> I will prepare another re-spin with that in mind then.
> 
> It would be great to have some feedback on patch#2 before that (in case you find
> some time ;-).

Yeah, will get to that soon. Mailbox is flooded right now :D


-- 
Thanks,

David / dhildenb

