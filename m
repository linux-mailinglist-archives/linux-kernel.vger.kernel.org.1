Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509DA26DBCA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgIQMl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:41:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726862AbgIQMhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:37:39 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 16E82D626641862432E6;
        Thu, 17 Sep 2020 20:37:04 +0800 (CST)
Received: from [10.174.179.91] (10.174.179.91) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 20:37:00 +0800
Subject: Re: [PATCH -next] drm/komeda: Convert to DEFINE_SHOW_ATTRIBUTE
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
References: <20200716090333.13334-1-miaoqinglang@huawei.com>
 <20200717064017.GA76612@jamwan02-TSP300>
 <CAKMK7uEpmhKok9Q3Rrg0v=1p7pv-wpV0Y3-k9GVav+Ad5Z4AkQ@mail.gmail.com>
 <7264de7e-6da4-288d-855d-410b2e05458b@huawei.com>
 <20200717091025.GQ3278063@phenom.ffwll.local>
CC:     Mihail Atanassov <mihail.atanassov@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <39be7c48-4a4e-4bef-2d08-1d9a5a479269@huawei.com>
Date:   Thu, 17 Sep 2020 20:36:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200717091025.GQ3278063@phenom.ffwll.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/7/17 17:10, Daniel Vetter 写道:
> On Fri, Jul 17, 2020 at 04:00:36PM +0800, miaoqinglang wrote:
>>
>>
>> 在 2020/7/17 15:06, Daniel Vetter 写道:
>>> On Fri, Jul 17, 2020 at 8:40 AM james qian wang (Arm Technology China)
>>> <james.qian.wang@arm.com> wrote:
>>>>
>>>> On Thu, Jul 16, 2020 at 05:03:33PM +0800, Qinglang Miao wrote:
>>>>> From: Liu Shixin <liushixin2@huawei.com>
>>>>>
>>>>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>>>>
>>>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>>>>> ---
>>>>>    drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 13 +------------
>>>>>    1 file changed, 1 insertion(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
>>>>> index 0246b2e94..4a10e6b9e 100644
>>>>> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
>>>>> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
>>>>> @@ -41,18 +41,7 @@ static int komeda_register_show(struct seq_file *sf, void *x)
>>>>>         return 0;
>>>>>    }
>>>>>
>>>>> -static int komeda_register_open(struct inode *inode, struct file *filp)
>>>>> -{
>>>>> -     return single_open(filp, komeda_register_show, inode->i_private);
>>>>> -}
>>>>> -
>>>>> -static const struct file_operations komeda_register_fops = {
>>>>> -     .owner          = THIS_MODULE,
>>>>> -     .open           = komeda_register_open,
>>>>> -     .read_iter              = seq_read_iter,
>>>>> -     .llseek         = seq_lseek,
>>>>> -     .release        = single_release,
>>>>> -};
>>>>> +DEFINE_SHOW_ATTRIBUTE(komeda_register);
>>>>>
>>>>
>>>> Hi Shixin & Qinglang
>>>>
>>>> Thanks for your patch.
>>>>
>>>> Reviewed-by: James Qian Wang <james.qian.wang@arm.com>
>>>>
>>>> Since your patch is not for drm-misc-next, so seems better
>>>> to leave it to you to merge it. :)
>>>
>>> I do think it's for drm-misc-next, what other tree would it be for?
>>> Some people put -next in their patch tag to differentiate from -fixes,
>>> so maintainers know what to do with the patch. It's also not part of a
>>> series, hence I think this is on you to apply it.
>>>
>> Hi James & Daniel,
>>
>> ​Sorry I didn't make it clear in commit log, but it do based on linux-next.
>>
>> ​I think the reason why James think it's not for drm-misc-next
>> is conflicts exists when this patch being applied. There's conflicts because
>> commit <4d4901c6d7> which switched over direct seq_read method calls to
>> seq_read_iter should applied before this clean-up patch(linkage listed as
>> below).
>>
>> https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/4d4901c6d748efab8aab6e7d2405dadaed0bea50
>>
>> I can send a new patch based on mainline if needed.
> 
> Uh yes this is annoying. We're at feature cutoff so this will likely cause
> bad conflicts no matter what if we merge it now, but the clean solution is
> to rebase onto drm-misc-next, and then let maintainers sort out the mess
> with conflicts. It's a pretty simple change in the above patch, so
> shouldn't cause too many troubles.
> -Daniel
> 
Hi James & Daniel,

I've sent v2 patch based on based on linux-next(20200917), and can be 
applied to mainline cleanly now.

Thanks.
 >
>>
>> ​Thanks.
>>
>> Qinglang
>>
>> .
>> 	
>>>
>>> Cheers, Daniel
>>>
>>>>
>>>> Thanks
>>>> James
>>>>
>>>>>    #ifdef CONFIG_DEBUG_FS
>>>>>    static void komeda_debugfs_init(struct komeda_dev *mdev)
>>>>> --
>>>>> 2.17.1
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>
>>>
>>>
>>
> 
