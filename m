Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F58D2EA815
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbhAEJ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727860AbhAEJ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609840586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSoCoG28BB3krzJrBO/as9WWlyGiL/7dmvac6i2JgK0=;
        b=ZICvsoicbQ2VvMc+kox3daFFL8iYYGjJLP8k4Hc4dQR+X0f+dMhndkG83sHWykREBFXhiV
        OMqDP2kQFB/mYxwOoBbOLpU/F7T+yZjmExUFoH+mWtxEA6Bk5K5OJ5Xw+OMCA/dKvD9O7Y
        /CQgGTpUhovkZe+SXEh/62CWb6Cc5rI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-Vz0ly2cJPByUxjFY3U60EQ-1; Tue, 05 Jan 2021 04:56:24 -0500
X-MC-Unique: Vz0ly2cJPByUxjFY3U60EQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 512F815734;
        Tue,  5 Jan 2021 09:56:23 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 429A227C4E;
        Tue,  5 Jan 2021 09:56:22 +0000 (UTC)
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
 <a2e8f11a-24b0-5d30-2d8f-1940b268392c@redhat.com>
 <20210105074459.GR13207@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <fed0a870-9cb3-8475-d0c4-b3d79abdddec@redhat.com>
Date:   Tue, 5 Jan 2021 10:56:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210105074459.GR13207@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.21 08:44, Michal Hocko wrote:
> On Mon 04-01-21 17:30:48, David Hildenbrand wrote:
>>>> Let's assume this is indeed a reserved pfn in the altmap. What's the
>>>> actual address of the memmap?
>>>
>>> Not sure what exactly you are asking for but crash says
>>> crash> kmem -p 6060000
>>>       PAGE          PHYSICAL      MAPPING       INDEX CNT FLAGS
>>> fffff8c600181800     6060000                0        0  0 fffffc0000000
>>
>> ^ this looks like it was somewhat initialized. All flags zero, nid/zone
>> set to -1 (wild guess) and thus the crash? weird
> 
> Yes that made me scratch my head as well.

My best guess would be that this is indeed part of the altmap reserve
with a memmap on the altmap. Maybe these values are just leftovers on
the PMEM device (e.g., from older kernels)?

In the kernel, I cannot find anything that would initialize node/zone to
-1 only.


@Dan: Will get_dev_pagemap() return a valid dev_pagemap for pfns falling
into the altmap reserved region? I think we should also initialize the
memmap of the altmap reserved region somewhow.

-- 
Thanks,

David / dhildenb

