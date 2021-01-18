Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC95B2FA149
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392159AbhARNW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:22:28 -0500
Received: from foss.arm.com ([217.140.110.172]:35950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392128AbhARNWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:22:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5609D31B;
        Mon, 18 Jan 2021 05:21:17 -0800 (PST)
Received: from [10.163.89.163] (unknown [10.163.89.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B70BB3F719;
        Mon, 18 Jan 2021 05:21:09 -0800 (PST)
Subject: Re: [PATCH RFC] virtio-mem: check against memhp_get_pluggable_range()
 which memory we can hotplug
To:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        hca@linux.ibm.com, catalin.marinas@arm.com
Cc:     Oscar Salvador <osalvador@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        teawater <teawaterz@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <1610975582-12646-5-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a1644ce0-427f-7a5c-b90a-547e61341a75@arm.com>
Date:   Mon, 18 Jan 2021 18:51:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1610975582-12646-5-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/21 6:43 PM, Anshuman Khandual wrote:
> From: David Hildenbrand <david@redhat.com>
> 
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
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Hello David,

As your original patch was in the RFC state, I have just maintained
the same here as well. But once you test this patch along with the
new series, please do let me know if this needs to be converted to
a normal PATCH instead. Thank you.

- Anshuman
