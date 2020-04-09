Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE931A2D9C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 04:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDICXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 22:23:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbgDICXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 22:23:34 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E8130F4DDE3D08055245;
        Thu,  9 Apr 2020 10:23:30 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 9 Apr 2020
 10:23:28 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce sysfs/data_io_flag to attach
 REQ_META/FUA
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200403161249.68385-1-jaegeuk@kernel.org>
 <0e627c29-7fb0-5bd6-c1d9-b96a94df62ae@huawei.com>
 <20200407025913.GB137081@google.com>
 <2ca452cd-073a-29fa-1884-99ad1199bb97@huawei.com>
 <20200409022005.GA110440@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <69df999a-1df2-595e-579d-a8c3fc700d7b@huawei.com>
Date:   Thu, 9 Apr 2020 10:23:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200409022005.GA110440@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/9 10:20, Jaegeuk Kim wrote:
> On 04/07, Chao Yu wrote:
>> On 2020/4/7 10:59, Jaegeuk Kim wrote:
>>> On 04/07, Chao Yu wrote:
>>>> On 2020/4/4 0:12, Jaegeuk Kim wrote:
>>>>> This patch introduces a way to attach REQ_META/FUA explicitly
>>>>> to all the data writes given temperature.
>>>>>
>>>>> -> attach REQ_FUA to Hot Data writes
>>>>>
>>>>> -> attach REQ_FUA to Hot|Warm Data writes
>>>>>
>>>>> -> attach REQ_FUA to Hot|Warm|Cold Data writes
>>>>>
>>>>> -> attach REQ_FUA to Hot|Warm|Cold Data writes as well as
>>>>>           REQ_META to Hot Data writes
>>>>
>>>> Out of curiosity, what scenario it is used for?
>>>
>>> It's testing purpose to compare the bandwidths per different IO flags.
>>
>> Thanks for the hint. :)
>>
>> As nobarrier was set in Android, so REQ_PREFLUSH will not be considered in
>> this sysfs interface?
> 
> I don't see any diff on performance, so not interesting. :)

I doubt it may has diff on non-ufs/emmc device? just guess.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>> .
>>>
> .
> 
