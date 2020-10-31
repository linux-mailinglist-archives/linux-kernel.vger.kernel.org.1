Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB5F2A1347
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 04:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgJaDK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 23:10:28 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2359 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaDK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 23:10:28 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CNPLp5ws2z503m;
        Sat, 31 Oct 2020 11:10:26 +0800 (CST)
Received: from [10.140.157.68] (10.140.157.68) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 31 Oct 2020 11:10:26 +0800
Subject: Re: Using fixed LPI number for some Device ID
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     Jason Cooper <jason@lakedaemon.net>, <linux-kernel@vger.kernel.org>
References: <0baed5b0-6cbe-6492-b4af-fe758f461602@huawei.com>
 <04e31996-6eb8-3bb9-e333-bc46eebe3d7a@huawei.com>
 <87eelfksm1.fsf@nanos.tec.linutronix.de>
From:   Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <7205d3e0-a03a-a06c-f3f4-9a28e58931e0@huawei.com>
Date:   Sat, 31 Oct 2020 11:10:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87eelfksm1.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.140.157.68]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/31 10:59, Thomas Gleixner wrote:
> On Sat, Oct 31 2020 at 10:19, Dongjiu Geng wrote:
>>  Hi Marc,
>>     Sorry to disturb you, Currently the LPI number is not fixed for
>>  the device. The LPI number is dynamically allocated start from 8092.
>>  For two OS which shares the ITS, One OS needs to configure the device
>>  interrupt required by another OS, and the other OS uses a fixed
>>  interrupt ID to respond the interrupt. Therefore, the LPI IRQ number
>>  of the device needed be fixed. I want to upstream this feature that
>>  allocate fixed LPI number for the device that is specified through
>>  the DTS. What is your meaning?  Thanks
> 
> What's the purpose of resending the same thing within less than 24
> hours? Do you really expect maintainers to be available 24/7 and being
  Sorry for the noise, Because Marc rarely uses the ARM email address,
  so I replace to use Marc's kernel.org address instead of ARM email address.



> able to respond within less than a day?
> 
> 
> .
> 
