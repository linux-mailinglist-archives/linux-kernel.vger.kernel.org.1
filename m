Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7581CEA35
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 03:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgELBob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 21:44:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43894 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbgELBob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 21:44:31 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C6F26100283E77CE895F;
        Tue, 12 May 2020 09:44:28 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 12 May
 2020 09:44:28 +0800
Subject: Re: [PATCH] f2fs: compress: fix zstd data corruption
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Daeho Jeong <daehojeong@google.com>
References: <20200508011603.54553-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0e7fd845-f89b-f483-bb5a-c6cb7ec5c739@huawei.com>
Date:   Tue, 12 May 2020 09:44:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200508011603.54553-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

I think we need this patch in order to avoid writebacking incomplete data
compressed by zstd.

On 2020/5/8 9:16, Chao Yu wrote:
> During zstd compression, ZSTD_endStream() may return non-zero value
> because distination buffer is full, but there is still compressed data
> remained in intermediate buffer, it means that zstd algorithm can not
> save at last one block space, let's just writeback raw data instead of
> compressed one, this can fix data corruption when decompressing
> incomplete stored compression data.
> 

Fixes: 50cfa66f0de0 ("f2fs: compress: support zstd compress algorithm")

Thanks,


> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/compress.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index c22cc0d37369..5e4947250262 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -358,6 +358,13 @@ static int zstd_compress_pages(struct compress_ctx *cc)
>  		return -EIO;
>  	}
>  
> +	/*
> +	 * there is compressed data remained in intermediate buffer due to
> +	 * no more space in cbuf.cdata
> +	 */
> +	if (ret)
> +		return -EAGAIN;
> +
>  	cc->clen = outbuf.pos;
>  	return 0;
>  }
> 
