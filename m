Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466C7257282
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 05:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgHaDzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 23:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgHaDzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:55:40 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2935FC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 20:55:40 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id q8so2713841lfb.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 20:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=st+ArUspW4cfoVkyw71QvK5Tr7yiSZTbcPXCqE9k4Fs=;
        b=kLzRPQ096GT9g3Z+Z8cryY7oTlxYxGQ3+9PjvhuhX0gtolEE7ANyqgOLS64/MrdzYL
         qT7C6i97ah1Hpvy5sk7dNDITzb0XdLQGKH5vU+LQJxFTxrEW8IBjy4HcD/xMiX6vP79q
         hz41kqbBJPJ1USTcMqbya11vdMb3gJBpaev2y2MR1KAb8pisKETcRdQY1M7nnD8wvbP5
         cfvTJr2k4Inm45vgiXD3gWku7+JxRJluQOBAAVuC6KpCuAZ8negB623XbcH9IDJhoE33
         CpIZvDOdCTyiAWSWurA2SEdaw+yQU20kaxZg8d0eLe4fwpVlMcwyNtyDEn3+qa2Ale9K
         fxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=st+ArUspW4cfoVkyw71QvK5Tr7yiSZTbcPXCqE9k4Fs=;
        b=oIQOgF1Bv2uXVnOZYOilt7xLAYxbmL0zejfhipe1FZYQQcOUvmycrdoo9oAr1A0tBW
         ug4TiOpI4sQheDOMCso9TS74CCO7xU6GHigINdURwuUpBjfGz2ApXV/QHx+2ueqx4YD8
         76EsXcnIntoB5HSkMK57dW2/LPNpeaoQMTbgxx2JJGud9KifmMpSVxYcD7HaVqPbHPbQ
         reN+tCoaWgKq3cKvHpEMjOtAuqiu/2KszOSKVqRMBM9EzRB0CW/8z+byV5G6L01OvDD5
         cL3PGhQ6WRnC6Tc1AN2LpVfndp3yxucBZNNCdxFwegrS8dVzcjrcTDbYOiPhYwHITb3X
         BXKA==
X-Gm-Message-State: AOAM530tW3lr+bdpqWndTvfHPMXT+ZsFrSads66w95eDTyRlJjNb7N7l
        vYsp1LniAzOLQsUKSRYt+kyfAQM8dfyaKfZbmXI=
X-Google-Smtp-Source: ABdhPJxIsMVgf/aNMl2I8AppTt2CTCql4I2LzVgzXYWCtuowuZpK8it75q1FCxd4Ctm+ZmX1MT4hnRVUq0s+XO4umrU=
X-Received: by 2002:a05:6512:6c1:: with SMTP id u1mr4692195lff.28.1598846138571;
 Sun, 30 Aug 2020 20:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200828054629.583577-1-daeho43@gmail.com> <61996dcd-6db1-13fc-8239-7e684f3ec49e@kernel.org>
 <CACOAw_wc29AROzFhcGyC73i_vYZC1NmHP60uQfP7X-j6y6=kSA@mail.gmail.com>
 <bd1a8ffa-83ff-b774-9bed-ed68025d0c7a@huawei.com> <CACOAw_y=O35_SFxdfsVER4+a+n-eE6f48NXF6CsAnj=Ms-dgkA@mail.gmail.com>
 <c4f58675-9df5-e3af-45fc-6fa924e3ee68@huawei.com>
In-Reply-To: <c4f58675-9df5-e3af-45fc-6fa924e3ee68@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 31 Aug 2020 12:55:27 +0900
Message-ID: <CACOAw_wZFAyyt8qPCFd-LQKpMGa1moyOqSBpUnaeM0z2Y5Z+cA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent compressed file from being
 disabled after releasing cblocks
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, Daeho Jeong <daehojeong@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> - open(O_RDWR)
> - ioctl(FS_IOC_SETFLAGS, F2FS_COMPR_FL)
> - write()
> - ioctl(RELEASE_COMPRESS_BLOCKS) -- inode is immutable now
> - ioctl(FS_IOC_SETFLAGS, ~F2FS_COMPR_FL) -- Should we allow to update immutable inode?
> as we know, normally, immutable inode should deny open(O_WRONLY or O_RDWR) and later update.
>

For this case, with this patch we'll return -EINVAL for
ioctl(FS_IOC_SETFLAGS, ~F2FS_COMPR_FL).
I thought RESERVE_COMPRESS_BLOCKS ioctl is always required to get the
file to normal mode after RELEASE_COMPRESS_BLOCKS is called.
