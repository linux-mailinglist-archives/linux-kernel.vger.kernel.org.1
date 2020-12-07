Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D882D16A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgLGQmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:42:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgLGQmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:42:53 -0500
Date:   Mon, 7 Dec 2020 08:42:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607359332;
        bh=r39jSa7O4h4XF+mtH8ZkdKDvVNF09KuX0GRwTm1zppU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=PuveFqKDjL3pYA8tgl7/wgzAdtn5QZxJPtExTfKEto6Fl8R1rgpB37DBAbi/qGu3/
         tfbR5z4EwZp/4pHzAhPLeGM3ObvwjjSds9IV5L22ACXP3641WlC32VzvZFwBLEsNW4
         c8HSApyYTwiUk7v45i15/URjObZ+Lz9Zcg8n0hG5mNI9GTEavhjLAXvN95r5LlaOuc
         wMQw6bY7YSHsemGpq4ybnbU1L8LfGFyQ1KR7XMQOCIIOs7QjUZEXl2tbDMQejryN2+
         BUBJVZ7n3IlBXSZmhiipJB3njLMmjkq5DYAcyrrPVUVwijUGHfVu4u9IPl48vAJDOl
         N8b1tl89Cgebw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix race of pending_pages in
 decompression
Message-ID: <X85bY0Itm0vxH3+I@google.com>
References: <20201205042626.1113600-1-daeho43@gmail.com>
 <c3c41d53-2a99-17a2-223a-3d674613a417@huawei.com>
 <CACOAw_zwbmYHbUVUmzGMci9SaSVSrP8NXXavHBSSLxbAEOrMcw@mail.gmail.com>
 <c45d327f-b669-a0ec-bd77-0c95dfd8db2c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c45d327f-b669-a0ec-bd77-0c95dfd8db2c@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07, Chao Yu wrote:
> On 2020/12/7 15:28, Daeho Jeong wrote:
> > > It looks like it will be better to move this into merge condition?
> > > 
> > >                  if (bio && (!page_is_mergeable(sbi, bio,
> > >                                          *last_block_in_bio, blkaddr) ||
> > >                      !f2fs_crypt_mergeable_bio(bio, inode, page->index, NULL) ||
> > >                          f2fs_verify_mergeable_bio())) {
> > > 
> > 
> > I tried this for the first time, but it requires unnecessary checks
> > within the compression cluster.
> 
> We only need to check f2fs_verify_mergeable_bio for i == 0 case? something like:
> 
> static bool f2fs_verify_mergeable_bio(struct bio *bio, bool verify, bool first_page)
> {
> 	if (!first_page)

Agreed that we don't need to run this instruction for every pages.

> 		return false;
> 	if (!verify)
> 		return false;
> 
> 	ctx = bio->bi_private;
> 	if (!(ctx->enabled_steps & (1 << STEP_VERITY)))
> 		return true;
> }
> 
> Thoughts?
> 
> > I wanted to just check one time in the beginning of the cluster.
> > What do you think?
> 
> It's trivial, but I'm think about the readability... at least, one line comment
> is needed to describe why we submit previous bio. :)

I added like this. :P
https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=f189a2471df2560e5834d999ab4ff68bc10853e4

> 
> Thanks,
> 
> > .
> > 
