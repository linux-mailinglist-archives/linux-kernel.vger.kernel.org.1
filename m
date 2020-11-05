Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D93A2A75FF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 04:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388538AbgKEDQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 22:16:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7459 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731990AbgKEDQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 22:16:02 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CRTDs4F93zhclL;
        Thu,  5 Nov 2020 11:15:57 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 5 Nov 2020
 11:15:54 +0800
Subject: Re: [PATCH v2] f2fs: change write_hint for hot/warm nodes
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Daejun Park <daejun7.park@samsung.com>
CC:     "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Jieon Seol <jieon.seol@samsung.com>,
        Sang-yoon Oh <sangyoon.oh@samsung.com>,
        Mankyu PARK <manq.park@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>,
        SEUNGUK SHIN <seunguk.shin@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Jaemyung Lee <jaemyung.lee@samsung.com>
References: <CGME20201103083832epcms2p6c8b0e4470f1392772317ab2b25256b3d@epcms2p6>
 <20201103083832epcms2p6c8b0e4470f1392772317ab2b25256b3d@epcms2p6>
 <20201103185808.GB1273166@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4be2e157-fbc1-6e2c-cdd7-a32514884754@huawei.com>
Date:   Thu, 5 Nov 2020 11:15:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201103185808.GB1273166@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/4 2:58, Jaegeuk Kim wrote:
> On 11/03, Daejun Park wrote:
>> In the fs-based mode of F2FS, the mapping of hot/warm node to
>> WRITE_LIFE_NOT_SET should be changed to WRITE_LIFE_SHORT.
>>
>> As a result of analyzing the write pattern of f2fs using real workload,
>> hot/warm nodes have high update ratio close to hot data.[*]
>> However, F2FS passes write hints for hot/warm nodes as WRITE_LIFE_NOT_SET.
> 
> I prefer to keep it as is, since basically node blocks should be separatly
> stored from data blocks in different erase blocks in order to match F2FS GC

Correct, I missed that the change will break HOT_DATA type and {HOT,WARM}_NODE
type data separation in FTL.

> and FTL GC units. And, we don't do IPU for node blocks which doesn't make sense
> to say *update ratio*.

IMO, if fs discard is fast enough, both IPU and OPU will cause original blkaddr in
FTL being invalid, we can compare update ratio on {I,O}PU IOs inside FTL; otherwise,
we can't.

Thanks,

> 
>>
>> Furthermore, WRITE_LIFE_NOT_SET is a default value of write hint when it is
>> not provided from the file system.
>> In storage, write_hint is used to distinguish streams (e.g. NVMe).
>> So, the hot/warm node of F2FS is not distinguished from other write_hints,
>> which can make the wrong stream seperation.
>>
>> * Liang, Yu, et al. "An empirical study of F2FS on mobile devices." 2017
>> IEEE 23rd International Conference on Embedded and Real-Time Computing
>> Systems and Applications (RTCSA).
>>
>> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
>> ---
>> v2: update documentation and comments
>> ---
>>   Documentation/filesystems/f2fs.rst | 4 ++--
>>   fs/f2fs/segment.c                  | 6 +++---
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
>> index b8ee761c9922..afa3da7cfade 100644
>> --- a/Documentation/filesystems/f2fs.rst
>> +++ b/Documentation/filesystems/f2fs.rst
>> @@ -717,8 +717,8 @@ WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
>>   ===================== ======================== ===================
>>   User                  F2FS                     Block
>>   ===================== ======================== ===================
>> -                      META                     WRITE_LIFE_MEDIUM;
>> -                      HOT_NODE                 WRITE_LIFE_NOT_SET
>> +                      META                     WRITE_LIFE_MEDIUM
>> +                      HOT_NODE                 WRITE_LIFE_SHORT
>>                         WARM_NODE                "
>>                         COLD_NODE                WRITE_LIFE_NONE
>>   ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 1596502f7375..577ab7516c6b 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -3160,8 +3160,8 @@ int f2fs_rw_hint_to_seg_type(enum rw_hint hint)
>>    *
>>    * User                  F2FS                     Block
>>    * ----                  ----                     -----
>> - *                       META                     WRITE_LIFE_MEDIUM;
>> - *                       HOT_NODE                 WRITE_LIFE_NOT_SET
>> + *                       META                     WRITE_LIFE_MEDIUM
>> + *                       HOT_NODE                 WRITE_LIFE_SHORT
>>    *                       WARM_NODE                "
>>    *                       COLD_NODE                WRITE_LIFE_NONE
>>    * ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
>> @@ -3208,7 +3208,7 @@ enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
>>   				return WRITE_LIFE_EXTREME;
>>   		} else if (type == NODE) {
>>   			if (temp == WARM || temp == HOT)
>> -				return WRITE_LIFE_NOT_SET;
>> +				return WRITE_LIFE_SHORT;
>>   			else if (temp == COLD)
>>   				return WRITE_LIFE_NONE;
>>   		} else if (type == META) {
>> -- 
>> 2.25.1
> .
> 
