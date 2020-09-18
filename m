Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF4826EA2C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 02:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIRAwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 20:52:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39480 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbgIRAwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 20:52:09 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 200A8D066FEC6FE9326E;
        Fri, 18 Sep 2020 08:52:04 +0800 (CST)
Received: from [10.174.178.248] (10.174.178.248) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 18 Sep
 2020 08:52:03 +0800
Subject: Re: [PATCH] fbcon: Remove the superfluous break
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        <b.zolnierkie@samsung.com>, <gregkh@linuxfoundation.org>,
        <daniel.vetter@ffwll.ch>, <jirislaby@kernel.org>,
        <ndesaulniers@google.com>, <natechancellor@gmail.com>,
        <george.kennedy@oracle.com>, <peda@axentia.se>
References: <20200917131515.147029-1-jingxiangfeng@huawei.com>
 <86015b42-1f87-9f0c-cb34-9d30e8da98a4@embeddedor.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5F6404B2.3080602@huawei.com>
Date:   Fri, 18 Sep 2020 08:52:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <86015b42-1f87-9f0c-cb34-9d30e8da98a4@embeddedor.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/18 2:52, Gustavo A. R. Silva wrote:
>
>
> On 9/17/20 08:15, Jing Xiangfeng wrote:
>> Remove the superfuous break, as there is a 'return' before it.
>>
>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> Also, the following Fixes tag should be included in the changelog text:
>
> Fixes: bad07ff74c32 ("fbcon: smart blitter usage for scrolling")

OK, I'll send a v2 with this tag.

>
> Thanks
> --
> Gustavo
>
>> ---
>>   drivers/video/fbdev/core/fbcon.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
>> index 0b49b0f44edf..623359aadd1e 100644
>> --- a/drivers/video/fbdev/core/fbcon.c
>> +++ b/drivers/video/fbdev/core/fbcon.c
>> @@ -1727,7 +1727,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>>   				    vc->vc_video_erase_char,
>>   				    vc->vc_size_row * count);
>>   			return true;
>> -			break;
>>
>>   		case SCROLL_WRAP_MOVE:
>>   			if (b - t - count > 3 * vc->vc_rows >> 2) {
>> @@ -1818,7 +1817,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>>   				    vc->vc_video_erase_char,
>>   				    vc->vc_size_row * count);
>>   			return true;
>> -			break;
>>
>>   		case SCROLL_WRAP_MOVE:
>>   			if (b - t - count > 3 * vc->vc_rows >> 2) {
>>
> .
>
