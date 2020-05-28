Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0807B1E5425
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 04:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgE1Cqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 22:46:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5295 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725896AbgE1Cqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:46:45 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3FBCEDC4BDD68E2F787E;
        Thu, 28 May 2020 10:46:44 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 28 May
 2020 10:46:39 +0800
Subject: Re: [PATCH] f2fs: compress: don't compress any datas after cp stop
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200526015502.22313-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fad281cf-a936-9b5a-6176-f9673b3038c9@huawei.com>
Date:   Thu, 28 May 2020 10:46:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200526015502.22313-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk, could you please review this patch?

On 2020/5/26 9:55, Chao Yu wrote:
> While compressed data writeback, we need to drop dirty pages like we did
> for non-compressed pages if cp stops, however it's not needed to compress
> any data in such case, so let's detect cp stop condition in
> cluster_may_compress() to avoid redundant compressing and let following
> f2fs_write_raw_pages() drops dirty pages correctly.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/compress.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index bf152c0d79fe..a53578a89211 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -849,6 +849,8 @@ static bool cluster_may_compress(struct compress_ctx *cc)
>  		return false;
>  	if (!f2fs_cluster_is_full(cc))
>  		return false;
> +	if (unlikely(f2fs_cp_error(F2FS_I_SB(cc->inode))))
> +		return false;
>  	return __cluster_may_compress(cc);
>  }
>  
> 
