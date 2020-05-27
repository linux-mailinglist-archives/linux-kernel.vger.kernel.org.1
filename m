Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629B71E4FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 22:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgE0U4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 16:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgE0U4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:56:04 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB7EA2088E;
        Wed, 27 May 2020 20:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590612964;
        bh=CZnp1dPscHvgEsASP4rO6RwpRosxd5cli/BtqtDHsvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7dJMVmocSOm/m0XBFdUcedmtZdF03oRbNVu4aLVC37xHlvKTqCnNB0YS6INeGVwr
         febkhyUGGwleQp5IIoEpKmcd7LHkdMLMyY7yNwrODe1+2GZRirg4lK7M6+77+sZadx
         sGYaa13HokZGZGXzo59VeQdJcQ0Rf79KqRtu0OTM=
Date:   Wed, 27 May 2020 13:56:03 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid inifinite loop to wait for
 flushing node pages at cp_error
Message-ID: <20200527205603.GB206249@google.com>
References: <20200522144752.216197-1-jaegeuk@kernel.org>
 <20200522233243.GA94020@google.com>
 <20200525035655.GA135148@google.com>
 <565af47c-8364-d910-8d1c-93645c12e660@huawei.com>
 <20200525150608.GA55033@google.com>
 <92afae8b-2dd3-171a-562c-404a67f9aab2@huawei.com>
 <a44f9c2e-3859-6c5d-6f06-7c4c6b4c01c5@huawei.com>
 <20200526015650.GA207949@google.com>
 <765a1ac5-a318-14d6-666f-eab46f892d01@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <765a1ac5-a318-14d6-666f-eab46f892d01@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/27, Chao Yu wrote:
> On 2020/5/26 9:56, Jaegeuk Kim wrote:
> > On 05/26, Chao Yu wrote:
> >> On 2020/5/26 9:11, Chao Yu wrote:
> >>> On 2020/5/25 23:06, Jaegeuk Kim wrote:
> >>>> On 05/25, Chao Yu wrote:
> >>>>> On 2020/5/25 11:56, Jaegeuk Kim wrote:
> >>>>>> Shutdown test is somtimes hung, since it keeps trying to flush dirty node pages
> 
>     71.07%     0.01%  kworker/u256:1+  [kernel.kallsyms]  [k] wb_writeback
>             |
>              --71.06%--wb_writeback
>                        |
>                        |--68.96%--__writeback_inodes_wb
>                        |          |
>                        |           --68.95%--writeback_sb_inodes
>                        |                     |
>                        |                     |--65.08%--__writeback_single_inode
>                        |                     |          |
>                        |                     |           --64.35%--do_writepages
>                        |                     |                     |
>                        |                     |                     |--59.83%--f2fs_write_node_pages
>                        |                     |                     |          |
>                        |                     |                     |           --59.74%--f2fs_sync_node_pages
>                        |                     |                     |                     |
>                        |                     |                     |                     |--27.91%--pagevec_lookup_range_tag
>                        |                     |                     |                     |          |
>                        |                     |                     |                     |           --27.90%--find_get_pages_range_tag
> 
> Before umount, kworker will always hold one core, that looks not reasonable,
> to avoid that, could we just allow node write, since it's out-place-update,
> and cp is not allowed, we don't need to worry about its effect on data on
> previous checkpoint, and it can decrease memory footprint cost by node pages.

It can cause some roll-forward recovery?

> 
> Thanks,
> 
> >>>>>
> >>>>> IMO, for umount case, we should drop dirty reference and dirty pages on meta/data
> >>>>> pages like we change for node pages to avoid potential dead loop...
> >>>>
> >>>> I believe we're doing for them. :P
> >>>
> >>> Actually, I mean do we need to drop dirty meta/data pages explicitly as below:
> >>>
> >>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >>> index 3dc3ac6fe143..4c08fd0a680a 100644
> >>> --- a/fs/f2fs/checkpoint.c
> >>> +++ b/fs/f2fs/checkpoint.c
> >>> @@ -299,8 +299,15 @@ static int __f2fs_write_meta_page(struct page *page,
> >>>
> >>>  	trace_f2fs_writepage(page, META);
> >>>
> >>> -	if (unlikely(f2fs_cp_error(sbi)))
> >>> +	if (unlikely(f2fs_cp_error(sbi))) {
> >>> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
> >>> +			ClearPageUptodate(page);
> >>> +			dec_page_count(sbi, F2FS_DIRTY_META);
> >>> +			unlock_page(page);
> >>> +			return 0;
> >>> +		}
> >>>  		goto redirty_out;
> >>> +	}
> >>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> >>>  		goto redirty_out;
> >>>  	if (wbc->for_reclaim && page->index < GET_SUM_BLOCK(sbi, 0))
> >>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>> index 48a622b95b76..94b342802513 100644
> >>> --- a/fs/f2fs/data.c
> >>> +++ b/fs/f2fs/data.c
> >>> @@ -2682,6 +2682,12 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
> >>>
> >>>  	/* we should bypass data pages to proceed the kworkder jobs */
> >>>  	if (unlikely(f2fs_cp_error(sbi))) {
> >>> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
> >>> +			ClearPageUptodate(page);
> >>> +			inode_dec_dirty_pages(inode);
> >>> +			unlock_page(page);
> >>> +			return 0;
> >>> +		}
> >>
> >> Oh, I notice previously, we will drop non-directory inode's dirty pages directly,
> >> however, during umount, we'd better drop directory inode's dirty pages as well, right?
> > 
> > Hmm, I remember I dropped them before. Need to double check.
> > 
> >>
> >>>  		mapping_set_error(page->mapping, -EIO);
> >>>  		/*
> >>>  		 * don't drop any dirty dentry pages for keeping lastest
> >>>
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>>> in an inifinite loop. Let's drop dirty pages at umount in that case.
> >>>>>>
> >>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>>>> ---
> >>>>>> v3:
> >>>>>>  - fix wrong unlock
> >>>>>>
> >>>>>> v2:
> >>>>>>  - fix typos
> >>>>>>
> >>>>>>  fs/f2fs/node.c | 9 ++++++++-
> >>>>>>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> >>>>>> index e632de10aedab..e0bb0f7e0506e 100644
> >>>>>> --- a/fs/f2fs/node.c
> >>>>>> +++ b/fs/f2fs/node.c
> >>>>>> @@ -1520,8 +1520,15 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
> >>>>>>  
> >>>>>>  	trace_f2fs_writepage(page, NODE);
> >>>>>>  
> >>>>>> -	if (unlikely(f2fs_cp_error(sbi)))
> >>>>>> +	if (unlikely(f2fs_cp_error(sbi))) {
> >>>>>> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
> >>>>>> +			ClearPageUptodate(page);
> >>>>>> +			dec_page_count(sbi, F2FS_DIRTY_NODES);
> >>>>>> +			unlock_page(page);
> >>>>>> +			return 0;
> >>>>>> +		}
> >>>>>>  		goto redirty_out;
> >>>>>> +	}
> >>>>>>  
> >>>>>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> >>>>>>  		goto redirty_out;
> >>>>>>
> >>>> .
> >>>>
> >>>
> >>>
> >>> _______________________________________________
> >>> Linux-f2fs-devel mailing list
> >>> Linux-f2fs-devel@lists.sourceforge.net
> >>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >>> .
> >>>
> > .
> > 
