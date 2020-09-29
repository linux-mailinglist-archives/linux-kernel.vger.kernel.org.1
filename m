Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343F827CF94
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgI2Nlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbgI2Nlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:41:52 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC76DC061755;
        Tue, 29 Sep 2020 06:41:51 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id k14so6409662edo.1;
        Tue, 29 Sep 2020 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+STyH5O53die4jdqqjMtAFsl2MxlZkezojrgZ2z1daA=;
        b=gQR6esvWA5VB8c+pFxu5ZUVTEmuzFU8jTLvmpvuhzYpF+hnUmrX88oRIoj6JPliLKO
         pYM7X8qOYmYiHgVBXppKpLcUDPqcjEG743lkeRX+guaNLrWxYtX0SWFUvGVMaUsLSdgc
         60osieHexS768K34EqAj0SE0Vd6GatjP154kA0Qo5+cBcKJ5q56Lyco6pmu9KwJlx43q
         Zl26FXmOB2xEF86ENkJiPY02QehREDNfcgmGo06uJWVcpYCjSYdvsjcHzTkY/eUd93Bu
         gmarNZGerNQMxtXFUqgYk8Ot1cQcdpNdUWiYDDw0tgPl2kqLY8n9CgAQBmg7/kTE61HB
         AHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+STyH5O53die4jdqqjMtAFsl2MxlZkezojrgZ2z1daA=;
        b=b0Rnc8Ren5Rp//ND4I/TjP+i9zIPI5sc1SnsZlVE6016dsW9e0KIYVWGTZiogMQqCv
         nEW/PmjAqWq4NjKHVmddBnJAW71wCuUtgmwJ/rfCxao/RDLBZDb3hg2sv9nIBSIg95zK
         1/qAtuCaNWS9aORT2mG+NbGZA+EEftL1SafX18QcT0GhZJxITz7PREzo9q8SNqxxMj7d
         f4FPao//YT5tW79+A+rAb/HI96wZTh3X40UeCccCYUOh2qBA2FgGNqt/F/ZzL4XHHlcF
         WkvVTZbvqNTmjJXC2EkrxETUObx712Z/qWRdcJL8cuq9uUk6PzTQP3n4IzT2XHF0xeLT
         m/GQ==
X-Gm-Message-State: AOAM533xRm++Qcla/xto2YpqGs1fTQScSblzzZQHjGnpfLXAnPDdFrW+
        eojbNnppo07HVgsirnELrr/MD7u8RrGT7R6zPEnqsIMM
X-Google-Smtp-Source: ABdhPJzGOnu1aURD9VEJ6jWVEDXeHUiHL5osL5o96MXswuDPvRtEUC84iR9t76/7Ka9vzbPSertkGRlkT+9c571bHjo=
X-Received: by 2002:a50:fe82:: with SMTP id d2mr3239070edt.86.1601386910462;
 Tue, 29 Sep 2020 06:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <1601386269-2423-1-git-send-email-konishi.ryusuke@gmail.com>
In-Reply-To: <1601386269-2423-1-git-send-email-konishi.ryusuke@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 29 Sep 2020 22:41:38 +0900
Message-ID: <CAKFNMonTkN8E4q+ZJdzFauwWo3tx5gB1rDKq=-fGs0XMV5cTbQ@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: Fix some kernel-doc warnings for nilfs2
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Please queue this, kernel-doc warnings fix, for the next merge window.

Thanks,
Ryusuke Konishi

