Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE53322B056
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 15:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgGWNU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 09:20:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:54654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGWNU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:20:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4352AAB55;
        Thu, 23 Jul 2020 13:21:04 +0000 (UTC)
Subject: Re: [PATCH 3/3] memory: introduce an option to force onlining of
 hotplug memory
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        xen-devel@lists.xenproject.org, linux-mm@kvack.org
References: <20200723084523.42109-1-roger.pau@citrix.com>
 <20200723084523.42109-4-roger.pau@citrix.com>
 <21490d49-b2cf-a398-0609-8010bdb0b004@redhat.com>
 <20200723122300.GD7191@Air-de-Roger>
 <404ea76f-c3d8-dbc5-432d-08d84a17f2d7@suse.com>
 <20200723130831.GE7191@Air-de-Roger>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <76640b3e-f46c-80d5-7714-aa3b731276ab@suse.com>
Date:   Thu, 23 Jul 2020 15:20:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723130831.GE7191@Air-de-Roger>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.20 15:08, Roger Pau Monné wrote:
> On Thu, Jul 23, 2020 at 02:28:13PM +0200, Jürgen Groß wrote:
>> On 23.07.20 14:23, Roger Pau Monné wrote:
>>> On Thu, Jul 23, 2020 at 01:37:03PM +0200, David Hildenbrand wrote:
>>>> On 23.07.20 10:45, Roger Pau Monne wrote:
>>>>> Add an extra option to add_memory_resource that overrides the memory
>>>>> hotplug online behavior in order to force onlining of memory from
>>>>> add_memory_resource unconditionally.
>>>>>
>>>>> This is required for the Xen balloon driver, that must run the
>>>>> online page callback in order to correctly process the newly added
>>>>> memory region, note this is an unpopulated region that is used by Linux
>>>>> to either hotplug RAM or to map foreign pages from other domains, and
>>>>> hence memory hotplug when running on Xen can be used even without the
>>>>> user explicitly requesting it, as part of the normal operations of the
>>>>> OS when attempting to map memory from a different domain.
>>>>>
>>>>> Setting a different default value of memhp_default_online_type when
>>>>> attaching the balloon driver is not a robust solution, as the user (or
>>>>> distro init scripts) could still change it and thus break the Xen
>>>>> balloon driver.
>>>>
>>>> I think we discussed this a couple of times before (even triggered by my
>>>> request), and this is responsibility of user space to configure. Usually
>>>> distros have udev rules to online memory automatically. Especially, user
>>>> space should eb able to configure *how* to online memory.
>>>
>>> Note (as per the commit message) that in the specific case I'm
>>> referring to the memory hotplugged by the Xen balloon driver will be
>>> an unpopulated range to be used internally by certain Xen subsystems,
>>> like the xen-blkback or the privcmd drivers. The addition of such
>>> blocks of (unpopulated) memory can happen without the user explicitly
>>> requesting it, and hence not even aware such hotplug process is taking
>>> place. To be clear: no actual RAM will be added to the system.
>>>
>>> Failure to online such blocks using the Xen specific online handler
>>> (which does not handle back the memory to the allocator in any way)
>>> will result in the system getting stuck and malfunctioning.
>>>
>>>> It's the admin/distro responsibility to configure this properly. In case
>>>> this doesn't happen (or as you say, users change it), bad luck.
>>>>
>>>> E.g., virtio-mem takes care to not add more memory in case it is not
>>>> getting onlined. I remember hyper-v has similar code to at least wait a
>>>> bit for memory to get onlined.
>>>
>>> I don't think VirtIO or Hyper-V use the hotplug system in the same way
>>> as Xen, as said this is done to add unpopulated memory regions that
>>> will be used to map foreign memory (from other domains) by Xen drivers
>>> on the system.
>>>
>>> Maybe this should somehow use a different mechanism to hotplug such
>>> empty memory blocks? I don't mind doing this differently, but I would
>>> need some pointers. Allowing user-space to change a (seemingly
>>> unrelated) parameter and as a result produce failures on Xen drivers
>>> is not an acceptable solution IMO.
>>
>> Maybe we can use the same approach as Xen PV-domains: pre-allocate a
>> region in the memory map to be used for mapping foreign pages. For the
>> kernel it will look like pre-ballooned memory, so it will create struct
>> page for the region (which is what we are after), but it won't give the
>> memory to the allocator.
> 
> IMO using something similar to memory hotplug would give us more
> flexibility, and TBH the logic is already there in the balloon driver.
> It seems quite wasteful to allocate such region(s) beforehand for all
> domains, even when most of them won't end up using foreign mappings at
> all.

We can do it for dom0 only per default, and add a boot parameter e.g.
for driver domains.

And the logic is already there (just pv-only right now).

> 
> Anyway, I'm going to take a look at how to do that, I guess it's going
> to involve playing with the memory map and reserving some space.

Look at arch/x86/xen/setup.c (xen_add_extra_mem() and its usage).

> 
> I suggest we should remove the Xen balloon hotplug logic, as it's not
> working properly and we don't have a plan to fix it.

I have used memory hotplug successfully not very long ago.


Juergen
