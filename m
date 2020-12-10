Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A789D2D507B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 02:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgLJBrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 20:47:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9052 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLJBrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 20:47:24 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Crxb11h04zhq60;
        Thu, 10 Dec 2020 09:46:05 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 10 Dec
 2020 09:46:33 +0800
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: fix potential shift-out-of-bounds
 error in sanity_check_raw_super()
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <syzbot+ca9a785f8ac472085994@syzkaller.appspotmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20201209181322.27932-1-anant.thazhemadam@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9e38608c-9fc3-1f94-d275-742facef3db3@huawei.com>
Date:   Thu, 10 Dec 2020 09:46:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201209181322.27932-1-anant.thazhemadam@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anant,

I've posted a patch a little earlier. :P

https://lore.kernel.org/linux-f2fs-devel/20201209084936.31711-1-yuchao0@huawei.com/T/#u

Thanks,

On 2020/12/10 2:13, Anant Thazhemadam wrote:
> In sanity_check_raw_super(), if
> 1 << le32_to_cpu(raw_super->log_blocksize) != F2FS_BLKSIZE, then the
> block size is deemed to be invalid.
> 
> syzbot triggered a shift-out-of-bounds bug by assigning a value of 59 to
> le32_to_cpu(raw_super->log_blocksize).
> Although the value assigned itself isn't of much significance, this goes
> to show that even if the block size is invalid,
> le32_to_cpu(raw_super->log_blocksize) can be potentially evaluated to a
> value for which the shift exponent becomes too large for the unsigned
> int.
> 
> Since 1 << le32_to_cpu(raw_super->log_blocksize) must be = 4096 for a
> valid block size, le32_to_cpu(raw_super->log_blocksize) must equal 12.
> Replacing the existing check with the more direct sanity check
> resolves this bug.
> 
> Reported-by: syzbot+ca9a785f8ac472085994@syzkaller.appspotmail.com
> Tested-by: syzbot+ca9a785f8ac472085994@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>   fs/f2fs/super.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 33808c397580..4bc7372af43f 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2775,7 +2775,6 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>   	block_t total_sections, blocks_per_seg;
>   	struct f2fs_super_block *raw_super = (struct f2fs_super_block *)
>   					(bh->b_data + F2FS_SUPER_OFFSET);
> -	unsigned int blocksize;
>   	size_t crc_offset = 0;
>   	__u32 crc = 0;
>   
> @@ -2802,10 +2801,8 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>   	}
>   
>   	/* Currently, support only 4KB block size */
> -	blocksize = 1 << le32_to_cpu(raw_super->log_blocksize);
> -	if (blocksize != F2FS_BLKSIZE) {
> -		f2fs_info(sbi, "Invalid blocksize (%u), supports only 4KB",
> -			  blocksize);
> +	if (le32_to_cpu(raw_super->log_blocksize) != 12) {
> +		f2fs_info(sbi, "Invalid blocksize. Only 4KB supported");
>   		return -EFSCORRUPTED;
>   	}
>   
> 
