Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C452220EB50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 04:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgF3CKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 22:10:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46048 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726288AbgF3CKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:10:18 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 767F9F4432087A4712BF;
        Tue, 30 Jun 2020 10:10:14 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 30 Jun
 2020 10:10:10 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix typo in comment of f2fs_do_add_link
To:     <jaegeuk@kernel.org>
CC:     Liu Song <fishland@aliyun.com>, <chao@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200625124011.8072-1-fishland@aliyun.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <31f8ff95-ad11-cb1c-fbf8-a9ddd450499d@huawei.com>
Date:   Tue, 30 Jun 2020 10:10:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200625124011.8072-1-fishland@aliyun.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

It looks we merge this patch with below wrong author, better to fix this

Liu Song via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>

On 2020/6/25 20:40, Liu Song via Linux-f2fs-devel wrote:
> stakable/stackable
> 
> Signed-off-by: Liu Song <fishland@aliyun.com>
> ---
>  fs/f2fs/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index d35976785e8c..069f498af1e3 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -779,7 +779,7 @@ int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
>  		return err;
>  
>  	/*
> -	 * An immature stakable filesystem shows a race condition between lookup
> +	 * An immature stackable filesystem shows a race condition between lookup
>  	 * and create. If we have same task when doing lookup and create, it's
>  	 * definitely fine as expected by VFS normally. Otherwise, let's just
>  	 * verify on-disk dentry one more time, which guarantees filesystem
> 
