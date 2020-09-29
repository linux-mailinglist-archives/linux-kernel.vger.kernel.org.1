Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF86927B92A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 03:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgI2BBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 21:01:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726698AbgI2BBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 21:01:19 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 77560ED12442A06B7F78;
        Tue, 29 Sep 2020 09:01:17 +0800 (CST)
Received: from [10.174.178.248] (10.174.178.248) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 29 Sep
 2020 09:01:15 +0800
Subject: Re: [PATCH] staging: most: don't access hdm_ch before checking it
 valid
To:     Dan Carpenter <dan.carpenter@oracle.com>
References: <20200928104838.189639-1-jingxiangfeng@huawei.com>
 <20200928114857.GR4282@kadam>
CC:     <gregkh@linuxfoundation.org>, <christian.gromm@microchip.com>,
        <masahiroy@kernel.org>, <tglx@linutronix.de>,
        <keescook@chromium.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5F72875A.8020900@huawei.com>
Date:   Tue, 29 Sep 2020 09:01:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20200928114857.GR4282@kadam>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/28 19:48, Dan Carpenter wrote:
> On Mon, Sep 28, 2020 at 06:48:38PM +0800, Jing Xiangfeng wrote:
>> In try_start_dim_transfer(), pointer hdm_ch is accessed before checking.
>> This may lead to a potential null pointer dereference. Fix this by
>> dereferencing hdm_ch after calling BUG_ON().
>>
>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>> ---
>>   drivers/staging/most/dim2/dim2.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
>> index 509c8012d20b..ccd7cc7545e4 100644
>> --- a/drivers/staging/most/dim2/dim2.c
>> +++ b/drivers/staging/most/dim2/dim2.c
>> @@ -148,7 +148,7 @@ void dimcb_on_error(u8 error_id, const char *error_message)
>>   static int try_start_dim_transfer(struct hdm_channel *hdm_ch)
>>   {
>>   	u16 buf_size;
>> -	struct list_head *head = &hdm_ch->pending_list;
> This is not a dereference, it's just pointer math.  In other words:
>
> 	struct list_head *head = hdm_ch + offsetof(struct hdm_channel, pending_list);
Thanks for correcting!

>
> So the commit message is wrong because this cannot lead to a NULL
> dereference.  It's better to just delete the BUG_ON().  We don't really
> like BUG_ON().  Checkpatch will complain about them.  An Oops gives
> basically the same information as a BUG_ON() without completely killing
> the kernel so just dereferencing a NULL is preferable.  Finally, we can
> see from the callers that "hdm_ch" is never NULL.
>
> regards,
> dan carpenter
>
> .
>

