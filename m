Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB513020E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 04:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbhAYDqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 22:46:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11581 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbhAYDqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 22:46:07 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DPG1h4D8TzMMq1;
        Mon, 25 Jan 2021 11:43:52 +0800 (CST)
Received: from [10.174.151.207] (10.174.151.207) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 11:45:15 +0800
Subject: Re: [PATCH] nitro_enclaves: set master in the procedure of NE probe
To:     "Paraschiv, Andra-Irina" <andraprs@amazon.com>
CC:     <arei.gonglei@huawei.com>, <linux-kernel@vger.kernel.org>,
        <lexnv@amazon.com>, <alcioa@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20210119033059.1467-1-longpeng2@huawei.com>
 <2d00a341-1442-9c1f-8114-7b7ded7f4d2e@amazon.com>
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Message-ID: <edc5c578-4105-e6d6-3ba2-e39000deb1dd@huawei.com>
Date:   Mon, 25 Jan 2021 11:45:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2d00a341-1442-9c1f-8114-7b7ded7f4d2e@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.207]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/1/20 18:27, Paraschiv, Andra-Irina 写道:
> 
> 
> On 19/01/2021 05:30, Longpeng(Mike) wrote:
>> According the PCI spec:
>>    Bus Master Enable – Controls the ability of a PCI Express
>>    Endpoint to issue Memory and I/O Read/Write Requests, and
>>    the ability of a Root or Switch Port to forward Memory and
>>    I/O Read/Write Requests in the Upstream direction
>>
>> Set BusMaster to make the driver to be PCI conformant.
> 
> Could update the commit title and message body to reflect more the why and what for the change. One option can be:
> 
> nitro_enclaves: Set Bus Master for the NE PCI device
> 
> Enable Bus Master for the NE PCI device, according to the PCI spec
> for submitting memory or I/O requests:
>   Bus Master Enable ...
> 
> 
> 
> Please include the changelog in the commit message for the next revision(s).
> 
> + Greg in CC, as the patches for the Nitro Enclaves kernel driver are first included in the char misc tree, then in the linux next and finally in the mainline.
> 
Will update the commit message in V2.

>>
>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>> ---
>>   drivers/virt/nitro_enclaves/ne_pci_dev.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.c b/drivers/virt/nitro_enclaves/ne_pci_dev.c
>> index b9c1de4..143207e 100644
>> --- a/drivers/virt/nitro_enclaves/ne_pci_dev.c
>> +++ b/drivers/virt/nitro_enclaves/ne_pci_dev.c
>> @@ -480,6 +480,8 @@ static int ne_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>                  goto free_ne_pci_dev;
>>          }
>>
>> +       pci_set_master(pdev);
> 
> I was looking if we need the reverse for this - pci_clear_master() [1] - on the error and remove / shutdown codebase paths, but pci_disable_device() seems to include the bus master disable logic [2][3].
> 
No need to call pci_clear_master.

> Thanks,
> Andra
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci.c?h=v5.11-rc4#n4312
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci.c?h=v5.11-rc4#n2104
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci.c?h=v5.11-rc4#n4242
> 
>> +
>>          rc = pci_request_regions_exclusive(pdev, "nitro_enclaves");
>>          if (rc < 0) {
>>                  dev_err(&pdev->dev, "Error in pci request regions [rc=%d]\n", rc);
>> -- 
>> 1.8.3.1
>>
> 
> 
> 
> 
> Amazon Development Center (Romania) S.R.L. registered office: 27A Sf. Lazar Street, UBC5, floor 2, Iasi, Iasi County, 700045, Romania. Registered in Romania. Registration number J22/2621/2005.
