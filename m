Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B6B302226
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 07:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbhAYGbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 01:31:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11856 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbhAYG2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 01:28:49 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DPKdl029jz7ZgK;
        Mon, 25 Jan 2021 14:26:51 +0800 (CST)
Received: from [10.174.179.117] (10.174.179.117) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 14:27:58 +0800
Subject: Re: [PATCH] mm/filemap: Remove redundant variable's assignment
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <08dc7237b44b9455ab095b44dc6969a1607b08db.1611544316.git.baolin.wang@linux.alibaba.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2dfe7c46-f8a3-a28b-021b-7c6f4d2843f9@huawei.com>
Date:   Mon, 25 Jan 2021 14:27:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <08dc7237b44b9455ab095b44dc6969a1607b08db.1611544316.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/25 11:20, Baolin Wang wrote:
> We've already set the variable 'i' 's initial value before using it,
> thus remove redundant previous assignment of variable 'i'.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/filemap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index e4906f5..07b02f3 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2472,7 +2472,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  		if ((iocb->ki_flags & IOCB_WAITQ) && written)
>  			iocb->ki_flags |= IOCB_NOWAIT;
>  
> -		i = 0;
>  		pg_nr = generic_file_buffered_read_get_pages(iocb, iter,
>  							     pages, nr_pages);
>  		if (pg_nr < 0) {
> 

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
