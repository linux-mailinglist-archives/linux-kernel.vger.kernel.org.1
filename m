Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AEE2A3EFB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgKCIdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:33:17 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:61690 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgKCIdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:33:16 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201103083312epoutp021a28f8dc6979d2742a5fbc95312bea28~D8mGIhGeR2024420244epoutp02C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 08:33:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201103083312epoutp021a28f8dc6979d2742a5fbc95312bea28~D8mGIhGeR2024420244epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604392393;
        bh=TxGvMOanx4q5d+aeauiVFV2oHKiQjYO6kUB0hmAZVQo=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=L1Z/DcDJPfa9zQLtjWvjrGedE1nnfUWYQimRrz4J4Kc6G2FHNwFJPgprJIEDaf2DF
         +EMd6BKGHrNUmf6UOfolqjIBqrMcajBVD8fIL8VS2Py+q2ej9EKgdQ8zy6vO68RDdI
         XQ7byPwg55Kg2udoAeHOjMDnXHHFkkOlCjMHJmkw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20201103083312epcas2p453b1c487800a823b54e7bd7c456f285a~D8mFWDGK53273432734epcas2p4T;
        Tue,  3 Nov 2020 08:33:12 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.184]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CQNMn6Dp6zMqYm0; Tue,  3 Nov
        2020 08:33:09 +0000 (GMT)
X-AuditID: b6c32a48-a9948a800000cd1f-b6-5fa115c3fdfc
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.0D.52511.3C511AF5; Tue,  3 Nov 2020 17:33:07 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [f2fs-dev] [PATCH] f2fs: change write_hint for hot/warm
 nodes
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>
CC:     yongmyung lee <ymhungry.lee@samsung.com>,
        Jieon Seol <jieon.seol@samsung.com>,
        Sang-yoon Oh <sangyoon.oh@samsung.com>,
        Mankyu PARK <manq.park@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Keoseong Park <keosung.park@samsung.com>,
        SEUNGUK SHIN <seunguk.shin@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Jaemyung Lee <jaemyung.lee@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <609445f8-de3b-eb79-449c-020125799449@huawei.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20201103083306epcms2p804f8fcbe11584488f476cacb9e28c5ac@epcms2p8>
Date:   Tue, 03 Nov 2020 17:33:06 +0900
X-CMS-MailID: 20201103083306epcms2p804f8fcbe11584488f476cacb9e28c5ac
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphl+LIzCtJLcpLzFFi42LZdljTTPew6MJ4gwdXOC1OTz3LZPHykKbF
        qgfhFr39W9ksnqyfxWyx+eAGZottnwUtjp98x2hxaZG7xeVdc9gsOi59ZrKY8HIJi8XtLVwW
        ndPXsFgsWribxWLq47WsDgIeLUfesnpsWtXJ5rF7wWcmj74tqxg9Pm+SC2CNamC0SSxKzsgs
        S1VIzUvOT8nMS7dVCg1x07VQUsjILy6xVYo2tDDSM7Q01TOx1DMyj7UyNDAwMlVSyEvMTbVV
        qtCF6lZSKEouAKouSS0uKUpNTgUKFTkUlySmp+oVJ+YWl+al6yXn5yoplCXmlAL1Kenb2WSk
        JqakFikkPGHM+LdhI0vBVb6Kc0ueMjUw3uLuYuTkkBAwkWj9NIexi5GLQ0hgB6PEsqtHWbsY
        OTh4BQQl/u4QBqkRFgiQ+LV3NzuILSSgJLH+4ix2iLiexK2HaxhBbDYBHYnpJ+6zg8wREZjD
        KPF/0WkmEIdZYBKLxNfGaawQ23glZrQ/ZYGwpSW2L98K1s0pYCex78crqBoNiR/LepkhbFGJ
        m6vfssPY74/NZ4SwRSRa752FqhGUePBzN1RcUuLY7g9MEHa9xNY7v8A+kxDoYZQ4vPMW1AJ9
        iWsdG8GO4BXwlXg9cRvYAhYBVYlLB39ADXWRmDqtGWwos4C8xPa3c5hBocIsoCmxfpc+iCkh
        oCxx5BYLzFsNG3+zo7OZBfgkOg7/hYvvmPcE6jQ1iXU/1zNNYFSehQjqWUh2zULYtYCReRWj
        WGpBcW56arFRgQlyTG9iBKdoLY8djLPfftA7xMjEwXiIUYKDWUmEtyZyXrwQb0piZVVqUX58
        UWlOavEhxiqgLycyS4km5wOzRF5JvKGZgZGZqbGJsbGpiSnZwqZGZmYGlqYWpmZGFkrivKEr
        ++KFBNITS1KzU1MLUotgljNxcEo1MEWt/VR3n+X0VnUXxU0V69XWBwXeyq/j2Lb9azXDhtwP
        Wxcev1VZ7HV9lUx/x7Ild8quHTNoUv+yanap+2KVCX9/XpZeK7jU0SDWaZ+ycEn0n7lnLwtN
        ybqy/2/hF5kis01Lf785/Iblep+7Vds3gZCnX1NvpO7ccebX/j8mX2t3us3x0vzs5VE2Mbnh
        NfutG0Y3kySd3d9MClaTuZg7Q0Jy9sop2jzzL10X9H22rvrgz703fpmcjn141mXOB1mZP5Zq
        7Lm83lKGn9fcbFU4+qZcY1+a1gnTY3usNjO8M+5uVniXJSQnevjNfe8q3Tmem6fbNQg/vVHn
        X328zNdG/dcrgYOeC5R1C2MUD2vsrvuhxFKckWioxVxUnAgAbx65sp8EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201103064039epcms2p30ecac0e7cefff0d50745f2e2e61ce38e
References: <609445f8-de3b-eb79-449c-020125799449@huawei.com>
        <20201103064039epcms2p30ecac0e7cefff0d50745f2e2e61ce38e@epcms2p3>
        <CGME20201103064039epcms2p30ecac0e7cefff0d50745f2e2e61ce38e@epcms2p8>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>From 818a76a9aee5bf225565264274d211edb07bae7d Mon Sep 17 00:00:00 2001
>> From: Daejun Park <daejun7.park@samsung.com>
>> Date: Tue, 3 Nov 2020 15:30:26 +0900
>> 
>> 
>> In the fs-based mode of F2FS, the mapping of hot/warm node to
>> WRITE_LIFE_NOT_SET should be changed to WRITE_LIFE_SHORT.
>> 
>> As a result of analyzing the write pattern of f2fs using real workload,
>> hot/warm nodes have high update ratio close to hot data.[*]
>> However, F2FS passes write hints for hot/warm nodes as WRITE_LIFE_NOT_SET.
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
>
>Could you please update Documentation/filesystems/f2fs.rst as well?
>
>Thanks,

Sure, I will make it next patch.

Thanks

>> 
>> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
>> ---
>>   fs/f2fs/segment.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 1596502f7375..7b42bb10c6c3 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -3208,7 +3208,7 @@ enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
>>   				return WRITE_LIFE_EXTREME;
>>   		} else if (type == NODE) {
>>   			if (temp == WARM || temp == HOT)
>> -				return WRITE_LIFE_NOT_SET;
>> +				return WRITE_LIFE_SHORT;
>>   			else if (temp == COLD)
>>   				return WRITE_LIFE_NONE;
>>   		} else if (type == META) {
>> 
>
>
