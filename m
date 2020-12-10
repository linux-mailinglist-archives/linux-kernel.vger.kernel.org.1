Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD202D52BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 05:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgLJETD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 23:19:03 -0500
Received: from foss.arm.com ([217.140.110.172]:46396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729968AbgLJETC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 23:19:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58E8631B;
        Wed,  9 Dec 2020 20:18:16 -0800 (PST)
Received: from [10.163.83.83] (unknown [10.163.83.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 360093F66B;
        Wed,  9 Dec 2020 20:18:10 -0800 (PST)
Subject: Re: [PATCH 3/3] s390/mm: Define arch_get_mappable_range()
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1607400978-31595-1-git-send-email-anshuman.khandual@arm.com>
 <1607400978-31595-4-git-send-email-anshuman.khandual@arm.com>
 <20201208152709.GA26979@osiris>
 <7484e153-6c77-8325-6195-621fe144011e@arm.com> <20201209145717.GD7160@osiris>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <04da0f9c-d50e-7729-5e4c-b0dc4e76d608@arm.com>
Date:   Thu, 10 Dec 2020 09:48:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209145717.GD7160@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/9/20 8:27 PM, Heiko Carstens wrote:
> On Wed, Dec 09, 2020 at 08:07:04AM +0530, Anshuman Khandual wrote:
>>>> +	if (seg->end + 1 > VMEM_MAX_PHYS || seg->end + 1 < seg->start_addr) {
>>>> +		rc = -ERANGE;
>>>> +		goto out_resource;
>>>> +	}
>>>> +
> ...
>>>> +struct range arch_get_mappable_range(void)
>>>> +{
>>>> +	struct range memhp_range;
>>>> +
>>>> +	memhp_range.start = 0;
>>>> +	memhp_range.end =  VMEM_MAX_PHYS;
>>>> +	return memhp_range;
>>>> +}
>>>> +
>>>>  int arch_add_memory(int nid, u64 start, u64 size,
>>>>  		    struct mhp_params *params)
>>>>  {
>>>> @@ -291,6 +300,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>>>  	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>>>>  		return -EINVAL;
>>>>  
>>>> +	VM_BUG_ON(!memhp_range_allowed(start, size, 1));
>>>>  	rc = vmem_add_mapping(start, size);
>>>>  	if (rc)
>>> Is there a reason why you added the memhp_range_allowed() check call
>>> to arch_add_memory() instead of vmem_add_mapping()? If you would do
>>
>> As I had mentioned previously, memhp_range_allowed() is available with
>> CONFIG_MEMORY_HOTPLUG but vmem_add_mapping() is always available. Hence
>> there will be a build failure in vmem_add_mapping() for the range check
>> memhp_range_allowed() without memory hotplug enabled.
>>
>>> that, then the extra code in __segment_load() wouldn't be
>>> required.
>>> Even though the error message from memhp_range_allowed() might be
>>> highly confusing.
>>
>> Alternatively leaving __segment_load() and vmem_add_memory() unchanged
>> will create three range checks i.e two memhp_range_allowed() and the
>> existing VMEM_MAX_PHYS check in vmem_add_mapping() on all the hotplug
>> paths, which is not optimal.
> 
> Ah, sorry. I didn't follow this discussion too closely. I just thought
> my point of view would be clear: let's not have two different ways to
> check for the same thing which must be kept in sync.
> Therefore I was wondering why this next version is still doing
> that. Please find a way to solve this.

The following change is after the current series and should work with
and without memory hotplug enabled. There will be just a single place
i.e vmem_get_max_addr() to update in case the maximum address changes
from VMEM_MAX_PHYS to something else later.

diff --git a/arch/s390/include/asm/sections.h b/arch/s390/include/asm/sections.h
index 0c21514..2da496f 100644
--- a/arch/s390/include/asm/sections.h
+++ b/arch/s390/include/asm/sections.h
@@ -16,6 +16,7 @@ static inline int arch_is_kernel_initmem_freed(unsigned long addr)
 	       addr < (unsigned long)__init_end;
 }
 
+unsigned long vmem_get_max_addr(void);
 /*
  * .boot.data section contains variables "shared" between the decompressor and
  * the decompressed kernel. The decompressor will store values in them, and
diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index cc055a7..1bddd6f 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -28,6 +28,7 @@
 #include <asm/extmem.h>
 #include <asm/cpcmd.h>
 #include <asm/setup.h>
+#include <asm/sections.h>
 
 #define DCSS_PURGESEG   0x08
 #define DCSS_LOADSHRX	0x20
@@ -287,6 +288,13 @@ segment_overlaps_others (struct dcss_segment *seg)
 	return 0;
 }
 
+static bool segment_outside_range(struct dcss_segment *seg)
+{
+	unsigned long max_addr = vmem_get_max_addr();
+
+	return (seg->end + 1 > max_addr || seg->end + 1 < seg->start_addr);
+}
+
 /*
  * real segment loading function, called from segment_load
  */
@@ -337,7 +345,7 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
 		goto out_free_resource;
 	}
 
-	if (seg->end + 1 > VMEM_MAX_PHYS || seg->end + 1 < seg->start_addr) {
+	if (segment_outside_range(seg)) {
 		rc = -ERANGE;
 		goto out_resource;
 	}
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 64937ba..5c6ee9f 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -283,7 +283,7 @@ struct range arch_get_mappable_range(void)
 	struct range memhp_range;
 
 	memhp_range.start = 0;
-	memhp_range.end =  VMEM_MAX_PHYS;
+	memhp_range.end =  vmem_get_max_addr();
 	return memhp_range;
 }
 
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 749eab4..6044e85 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -532,6 +532,11 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
 	mutex_unlock(&vmem_mutex);
 }
 
+unsigned long vmem_get_max_addr(void)
+{
+        return VMEM_MAX_PHYS;
+}
+
 int vmem_add_mapping(unsigned long start, unsigned long size)
 {
 	int ret;
-- 
2.7.4

