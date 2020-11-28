Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53FC2C6DF9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 01:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgK1Aef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 19:34:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8190 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731450AbgK1Acd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 19:32:33 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CjXVp2N3Dzkfrs;
        Sat, 28 Nov 2020 08:31:46 +0800 (CST)
Received: from [10.174.176.199] (10.174.176.199) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Nov 2020 08:32:05 +0800
Subject: Re: nohz: Update tick instead of restarting tick in
 tick_nohz_idle_exit()
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>,
        <linux-kernel@vger.kernel.org>, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <66014fea-7b84-358b-137d-d15190241528@huawei.com>
 <20201127121542.GA109224@lothringen>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <6d77dcc0-dea1-7b5e-9451-e4b21d7fb160@huawei.com>
Date:   Sat, 28 Nov 2020 08:32:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20201127121542.GA109224@lothringen>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.199]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/27 20:15, Frederic Weisbecker wrote:
> On Mon, Nov 23, 2020 at 09:22:08PM +0800, Yunfeng Ye wrote:
>> In realtime scenarios, the "nohz_full" parameter is configured. Tick
>> interference is not expected when there is only one realtime thread.
>> But when the idle thread is switched to the realtime thread, the tick
>> timer is restarted always.
>>
>> So on the nohz full mode, it is unnecessary to restart the tick timer
>> when there is only one realtime thread. Adding can_stop_full_tick()
>> before restarting the tick, if it return true, keep tick stopped.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> 
> We can indeed stop the tick and avoid it to be re-armed needlessly at this
> point.
> 
> I'm taking your patch, I may just edit it a little and resend it.
> 
Ok, thanks.

> Thanks!
> .
> 
