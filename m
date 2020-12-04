Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47CD2CEA2F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgLDIvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:51:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9104 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLDIvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:51:02 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CnRGb5mhzzLyfH;
        Fri,  4 Dec 2020 16:49:43 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 4 Dec 2020
 16:50:14 +0800
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: compress: support compress level
To:     Gao Xiang <hsiangkao@redhat.com>
CC:     Eric Biggers <ebiggers@kernel.org>, <jaegeuk@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201203061715.60447-1-yuchao0@huawei.com>
 <X8k9UoUKcyThlJNU@gmail.com> <20201204003119.GA1957051@xiangao.remote.csb>
 <d713f69b-af1b-4e4a-41ad-267a3b9026ac@huawei.com>
 <20201204074323.GA2025226@xiangao.remote.csb>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <ffca7f07-653f-1270-72d4-e66ffc8a7473@huawei.com>
Date:   Fri, 4 Dec 2020 16:50:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201204074323.GA2025226@xiangao.remote.csb>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiang,

On 2020/12/4 15:43, Gao Xiang wrote:
> Hi Chao,
> 
> On Fri, Dec 04, 2020 at 03:09:20PM +0800, Chao Yu wrote:
>> On 2020/12/4 8:31, Gao Xiang wrote:
>>> could make more sense), could you leave some CR numbers about these
>>> algorithms on typical datasets (enwik9, silisia.tar or else.) with 16k
>>> cluster size?
>>
>> Just from a quick test with enwik9 on vm:
>>
>> Original blocks:	244382
>>
>> 			lz4			lz4hc-9
>> compressed blocks	170647			163270
>> compress ratio		69.8%			66.8%
>> speed			16.4207 s, 60.9 MB/s	26.7299 s, 37.4 MB/s
>>
>> compress ratio = after / before
> 
> Thanks for the confirmation. it'd be better to add this to commit message
> if needed when adding a new algorithm to show the benefits.

Sure, will add this.

> 
> About the speed, I think which is also limited to storage device and other
> conditions (I mean the CPU loading during the writeback might be different
> between lz4 and lz4hc-9 due to many other bounds, e.g. UFS 3.0 seq
> write is somewhat higher vs VM. lz4 may have higher bandwidth on high

Yeah, I guess my VM have been limited on its storage bandwidth, and its back-end
could be low-end rotating disk...

> level devices since it seems some IO bound here... I guess but not sure,
> since pure in-memory lz4 is fast according to lzbench / lz4 homepage.)
> 
> Anyway, it's up to f2fs folks if it's useful :) (the CR number is what
> I expect though... I'm a bit of afraid the CPU runtime loading.)

I just have a glance at CPU usage numbers (my VM has 16 cores):
lz4hc takes 11% in first half and downgrade to 6% at second half.
lz4 takes 6% in whole process.

But that's not accruate...

Thanks,

> Thanks for your time!
> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>>
> 
> .
> 
