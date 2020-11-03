Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FC72A448C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgKCLvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 06:51:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6695 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgKCLvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:51:13 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQSmF0G0nz15QTk;
        Tue,  3 Nov 2020 19:51:09 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 3 Nov 2020
 19:51:05 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: support chksum
To:     David Laight <David.Laight@ACULAB.COM>,
        Jaegeuk Kim <jaegeuk@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201102122333.76667-1-yuchao0@huawei.com>
 <20201102163123.GD529594@google.com>
 <756e482c-b638-1c09-3868-ae45d33ed2c2@huawei.com>
 <6b5bce0e-c967-b9cf-3544-a8e65595059c@huawei.com>
 <aa11afd31edb42979c03d2a27ed9e850@AcuMS.aculab.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4d58b7c7-70b5-514d-fab2-27a0f16886e5@huawei.com>
Date:   Tue, 3 Nov 2020 19:51:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <aa11afd31edb42979c03d2a27ed9e850@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/3 18:35, David Laight wrote:
> From: Chao Yu
>> Sent: 03 November 2020 02:37
> ...
>>>> Do we need to change fsck.f2fs to recover this?
>>
>> However, we don't know which one is correct, compressed data or chksum value?
>> if compressed data was corrupted, repairing chksum value doesn't help.
>>
>> Or how about adding chksum values for both raw data and compressed data.
> 
> What errors are you trying to detect?

Hi,

The original intention of adding this checksum feature is for code debug
purpose when I develop compress framework in f2fs and add more compress
algorithms into the framework, it helps to find obvious implementation
bug, however this checksum feature was not fully designed, so that I didn't
upstream it at that time.

One other concern is to find any mismatch between original raw data and
persisted data, no matter how it becomes to mismatched and then return
error code to user if it detects the mismatch.

And then fsck can repair mismatched chksum in the condition one persisted
chksum matchs to calculated one, and one other doesn't.

Thanks,

> 
> If there are errors in the data then 'fixing' the checksum is pointless.
> (You've got garbage data - might as well not have the checksum).
> 
> If you are worried about the implementation of the compression
> algorithm then a checksum of the raw data is needed.
> 
> If you want to try error correcting burst errors in the compressed
> data then a crc of the compressed data can be used for error correction.
> 
> OTOH the most likely error is that the file meta-data and data sector
> weren't both committed to disk when the system crashed.
> In which case the checksum has done its job and the file is corrupt.
> fsck should probably move the file to 'lost+found' for manual checking.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
> .
> 
