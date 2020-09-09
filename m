Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EBD2625CE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 05:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgIIDT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 23:19:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbgIIDT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 23:19:26 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 30D54FF0F60299D870FD;
        Wed,  9 Sep 2020 11:19:24 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 9 Sep 2020
 11:19:20 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up vm_map_ram() call
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20200909023634.3821423-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4c8971ce-98b5-4675-8310-5e9af0a14bb6@huawei.com>
Date:   Wed, 9 Sep 2020 11:19:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200909023634.3821423-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/9 10:36, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Made f2fs_vmap() wrapper to handle vm_map_ram() stuff.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

LGTM,

I think it should be merged into original patch. :)

Maybe Jaeguek could help to do that.

Thanks,

> ---
>   fs/f2fs/compress.c | 42 ++++++++++++++++++------------------------
>   1 file changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 357303d8514b..7895186cc765 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -557,6 +557,20 @@ static void f2fs_compress_free_page(struct page *page)
>   
>   #define MAX_VMAP_RETRIES	3
>   
> +static void *f2fs_vmap(struct page **pages, unsigned int count)
> +{
> +	int i;
> +	void *buf = NULL;
> +
> +	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
> +		buf = vm_map_ram(pages, count, -1);
> +		if (buf)
> +			break;
> +		vm_unmap_aliases();
> +	}
> +	return buf;
> +}
> +
>   static int f2fs_compress_pages(struct compress_ctx *cc)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
> @@ -593,23 +607,13 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
>   		}
>   	}
>   
> -	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
> -		cc->rbuf = vm_map_ram(cc->rpages, cc->cluster_size, -1);
> -		if (cc->rbuf)
> -			break;
> -		vm_unmap_aliases();
> -	}
> +	cc->rbuf = f2fs_vmap(cc->rpages, cc->cluster_size);
>   	if (!cc->rbuf) {
>   		ret = -ENOMEM;
>   		goto out_free_cpages;
>   	}
>   
> -	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
> -		cc->cbuf = vm_map_ram(cc->cpages, cc->nr_cpages, -1);
> -		if (cc->cbuf)
> -			break;
> -		vm_unmap_aliases();
> -	}
> +	cc->cbuf = f2fs_vmap(cc->cpages, cc->nr_cpages);
>   	if (!cc->cbuf) {
>   		ret = -ENOMEM;
>   		goto out_vunmap_rbuf;
> @@ -728,23 +732,13 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
>   			goto out_free_dic;
>   	}
>   
> -	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
> -		dic->rbuf = vm_map_ram(dic->tpages, dic->cluster_size, -1);
> -		if (dic->rbuf)
> -			break;
> -		vm_unmap_aliases();
> -	}
> +	dic->rbuf = f2fs_vmap(dic->tpages, dic->cluster_size);
>   	if (!dic->rbuf) {
>   		ret = -ENOMEM;
>   		goto destroy_decompress_ctx;
>   	}
>   
> -	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
> -		dic->cbuf = vm_map_ram(dic->cpages, dic->nr_cpages, -1);
> -		if (dic->cbuf)
> -			break;
> -		vm_unmap_aliases();
> -	}
> +	dic->cbuf = f2fs_vmap(dic->cpages, dic->nr_cpages);
>   	if (!dic->cbuf) {
>   		ret = -ENOMEM;
>   		goto out_vunmap_rbuf;
> 
