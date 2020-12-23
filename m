Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F220A2E1A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgLWImj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:42:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727647AbgLWImi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608712871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zv96305hyzLZGE7I3eUoIN4EPFxBqS+G6WB1JQP8vJI=;
        b=M1g9OEaJOjmNLZq9dDLPMv61+hwejtoxMcBinm//QZ2KtD8CPpRPR+at0qA1oK4AcNHhKq
        ec+KtIPhhrYPLIUvoZywrFUOTAmE9BlBAxtP067BhlLspWUuwV+8ATEkq7jbyCWC/46q14
        ja73ZNmZCyMgeUkXAUzQ4UWoSKRVLy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-EGS5sk_WMgaJnHdIWDcBDQ-1; Wed, 23 Dec 2020 03:41:09 -0500
X-MC-Unique: EGS5sk_WMgaJnHdIWDcBDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0148A801A9E;
        Wed, 23 Dec 2020 08:41:07 +0000 (UTC)
Received: from [10.36.113.184] (ovpn-113-184.ams2.redhat.com [10.36.113.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10F9F60C64;
        Wed, 23 Dec 2020 08:41:00 +0000 (UTC)
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
To:     Liang Li <liliang324@gmail.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20201221162519.GA22504@open-light-1.localdomain>
 <7bf0e895-52d6-9e2d-294b-980c33cf08e4@redhat.com>
 <CA+2MQi89v=DZJZ7b-QaMsU2f42j4SRW47XcZvLtBj10YeqRGgQ@mail.gmail.com>
 <840ff69d-20d5-970a-1635-298000196f3e@redhat.com>
 <CA+2MQi87+N87x+gLuJPurst38AfFQhnc9eyHr8On55d1+WY5zQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <55052a91-64f9-b343-a1c4-f059ca50ecf3@redhat.com>
Date:   Wed, 23 Dec 2020 09:41:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CA+2MQi87+N87x+gLuJPurst38AfFQhnc9eyHr8On55d1+WY5zQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>> I was rather saying that for security it's of little use IMHO.
>> Application/VM start up time might be improved by using huge pages (and
>> pre-zeroing these). Free page reporting might be improved by using
>> MADV_FREE instead of MADV_DONTNEED in the hypervisor.
>>
>>> this feature, above all of them, which one is likely to become the
>>> most strong one?  From the implementation, you will find it is
>>> configurable, users don't want to use it can turn it off.  This is not
>>> an option?
>>
>> Well, we have to maintain the feature and sacrifice a page flag. For
>> example, do we expect someone explicitly enabling the feature just to
>> speed up startup time of an app that consumes a lot of memory? I highly
>> doubt it.
> 
> In our production environment, there are three main applications have such
> requirement, one is QEMU [creating a VM with SR-IOV passthrough device],
> anther other two are DPDK related applications, DPDK OVS and SPDK vhost,
> for best performance, they populate memory when starting up. For SPDK vhost,
> we make use of the VHOST_USER_GET/SET_INFLIGHT_FD feature for
> vhost 'live' upgrade, which is done by killing the old process and
> starting a new
> one with the new binary. In this case, we want the new process started as quick
> as possible to shorten the service downtime. We really enable this feature
> to speed up startup time for them  :)

Thanks for info on the use case!

All of these use cases either already use, or could use, huge pages
IMHO. It's not your ordinary proprietary gaming app :) This is where
pre-zeroing of huge pages could already help.

Just wondering, wouldn't it be possible to use tmpfs/hugetlbfs ...
creating a file and pre-zeroing it from another process, or am I missing
something important? At least for QEMU this should work AFAIK, where you
can just pass the file to be use using memory-backend-file.

> 
>> I'd love to hear opinions of other people. (a lot of people are offline
>> until beginning of January, including, well, actually me :) )
> 
> OK. I will wait some time for others' feedback. Happy holidays!

To you too, cheers!


-- 
Thanks,

David / dhildenb