On Tue, Sep 29, 2020 at 10:31 PM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> From: Wang Hai <wanghai38@huawei.com>
>
> Fixes the following W=1 kernel build warning(s):
>
> fs/nilfs2/bmap.c:378: warning: Excess function parameter 'bhp' description in 'nilfs_bmap_assign'
> fs/nilfs2/cpfile.c:907: warning: Excess function parameter 'status' description in 'nilfs_cpfile_change_cpmode'
> fs/nilfs2/cpfile.c:946: warning: Excess function parameter 'stat' description in 'nilfs_cpfile_get_stat'
> fs/nilfs2/page.c:76: warning: Excess function parameter 'inode' description in 'nilfs_forget_buffer'
> fs/nilfs2/sufile.c:563: warning: Excess function parameter 'stat' description in 'nilfs_sufile_get_stat'
>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> ---
>  fs/nilfs2/bmap.c   | 2 +-
>  fs/nilfs2/cpfile.c | 6 +++---
>  fs/nilfs2/page.c   | 1 -
>  fs/nilfs2/sufile.c | 4 ++--
>  4 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> index e516ae389ca5..5900879d5693 100644
> --- a/fs/nilfs2/bmap.c
> +++ b/fs/nilfs2/bmap.c
> @@ -355,7 +355,7 @@ void nilfs_bmap_lookup_dirty_buffers(struct nilfs_bmap *bmap,
>  /**
>   * nilfs_bmap_assign - assign a new block number to a block
>   * @bmap: bmap
> - * @bhp: pointer to buffer head
> + * @bh: pointer to buffer head
>   * @blocknr: block number
>   * @binfo: block information
>   *
> diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
> index 86d4d850d130..025fb082575a 100644
> --- a/fs/nilfs2/cpfile.c
> +++ b/fs/nilfs2/cpfile.c
> @@ -889,7 +889,7 @@ int nilfs_cpfile_is_snapshot(struct inode *cpfile, __u64 cno)
>   * nilfs_cpfile_change_cpmode - change checkpoint mode
>   * @cpfile: inode of checkpoint file
>   * @cno: checkpoint number
> - * @status: mode of checkpoint
> + * @mode: mode of checkpoint
>   *
>   * Description: nilfs_change_cpmode() changes the mode of the checkpoint
>   * specified by @cno. The mode @mode is NILFS_CHECKPOINT or NILFS_SNAPSHOT.
> @@ -930,12 +930,12 @@ int nilfs_cpfile_change_cpmode(struct inode *cpfile, __u64 cno, int mode)
>  /**
>   * nilfs_cpfile_get_stat - get checkpoint statistics
>   * @cpfile: inode of checkpoint file
> - * @stat: pointer to a structure of checkpoint statistics
> + * @cpstat: pointer to a structure of checkpoint statistics
>   *
>   * Description: nilfs_cpfile_get_stat() returns information about checkpoints.
>   *
>   * Return Value: On success, 0 is returned, and checkpoints information is
> - * stored in the place pointed by @stat. On error, one of the following
> + * stored in the place pointed by @cpstat. On error, one of the following
>   * negative error codes is returned.
>   *
>   * %-EIO - I/O error.
> diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
> index b175f1330408..171fb5cd427f 100644
> --- a/fs/nilfs2/page.c
> +++ b/fs/nilfs2/page.c
> @@ -69,7 +69,6 @@ struct buffer_head *nilfs_grab_buffer(struct inode *inode,
>
>  /**
>   * nilfs_forget_buffer - discard dirty state
> - * @inode: owner inode of the buffer
>   * @bh: buffer head of the buffer to be discarded
>   */
>  void nilfs_forget_buffer(struct buffer_head *bh)
> diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
> index 42ff67c0c14f..63722475e17e 100644
> --- a/fs/nilfs2/sufile.c
> +++ b/fs/nilfs2/sufile.c
> @@ -546,13 +546,13 @@ int nilfs_sufile_set_segment_usage(struct inode *sufile, __u64 segnum,
>  /**
>   * nilfs_sufile_get_stat - get segment usage statistics
>   * @sufile: inode of segment usage file
> - * @stat: pointer to a structure of segment usage statistics
> + * @sustat: pointer to a structure of segment usage statistics
>   *
>   * Description: nilfs_sufile_get_stat() returns information about segment
>   * usage.
>   *
>   * Return Value: On success, 0 is returned, and segment usage information is
> - * stored in the place pointed by @stat. On error, one of the following
> + * stored in the place pointed by @sustat. On error, one of the following
>   * negative error codes is returned.
>   *
>   * %-EIO - I/O error.
> --
> 1.8.3.1
>
