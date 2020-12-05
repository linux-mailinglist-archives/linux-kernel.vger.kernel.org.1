Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135902CF89F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 02:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgLEB3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 20:29:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgLEB3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 20:29:49 -0500
Subject: Re: [PATCH] f2fs: introduce a new per-sb directory in sysfs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607131748;
        bh=JV56CdjyUv1Rv5BMk7QaP3IuCqfsvKze12smgZ438Ts=;
        h=To:Cc:References:From:Date:In-Reply-To:From;
        b=RdgFsX88favfTDnLR2lWWvSDPoZsx9GiPHI9L6IrnBb/hzecsHGF45dgbAhkpFn9X
         n3BlXB1hr5kB/nt+p9U6pknhjPZCGbZ7c48AtfToUyX95NnA5HjL7AtRcouvZ7lYXH
         8jbtP83aZlexQV+i5KUDbnydSWe4y+vkrKfx2QuQs+skPfoIWGtWKvXUfkZTkeSJrs
         N8l2N0UXrVJneK9yatR4cm+YP59epbcNGGbp0nw54GSEXMc1jDOS1GhgtWc8FQB6SI
         /SFRRJmtbco5qObChvuhq1pxdKvZZGkjNRT21vxy9dwUGlvdMtEdHuXhPvm/YCp9OZ
         9viTYkTYv3jvg==
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20201127090118.84235-1-yuchao0@huawei.com>
 <af26ca56-1dbf-e59b-b7b0-63ce817fd94d@huawei.com>
 <X8p+rK6wQsXdcG33@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <e35d3dde-db71-27dc-88fd-fd6e2cd2b02f@kernel.org>
Date:   Sat, 5 Dec 2020 09:29:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <X8p+rK6wQsXdcG33@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/5 2:23, Jaegeuk Kim wrote:
> On 12/03, Chao Yu wrote:
>> Jaegeuk,
>>
>> Can you comment on this patch?
> 
> Waiting for use-case? :)

How do you think of duplicating below stats into /sys/fs/f2fs/<devname>/stat/

F2FS_GENERAL_RO_ATTR(dirty_segments);
F2FS_GENERAL_RO_ATTR(free_segments);
F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
F2FS_GENERAL_RO_ATTR(features);
F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
F2FS_GENERAL_RO_ATTR(unusable);
F2FS_GENERAL_RO_ATTR(encoding);
F2FS_GENERAL_RO_ATTR(mounted_time_sec);
F2FS_GENERAL_RO_ATTR(main_blkaddr);
#ifdef CONFIG_F2FS_STAT_FS
F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, gc_foreground_calls, call_count);
F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, gc_background_calls, bg_gc);
F2FS_GENERAL_RO_ATTR(moved_blocks_background);
F2FS_GENERAL_RO_ATTR(moved_blocks_foreground);
F2FS_GENERAL_RO_ATTR(avg_vblocks);
#endif

Thanks,
