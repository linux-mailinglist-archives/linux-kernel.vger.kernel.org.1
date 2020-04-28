Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C841BBDBC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 14:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgD1MkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 08:40:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3370 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726678AbgD1MkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:40:01 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8BC8EF9C70D98CA403CF;
        Tue, 28 Apr 2020 20:39:57 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.7) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 20:39:51 +0800
Subject: Re: [PATCH 2/7] staging: rtl8723bs: os_dep: remove set but not used
 'size'
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <wambui.karugax@gmail.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
References: <20200427032342.27211-1-yanaijie@huawei.com>
 <20200427032342.27211-3-yanaijie@huawei.com>
 <20200428122853.GB1253850@kroah.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <a586bc5f-d7af-c1cc-8213-b63639061947@huawei.com>
Date:   Tue, 28 Apr 2020 20:39:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200428122853.GB1253850@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.7]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/4/28 20:28, Greg KH 写道:
> On Mon, Apr 27, 2020 at 11:23:37AM +0800, Jason Yan wrote:
>> And also remove the NULL check before kfree() because kfree() can handle
>> NULL pointers correctly.
>>
>> Fix the following gcc warning:
>>
>> drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:157:6: warning:
>> variable ‘size’ set but not used [-Wunused-but-set-variable]
>>    u32 size = 0;
>>        ^~~~
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> ---
>>   drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 11 -----------
>>   1 file changed, 11 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>> index 1ba85a43f05a..b037868fbf22 100644
>> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>> @@ -154,17 +154,6 @@ static struct ieee80211_supported_band *rtw_spt_band_alloc(
>>   
>>   static void rtw_spt_band_free(struct ieee80211_supported_band *spt_band)
>>   {
>> -	u32 size = 0;
>> -
>> -	if (!spt_band)
>> -		return;
>> -
>> -	if (spt_band->band == NL80211_BAND_2GHZ)
>> -	{
>> -		size = sizeof(struct ieee80211_supported_band)
>> -			+ sizeof(struct ieee80211_channel)*RTW_2G_CHANNELS_NUM
>> -			+ sizeof(struct ieee80211_rate)*RTW_G_RATES_NUM;
>> -	}
>>   	kfree(spt_band);
>>   }
> 
> This function can now be removed and replaced with the call to kfree(),
> right?  Can you send a follow-on patch to do that?
> 

Sure.

> thanks,
> 
> greg k-h
> 
> .
> 

