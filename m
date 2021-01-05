Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D322EA72B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbhAEJSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:18:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbhAEJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609838198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/mNj4FXntJ6f+kqOYOdyOb/PeZxp46sguDuCB5Sa8g=;
        b=gVAwIwT3y1cQ3XjFOnay0M81TKVpLO5CebapgXkgSYEtWf/BYPq/xVgbDAX/aGGjkh+Hnq
        yx4BGTDg8limHuB/q1ZZzmglvi/2lsVDPPZnjeDvdIb8sVjavW2Rh8otC1ukBG/HaNIWFa
        CnT1yKZ5HPqqGNp3sExywGsqhMQ1Ey4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-67LHksxIP_6SrGcjPnQ5tw-1; Tue, 05 Jan 2021 04:16:36 -0500
X-MC-Unique: 67LHksxIP_6SrGcjPnQ5tw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2863800D62;
        Tue,  5 Jan 2021 09:16:34 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0FD060873;
        Tue,  5 Jan 2021 09:16:33 +0000 (UTC)
Subject: Re: uninitialized pmem struct pages
To:     Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20210104100323.GC13207@dhcp22.suse.cz>
 <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <CAPcyv4h6mdKrwpqXfO0e_=sKjB-pY5KbP9ii+tQyFsK5bPkb=A@mail.gmail.com>
 <20210105075028.GS13207@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5fa1ff35-71f3-2526-6819-34c1ee959295@redhat.com>
Date:   Tue, 5 Jan 2021 10:16:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210105075028.GS13207@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.21 08:50, Michal Hocko wrote:
> On Mon 04-01-21 21:17:43, Dan Williams wrote:
>> On Mon, Jan 4, 2021 at 2:45 AM David Hildenbrand <david@redhat.com> wrote:
> [...]
>>> I believe Dan mentioned somewhere that he wants to see a real instance
>>> of this producing a BUG before actually moving forward with a fix. I
>>> might be wrong.
>>
>> I think I'm missing an argument for the user-visible effects of the
>> "Bad." statements above. I think soft_offline_page() is a candidate
>> for a local fix because mm/memory-failure.c already has a significant
>> amount of page-type specific knowledge. So teaching it "yes" for
>> MEMORY_DEVICE_PRIVATE-ZONE_DEVICE and "no" for other ZONE_DEVICE seems
>> ok to me.
> 
> I believe we do not want to teach _every_ pfn walker about zone device
> pages. This would be quite error prone. Especially when a missig check
> could lead to a silently broken data or BUG_ON with debugging enabled
> (which is not the case for many production users). Or are we talking
> about different bugs here?

I'd like us to stick to the documentation, e.g., include/linux/mmzone.h


"
pfn_valid() is meant to be able to tell if a given PFN has valid memmap
associated with it or not. This means that a struct page exists for this
pfn. The caller cannot assume the page is fully initialized in general.
Hotplugable pages might not have been onlined yet. pfn_to_online_page()
will ensure the struct page is fully online and initialized. Special
pages (e.g. ZONE_DEVICE) are never onlined and should be treated
accordingly.
"

-- 
Thanks,

David / dhildenb

