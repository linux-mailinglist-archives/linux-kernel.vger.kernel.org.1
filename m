Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627AA2A4F7C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgKCS6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:58:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgKCS6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:58:11 -0500
Received: from google.com (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5F720786;
        Tue,  3 Nov 2020 18:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604429890;
        bh=a0Obnq7zFjA7+lJwjIGr/YVojARoM/224HrcQIDvg3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAAhpE2eeEd8Ww6QiU17UcSdXQtMQaV6V3GiM1FJdX9ZIo2YFvu3bY+EqmmkvDHq+
         7ZgUWywksrRGDTqaJWSpAF6JMLHtvlLW42IEgNN4U2eBR511nlCmmlEKbXIkNJA0+b
         7AbNJ104CZham7e7CQnHDsHqORmx7TCudoIn5kBs=
Date:   Tue, 3 Nov 2020 10:58:08 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daejun Park <daejun7.park@samsung.com>
Cc:     "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Chao Yu <yuchao0@huawei.com>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Jieon Seol <jieon.seol@samsung.com>,
        Sang-yoon Oh <sangyoon.oh@samsung.com>,
        Mankyu PARK <manq.park@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>,
        SEUNGUK SHIN <seunguk.shin@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Jaemyung Lee <jaemyung.lee@samsung.com>
Subject: Re: [PATCH v2] f2fs: change write_hint for hot/warm nodes
Message-ID: <20201103185808.GB1273166@google.com>
References: <CGME20201103083832epcms2p6c8b0e4470f1392772317ab2b25256b3d@epcms2p6>
 <20201103083832epcms2p6c8b0e4470f1392772317ab2b25256b3d@epcms2p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103083832epcms2p6c8b0e4470f1392772317ab2b25256b3d@epcms2p6>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03, Daejun Park wrote:
> In the fs-based mode of F2FS, the mapping of hot/warm node to
> WRITE_LIFE_NOT_SET should be changed to WRITE_LIFE_SHORT.
> 
> As a result of analyzing the write pattern of f2fs using real workload,
> hot/warm nodes have high update ratio close to hot data.[*]
> However, F2FS passes write hints for hot/warm nodes as WRITE_LIFE_NOT_SET.

I prefer to keep it as is, since basically node blocks should be separatly
stored from data blocks in different erase blocks in order to match F2FS GC
and FTL GC units. And, we don't do IPU for node blocks which doesn't make sense
to say *update ratio*.

> 
> Furthermore, WRITE_LIFE_NOT_SET is a default value of write hint when it is
> not provided from the file system.
> In storage, write_hint is used to distinguish streams (e.g. NVMe).
> So, the hot/warm node of F2FS is not distinguished from other write_hints,
> which can make the wrong stream seperation.
> 
> * Liang, Yu, et al. "An empirical study of F2FS on mobile devices." 2017
> IEEE 23rd International Conference on Embedded and Real-Time Computing
> Systems and Applications (RTCSA).
> 
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
> v2: update documentation and comments
> ---
>  Documentation/filesystems/f2fs.rst | 4 ++--
>  fs/f2fs/segment.c                  | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index b8ee761c9922..afa3da7cfade 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -717,8 +717,8 @@ WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
>  ===================== ======================== ===================
>  User                  F2FS                     Block
>  ===================== ======================== ===================
> -                      META                     WRITE_LIFE_MEDIUM;
> -                      HOT_NODE                 WRITE_LIFE_NOT_SET
> +                      META                     WRITE_LIFE_MEDIUM
> +                      HOT_NODE                 WRITE_LIFE_SHORT
>                        WARM_NODE                "
>                        COLD_NODE                WRITE_LIFE_NONE
>  ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 1596502f7375..577ab7516c6b 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3160,8 +3160,8 @@ int f2fs_rw_hint_to_seg_type(enum rw_hint hint)
>   *
>   * User                  F2FS                     Block
>   * ----                  ----                     -----
> - *                       META                     WRITE_LIFE_MEDIUM;
> - *                       HOT_NODE                 WRITE_LIFE_NOT_SET
> + *                       META                     WRITE_LIFE_MEDIUM
> + *                       HOT_NODE                 WRITE_LIFE_SHORT
>   *                       WARM_NODE                "
>   *                       COLD_NODE                WRITE_LIFE_NONE
>   * ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
> @@ -3208,7 +3208,7 @@ enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
>  				return WRITE_LIFE_EXTREME;
>  		} else if (type == NODE) {
>  			if (temp == WARM || temp == HOT)
> -				return WRITE_LIFE_NOT_SET;
> +				return WRITE_LIFE_SHORT;
>  			else if (temp == COLD)
>  				return WRITE_LIFE_NONE;
>  		} else if (type == META) {
> -- 
> 2.25.1
