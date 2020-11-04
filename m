Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0572B2A5F99
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgKDI10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:27:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6743 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgKDI10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:27:26 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CR0Bb0VjJzkfH8;
        Wed,  4 Nov 2020 16:27:19 +0800 (CST)
Received: from [10.174.179.106] (10.174.179.106) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 4 Nov 2020 16:27:22 +0800
Subject: Re: Patch "powerpc/powernv/dump: Fix race while processing OPAL dump"
 has been added to the 4.4-stable tree
To:     <linux-kernel@vger.kernel.org>, <hegdevasant@linux.vnet.ibm.com>
CC:     <stable-commits@vger.kernel.org>
References: <20201026055725.6F19F21BE5@mail.kernel.org>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <476bcc61-e59b-f3e5-e50b-44c65ee83a65@huawei.com>
Date:   Wed, 4 Nov 2020 16:27:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201026055725.6F19F21BE5@mail.kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.106]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This will lead a compile error.


arch/powerpc/platforms/powernv/opal-dump.c: In function ¡®process_dump¡¯:
arch/powerpc/platforms/powernv/opal-dump.c:409:7: error: void value not 
ignored as it ought to be
   dump = create_dump_obj(dump_id, dump_size, dump_type);
        ^
make[2]: *** [arch/powerpc/platforms/powernv/opal-dump.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [arch/powerpc/platforms/powernv] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [arch/powerpc/platforms] Error 2
make: *** Waiting for unfinished jobs....


ÔÚ 2020/10/26 13:57, Sasha Levin Ð´µÀ:
> This is a note to let you know that I've just added the patch titled
> 
>      powerpc/powernv/dump: Fix race while processing OPAL dump
> 
> to the 4.4-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       powerpc-powernv-dump-fix-race-while-processing-opal-.patch
> and it can be found in the queue-4.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit faa63b3cf39346b7a1e96d128133aadd8b59cc4a
> Author: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> Date:   Sat Oct 17 22:12:10 2020 +0530
> 
>      powerpc/powernv/dump: Fix race while processing OPAL dump
>      
>      [ Upstream commit 0a43ae3e2beb77e3481d812834d33abe270768ab ]
>      
>      Every dump reported by OPAL is exported to userspace through a sysfs
>      interface and notified using kobject_uevent(). The userspace daemon
>      (opal_errd) then reads the dump and acknowledges that the dump is
>      saved safely to disk. Once acknowledged the kernel removes the
>      respective sysfs file entry causing respective resources to be
>      released including kobject.
>      
>      However it's possible the userspace daemon may already be scanning
>      dump entries when a new sysfs dump entry is created by the kernel.
>      User daemon may read this new entry and ack it even before kernel can
>      notify userspace about it through kobject_uevent() call. If that
>      happens then we have a potential race between
>      dump_ack_store->kobject_put() and kobject_uevent which can lead to
>      use-after-free of a kernfs object resulting in a kernel crash.
>      
>      This patch fixes this race by protecting the sysfs file
>      creation/notification by holding a reference count on kobject until we
>      safely send kobject_uevent().
>      
>      The function create_dump_obj() returns the dump object which if used
>      by caller function will end up in use-after-free problem again.
>      However, the return value of create_dump_obj() function isn't being
>      used today and there is no need as well. Hence change it to return
>      void to make this fix complete.
>      
>      Fixes: c7e64b9ce04a ("powerpc/powernv Platform dump interface")
>      Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
>      Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>      Link: https://lore.kernel.org/r/20201017164210.264619-1-hegdevasant@linux.vnet.ibm.com
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
> index 4c827826c05eb..e21e2c0af69d2 100644
> --- a/arch/powerpc/platforms/powernv/opal-dump.c
> +++ b/arch/powerpc/platforms/powernv/opal-dump.c
> @@ -319,15 +319,14 @@ static ssize_t dump_attr_read(struct file *filep, struct kobject *kobj,
>   	return count;
>   }
>   
> -static struct dump_obj *create_dump_obj(uint32_t id, size_t size,
> -					uint32_t type)
> +static void create_dump_obj(uint32_t id, size_t size, uint32_t type)
>   {
>   	struct dump_obj *dump;
>   	int rc;
>   
>   	dump = kzalloc(sizeof(*dump), GFP_KERNEL);
>   	if (!dump)
> -		return NULL;
> +		return;
>   
>   	dump->kobj.kset = dump_kset;
>   
> @@ -347,21 +346,39 @@ static struct dump_obj *create_dump_obj(uint32_t id, size_t size,
>   	rc = kobject_add(&dump->kobj, NULL, "0x%x-0x%x", type, id);
>   	if (rc) {
>   		kobject_put(&dump->kobj);
> -		return NULL;
> +		return;
>   	}
>   
> +	/*
> +	 * As soon as the sysfs file for this dump is created/activated there is
> +	 * a chance the opal_errd daemon (or any userspace) might read and
> +	 * acknowledge the dump before kobject_uevent() is called. If that
> +	 * happens then there is a potential race between
> +	 * dump_ack_store->kobject_put() and kobject_uevent() which leads to a
> +	 * use-after-free of a kernfs object resulting in a kernel crash.
> +	 *
> +	 * To avoid that, we need to take a reference on behalf of the bin file,
> +	 * so that our reference remains valid while we call kobject_uevent().
> +	 * We then drop our reference before exiting the function, leaving the
> +	 * bin file to drop the last reference (if it hasn't already).
> +	 */
> +
> +	/* Take a reference for the bin file */
> +	kobject_get(&dump->kobj);
>   	rc = sysfs_create_bin_file(&dump->kobj, &dump->dump_attr);
> -	if (rc) {
> +	if (rc == 0) {
> +		kobject_uevent(&dump->kobj, KOBJ_ADD);
> +
> +		pr_info("%s: New platform dump. ID = 0x%x Size %u\n",
> +			__func__, dump->id, dump->size);
> +	} else {
> +		/* Drop reference count taken for bin file */
>   		kobject_put(&dump->kobj);
> -		return NULL;
>   	}
>   
> -	pr_info("%s: New platform dump. ID = 0x%x Size %u\n",
> -		__func__, dump->id, dump->size);
> -
> -	kobject_uevent(&dump->kobj, KOBJ_ADD);
> -
> -	return dump;
> +	/* Drop our reference */
> +	kobject_put(&dump->kobj);
> +	return;
>   }
>   
>   static irqreturn_t process_dump(int irq, void *data)
> .
> 
