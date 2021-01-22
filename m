Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EE93001B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbhAVLff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:35:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11431 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbhAVLec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:34:32 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DMcZB6wYzzj7l7;
        Fri, 22 Jan 2021 19:32:50 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Fri, 22 Jan 2021
 19:33:40 +0800
Subject: Re: [PATCH] uacce: Add uacce_ctrl misc device
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1611220154-90232-1-git-send-email-wangzhou1@hisilicon.com>
 <YAlM8hC9OGm3X/0k@kroah.com>
CC:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>,
        "Sihang Chen" <chensihang1@hisilicon.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <dcbe9a53-8aa0-10f5-4e78-ae0ab94171de@hisilicon.com>
Date:   Fri, 22 Jan 2021 19:33:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YAlM8hC9OGm3X/0k@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/21 17:44, Greg Kroah-Hartman wrote:
> On Thu, Jan 21, 2021 at 05:09:14PM +0800, Zhou Wang wrote:
>> When IO page fault happens, DMA performance will be affected. Pin user page
>> can avoid IO page fault, this patch introduces a new char device named
>> /dev/uacce_ctrl to help to maintain pin/unpin pages. User space can do
>> pin/unpin pages by ioctls of an open file of /dev/uacce_ctrl, all pinned
>> pages under one file will be unpinned in file release process.
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Signed-off-by: Sihang Chen <chensihang1@hisilicon.com>
>> Suggested-by: Barry Song <song.bao.hua@hisilicon.com>
>> ---
>>  drivers/misc/uacce/uacce.c      | 172 +++++++++++++++++++++++++++++++++++++++-
>>  include/uapi/misc/uacce/uacce.h |  16 ++++
>>  2 files changed, 187 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
>> index d07af4e..b8ac408 100644
>> --- a/drivers/misc/uacce/uacce.c
>> +++ b/drivers/misc/uacce/uacce.c
>> @@ -2,6 +2,7 @@
>>  #include <linux/compat.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/iommu.h>
>> +#include <linux/miscdevice.h>
>>  #include <linux/module.h>
>>  #include <linux/poll.h>
>>  #include <linux/slab.h>
>> @@ -12,6 +13,16 @@ static dev_t uacce_devt;
>>  static DEFINE_MUTEX(uacce_mutex);
>>  static DEFINE_XARRAY_ALLOC(uacce_xa);
>>  
>> +struct uacce_pin_container {
>> +	struct xarray array;
>> +};
>> +
>> +struct pin_pages {
>> +	unsigned long first;
>> +	unsigned long nr_pages;
>> +	struct page **pages;
>> +};
>> +
>>  static int uacce_start_queue(struct uacce_queue *q)
>>  {
>>  	int ret = 0;
>> @@ -497,6 +508,152 @@ void uacce_remove(struct uacce_device *uacce)
>>  }
>>  EXPORT_SYMBOL_GPL(uacce_remove);
>>  
>> +int uacce_ctrl_open(struct inode *inode, struct file *file)
>> +{
>> +	struct uacce_pin_container *p;
>> +
>> +	p = kzalloc(sizeof(*p), GFP_KERNEL);
>> +	if (!p)
>> +		return -ENOMEM;
>> +	file->private_data = p;
>> +
>> +	xa_init(&p->array);
>> +
>> +	return 0;
>> +}
>> +
>> +int uacce_ctrl_release(struct inode *inode, struct file *file)
>> +{
>> +	struct uacce_pin_container *priv = file->private_data;
>> +	struct pin_pages *p;
>> +	unsigned long idx;
>> +
>> +	xa_for_each(&priv->array, idx, p) {
>> +		unpin_user_pages(p->pages, p->nr_pages);
>> +		xa_erase(&priv->array, p->first);
>> +		vfree(p->pages);
>> +		kfree(p);
>> +	}
>> +
>> +	xa_destroy(&priv->array);
>> +	kfree(priv);
>> +
>> +	return 0;
>> +}
>> +
>> +static int uacce_pin_page(struct uacce_pin_container *priv,
>> +			  struct uacce_pin_address *addr)
>> +{
>> +	unsigned int flags = FOLL_FORCE | FOLL_WRITE;
>> +	unsigned long first, last, nr_pages;
>> +	struct page **pages;
>> +	struct pin_pages *p;
>> +	int ret;
>> +
>> +	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;
>> +	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
>> +	nr_pages = last - first + 1;
>> +
>> +	pages = vmalloc(nr_pages * sizeof(struct page *));
>> +	if (!pages)
>> +		return -ENOMEM;
>> +
>> +	p = kzalloc(sizeof(*p), GFP_KERNEL);
>> +	if (!p) {
>> +		ret = -ENOMEM;
>> +		goto free;
>> +	}
>> +
>> +	ret = pin_user_pages_fast(addr->addr & PAGE_MASK, nr_pages,
>> +				  flags | FOLL_LONGTERM, pages);
>> +	if (ret != nr_pages) {
>> +		pr_err("uacce: Failed to pin page\n");
>> +		goto free_p;
>> +	}
>> +	p->first = first;
>> +	p->nr_pages = nr_pages;
>> +	p->pages = pages;
>> +
>> +	ret = xa_err(xa_store(&priv->array, p->first, p, GFP_KERNEL));
>> +	if (ret)
>> +		goto unpin_pages;
>> +
>> +	return 0;
>> +
>> +unpin_pages:
>> +	unpin_user_pages(pages, nr_pages);
>> +free_p:
>> +	kfree(p);
>> +free:
>> +	vfree(pages);
>> +	return ret;
>> +}
>> +
>> +static int uacce_unpin_page(struct uacce_pin_container *priv,
>> +			    struct uacce_pin_address *addr)
>> +{
>> +	unsigned long first, last, nr_pages;
>> +	struct pin_pages *p;
>> +
>> +	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;
>> +	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
>> +	nr_pages = last - first + 1;
>> +
>> +	/* find pin_pages */
>> +	p = xa_load(&priv->array, first);
>> +	if (!p)
>> +		return -ENODEV;
>> +
>> +	if (p->nr_pages != nr_pages)
>> +		return -EINVAL;
>> +
>> +	/* unpin */
>> +	unpin_user_pages(p->pages, p->nr_pages);
>> +
>> +	/* release resource */
>> +	xa_erase(&priv->array, first);
>> +	vfree(p->pages);
>> +	kfree(p);
>> +
>> +	return 0;
>> +}
>> +
>> +static long uacce_ctrl_unl_ioctl(struct file *filep, unsigned int cmd,
>> +				 unsigned long arg)
>> +{
>> +	struct uacce_pin_container *p = filep->private_data;
>> +	struct uacce_pin_address addr;
>> +	int ret;
>> +
>> +	if (copy_from_user(&addr, (void __user *)arg,
>> +			   sizeof(struct uacce_pin_address)))
>> +		return -EFAULT;
>> +
>> +	switch (cmd) {
>> +	case UACCE_CMD_PIN:
>> +		return uacce_pin_page(p, &addr);
>> +
>> +	case UACCE_CMD_UNPIN:
>> +		return uacce_unpin_page(p, &addr);
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct file_operations uacce_ctrl_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = uacce_ctrl_open,
>> +	.release = uacce_ctrl_release,
>> +	.unlocked_ioctl	= uacce_ctrl_unl_ioctl,
>> +};
>> +
>> +static struct miscdevice uacce_ctrl_miscdev = {
>> +	.name = "uacce_ctrl",
>> +	.minor = MISC_DYNAMIC_MINOR,
>> +	.fops = &uacce_ctrl_fops,
>> +};
>> +
>>  static int __init uacce_init(void)
>>  {
>>  	int ret;
>> @@ -507,13 +664,26 @@ static int __init uacce_init(void)
>>  
>>  	ret = alloc_chrdev_region(&uacce_devt, 0, MINORMASK, UACCE_NAME);
>>  	if (ret)
>> -		class_destroy(uacce_class);
>> +		goto destroy_class;
>> +
>> +	ret = misc_register(&uacce_ctrl_miscdev);
>> +	if (ret) {
>> +		pr_err("uacce: ctrl dev registration failed\n");
>> +		goto unregister_cdev;
>> +	}
>>  
>> +	return 0;
>> +
>> +unregister_cdev:
>> +	unregister_chrdev_region(uacce_devt, MINORMASK);
>> +destroy_class:
>> +	class_destroy(uacce_class);
>>  	return ret;
>>  }
>>  
>>  static __exit void uacce_exit(void)
>>  {
>> +	misc_deregister(&uacce_ctrl_miscdev);
>>  	unregister_chrdev_region(uacce_devt, MINORMASK);
>>  	class_destroy(uacce_class);
>>  }
>> diff --git a/include/uapi/misc/uacce/uacce.h b/include/uapi/misc/uacce/uacce.h
>> index cc71856..f9e326f 100644
>> --- a/include/uapi/misc/uacce/uacce.h
>> +++ b/include/uapi/misc/uacce/uacce.h
>> @@ -35,4 +35,20 @@ enum uacce_qfrt {
>>  	UACCE_QFRT_DUS = 1,
>>  };
>>  
>> +/**
>> + * struct uacce_pin_address - Expected pin user space address and size
>> + * @addr: Address to pin
>> + * @size: Size of pin address
>> + */
>> +struct uacce_pin_address {
>> +	unsigned long addr;
>> +	unsigned long size;
> 
> These are not valid ioctl structure members for crossing the user/kernel
> boundry.  Please make them work properly (i.e. use __u64 and friends).

Got it, will modify this to __u64 together with other problems found by 0-day robot.

Thanks,
Zhou

> 
> thanks,
> 
> greg k-h
> 
> .
> 

