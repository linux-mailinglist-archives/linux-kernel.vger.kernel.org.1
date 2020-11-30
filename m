Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5F82C84E0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgK3NPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:15:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2176 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgK3NPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:15:34 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cl5JD0KW2z67KhR;
        Mon, 30 Nov 2020 21:13:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 30 Nov 2020 14:14:52 +0100
Received: from [10.47.3.199] (10.47.3.199) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 30 Nov
 2020 13:14:51 +0000
Subject: Re: [PATCH 0/3] MSI: Track device proxying when allocating MSIs
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>
References: <20201129135208.680293-1-maz@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6dec3d43-70bb-6c66-fca6-77e1c2b0cc4f@huawei.com>
Date:   Mon, 30 Nov 2020 13:14:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201129135208.680293-1-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.3.199]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2020 13:52, Marc Zyngier wrote:
> This series aims to plug a gap found with John's "managed interrupts
> for platform devices" series.
> 
> We have a couple of cases where we allocate MSIs for a device, but the
> endpoint generating the actual interrupts (let's call it the "logical
> device") isn't the one being seen generating the MSIs (the "effective
> device"):
> 
> - PCI devices behind a non transparent bridge
> - Devices attached to a wire-to-MSI bridge
> 
> For interrupt infrastructures such as the ITS (where the effective
> device ID is part of the translation), it is important decouple the
> lifetime of the effective device mapping from the interrupt allocation
> on behalf of the logical device. Yes, I have a headache too.
> 
> To achieve this split, let's tag the such allocations with a new flag
> that convey the fact that the effective device isn't the logical
> one. This mostly affects the platform-MSI subsystem.
> 
> Subsequent patches add handling of this new flag in the GICv3 ITS
> (though there may be scope for something more generic in the case of
> the last patch).

Hi Marc,

Tested-by: John Garry <john.garry@huawei.com>

Thanks!

> 
> Marc Zyngier (3):
>    platform-msi: Track shared domain allocation
>    irqchip/gic-v3-its: Tag ITS device as shared if allocating for a proxy
>      device
>    irqchip/gic-v3-its: Flag device allocation as proxied if behind a PCI
>      bridge
> 
>   drivers/base/platform-msi.c              |  7 +++++++
>   drivers/irqchip/irq-gic-v3-its-pci-msi.c | 11 ++++++++---
>   drivers/irqchip/irq-gic-v3-its.c         |  3 +++
>   include/asm-generic/msi.h                |  4 ++++
>   4 files changed, 22 insertions(+), 3 deletions(-)
> 

