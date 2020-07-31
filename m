Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD7D233EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 07:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbgGaFYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 01:24:38 -0400
Received: from nautica.notk.org ([91.121.71.147]:57207 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbgGaFYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 01:24:38 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 5DC4FC01C; Fri, 31 Jul 2020 07:24:36 +0200 (CEST)
Date:   Fri, 31 Jul 2020 07:24:21 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Li Heng <liheng40@huawei.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] 9p: Remove unneeded cast from memory allocation
Message-ID: <20200731052421.GA22875@nautica>
References: <1596013140-49744-1-git-send-email-liheng40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1596013140-49744-1-git-send-email-liheng40@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li Heng wrote on Wed, Jul 29, 2020:
> Remove casting the values returned by memory allocation function.
> 
> Coccinelle emits WARNING:
> 
> ./fs/9p/vfs_inode.c:226:12-29: WARNING: casting value returned by memory allocation function to (struct v9fs_inode *) is useless.
> 
> Signed-off-by: Li Heng <liheng40@huawei.com>

Why not, I'll take this for next.
Please pay a bit more attention to the commit message next time though,
neither "Remove casting the values" nor "x emits warning" are proper
English -- I've taken the liberty to fix the grammar a bit...

> ---
>  fs/9p/vfs_inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 0fd5bf2..ae0c38a 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -223,8 +223,7 @@ v9fs_blank_wstat(struct p9_wstat *wstat)
>  struct inode *v9fs_alloc_inode(struct super_block *sb)
>  {
>  	struct v9fs_inode *v9inode;
> -	v9inode = (struct v9fs_inode *)kmem_cache_alloc(v9fs_inode_cache,
> -							GFP_KERNEL);
> +	v9inode = kmem_cache_alloc(v9fs_inode_cache, GFP_KERNEL);
>  	if (!v9inode)
>  		return NULL;
>  #ifdef CONFIG_9P_FSCACHE
