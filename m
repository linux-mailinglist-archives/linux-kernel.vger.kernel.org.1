Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE5F2CE6C5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgLDEC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:02:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgLDEC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:02:28 -0500
Date:   Thu, 3 Dec 2020 20:01:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607054507;
        bh=DcfkWsDbsf/JOEQ79AZ1Kv2EVoF9gtQ63C/irFhCC60=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=bsJhD0lEDweOLSefcJ+JBO59ev7ZiiljHLUPejv44ascpkB9kMvOsTtR6vDlHT/zF
         sSlYCgX3qzDfw+z4LsfYuI4ymFm3g3SGXWcgvOVmabjVRd5YBYhM31iwRxuemztw7J
         dv9C3i/ZC1PnP9/T8KfEOgHwhi13sMSLTtYyGQYVOFx+U9hrI2V39iVogAqZM5t6dM
         jmXJPqAHUVWC0PYnRciyfXLPFFUWrZEUiRAMAw/e0Z67phzdQAyNFcWWH8k5AjHFKo
         Snwqpbn7+jcPiUv1xfAgTpmS/LHVZeiVEEbQJ+bplOGGELryNjGfVKWm+FhF9q0h+S
         LtZeMi/ZXervg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix race of pending_pages in
 decompression
Message-ID: <X8m0qbd7rvQyiwOt@sol.localdomain>
References: <20201204005847.654074-1-daeho43@gmail.com>
 <X8msy1T8uqZ4Z/iR@sol.localdomain>
 <CACOAw_wTFsfgLfrWKRoM1o_HQorJE-=2ztZftQTn+comcpmHxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_wTFsfgLfrWKRoM1o_HQorJE-=2ztZftQTn+comcpmHxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 12:43:23PM +0900, Daeho Jeong wrote:
> STEP_VERITY is enabled by f2fs_need_verity() and the function is like below.
> We already know the second condition (idx < DIV_ROUND_UP...) is
> satisfied when invoking f2fs_alloc_dic().
> 
> static inline bool f2fs_need_verity(const struct inode *inode, pgoff_t idx)
> {
>         return fsverity_active(inode) &&
>                idx < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
> }

Are you sure?  I thought that compression (and encryption) apply to the whole
file, including any Merkle tree blocks past i_size.

Also, even if you include the i_size check, it's still wrong to check
fsverity_active() in the middle of the I/O because FS_IOC_ENABLE_VERITY can
execute concurrently, causing fsverity_active() to return false at the beginning
of the I/O and true later in the I/O.  It needs to be checked only once, at the
beginning...

- Eric
