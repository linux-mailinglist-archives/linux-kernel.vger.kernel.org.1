Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FF72F2703
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 05:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbhALEZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 23:25:58 -0500
Received: from foss.arm.com ([217.140.110.172]:39824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbhALEZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 23:25:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D9A31042;
        Mon, 11 Jan 2021 20:25:12 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EDA23F66E;
        Mon, 11 Jan 2021 20:25:06 -0800 (PST)
Subject: Re: [PATCH RFC] virtio-mem: check against memhp_get_pluggable_range()
 which memory we can hotplug
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        catalin.marinas@arm.com, teawater <teawaterz@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        hca@linux.ibm.com, Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
 <20210111124140.11423-1-david@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0d5b797b-8a1c-7ee5-c821-99e065e9c489@arm.com>
Date:   Tue, 12 Jan 2021 09:55:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111124140.11423-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/21 6:11 PM, David Hildenbrand wrote:
> Right now, we only check against MAX_PHYSMEM_BITS - but turns out there
> are more restrictions of which memory we can actually hotplug, especially
> om arm64 or s390x once we support them: we might receive something like
> -E2BIG or -ERANGE from add_memory_driver_managed(), stopping device
> operation.
> 
> So, check right when initializing the device which memory we can add,
> warning the user. Try only adding actually pluggable ranges: in the worst
> case, no memory provided by our device is pluggable.
> 
> In the usual case, we expect all device memory to be pluggable, and in
> corner cases only some memory at the end of the device-managed memory
> region to not be pluggable.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: catalin.marinas@arm.com
> Cc: teawater <teawaterz@linux.alibaba.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: hca@linux.ibm.com
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> This is an example how virito-mem intends to use an interface like
> memhp_get_pluggable_range() once around. See:
> 
> "[PATCH V2 0/3] mm/hotplug: Pre-validate the address range with platform"
> https://lkml.kernel.org/r/1608218912-28932-1-git-send-email-anshuman.khandual@arm.com
> 
> @Anshuman, feel free to pick up and carry this patch. I'll retest the final
> result / new versions of you series.

Makes sense, will carry this patch in the series.
