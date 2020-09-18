Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A31726EA29
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 02:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRAuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 20:50:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbgIRAuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 20:50:32 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A79DC255FB1C7A8DD48E;
        Fri, 18 Sep 2020 08:50:28 +0800 (CST)
Received: from [10.174.178.248] (10.174.178.248) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 18 Sep
 2020 08:50:26 +0800
Subject: Re: [PATCH] fbcon: Remove the superfluous break
To:     Nick Desaulniers <ndesaulniers@google.com>
References: <20200917131515.147029-1-jingxiangfeng@huawei.com>
 <CAKwvOdnm-PkEt6T3HqB-NYNYADth0MJkXCvFsc-_gyqRE-nmcg@mail.gmail.com>
CC:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg KH <gregkh@linuxfoundation.org>, <daniel.vetter@ffwll.ch>,
        <jirislaby@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        <george.kennedy@oracle.com>, <peda@axentia.se>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5F640451.7020704@huawei.com>
Date:   Fri, 18 Sep 2020 08:50:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnm-PkEt6T3HqB-NYNYADth0MJkXCvFsc-_gyqRE-nmcg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/18 1:36, Nick Desaulniers wrote:
> On Thu, Sep 17, 2020 at 6:15 AM Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:
>>
>> Remove the superfuous break, as there is a 'return' before it.
>
> superfluous (missed "l")

Thanks for correcting!
>
>>
>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Thanks for the patch; I audited the rest of the switch statements in
> this translation unit; LGTM.
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
>>                                      vc->vc_video_erase_char,
>>                                      vc->vc_size_row * count);
>>                          return true;
>> -                       break;
>>
>>                  case SCROLL_WRAP_MOVE:
>>                          if (b - t - count > 3 * vc->vc_rows >> 2) {
>> @@ -1818,7 +1817,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>>                                      vc->vc_video_erase_char,
>>                                      vc->vc_size_row * count);
>>                          return true;
>> -                       break;
>>
>>                  case SCROLL_WRAP_MOVE:
>>                          if (b - t - count > 3 * vc->vc_rows >> 2) {
>> --
>> 2.17.1
>>
>
>
