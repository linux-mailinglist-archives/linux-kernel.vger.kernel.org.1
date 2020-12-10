Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D342D61AF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392228AbgLJQXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:23:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388407AbgLJQXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:23:38 -0500
Date:   Thu, 10 Dec 2020 08:22:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607617378;
        bh=IT1JhMouVay4d31+Gw+I77QyHRv1BMMQHowugQ1EGS8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uo0NiqgPB/g8PXQKQB1ZRC1Telxr2qFG92011hQ3lHonyXSLgYaxJq158mhIWfKFZ
         HicY16RuNTpihqbB3lhvS5B0lT793phbiG+v82xkBK1sIb8kLIzpluOrHO22KhaZP1
         DMdphQ8Mw7oe9cn5SrVx0/YisG6MS7RKeVcA6cxHhknAWBvUgwYMcMYhr7oDZM0SgA
         Y0ktr1nILe/+Q2OEkkH/dGG14TWxGtPvQiVAUXuoW90aD4J+x1xMWpI/d8feiMhHrd
         Z2waf0JVIn1DUdrZv/Gp1EWiXCpAIigqyCyqM9EaGykgMQWUtnbwaZSFW6wO1QSxmw
         hOG5IHCWpQ4Wg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     =?utf-8?B?5b6Q55Ge5paM?= <robinh3123@gmail.com>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v3 2/3] f2fs-tools:sload.f2fs compression
 support
Message-ID: <X9JLYADc4+lF53gG@google.com>
References: <20201208081555.652932-1-robinh3123@gmail.com>
 <20201208081555.652932-3-robinh3123@gmail.com>
 <785e9f0a-c3d6-9cc5-f17a-a3cc58a43a0f@huawei.com>
 <CAKnFrsLmEROi+ZwVCmoC=W7u+rVoZfWGC9Lr9_y=oLMUZMw63Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKnFrsLmEROi+ZwVCmoC=W7u+rVoZfWGC9Lr9_y=oLMUZMw63Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10, 徐瑞斌 wrote:
> Hi, Jaegeuk,
> 
> I comment here the patch your provided (3 parts, since the patch contains 3
> fixes):
> 1.  +       dn->data_blkaddr = blkaddr;
>         ret = reserve_new_block(sbi, &dn->data_blkaddr, &sum, type, 0);
> 
> We cannot assign dn->data_blkaddr here.  The old one is to be used in
> reserve_new_block() function.  Also, reserve_new_block() function actually
> will set dn->data_blkaddr to blkaddr in the end.

This tries to avoid deleting the block address used in the previous offset.
Otherwise, we'll see wrong i_blocks.

> 
> 2.   Added condition "n < (1 << c.sldc_cc.log_cluster_size) * BLOCK_SZ"
> 
> The semantic meaning of the whole if statement is to say:
>    When the compression fail (ret  != 0) or the original read size is
> smaller than the compressed size plus (the minimum block saved (specified
> by the user) x block size), we will not do compression but just write the
> data as is.

This is missing the last block having < 4Kb.

> 
> The right hand side (RHS) of your added condition is exactly the read size,
> i.e. the cluster size.  That means the condition is always false except the
> read of the last part of the file, when the file size is not exactly the
> multiple of the cluster size.  That means we will never try to compress the
> last part of the file (when the last part is not a multiple of the cluster
> size)
> 
> IMHO, the original implementation should be correct.
> 
> 3.  node_blk->i.i_blocks += cpu_to_le64(cblocks);
> 
> I am not quite sure of the i_blocks count.  Did you mean that when the file
> is mutable,   meaning that the file reserves some blocks for future write,
> we will add count to i_blocks to mark the block as a used block by the
> file, right?  I thought we only need to increment the allocated count...

Should add it.

> 
> Regards,
> Robin Hsu 徐瑞斌
> 
> 
> On Thu, Dec 10, 2020 at 4:42 PM Chao Yu <yuchao0@huawei.com> wrote:
> 
> > On 2020/12/8 16:15, Robin Hsu wrote:
> > > From: Robin Hsu <robinhsu@google.com>
> > >
> > > Add F2FS compression support for sload
> > > * Support file extension filter, either default-accept or default-deny
> > >    policy
> > > * Support choice of compression algorithm, LZO (version 2) or LZ4
> > >    (default)
> > > * Support custom log of cluster size
> > > * Support minimum number of compressed blocks per cluster (default 1).
> > >    A cluster will not be compressed if the number can not be met.
> > > * suuport -r (read-only) option
> >
> > Could you please update manual as well?
> >
> > > +
> > > +     /* sldc: sload compression support */
> >
> > Personally, I don't like the naming method of adding "sldc_" prefix... :(
> >
> > > +     bool sldc_en;
> > > +     bool sldc_use_allow_list;  /* default false to use the deny list */
> > > +     struct compress_ctx sldc_cc;
> > > +     u8 sldc_ca; /* compress algorithm: 0 = LZO, 1 = LZ4 */
> > > +     compress_ops *sldc_compr;
> > > +     enum filter_policy sldc_policy;
> > > +     /* max_cppc can used to specify minimum compression rate */
> > > +     unsigned int sldc_min_cbpc; /* min compressed pages per cluster */
> > > +     bool sldc_got_opt;
> > > +     bool sldc_immutable;
> > > +     struct ext_tbl_op *sldc_ef; /* extension filter */
> >
> > The variables name like sldc_en, sldc_ca, min_cbpc, sldc_ef makes
> > developers
> > hard to understand w/o comments, and also there is no comments for several
> > variable like sldc_en, sldc_cc...
> >
> > Could you please improve the naming like f2fs-tools style?
> >
> > Thanks,
> >
