Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01C02B361E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 17:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgKOQVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 11:21:54 -0500
Received: from m12-11.163.com ([220.181.12.11]:44980 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgKOQVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 11:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=r9zkQ
        B9zbIIFRujpdUPddFMqxQ4Ac8VH6/3xP7sWVOg=; b=R1+roSQRUJrWBH98OyL86
        nVItjrZku9H5HWQUqqMcC9BGLDqyHY1Tk8+8t8hsZx7vTbjgNClNYpwoSL5ucFwC
        5nIO7Tgld1LdThqWcuF3yL/V3Hg+mPV/D6zMFUuPEUEBNdVecIQ8X89pgCp9ICLC
        6c9ASL/yLAHddyH++tnszM=
Received: from localhost (unknown [101.86.213.176])
        by smtp7 (Coremail) with SMTP id C8CowADX66ElVbFf0IHSBw--.535S2;
        Mon, 16 Nov 2020 00:19:49 +0800 (CST)
Date:   Mon, 16 Nov 2020 00:19:49 +0800
From:   Hui Su <sh_def@163.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hughd@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        lkp@intel.com
Subject: Re: [PATCH v2] mm/shmem.c: make shmem_mapping() inline
Message-ID: <20201115161949.GA249884@rlk>
References: <20201114055134.GA186011@rlk>
 <20201114105039.4d44e3036e22e10c9a70912c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114105039.4d44e3036e22e10c9a70912c@linux-foundation.org>
X-CM-TRANSID: C8CowADX66ElVbFf0IHSBw--.535S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4fuFykXr1UCFy8uw4kZwb_yoW8AF47pF
        yUJa15Cr40qry7KFWIvF18ZFyFqa18t3y0y345Gwn0vF1kXry7tFWjkrs0vF4UAryxGw40
        qF4jkw18W34aqrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3Oz3UUUUU=
X-Originating-IP: [101.86.213.176]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiLgXdX1SIq1n1wAAAsy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 10:50:39AM -0800, Andrew Morton wrote:
> On Sat, 14 Nov 2020 13:51:34 +0800 Hui Su <sh_def@163.com> wrote:
> 
> > inline the shmem_mapping(), and use shmem_mapping()
> > instead of 'inode->i_mapping->a_ops == &shmem_aops'
> > in shmem_evict_inode().
> > 
> > ...
> >
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1152,7 +1152,7 @@ static void shmem_evict_inode(struct inode *inode)
> >  	struct shmem_inode_info *info = SHMEM_I(inode);
> >  	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> >  
> > -	if (inode->i_mapping->a_ops == &shmem_aops) {
> > +	if (shmem_mapping(inode->i_mapping)) {
> >  		shmem_unacct_size(info->flags, inode->i_size);
> >  		inode->i_size = 0;
> >  		shmem_truncate_range(inode, 0, (loff_t)-1);
> > @@ -2352,7 +2352,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
> >  	return inode;
> >  }
> >  
> > -bool shmem_mapping(struct address_space *mapping)
> > +inline bool shmem_mapping(struct address_space *mapping)
> >  {
> >  	return mapping->a_ops == &shmem_aops;
> >  }
> 
> huh.  I'd have expected the inlining in shmem_evict_inode() to not work
> because the compiler hasn't seen the definition yet.  But gcc has
> evidently become smarter about that.
> 
> But really, shmem_mapping() isn't worth an out-of-line call from any
> callsite - it would be best to make it inlined everywhere.
> 
> - make shmem_aops global
> - declare shmem_aops in shmem_fs.h
> - export shmem_aops to modules for drivers/dma-buf/udmabuf.c
> - include linux/fs.h in shmem_fs.h for address_space_operations (we already
>   include fs.h via swap.h, but we shouldn't depend on that)
> - make shmem_mapping() a static inline in shmem_fs.h.

Yeah, thanks.

i will resend a PATCH V3 later.

