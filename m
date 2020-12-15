Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E80C2DACB5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgLOMG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:06:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9609 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgLOMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:05:55 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CwH462NdXzM6Ks;
        Tue, 15 Dec 2020 20:04:22 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Tue, 15 Dec 2020
 20:04:09 +0800
Subject: Re: [PATCH] drm/hisilicon: Fix rmmod hibmc_drm failed
To:     Tian Tao <tiantao6@hisilicon.com>, <airlied@linux.ie>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <1608001299-7237-1-git-send-email-tiantao6@hisilicon.com>
 <X9ilOeTwn9V0Jpdp@phenom.ffwll.local> <X9ilnrE1jcqS3LBF@phenom.ffwll.local>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <1b072884-6d4e-905c-c38e-b6cbe1be2174@huawei.com>
Date:   Tue, 15 Dec 2020 20:04:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <X9ilnrE1jcqS3LBF@phenom.ffwll.local>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2020/12/15 20:01, Daniel Vetter Ð´µÀ:
> On Tue, Dec 15, 2020 at 12:59:53PM +0100, Daniel Vetter wrote:
>> On Tue, Dec 15, 2020 at 11:01:39AM +0800, Tian Tao wrote:
>>> drm_irq_uninstall should be called before pci_disable_msi, if use
>>> devm_drm_irq_install to register the interrupt, the system will
>>> call pci_disable_msi first and then call drm_irq_uninstall, which
>>>   will result in the following callstack.
>>>
>>> kernel BUG at drivers/pci/msi.c:376!
>>> Internal error: Oops - BUG: 0 [#1] SMP
>>> CPU: 93 PID: 173814 Comm: rmmod Tainted:
>>> pstate: a0400009 (NzCv daif +PAN -UAO -TCO BTYPE=--)
>>> pc : free_msi_irqs+0x17c/0x1a0
>>> lr : free_msi_irqs+0x16c/0x1a0
>>> sp : ffff2028157f7bd0
>>> x29: ffff2028157f7bd0 x28: ffff202849edab00
>>> x27: 0000000000000000 x26: 0000000000000000
>>> x25: 0000000000000000 x24: 0000000000000000
>>> x23: ffff0020851da000 x22: ffff0020851da2d8
>>> x21: ffff0020cc829000 x20: 0000000000000000
>>> x19: ffff0020d6714800 x18: 0000000000000010
>>> x17: 0000000000000000 x16: 0000000000000000
>>> x15: ffffffffffffffff x14: ffff2028957f77df
>>> x13: ffff2028157f77ed x12: 0000000000000000
>>> x11: 0000000000000040 x10: ffff800011b2f8e0
>>> x9 : ffff800011b2f8d8 x8 : ffff2020203fc458
>>> x7 : 0000000000000000 x6 : 0000000000000000
>>> x5 : ffff2020203fc430 x4 : ffff2020203fc4a0
>>> x3 : 0000000000000000 x2 : 0000000000000000
>>> x1 : 00000000000002c9 x0 : ffff0020d6719500
>>> Call trace:
>>>   free_msi_irqs+0x17c/0x1a0
>>>   pci_disable_msi+0xe4/0x118
>>>   hibmc_unload+0x44/0x80 [hibmc_drm]
>>>   hibmc_pci_remove+0x2c/0x38 [hibmc_drm]
>>>   pci_device_remove+0x48/0x108
>>>   device_release_driver_internal+0x118/0x1f0
>>>   driver_detach+0x6c/0xe0
>>>   bus_remove_driver+0x74/0x100
>>>   driver_unregister+0x34/0x60
>>>   pci_unregister_driver+0x24/0xd8
>>>   hibmc_pci_driver_exit+0x14/0xe768 [hibmc_drm]
>>>   __arm64_sys_delete_module+0x1fc/0x2d0
>>>   el0_svc_common.constprop.3+0xa8/0x188
>>>   do_el0_svc+0x80/0xa0
>>>   el0_sync_handler+0x8c/0xb0
>>>   el0_sync+0x15c/0x180
>>> Code: f940b400 b4ffff00 a903e7b8 f90013b5 (d4210000)
>>> ---[ end trace 310d94ee8abef44f ]---
>>> Kernel panic - not syncing: Oops - BUG: Fatal exception
>>>
>> You should mention here which patch you're reverting. With that:
>>
>> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> Since the proper fix will probably take a while longer. Also why was this
>> not noticed when merging the original patch? hisilicon is the only user of
>> devm_drm_irq_install we have in-tree right now.
> I also just noticed that you didn't add devm_drm_irq_install to the list
> of functions in Documentation/driver-api/driver-model/devres.rst. Can you
> please submit a patch to fix this?
sure
>
> Thanks, Daniel
>
>> -Daniel
>>
>>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>>> ---
>>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>> index e3ab765b..02f3bd1 100644
>>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>> @@ -251,6 +251,10 @@ static int hibmc_hw_init(struct hibmc_drm_private *priv)
>>>   static int hibmc_unload(struct drm_device *dev)
>>>   {
>>>   	drm_atomic_helper_shutdown(dev);
>>> +
>>> +	if (dev->irq_enabled)
>>> +		drm_irq_uninstall(dev);
>>> +
>>>   	pci_disable_msi(dev->pdev);
>>>   
>>>   	return 0;
>>> @@ -286,7 +290,7 @@ static int hibmc_load(struct drm_device *dev)
>>>   	if (ret) {
>>>   		drm_warn(dev, "enabling MSI failed: %d\n", ret);
>>>   	} else {
>>> -		ret = devm_drm_irq_install(dev, dev->pdev->irq);
>>> +		ret = drm_irq_install(dev, dev->pdev->irq);
>>>   		if (ret)
>>>   			drm_warn(dev, "install irq failed: %d\n", ret);
>>>   	}
>>> -- 
>>> 2.7.4
>>>
>> -- 
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch

