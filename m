Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C82CFEE8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 21:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgLEUn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 15:43:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgLEUn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 15:43:29 -0500
Date:   Sat, 5 Dec 2020 12:42:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607200968;
        bh=x7rofouDQwKdeiKgyOhN+pS04UY3hUFno5zmc3XEp/M=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSwp5oHxvRnU8AvzY71q/6TaPmFzAoz7cc+JBdhBHrVpHwV7K5lpf5geXcVR/3HVZ
         lVy7fctqxxWna3ecKA9hfPF+/xAFXbcj9DQbYnQ/IiHSuZEXZWuEil3xMiIKNaGbls
         pMyGXF5fDyJ3mAXndkox84Iogk8xxxVWjLuAvs1Zgl42IDkgYaXe1oCfuYA82BnUfl
         qlAWKyhOol094Rb9TB8cOLkV0DJBv+EqPRiBxgeVNgJzyHVqtCgCcv0HmUWuCJNYwF
         PAgaKmcD/6Ly61VLNqrCKnWFR6bxg5lplbaRDT1BGD87DAGJ0upT2EFvzD3Voy8aQA
         0iXtpasLtLXEA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: introduce a new per-sb directory in sysfs
Message-ID: <X8vwxtBuFGCD/IS/@google.com>
References: <20201127090118.84235-1-yuchao0@huawei.com>
 <af26ca56-1dbf-e59b-b7b0-63ce817fd94d@huawei.com>
 <X8p+rK6wQsXdcG33@google.com>
 <e35d3dde-db71-27dc-88fd-fd6e2cd2b02f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e35d3dde-db71-27dc-88fd-fd6e2cd2b02f@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05, Chao Yu wrote:
> On 2020/12/5 2:23, Jaegeuk Kim wrote:
> > On 12/03, Chao Yu wrote:
> > > Jaegeuk,
> > > 
> > > Can you comment on this patch?
> > 
> > Waiting for use-case? :)
> 
> How do you think of duplicating below stats into /sys/fs/f2fs/<devname>/stat/

We can't move them to /stat, since it requires lots of mess. Let's think
about new ones only.

> 
> F2FS_GENERAL_RO_ATTR(dirty_segments);
> F2FS_GENERAL_RO_ATTR(free_segments);
> F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
> F2FS_GENERAL_RO_ATTR(features);
> F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
> F2FS_GENERAL_RO_ATTR(unusable);
> F2FS_GENERAL_RO_ATTR(encoding);
> F2FS_GENERAL_RO_ATTR(mounted_time_sec);
> F2FS_GENERAL_RO_ATTR(main_blkaddr);
> #ifdef CONFIG_F2FS_STAT_FS
> F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
> F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
> F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, gc_foreground_calls, call_count);
> F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, gc_background_calls, bg_gc);
> F2FS_GENERAL_RO_ATTR(moved_blocks_background);
> F2FS_GENERAL_RO_ATTR(moved_blocks_foreground);
> F2FS_GENERAL_RO_ATTR(avg_vblocks);
> #endif
> 
> Thanks,
