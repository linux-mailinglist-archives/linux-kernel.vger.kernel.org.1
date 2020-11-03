Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9DA2A3BC0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 06:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgKCFWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 00:22:39 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2424 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCFWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 00:22:39 -0500
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CQJ7q34twz51f3;
        Tue,  3 Nov 2020 13:22:31 +0800 (CST)
Received: from [10.140.157.68] (10.140.157.68) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 3 Nov 2020 13:22:32 +0800
Subject: Re: Using fixed LPI number for some Device ID
To:     Marc Zyngier <maz@kernel.org>
CC:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
References: <0baed5b0-6cbe-6492-b4af-fe758f461602@huawei.com>
 <04e31996-6eb8-3bb9-e333-bc46eebe3d7a@huawei.com>
 <87eeleen3m.wl-maz@kernel.org>
From:   Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <8ff6a30a-b51f-f9f0-4a18-307948f3519b@huawei.com>
Date:   Tue, 3 Nov 2020 13:22:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87eeleen3m.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.140.157.68]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/31 17:55, Marc Zyngier wrote:
> Dongjiu,
> 
> On Sat, 31 Oct 2020 02:19:19 +0000,
> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>>
>> Hi Marc,
>> Sorry to disturb you, Currently the LPI number is not fixed for the
>> device. The LPI number is dynamically allocated start from 8092.
>> For two OS which shares the ITS, One OS needs to configure the
>> device interrupt required by another OS, and the other OS uses a
>> fixed interrupt ID to respond the interrupt. Therefore, the LPI IRQ
>> number of the device needed be fixed. I want to upstream this
>> feature that allocate fixed LPI number for the device that is
>> specified through the DTS. What is your meaning?  Thanks
> 
> I think you are starting from the wrong premises.
> 
> You can't "share" an ITS directly between two operating systems. The
> ITS can only be controlled by a single operating system, because its
> function goes way beyond allocating an LPI. How would you deal with
> simple things such as masking an interrupt, which requires:
> 
> - Access to memory (configuration table)
> - Access to the command queue (to insert an invalidation command)
> - Access to MMIO registers (to kick the command queue into action)
> 
> all of which needs to be exclusive of concurrent modifications. How do
> you propose this is implemented in a safe manner by two operating
> systems which, by nature, distrust each other? Allocating LPIs is the
> least of your problems, really.
Yes， I agree with you it . But in my HW platform, using virtualization, the performance
deteriorates greatly.  So I distributed the I/O devices to different operation systems. During the startup of one OS,
interrupts are bound to different OS in one OS, which can be exclusive of concurrent modifications.

In fact it has some limitations as you said, such mask/enable/route Interrupts, If want to
mask interrupts, need to mask interrupts on the source device.

If you think it is not a common feature, I will used it as a local customization function and not upstream.

> 
> If you need two concurrent OSs taking interrupts, use virtualization.
> That is its purpose. On your HW, you'll even get direct injection.
> 
> Thanks,
> 
> 	M.
> 
