Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DE51E4FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 23:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgE0VCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 17:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgE0VCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:02:34 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C06A02075A;
        Wed, 27 May 2020 21:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590613353;
        bh=ZpO0iNl8OoGkBHS2pJ/PqkCglFvOTpmwqFbqZfDiGY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gqEJvXasPi5lFg1/xywpRwGhcG5v/IH/172gnPF/Ty0re3g/x3sczXploZAL2VVM/
         mr9oqYQ4igDy90BmYERy8TsNN5tHyttqq4aamjX0DkSV5ehxCZVOz0iMjlIuOcWUY9
         qnzC8MZMrrdZgShG+Ao3RflypOXb7B0xhbwIBJ0o=
Date:   Wed, 27 May 2020 14:02:33 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 3/3] f2fs: fix to cover meta flush with cp_lock
Message-ID: <20200527210233.GC206249@google.com>
References: <20200527102753.15743-1-yuchao0@huawei.com>
 <20200527102753.15743-3-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527102753.15743-3-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/27, Chao Yu wrote:
> meta inode page should be flushed under cp_lock, fix it.

It doesn't matter for this case, yes?

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f7de2a1da528..0fcae4d90074 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2260,7 +2260,9 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>  		break;
>  	case F2FS_GOING_DOWN_METAFLUSH:
> +		mutex_lock(&sbi->cp_mutex);
>  		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
> +		mutex_unlock(&sbi->cp_mutex);
>  		f2fs_stop_checkpoint(sbi, false);
>  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>  		break;
> -- 
> 2.18.0.rc1
