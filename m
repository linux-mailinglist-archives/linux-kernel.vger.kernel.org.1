Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03212CE92B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgLDIEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:04:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8643 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgLDIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:04:54 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnQFN28wZz15Kfk;
        Fri,  4 Dec 2020 16:03:36 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 4 Dec 2020
 16:04:01 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix race of pending_pages in
 decompression
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Daeho Jeong <daehojeong@google.com>
References: <20201204072802.795397-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <680c5cbe-d570-b20d-f478-28acbefd8ef5@huawei.com>
Date:   Fri, 4 Dec 2020 16:04:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201204072802.795397-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/4 15:28, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> I found out f2fs_free_dic() is invoked in a wrong timing, but
> f2fs_verify_bio() still needed the dic info and it triggered the
> below kernel panic. It has been caused by the race condition of
> pending_pages value between decompression and verity logic, when
> the same compression cluster had been split in different bios.
> By split bios, f2fs_verify_bio() ended up with decreasing
> pending_pages value before it is reset to nr_cpages by
> f2fs_decompress_pages() and caused the kernel panic.
> 
> [ 4416.564763] Unable to handle kernel NULL pointer dereference
>                 at virtual address 0000000000000000
> ...
> [ 4416.896016] Workqueue: fsverity_read_queue f2fs_verity_work
> [ 4416.908515] pc : fsverity_verify_page+0x20/0x78
> [ 4416.913721] lr : f2fs_verify_bio+0x11c/0x29c
> [ 4416.913722] sp : ffffffc019533cd0
> [ 4416.913723] x29: ffffffc019533cd0 x28: 0000000000000402
> [ 4416.913724] x27: 0000000000000001 x26: 0000000000000100
> [ 4416.913726] x25: 0000000000000001 x24: 0000000000000004
> [ 4416.913727] x23: 0000000000001000 x22: 0000000000000000
> [ 4416.913728] x21: 0000000000000000 x20: ffffffff2076f9c0
> [ 4416.913729] x19: ffffffff2076f9c0 x18: ffffff8a32380c30
> [ 4416.913731] x17: ffffffc01f966d97 x16: 0000000000000298
> [ 4416.913732] x15: 0000000000000000 x14: 0000000000000000
> [ 4416.913733] x13: f074faec89ffffff x12: 0000000000000000
> [ 4416.913734] x11: 0000000000001000 x10: 0000000000001000
> [ 4416.929176] x9 : ffffffff20d1f5c7 x8 : 0000000000000000
> [ 4416.929178] x7 : 626d7464ff286b6b x6 : ffffffc019533ade
> [ 4416.929179] x5 : 000000008049000e x4 : ffffffff2793e9e0
> [ 4416.929180] x3 : 000000008049000e x2 : ffffff89ecfa74d0
> [ 4416.929181] x1 : 0000000000000c40 x0 : ffffffff2076f9c0
> [ 4416.929184] Call trace:
> [ 4416.929187]  fsverity_verify_page+0x20/0x78
> [ 4416.929189]  f2fs_verify_bio+0x11c/0x29c
> [ 4416.929192]  f2fs_verity_work+0x58/0x84
> [ 4417.050667]  process_one_work+0x270/0x47c
> [ 4417.055354]  worker_thread+0x27c/0x4d8
> [ 4417.059784]  kthread+0x13c/0x320
> [ 4417.063693]  ret_from_fork+0x10/0x18
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> v2: merged verity_pages with pending_pages, and increased the
>      pending_pages count only if STEP_VERITY is set on bio
> ---
>   fs/f2fs/compress.c | 2 --
>   fs/f2fs/data.c     | 2 ++
>   fs/f2fs/f2fs.h     | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 87090da8693d..832b19986caf 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -803,8 +803,6 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
>   	if (cops->destroy_decompress_ctx)
>   		cops->destroy_decompress_ctx(dic);
>   out_free_dic:
> -	if (verity)
> -		atomic_set(&dic->pending_pages, dic->nr_cpages);
>   	if (!verity)
>   		f2fs_decompress_end_io(dic->rpages, dic->cluster_size,
>   								ret, false);
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 42254d3859c7..b825d63cabdd 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2290,6 +2290,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>   		ctx = bio->bi_private;
>   		if (!(ctx->enabled_steps & (1 << STEP_DECOMPRESS)))
>   			ctx->enabled_steps |= 1 << STEP_DECOMPRESS;
> +		if (ctx->enabled_steps & (1 << STEP_VERITY))
> +			atomic_inc(&dic->pending_pages);

Hmm.. have a glance at this, then f2fs_decompress_pages() will always return due
to atomic_dec_return() is true? then f2fs_do_decompress_pages() will never be
called?

atomic_inc(dic->verity_pages) here and atomic_dec(dic->verity_pages) in
f2fs_verify_bio()?

	if (atomic_dec_return(dic->verity_pages))
		continue;

Thanks,

>   
>   		inc_page_count(sbi, F2FS_RD_DATA);
>   		f2fs_update_iostat(sbi, FS_DATA_READ_IO, F2FS_BLKSIZE);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 94d16bde5e24..a9ee7921c7ec 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1340,7 +1340,7 @@ struct decompress_io_ctx {
>   	struct compress_data *cbuf;	/* virtual mapped address on cpages */
>   	size_t rlen;			/* valid data length in rbuf */
>   	size_t clen;			/* valid data length in cbuf */
> -	atomic_t pending_pages;		/* in-flight compressed page count */
> +	atomic_t pending_pages;		/* in-flight compressed + verity page count */
>   	bool failed;			/* indicate IO error during decompression */
>   	void *private;			/* payload buffer for specified decompression algorithm */
>   	void *private2;			/* extra payload buffer */
> 
