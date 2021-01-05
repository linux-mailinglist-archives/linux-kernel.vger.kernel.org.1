Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E602EA2F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 02:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbhAEBpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 20:45:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9712 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbhAEBpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 20:45:11 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D8wHr5B5Gzl0DQ;
        Tue,  5 Jan 2021 09:43:20 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 5 Jan 2021
 09:44:26 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix null page reference in
 redirty_blocks
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Colin Ian King <colin.king@canonical.com>,
        Daeho Jeong <daehojeong@google.com>
References: <20210105012826.956800-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <904b7677-3655-2e81-52e0-48296cf1c0da@huawei.com>
Date:   Tue, 5 Jan 2021 09:44:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210105012826.956800-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/5 9:28, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Fixed null page reference when find_lock_page() fails in
> redirty_blocks().
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
> ---
>   fs/f2fs/file.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 9e5275716be8..bf6682a52433 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4060,8 +4060,10 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
>   
>   	for (i = 0; i < page_len; i++, redirty_idx++) {
>   		page = find_lock_page(mapping, redirty_idx);
> -		if (!page)
> +		if (!page) {
>   			ret = -ENOENT;

ret = -ENOMEM;

> +			continue;

How about breaking the loop for out-of-memory case, because in such condition
we have less chance to dirty whole cluster due to no memory, and continue to
allocate pages for target file will make system suffer more memory pressure,
it will make many thing slower.

Thnaks,

> +		}
>   		set_page_dirty(page);
>   		f2fs_put_page(page, 1);
>   		f2fs_put_page(page, 0);
> 
