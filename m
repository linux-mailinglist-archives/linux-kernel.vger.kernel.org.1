Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58ACC293254
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 02:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgJTAXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 20:23:38 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:49402 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726863AbgJTAXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 20:23:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UCbA6wY_1603153414;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCbA6wY_1603153414)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Oct 2020 08:23:35 +0800
Date:   Tue, 20 Oct 2020 08:23:34 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 29/29] virtio-mem: Big Block Mode (BBM) - safe memory
 hotunplug
Message-ID: <20201020002334.GA61232@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-30-david@redhat.com>
 <20201019075406.GE54484@L-31X9LVDL-1304.local>
 <e7f7d154-a1e3-0a89-743e-69f51c0e06fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f7d154-a1e3-0a89-743e-69f51c0e06fc@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 10:50:39AM +0200, David Hildenbrand wrote:
>On 19.10.20 09:54, Wei Yang wrote:
>> On Mon, Oct 12, 2020 at 02:53:23PM +0200, David Hildenbrand wrote:
>>> Let's add a safe mechanism to unplug memory, avoiding long/endless loops
>>> when trying to offline memory - similar to in SBM.
>>>
>>> Fake-offline all memory (via alloc_contig_range()) before trying to
>>> offline+remove it. Use this mode as default, but allow to enable the other
>>> mode explicitly (which could give better memory hotunplug guarantees in
>> 
>> I don't get the point how unsafe mode would have a better guarantees?
>
>It's primarily only relevant when there is a lot of concurrent action
>going on while unplugging memory. Using alloc_contig_range() on
>ZONE_MOVABLE can fail more easily than memory offlining.
>
>alloc_contig_range() doesn't try as hard as memory offlining code to
>isolate memory. There are known issues with temporary page pinning
>(e.g., when a process dies) and the PCP. (mostly discovered via CMA
>allocations)
>
>See the TODO I add in patch #14.
>
>[...]
>>>
>>> +	if (bbm_safe_unplug) {
>>> +		/*
>>> +		 * Start by fake-offlining all memory. Once we marked the device
>>> +		 * block as fake-offline, all newly onlined memory will
>>> +		 * automatically be kept fake-offline. Protect from concurrent
>>> +		 * onlining/offlining until we have a consistent state.
>>> +		 */
>>> +		mutex_lock(&vm->hotplug_mutex);
>>> +		virtio_mem_bbm_set_bb_state(vm, bb_id,
>>> +					    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE);
>>> +
>> 
>> State is set here.
>> 
>>> +		for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>>> +			page = pfn_to_online_page(pfn);
>>> +			if (!page)
>>> +				continue;
>>> +
>>> +			rc = virtio_mem_fake_offline(pfn, PAGES_PER_SECTION);
>>> +			if (rc) {
>>> +				end_pfn = pfn;
>>> +				goto rollback_safe_unplug;
>>> +			}
>>> +		}
>>> +		mutex_unlock(&vm->hotplug_mutex);
>>> +	}
>>> +
>>> 	rc = virtio_mem_bbm_offline_and_remove_bb(vm, bb_id);
>>> -	if (rc)
>>> +	if (rc) {
>>> +		if (bbm_safe_unplug) {
>>> +			mutex_lock(&vm->hotplug_mutex);
>>> +			goto rollback_safe_unplug;
>>> +		}
>>> 		return rc;
>>> +	}
>>>
>>> 	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
>>> 	if (rc)
>> 
>> And changed to PLUGGED or UNUSED based on rc.
>
>Right, after offlining+remove succeeded. So no longer added to Linux.
>
>The final state depends on the success of the unplug request towards the
>hypervisor.
>
>> 
>>> @@ -1987,6 +2069,17 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
>>> 		virtio_mem_bbm_set_bb_state(vm, bb_id,
>>> 					    VIRTIO_MEM_BBM_BB_UNUSED);
>>> 	return rc;
>>> +
>>> +rollback_safe_unplug:
>>> +	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>>> +		page = pfn_to_online_page(pfn);
>>> +		if (!page)
>>> +			continue;
>>> +		virtio_mem_fake_online(pfn, PAGES_PER_SECTION);
>>> +	}
>>> +	virtio_mem_bbm_set_bb_state(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED);
>> 
>> And changed to ADDED if failed.
>
>Right, back to the initial state when entering this function.
>
>> 
>>> +	mutex_unlock(&vm->hotplug_mutex);
>>> +	return rc;
>>> }
>> 
>> So in which case, the bbm state is FAKE_OFFLINE during
>> virtio_mem_bbm_notify_going_offline() and
>> virtio_mem_bbm_notify_cancel_offline() ?
>
>Exactly, so we can do our magic with fake-offline pages and our
>virtio_mem_bbm_offline_and_remove_bb() can actually succeed.

Ah, my fault. The exact code flow is this:

    virtio_mem_bbm_offline_remove_and_unplug_bb()
        virtio_mem_bbm_set_bb_state(vm, bb_id, VIRTIO_MEM_BBM_BB_FAKE_OFFLINE)
	virtio_mem_fake_offline(pfn, PAGES_PER_SECTION)
	virtio_mem_bbm_offline_and_remove_bb(vm, bb_id)
	    offline and trigger memory notification  --- 1)

The notification is necessary at 1) to release the refcount, which is grabbed
during fake offline.

>
>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
