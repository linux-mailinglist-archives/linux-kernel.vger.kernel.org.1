Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6132C6E47
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 02:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbgK1BuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 20:50:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8053 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbgK1BqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 20:46:00 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CjYn11CFnzhjY5;
        Sat, 28 Nov 2020 09:29:09 +0800 (CST)
Received: from [10.174.178.154] (10.174.178.154) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sat, 28 Nov
 2020 09:29:27 +0800
Subject: Re: [PATCH -next] fs/ntfs: fix set but not used variable
 'log_page_mask'
To:     <anton@tuxera.com>
CC:     <linux-ntfs-dev@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20200312041353.19877-1-zhengzengkai@huawei.com>
From:   Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <3f52b53a-d7b4-7246-c1f6-7f57cc1c311f@huawei.com>
Date:   Sat, 28 Nov 2020 09:29:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200312041353.19877-1-zhengzengkai@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> fs/ntfs/logfile.c: In function ntfs_check_logfile:
> fs/ntfs/logfile.c:481:21:
>   warning: variable log_page_mask set but not used [-Wunused-but-set-variable]
>
> Actually log_page_mask can be used to replace 'log_page_size - 1' as it is set.
>
> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> ---
>   fs/ntfs/logfile.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
> index a0c40f1be7ac..c35fcf389369 100644
> --- a/fs/ntfs/logfile.c
> +++ b/fs/ntfs/logfile.c
> @@ -507,7 +507,7 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
>   	 * optimize log_page_size and log_page_bits into constants.
>   	 */
>   	log_page_bits = ntfs_ffs(log_page_size) - 1;
> -	size &= ~(s64)(log_page_size - 1);
> +	size &= ~(s64)(log_page_mask);
>   	/*
>   	 * Ensure the log file is big enough to store at least the two restart
>   	 * pages and the minimum number of log record pages.
