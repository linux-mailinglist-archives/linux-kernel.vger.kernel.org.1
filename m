Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392C62EBBAF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbhAFJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:29:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10394 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbhAFJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:29:41 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D9kYc73G9z7PnK;
        Wed,  6 Jan 2021 17:28:04 +0800 (CST)
Received: from [10.136.114.193] (10.136.114.193) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 6 Jan 2021 17:28:52 +0800
Subject: Re: [PATCH] tty/serial/8250: make touch watchdog settable
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <lukas@wunner.de>,
        <Sergey.Semin@baikalelectronics.ru>, <vigneshr@ti.com>,
        <rose.chen@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20210106064641.2621838-1-chenzhen105@huawei.com>
 <X/VnrvmN4k8UrXad@jagdpanzerIV.localdomain>
From:   "chenzhen (R)" <chenzhen105@huawei.com>
Message-ID: <db5f51df-3a3e-41a6-00e3-234575c07ec6@huawei.com>
Date:   Wed, 6 Jan 2021 17:28:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X/VnrvmN4k8UrXad@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.136.114.193]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/1/6 15:33, Sergey Senozhatsky wrote:
> On (21/01/06 14:46), chenzhen wrote:
>> Since 54f19b4a6(tty/serial/8250: Touch NMI watchdog in wait_for_xmitr), serial8250
>> will always touch watchdog in write and wait_for_xmitr. However, serial8250 may
>> become low speed thus take a long time to print. In this process, nmi and soft
>> watchdog on current CPU will be invalid.
>>
>> To resolve this problem, add a cmdline option "tty_watchdog_enable" to control
>> the touchdog in serial8250.
> Sorry, I don't understand - what does this fix?
>
> 	-ss
> .

It fixes that if serial8250 is low speed on some machine, when it writes for a long time, NMI/softlockup watchdog will never bark and potential rlock will not be detected. So an option to control the touchdog in serial8250 may help.

Thanks for your reply!

                                                                 -Zhen Chen

