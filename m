Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F492E9B18
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbhADQcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:32:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39642 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727522AbhADQcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609777855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJN1qsMOLVTuDkPDhsf9jdeYHMvv+gruDegQHf3V90o=;
        b=CvVSljLqV6PoPUdva0Fmaq+kAVHOXg3wj3TS1Ep8sxqhLKotgUk9244cmSu3BFn9h9N6Qg
        XC/CUHeDdrmDbtYVFrD9yz7gaL1qgxKdtcZJ93TAzkxOObxUzMwtf6x9Mawxwi0A2TOni7
        te0HmP1mPJWdYOCbWFFVkgr69BNbtuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-KpCuSUgzOYS6G2GzFpIlFQ-1; Mon, 04 Jan 2021 11:30:52 -0500
X-MC-Unique: KpCuSUgzOYS6G2GzFpIlFQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A40118C8C01;
        Mon,  4 Jan 2021 16:30:51 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F1A761D31;
        Mon,  4 Jan 2021 16:30:50 +0000 (UTC)
Subject: Re: uninitialized pmem struct pages
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
References: <20210104100323.GC13207@dhcp22.suse.cz>
 <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <20210104142624.GI13207@dhcp22.suse.cz>
 <23a4eea2-9fdb-fd1d-ee92-9cd8ac6e8f41@redhat.com>
 <20210104151005.GK13207@dhcp22.suse.cz>
 <26db2c3e-10c7-c6e3-23f7-21eb5101b31a@redhat.com>
 <20210104153300.GL13207@dhcp22.suse.cz>
 <bf26f568-79b3-67f9-832a-9d8ef3f72c43@redhat.com>
 <20210104155931.GN13207@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a2e8f11a-24b0-5d30-2d8f-1940b268392c@redhat.com>
Date:   Mon, 4 Jan 2021 17:30:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210104155931.GN13207@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Let's assume this is indeed a reserved pfn in the altmap. What's the
>> actual address of the memmap?
> 
> Not sure what exactly you are asking for but crash says
> crash> kmem -p 6060000
>       PAGE          PHYSICAL      MAPPING       INDEX CNT FLAGS
> fffff8c600181800     6060000                0        0  0 fffffc0000000

^ this looks like it was somewhat initialized. All flags zero, nid/zone
set to -1 (wild guess) and thus the crash? weird

>  
>> I do wonder what hosts pfn_to_page(PHYS_PFN(0x6060000)) - is it actually
>> part of the actual altmap (i.e. > 0x6060000) or maybe even self-hosted?
> 
> I am not really familiar with the pmem so I would need more assistance
> here. I've tried this (shot into the dark):
> crash> struct page.pgmap fffff8c600181800
>       pgmap = 0xfffff8c600181808

That's weird. If the memmap is at fffff8c600181800, why should the pgmap
be at an offset of 8 bytes from there. The "pgmap" field is actually at
an offset of 8 bytes within the memmap ...

Assuming the memmap is not actually ZONE_DEVICE, fffff8c600181800 really
only contains garbage, including the pgmap pointer :(

> crash> struct -x dev_pagemap 0xfffff8c600181808
> struct dev_pagemap {
>   altmap = {
>     base_pfn = 0xfffff8c600181808, 
>     end_pfn = 0xfffff8c600181808,

^ because this is very weird

>     reserve = 0x0, 

^ and this indicates nothing was actually reserved.


-- 
Thanks,

David / dhildenb

