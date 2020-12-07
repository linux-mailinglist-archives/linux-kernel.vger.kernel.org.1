Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C83A2D08EE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 02:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgLGBvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 20:51:24 -0500
Received: from linux.microsoft.com ([13.77.154.182]:49282 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgLGBvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 20:51:24 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 73EE020B717A;
        Sun,  6 Dec 2020 17:50:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 73EE020B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607305842;
        bh=vtq8CyQBySYNuts4DDchsgC3KgHAe6Af4KocNaAPQZw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LtRQZg+2FE0F3ZEro0HxgFb8Pb+6iJetwOA0BneYeF5Eoen9J+voUIfOUSV3N1MHj
         CGHdsDIzs9J6/zsAxGtOeTqBj2S34LHl/L4d3DWv15UwNk35LTXbLoZB8fon4tPM9e
         4H/TLv4OSL4EA5GJnMUkrk//mHAUyOxsk3GGXsn4=
Subject: Re: [PATCH v10 2/8] powerpc: Move delete_fdt_mem_rsv() to
 drivers/of/kexec.c
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, gregkh@linuxfoundation.org,
        james.morse@arm.com, catalin.marinas@arm.com, sashal@kernel.org,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
References: <20201204195149.611-1-nramas@linux.microsoft.com>
 <20201204195149.611-3-nramas@linux.microsoft.com>
 <87ft4louto.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <40f8c03a-f08f-d49e-b404-9a6d79873dd1@linux.microsoft.com>
Date:   Sun, 6 Dec 2020 17:50:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87ft4louto.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/20 6:22 PM, Thiago Jung Bauermann wrote:
> 
> Hello Lakshmi,
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> delete_fdt_mem_rsv() retrieves the memory reserve map entry, for
>> the given starting address and size, from the device tree blob, and
>> removes the entry from the device tree blob. This function is called
>> to free the resources reserved for the buffer used for carrying forward
>> the IMA measurement logs on kexec. This function does not have
>> architecture specific code, but is currently limited to powerpc.
>>
>> Move delete_fdt_mem_rsv() to "drivers/of/kexec_fdt.c" so that it is
> 
> s/kexec_fdt.c/kexec.c/

Missed that in the patch description. Will fix it. Thanks.

>> accessible for other architectures as well.
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>>   arch/powerpc/include/asm/kexec.h |  1 -
>>   arch/powerpc/kexec/file_load.c   | 32 -----------------
>>   drivers/of/Makefile              |  1 +
>>   drivers/of/kexec.c               | 61 ++++++++++++++++++++++++++++++++
>>   include/linux/kexec.h            |  5 +++
>>   5 files changed, 67 insertions(+), 33 deletions(-)
>>   create mode 100644 drivers/of/kexec.c
>>
>> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
>> index 55d6ede30c19..7c223031ecdd 100644
>> --- a/arch/powerpc/include/asm/kexec.h
>> +++ b/arch/powerpc/include/asm/kexec.h
>> @@ -126,7 +126,6 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
>>   int setup_new_fdt(const struct kimage *image, void *fdt,
>>   		  unsigned long initrd_load_addr, unsigned long initrd_len,
>>   		  const char *cmdline);
>> -int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size);
>>   
>>   #ifdef CONFIG_PPC64
>>   struct kexec_buf;
>> diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
>> index 9a232bc36c8f..9efc98b1e2ae 100644
>> --- a/arch/powerpc/kexec/file_load.c
>> +++ b/arch/powerpc/kexec/file_load.c
>> @@ -109,38 +109,6 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
>>   	return 0;
>>   }
>>   
>> -/**
>> - * delete_fdt_mem_rsv - delete memory reservation with given address and size
>> - *
>> - * Return: 0 on success, or negative errno on error.
>> - */
>> -int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
>> -{
>> -	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
>> -
>> -	for (i = 0; i < num_rsvs; i++) {
>> -		uint64_t rsv_start, rsv_size;
>> -
>> -		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
>> -		if (ret) {
>> -			pr_err("Malformed device tree.\n");
>> -			return -EINVAL;
>> -		}
>> -
>> -		if (rsv_start == start && rsv_size == size) {
>> -			ret = fdt_del_mem_rsv(fdt, i);
>> -			if (ret) {
>> -				pr_err("Error deleting device tree reservation.\n");
>> -				return -EINVAL;
>> -			}
>> -
>> -			return 0;
>> -		}
>> -	}
>> -
>> -	return -ENOENT;
>> -}
>> -
>>   /*
>>    * setup_new_fdt - modify /chosen and memory reservation for the next kernel
>>    * @image:		kexec image being loaded.
>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> index 6e1e5212f058..77d24712c0c8 100644
>> --- a/drivers/of/Makefile
>> +++ b/drivers/of/Makefile
>> @@ -13,5 +13,6 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
>>   obj-$(CONFIG_OF_RESOLVE)  += resolver.o
>>   obj-$(CONFIG_OF_OVERLAY) += overlay.o
>>   obj-$(CONFIG_OF_NUMA) += of_numa.o
>> +obj-$(CONFIG_OF_FLATTREE) += kexec.o
> 
> Isn't this too broad? kexec.o will only be useful to kernel configs
> which enable CONFIG_KEXEC_FILE, so perhaps do:
> 
> ifdef CONFIG_OF_FLATTREE
> ifdef CONFIG_KEXEC_FILE
> obj-y += kexec.o
> endif
> endif
> 
> What do you think?

Per Rob's feedback on v9 patch set, I have moved all the architecture 
independent ima kexec functions to a single file "drivers/of/kexec.c"

Since these functions are enabled on different kernel CONFIGs, I have 
used IS_ENABLED(CONFIG_XYZ) macro instead of "#ifdef" in the C file to 
conditionally compile.

> 
>>   obj-$(CONFIG_OF_UNITTEST) += unittest-data/
>> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
>> new file mode 100644
>> index 000000000000..b7d59105fcb8
>> --- /dev/null
>> +++ b/drivers/of/kexec.c
>> @@ -0,0 +1,61 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2020 Microsoft Corporation
>> + *
>> + * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
>> + *
>> + * File: kexec.c
>> + *	Defines kexec related functions.
>> + */
>> +
>> +#define pr_fmt(fmt)	"OF: kexec: " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/memblock.h>
>> +#include <linux/kexec.h>
>> +#include <linux/of.h>
>> +#include <linux/of_fdt.h>
>> +#include <linux/libfdt.h>
>> +
>> +/**
>> + * delete_fdt_mem_rsv - delete memory reservation with given address and size
>> + *
>> + * @fdt: Flattened Device Tree to update
>> + * @start: Starting address of the reservation to delete
>> + * @size: Size of the reservation to delete
>> + *
>> + * Return: 0 on success, or negative errno on error.
>> + */
>> +int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
>> +{
>> +	int i, ret, num_rsvs;
>> +
>> +	if (!IS_ENABLED(CONFIG_KEXEC_FILE))
>> +		return 0;
> 
> If you agree with my suggestion, then this IS_ENABLED() wouldn't be
> needed.
> 

Please see my response above.

If there is a way to keep all the ima kexec functions in a single file 
and yet not use "#ifdef" in C file to conditionally compile, please let 
me know. I'll update.

thanks,
  -lakshmi

>> +
>> +	num_rsvs = fdt_num_mem_rsv(fdt);
>> +	for (i = 0; i < num_rsvs; i++) {
>> +		uint64_t rsv_start, rsv_size;
>> +
>> +		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
>> +		if (ret) {
>> +			pr_err("Malformed device tree.\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (rsv_start == start && rsv_size == size) {
>> +			ret = fdt_del_mem_rsv(fdt, i);
>> +			if (ret) {
>> +				pr_err("Error deleting device tree reservation.\n");
>> +				return -EINVAL;
>> +			}
>> +
>> +			pr_debug("Freed reserved memory at %lu of size %lu\n",
>> +				 start, size);
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return -ENOENT;
>> +}
> 
> The function code is unchanged apart from the addition of the
> IS_ENABLED() and the pr_debug(), so that is good.
> 
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 9e93bef52968..d0234c4815da 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -407,6 +407,11 @@ static inline int kexec_crash_loaded(void) { return 0; }
>>   #define kexec_in_progress false
>>   #endif /* CONFIG_KEXEC_CORE */
>>   
>> +#if defined(CONFIG_OF_FLATTREE)
> 
> This would also change to require CONFIG_KEXEC_FILE.
> 
>> +extern int delete_fdt_mem_rsv(void *fdt, unsigned long start,
>> +			      unsigned long size);
>> +#endif /* CONFIG_OF_FLATTREE */
>> +
>>   #endif /* !defined(__ASSEBMLY__) */
>>   
>>   #endif /* LINUX_KEXEC_H */
> 
> 

