Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46CA2B2FD8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 19:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKNSuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 13:50:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgKNSul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 13:50:41 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94B8822265;
        Sat, 14 Nov 2020 18:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605379839;
        bh=ezxCtaDdeZly+HW5p2b/mg5LVu5bhTfJ9fCs92Y0UZs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pMGPmxFhw48ZKVu31kEXodS5VuJ7nCpP4JNdw9xkZL/c9XuTr3psNSp6hB3uNyIlJ
         iQPO2Mnr7oTo4iz0n1aGaD1DJD94PouMgkwSM/4LpnoXGKC/FmQHOBGVwAHRrq7c9q
         xUW1RZPxRZYBOXqrkVFIYyNhWLIG0s5Qi/ipcqPo=
Date:   Sat, 14 Nov 2020 10:50:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hui Su <sh_def@163.com>
Cc:     hughd@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        pankaj.gupta.linux@gmail.com, lkp@intel.com
Subject: Re: [PATCH v2] mm/shmem.c: make shmem_mapping() inline
Message-Id: <20201114105039.4d44e3036e22e10c9a70912c@linux-foundation.org>
In-Reply-To: <20201114055134.GA186011@rlk>
References: <20201114055134.GA186011@rlk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Nov 2020 13:51:34 +0800 Hui Su <sh_def@163.com> wrote:

> inline the shmem_mapping(), and use shmem_mapping()
> instead of 'inode->i_mapping->a_ops == &shmem_aops'
> in shmem_evict_inode().
> 
> ...
>
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1152,7 +1152,7 @@ static void shmem_evict_inode(struct inode *inode)
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>  
> -	if (inode->i_mapping->a_ops == &shmem_aops) {
> +	if (shmem_mapping(inode->i_mapping)) {
>  		shmem_unacct_size(info->flags, inode->i_size);
>  		inode->i_size = 0;
>  		shmem_truncate_range(inode, 0, (loff_t)-1);
> @@ -2352,7 +2352,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>  	return inode;
>  }
>  
> -bool shmem_mapping(struct address_space *mapping)
> +inline bool shmem_mapping(struct address_space *mapping)
>  {
>  	return mapping->a_ops == &shmem_aops;
>  }

huh.  I'd have expected the inlining in shmem_evict_inode() to not work
because the compiler hasn't seen the definition yet.  But gcc has
evidently become smarter about that.

But really, shmem_mapping() isn't worth an out-of-line call from any
callsite - it would be best to make it inlined everywhere.

- make shmem_aops global
- declare shmem_aops in shmem_fs.h
- export shmem_aops to modules for drivers/dma-buf/udmabuf.c
- include linux/fs.h in shmem_fs.h for address_space_operations (we already
  include fs.h via swap.h, but we shouldn't depend on that)
- make shmem_mapping() a static inline in shmem_fs.h.
