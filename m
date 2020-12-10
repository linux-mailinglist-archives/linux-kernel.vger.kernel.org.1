Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13CA2D6214
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392084AbgLJQhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:37:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391184AbgLJQgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:36:54 -0500
Date:   Thu, 10 Dec 2020 08:36:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607618173;
        bh=fbQ4nuVsVzui/yLCe8bXeRIRjFWB90VPKZTYzTxSMsU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=GzMO/8Sg2LxApIIozXGkp2kgxVaFJ1k8OEWW7WQ6vCJPb//80dlWjFqcTWjXH4dns
         ViCNL5ubiNQnJBtKE5Nsgh1+W2C2JhRMO+SgKG8pkk+6GzEHJzK6S/sfxTGurmeDG0
         JSIDkOlpGvd/vNW9kC3YCi97QD/kDZkrkcHejfyLCbLVpNYX2kT9ootfZ3ieOEQ/9o
         bONisRZRZ12z20XKbP/wAFinLmN3nyEyOjwfgS9+jzeUOwjeHMwBSSawWflOOsJmwp
         V6WrYSeulHnXBzixunP4sLIDqLBKNVD0rwuaIIhrVJI7P9lUXMRmfQU8C3Ib5NrweJ
         Fgc/fHeQyrbRA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     =?utf-8?B?5b6Q55Ge5paM?= <robinh3123@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3 2/3] f2fs-tools:sload.f2fs compression
 support
Message-ID: <X9JOe7pULqpJnD0d@google.com>
References: <20201208081555.652932-1-robinh3123@gmail.com>
 <20201208081555.652932-3-robinh3123@gmail.com>
 <785e9f0a-c3d6-9cc5-f17a-a3cc58a43a0f@huawei.com>
 <CAKnFrsLmEROi+ZwVCmoC=W7u+rVoZfWGC9Lr9_y=oLMUZMw63Q@mail.gmail.com>
 <X9JLYADc4+lF53gG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X9JLYADc4+lF53gG@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chao and Robin,

I refactored the patch to modify the names and structures.
Please take a look at this.
https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev&id=5cd8e5fcc79611c0692f18c7e7e13d6b4742d3c0

On 12/10, Jaegeuk Kim wrote:
> On 12/10, 徐瑞斌 wrote:
> > Hi, Jaegeuk,
> > 
> > I comment here the patch your provided (3 parts, since the patch contains 3
> > fixes):
> > 1.  +       dn->data_blkaddr = blkaddr;
> >         ret = reserve_new_block(sbi, &dn->data_blkaddr, &sum, type, 0);
> > 
> > We cannot assign dn->data_blkaddr here.  The old one is to be used in
> > reserve_new_block() function.  Also, reserve_new_block() function actually
> > will set dn->data_blkaddr to blkaddr in the end.
> 
> This tries to avoid deleting the block address used in the previous offset.
> Otherwise, we'll see wrong i_blocks.
> 
> > 
> > 2.   Added condition "n < (1 << c.sldc_cc.log_cluster_size) * BLOCK_SZ"
> > 
> > The semantic meaning of the whole if statement is to say:
> >    When the compression fail (ret  != 0) or the original read size is
> > smaller than the compressed size plus (the minimum block saved (specified
> > by the user) x block size), we will not do compression but just write the
> > data as is.
> 
> This is missing the last block having < 4Kb.
> 
> > 
> > The right hand side (RHS) of your added condition is exactly the read size,
> > i.e. the cluster size.  That means the condition is always false except the
> > read of the last part of the file, when the file size is not exactly the
> > multiple of the cluster size.  That means we will never try to compress the
> > last part of the file (when the last part is not a multiple of the cluster
> > size)
> > 
> > IMHO, the original implementation should be correct.
> > 
> > 3.  node_blk->i.i_blocks += cpu_to_le64(cblocks);
> > 
> > I am not quite sure of the i_blocks count.  Did you mean that when the file
> > is mutable,   meaning that the file reserves some blocks for future write,
> > we will add count to i_blocks to mark the block as a used block by the
> > file, right?  I thought we only need to increment the allocated count...
> 
> Should add it.
> 
> > 
> > Regards,
> > Robin Hsu 徐瑞斌
> > 
> > 
> > On Thu, Dec 10, 2020 at 4:42 PM Chao Yu <yuchao0@huawei.com> wrote:
> > 
> > > On 2020/12/8 16:15, Robin Hsu wrote:
> > > > From: Robin Hsu <robinhsu@google.com>
> > > >
> > > > Add F2FS compression support for sload
> > > > * Support file extension filter, either default-accept or default-deny
> > > >    policy
> > > > * Support choice of compression algorithm, LZO (version 2) or LZ4
> > > >    (default)
> > > > * Support custom log of cluster size
> > > > * Support minimum number of compressed blocks per cluster (default 1).
> > > >    A cluster will not be compressed if the number can not be met.
> > > > * suuport -r (read-only) option
> > >
> > > Could you please update manual as well?
> > >
> > > > +
> > > > +     /* sldc: sload compression support */
> > >
> > > Personally, I don't like the naming method of adding "sldc_" prefix... :(
> > >
> > > > +     bool sldc_en;
> > > > +     bool sldc_use_allow_list;  /* default false to use the deny list */
> > > > +     struct compress_ctx sldc_cc;
> > > > +     u8 sldc_ca; /* compress algorithm: 0 = LZO, 1 = LZ4 */
> > > > +     compress_ops *sldc_compr;
> > > > +     enum filter_policy sldc_policy;
> > > > +     /* max_cppc can used to specify minimum compression rate */
> > > > +     unsigned int sldc_min_cbpc; /* min compressed pages per cluster */
> > > > +     bool sldc_got_opt;
> > > > +     bool sldc_immutable;
> > > > +     struct ext_tbl_op *sldc_ef; /* extension filter */
> > >
> > > The variables name like sldc_en, sldc_ca, min_cbpc, sldc_ef makes
> > > developers
> > > hard to understand w/o comments, and also there is no comments for several
> > > variable like sldc_en, sldc_cc...
> > >
> > > Could you please improve the naming like f2fs-tools style?
> > >
> > > Thanks,
> > >
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
