Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4A129968C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1792691AbgJZTOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1737873AbgJZTJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:09:51 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69779207C4;
        Mon, 26 Oct 2020 19:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603739390;
        bh=2IS64HnRc9y+q8Z5MiJRIZdsBB3GJPhRkgeyWqltGDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/LKASGjJkVprsSmMg8GqFQLrl5ou0F3gi1tBM8CJ8irI92i9wmzybBnIh4+62iRH
         Bu1pp8ffjCos+dunaOvrrSjjNUxHbg8l5rihlKx5xvIAbtOFUKlWNNTKXMI8DdDI7j
         Ubi03oOFWXRLPCXdTa5l4POmqywQxrcJfyLL3FcM=
Date:   Mon, 26 Oct 2020 12:09:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 2/2] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl
Message-ID: <20201026190948.GM858@sol.localdomain>
References: <20201026041656.2785980-1-daeho43@gmail.com>
 <20201026041656.2785980-2-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026041656.2785980-2-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 01:16:56PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added a new F2FS_IOC_SET_COMPRESS_OPTION ioctl to change file
> compression option of a file.
> 
> struct f2fs_comp_option {
>     u8 algorithm;         => compression algorithm
>                           => 0:lzo, 1:lz4, 2:zstd, 3:lzorle
>     u8 log_cluster_size;  => log scale cluster size
>                           => 2 ~ 8
> };
> 
> struct f2fs_comp_option option;
> 
> option.algorithm = 1;
> option.log_cluster_size = 7;
> 
> ioctl(fd, F2FS_IOC_SET_COMPRESS_OPTION, &option);
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>

Likewise, please don't add Reviewed-by until it is explicitly given.

The code looks fine now, but this is still missing any explicit mention of
documentation, tests, or use cases.

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

It's best not to use Reported-by for fixes that get folded in to a patch, since
Reported-by makes it seems like the patch itself is a bug fix.  I recommend
mentioning folded-in fixes informally in the commit message instead, e.g.
"Folded in fix for build breakage reported by kernel test robot.".

- Eric
