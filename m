Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3104A26EA56
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 03:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIRBNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 21:13:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13245 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbgIRBNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:13:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8301C5BEDA7A68142340;
        Fri, 18 Sep 2020 09:13:20 +0800 (CST)
Received: from [10.174.177.167] (10.174.177.167) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 09:13:15 +0800
Subject: Re: [PATCH 1/2] locktorture: doesn't check nreaders_stress when no
 readlock support
To:     <paulmck@kernel.org>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>
References: <20200917135910.137389-1-houtao1@huawei.com>
 <20200917135910.137389-2-houtao1@huawei.com>
 <20200917165817.GK29330@paulmck-ThinkPad-P72>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <86bc5a54-5dfa-4320-9e10-9660a25724d0@huawei.com>
Date:   Fri, 18 Sep 2020 09:13:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917165817.GK29330@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.167]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2020/9/18 0:58, Paul E. McKenney wrote:
> On Thu, Sep 17, 2020 at 09:59:09PM +0800, Hou Tao wrote:
>> To ensure there is always at least one locking thread.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/locking/locktorture.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
>> index 9cfa5e89cff7f..bebdf98e6cd78 100644
>> --- a/kernel/locking/locktorture.c
>> +++ b/kernel/locking/locktorture.c
>> @@ -868,7 +868,8 @@ static int __init lock_torture_init(void)
>>  		goto unwind;
>>  	}
>>  
>> -	if (nwriters_stress == 0 && nreaders_stress == 0) {
>> +	if (nwriters_stress == 0 &&
>> +	    (!cxt.cur_ops->readlock || nreaders_stress == 0)) {
> 
> You lost me on this one.  How does it help to allow tests with zero
> writers on exclusive locks?  Or am I missing something subtle here?
> 
The purpose is to prohibit test with only readers on exclusive locks, not allow it.

So if the module parameters are "torture_type=mutex_lock nwriters_stress=0 nreaders_stress=3",
locktorture can fail early instead of continuing but doing nothing useful.

Regards,
Tao

> 							Thanx, Paul
> 
>>  		pr_alert("lock-torture: must run at least one locking thread\n");
>>  		firsterr = -EINVAL;
>>  		goto unwind;
>> -- 
>> 2.25.0.4.g0ad7144999
>>
> .
> 
