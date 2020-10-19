Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C372923EA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 10:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgJSIu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 04:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728421AbgJSIu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 04:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603097454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+GLhGk+DGr7aqMMN9qogQIvYXULDe5V4KCY/zVX1ro=;
        b=USxGFiro/JXM7mP88twPYYkPWmNHY4Sx/Bi3JP1v5H5dey/eKYccbBg9wmnhGj5qYgfpA9
        jZBkK37P21phfZOPXYHvwx6bHQ6hsR7BH8atTmGztmvhuYdQM5qMZ2Jgw8sK8r3SXYvfof
        m3/XeQmt8Spm4LMsMawjqHhrTmsXgRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-zf7Z9wQlPKyxDxftXp6dLA-1; Mon, 19 Oct 2020 04:50:49 -0400
X-MC-Unique: zf7Z9wQlPKyxDxftXp6dLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F9F310A0B83;
        Mon, 19 Oct 2020 08:50:48 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8A7B50B44;
        Mon, 19 Oct 2020 08:50:41 +0000 (UTC)
Subject: Re: [PATCH v1 29/29] virtio-mem: Big Block Mode (BBM) - safe memory
 hotunplug
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-30-david@redhat.com>
 <20201019075406.GE54484@L-31X9LVDL-1304.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e7f7d154-a1e3-0a89-743e-69f51c0e06fc@redhat.com>
Date:   Mon, 19 Oct 2020 10:50:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019075406.GE54484@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.20 09:54, Wei Yang wrote:
> On Mon, Oct 12, 2020 at 02:53:23PM +0200, David Hildenbrand wrote:
>> Let's add a safe mechanism to unplug memory, avoiding long/endless loops
>> when trying to offline memory - similar to in SBM.
>>
>> Fake-offline all memory (via alloc_contig_range()) before trying to
>> offline+remove it. Use this mode as default, but allow to enable the other
>> mode explicitly (which could give better memory hotunplug guarantees in
> 
> I don't get the point how unsafe mode would have a better guarantees?

It's primarily only relevant when there is a lot of concurrent action
going on while unplugging memory. Using alloc_contig_range() on
ZONE_MOVABLE can fail more easily than memory offlining.

alloc_contig_range() doesn't try as hard as memory offlining code to
isolate memory. There are known issues with temporary page pinning
(e.g., when a process dies) and the PCP. (mostly discovered via CMA
allocations)

See the TODO I add in patch #14.

[...]
>>
>> +	if (bbm_safe_unplug) {
>> +		/*
>> +		 * Start by fake-offlining all memory. Once we marked the device
>> +		 * block as fake-offline, all newly onlined memory will
>> +		 * automatically be kept fake-offline. Protect from concurrent
>> +		 * onlining/offlining until we have a consistent state.
>> +		 */
>> +		mutex_lock(&vm->hotplug_mutex);
>> +		virtio_mem_bbm_set_bb_state(vm, bb_id,
>> +					    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE);
>> +
> 
> State is set here.
> 
>> +		for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>> +			page = pfn_to_online_page(pfn);
>> +			if (!page)
>> +				continue;
>> +
>> +			rc = virtio_mem_fake_offline(pfn, PAGES_PER_SECTION);
>> +			if (rc) {
>> +				end_pfn = pfn;
>> +				goto rollback_safe_unplug;
>> +			}
>> +		}
>> +		mutex_unlock(&vm->hotplug_mutex);
>> +	}
>> +
>> 	rc = virtio_mem_bbm_offline_and_remove_bb(vm, bb_id);
>> -	if (rc)
>> +	if (rc) {
>> +		if (bbm_safe_unplug) {
>> +			mutex_lock(&vm->hotplug_mutex);
>> +			goto rollback_safe_unplug;
>> +		}
>> 		return rc;
>> +	}
>>
>> 	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
>> 	if (rc)
> 
> And changed to PLUGGED or UNUSED based on rc.

Right, after offlining+remove succeeded. So no longer added to Linux.

The final state depends on the success of the unplug request towards the
hypervisor.

> 
>> @@ -1987,6 +2069,17 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
>> 		virtio_mem_bbm_set_bb_state(vm, bb_id,
>> 					    VIRTIO_MEM_BBM_BB_UNUSED);
>> 	return rc;
>> +
>> +rollback_safe_unplug:
>> +	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>> +		page = pfn_to_online_page(pfn);
>> +		if (!page)
>> +			continue;
>> +		virtio_mem_fake_online(pfn, PAGES_PER_SECTION);
>> +	}
>> +	virtio_mem_bbm_set_bb_state(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED);
> 
> And changed to ADDED if failed.

Right, back to the initial state when entering this function.

> 
>> +	mutex_unlock(&vm->hotplug_mutex);
>> +	return rc;
>> }
> 
> So in which case, the bbm state is FAKE_OFFLINE during
> virtio_mem_bbm_notify_going_offline() and
> virtio_mem_bbm_notify_cancel_offline() ?

Exactly, so we can do our magic with fake-offline pages and our
virtio_mem_bbm_offline_and_remove_bb() can actually succeed.


-- 
Thanks,

David / dhildenb

