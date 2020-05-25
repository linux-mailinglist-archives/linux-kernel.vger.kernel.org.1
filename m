Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342131E049F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 04:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388678AbgEYCRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 22:17:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43784 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388425AbgEYCRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 22:17:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E161DA2192EA7979E763;
        Mon, 25 May 2020 10:16:58 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 25 May
 2020 10:16:55 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid inifinite loop to wait for
 flushing node pages at cp_error
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200522144752.216197-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d105adcf-fa04-4165-f19d-84e1cafe3ce5@huawei.com>
Date:   Mon, 25 May 2020 10:16:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200522144752.216197-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/22 22:47, Jaegeuk Kim wrote:
> Shutdown test is somtime hung, since dirty node pages weren't flushed out.
> Let's drop dirty pages at umount after shutdown.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/node.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index e632de10aedab..8c63964a82fd0 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1520,8 +1520,15 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>  
>  	trace_f2fs_writepage(page, NODE);
>  
> -	if (unlikely(f2fs_cp_error(sbi)))
> +	if (unlikely(f2fs_cp_error(sbi))) {
> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
> +			dec_page_count(sbi, F2FS_DIRTY_NODES);
> +			up_read(&sbi->node_write);

We don't need to release node_write lock.

> +			unlock_page(page);
> +			return 0;
> +		}
>  		goto redirty_out;
> +	}
>  
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>  		goto redirty_out;
> 
