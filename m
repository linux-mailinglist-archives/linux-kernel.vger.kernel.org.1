Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1F727D2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 17:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgI2Pld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 11:41:33 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33476 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728241AbgI2Plc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 11:41:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UAVQF6N_1601394085;
Received: from 30.39.52.131(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UAVQF6N_1601394085)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Sep 2020 23:41:26 +0800
Subject: Re: [PATCH] arm64: PCI: Validate the node before setting node id for
 root bus
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
        baolin.wang7@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1600770804-116365-1-git-send-email-baolin.wang@linux.alibaba.com>
 <20200928140054.GA11500@willie-the-truck>
 <20200928144957.GA90366@VM20190228-100.tbsite.net>
 <20200928152326.GA15640@e121166-lin.cambridge.arm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <26284ca5-ea05-0496-629d-9951f49dda8f@linux.alibaba.com>
Date:   Tue, 29 Sep 2020 23:41:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.0
MIME-Version: 1.0
In-Reply-To: <20200928152326.GA15640@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2020/9/28 23:23, Lorenzo Pieralisi Ð´µÀ:
> On Mon, Sep 28, 2020 at 10:49:57PM +0800, Baolin Wang wrote:
>> On Mon, Sep 28, 2020 at 03:00:55PM +0100, Will Deacon wrote:
>>> [+ Lorenzo]
>>>
>>> On Tue, Sep 22, 2020 at 06:33:24PM +0800, Baolin Wang wrote:
>>>> If the BIOS disabled the NUMA configuration, but did not change the
>>>> proximity domain description in the SRAT table, so the PCI root bus
>>>> device may get a incorrect node id by acpi_get_node().
>>>
>>> How "incorrect" are we talking here? What actually goes wrong? At some
>>> point, we have to trust what the firmware is telling us.
>>
>> What I mean is, if we disable the NUMA from BIOS
> 
> Please define what this means ie are you removing SRAT from ACPI static
> tables ?

Yes.

> 
>> but we did not change the PXM for the PCI devices,
> 
> If a _PXM maps to a proximity domain that is not described in the SRAT
> your firmware is buggy.

Sorry for confusing, that's not what I mean. When the BIOS disable the 
NUMA (remove the SRAT table), but the PCI devices' _PXM description is 
still available, which means we can still get the pxm from 
acpi_evaluate_integer() in this case.

So we can get below inconsistent log on ARM platform:
"No NUMA configuration found
PCI_bus 0000:00 on NUMA node 0
...
PCI_bus 0000:e3 on NUMA node 1"

On X86, the pci_acpi_root_get_node() will validate the node before 
setting the node id for root bus. So I think we can add this validation 
for ARM platform. Or anything else I missed?

> 
>> so the PCI devices can still get a numa node id from acpi_get_node().
>> For example, we can still get the numa node id = 1 in this case from
>> acpi_get_node(), but the numa_nodes_parsed is empty, which means the
>> node id 1 is invalid.  We should add a validation for the node id when
>> setting the root bus node id.
> 
> The kernel is not a firmware validation test suite, so fix the firmware
> please.
> 
> Having said that, please provide a trace log of the issue this is
> causing, if any.

See above.
