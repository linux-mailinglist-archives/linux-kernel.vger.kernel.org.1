Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00C01E06F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 08:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388895AbgEYGak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 02:30:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44998 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388631AbgEYGaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:30:39 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0D714C6D2510EF809AD4;
        Mon, 25 May 2020 14:30:27 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 25 May
 2020 14:30:26 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid inifinite loop to wait for
 flushing node pages at cp_error
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200522144752.216197-1-jaegeuk@kernel.org>
 <20200522233243.GA94020@google.com> <20200525035655.GA135148@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <565af47c-8364-d910-8d1c-93645c12e660@huawei.com>
Date:   Mon, 25 May 2020 14:30:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200525035655.GA135148@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/25 11:56, Jaegeuk Kim wrote:
> Shutdown test is somtimes hung, since it keeps trying to flush dirty node pages

IMO, for umount case, we should drop dirty reference and dirty pages on meta/data
pages like we change for node pages to avoid potential dead loop...

Thanks,

> in an inifinite loop. Let's drop dirty pages at umount in that case.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> v3:
>  - fix wrong unlock
> 
> v2:
>  - fix typos
> 
>  fs/f2fs/node.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index e632de10aedab..e0bb0f7e0506e 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1520,8 +1520,15 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>  
>  	trace_f2fs_writepage(page, NODE);
>  
> -	if (unlikely(f2fs_cp_error(sbi)))
> +	if (unlikely(f2fs_cp_error(sbi))) {
> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
> +			ClearPageUptodate(page);
> +			dec_page_count(sbi, F2FS_DIRTY_NODES);
> +			unlock_page(page);
> +			return 0;
> +		}
>  		goto redirty_out;
> +	}
>  
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>  		goto redirty_out;
> 
