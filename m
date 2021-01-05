Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160192EA7B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbhAEJfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:35:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50434 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbhAEJfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:35:09 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kwijS-0007eX-9w; Tue, 05 Jan 2021 09:34:26 +0000
Subject: Re: [PATCH v2] f2fs: fix null page reference in redirty_blocks
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210105041630.1393157-1-daeho43@gmail.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <57be566b-89e2-04a1-9a8e-51e902fee96c@canonical.com>
Date:   Tue, 5 Jan 2021 09:34:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105041630.1393157-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2021 04:16, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Fixed null page reference when find_lock_page() fails in
> redirty_blocks().
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
> ---
> v2: changed error value and break the loop when error occurs
> ---
>  fs/f2fs/file.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 9e5275716be8..d27173c24391 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4060,8 +4060,10 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
>  
>  	for (i = 0; i < page_len; i++, redirty_idx++) {
>  		page = find_lock_page(mapping, redirty_idx);
> -		if (!page)
> -			ret = -ENOENT;
> +		if (!page) {
> +			ret = -ENOMEM;
> +			break;
> +		}
>  		set_page_dirty(page);
>  		f2fs_put_page(page, 1);
>  		f2fs_put_page(page, 0);
> 
Thanks, looks good to me.

Reviewed-by: Colin Ian King <colin.king@canonical.com>
