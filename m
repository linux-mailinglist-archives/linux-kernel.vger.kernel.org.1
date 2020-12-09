Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F282D3DBE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgLIInC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:43:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9042 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgLIInC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:43:02 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CrVs82s3NzhpgZ;
        Wed,  9 Dec 2020 16:41:48 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 9 Dec 2020
 16:42:15 +0800
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: compress: support chksum
From:   Chao Yu <yuchao0@huawei.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201208031437.56627-1-yuchao0@huawei.com>
 <22ac4df6-53ec-fb7c-c4dd-26435352a701@huawei.com>
 <X9A7Jn+cHRRcAmIi@google.com>
 <37d89d34-add1-5254-380b-233ef7a460d4@huawei.com>
 <X9BKX9PUMFkts9bI@google.com>
 <5398c880-d4d3-81b9-f3c9-765ba1470e96@huawei.com>
 <0d4a20ec-f6e4-ff24-8733-94cc3762195d@huawei.com>
 <X9CJc7xas7OqTZv2@google.com>
 <b3e385d6-b473-c4c9-308d-0285bc71b5b0@huawei.com>
Message-ID: <e773f0bf-16ea-c503-4138-0fd6fabc13a3@huawei.com>
Date:   Wed, 9 Dec 2020 16:42:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b3e385d6-b473-c4c9-308d-0285bc71b5b0@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/9 16:31, Chao Yu wrote:
> On 2020/12/9 16:23, Jaegeuk Kim wrote:
>> On 12/09, Chao Yu wrote:
>>> On 2020/12/9 12:28, Chao Yu wrote:
>>>> On 2020/12/9 11:54, Jaegeuk Kim wrote:
>>>>> Ah, could you please write another patch to adjust the new changes?
>>>>
>>>> No problem, will drop "f2fs: compress:support chksum" based on your dev branch, and
>>>> apply all compress related patches on top of dev branch.
>>>
>>> Jaegeuk, could you please
>>> - drop "f2fs: compress:support chksum",
>>
>> What I mean is keeping the old version in dev branch as is, since it gives
>> another conflicts when dropping it. That can add another bug at this point.
>> Can I get a separate patch to fix any issues in that original patch?
> 
> Oops...

The diff is as below:

 From 1ad86c640d3a295292960f6b90802cc5a9be7a0d Mon Sep 17 00:00:00 2001
From: Chao Yu <yuchao0@huawei.com>
Date: Wed, 9 Dec 2020 16:36:58 +0800
Subject: [PATCH] fix_chksum

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
  fs/f2fs/compress.c | 3 +--
  fs/f2fs/compress.h | 0
  2 files changed, 1 insertion(+), 2 deletions(-)
  create mode 100644 fs/f2fs/compress.h

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index f05d409fd0ed..4bcbacfe3325 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -796,7 +796,7 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)

  	ret = cops->decompress_pages(dic);

-	if (!ret && fi->i_compress_flag & 1 << COMPRESS_CHKSUM) {
+	if (!ret && (fi->i_compress_flag & 1 << COMPRESS_CHKSUM)) {
  		u32 provided = le32_to_cpu(dic->cbuf->chksum);
  		u32 calculated = f2fs_crc32(sbi, dic->cbuf->cdata, dic->clen);

@@ -809,7 +809,6 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
  					provided, calculated);
  			}
  			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			WARN_ON_ONCE(1);
  		}
  	}

diff --git a/fs/f2fs/compress.h b/fs/f2fs/compress.h
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.29.2

> 
> Thanks,
> 
>>
>>> - manually fix conflict when applying "f2fs: add compress_mode mount option"
>>> - and then apply last my resent patches.
>>>
>>> Thanks,
>> .
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
