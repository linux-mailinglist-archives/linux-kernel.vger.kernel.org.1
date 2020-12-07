Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDB42D0B3F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgLGHm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:42:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9020 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLGHm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:42:26 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqFc92nSPzhnbZ;
        Mon,  7 Dec 2020 15:41:13 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 7 Dec 2020
 15:41:39 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix race of pending_pages in
 decompression
To:     Daeho Jeong <daeho43@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <kernel-team@android.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Daeho Jeong <daehojeong@google.com>
References: <20201205042626.1113600-1-daeho43@gmail.com>
 <c3c41d53-2a99-17a2-223a-3d674613a417@huawei.com>
 <CACOAw_zwbmYHbUVUmzGMci9SaSVSrP8NXXavHBSSLxbAEOrMcw@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c45d327f-b669-a0ec-bd77-0c95dfd8db2c@huawei.com>
Date:   Mon, 7 Dec 2020 15:41:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_zwbmYHbUVUmzGMci9SaSVSrP8NXXavHBSSLxbAEOrMcw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/7 15:28, Daeho Jeong wrote:
>> It looks like it will be better to move this into merge condition?
>>
>>                  if (bio && (!page_is_mergeable(sbi, bio,
>>                                          *last_block_in_bio, blkaddr) ||
>>                      !f2fs_crypt_mergeable_bio(bio, inode, page->index, NULL) ||
>>                          f2fs_verify_mergeable_bio())) {
>>
> 
> I tried this for the first time, but it requires unnecessary checks
> within the compression cluster.

We only need to check f2fs_verify_mergeable_bio for i == 0 case? something like:

static bool f2fs_verify_mergeable_bio(struct bio *bio, bool verify, bool first_page)
{
	if (!first_page)
		return false;
	if (!verify)
		return false;

	ctx = bio->bi_private;
	if (!(ctx->enabled_steps & (1 << STEP_VERITY)))
		return true;
}

Thoughts?

> I wanted to just check one time in the beginning of the cluster.
> What do you think?

It's trivial, but I'm think about the readability... at least, one line comment
is needed to describe why we submit previous bio. :)

Thanks,

> .
> 
