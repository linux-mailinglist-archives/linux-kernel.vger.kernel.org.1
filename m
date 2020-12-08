Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA98A2D264A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgLHIfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:35:38 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2087 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgLHIfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:35:37 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Cqtkd2tpYzVmV2;
        Tue,  8 Dec 2020 16:34:01 +0800 (CST)
Received: from [10.174.177.103] (10.174.177.103) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 8 Dec 2020 16:34:53 +0800
Subject: Re: [PATCH -next] panic: complete the flush of the hard deadlock log
 messages to the serial port
From:   "xuqiang (M)" <xuqiang36@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <keescook@chromium.org>, <mingo@kernel.org>,
        <peterz@infradead.org>, <mcgrof@kernel.org>, <huyue2@yulong.com>,
        <yangtiezhu@loongson.cn>, <will@kernel.org>, <aquini@redhat.com>,
        <gpiccoli@canonical.com>, <aik@ozlabs.ru>,
        <linux-kernel@vger.kernel.org>, <rui.xiang@huawei.com>
References: <20201123131359.34600-1-xuqiang36@huawei.com>
 <20201123115235.74aab2449ac5cf27f10a4cfd@linux-foundation.org>
 <080e8065-c696-eeec-3390-13b4458f67b6@huawei.com>
Message-ID: <77ecf60d-9c9b-52f9-ea5a-924aa5ae6642@huawei.com>
Date:   Tue, 8 Dec 2020 16:34:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <080e8065-c696-eeec-3390-13b4458f67b6@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.103]
X-ClientProxiedBy: dggeme717-chm.china.huawei.com (10.1.199.113) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/11/24 11:22, xuqiang (M) 写道:
>
> 在 2020/11/24 3:52, Andrew Morton 写道:
>> On Mon, 23 Nov 2020 13:13:59 +0000 Xu Qiang <xuqiang36@huawei.com> 
>> wrote:
>>
>>> when hardlockup_all_cpu_backtrace is on, and there are
>>> a large number of cores in the system, it takes
>>> a long time to output the hard deadlock logs of all cores
>>> to the serial port. When the console_flush_on_panic function
>>> in panic is executed, console_locked is still held.
>>> As a result, garbled characters are displayed in the serial port log.
>>>
>>> To solve this problem, wait for a maximum of 10s for the serial port
>>> to be released before console_flush_on_panic.
>> Wouldn't it be better to wait until all the printing of all those
>> backtraces has completed?
>>
>>
>> .
>
> The fear that there may be some unexpected abnormal situation,
>
> resulting in the serial port has been occupied without release.
>
>
> Thanks
>
>         Xu.
>
Hi, Are there any other questions about this patch?


Thanks

         Xu.

