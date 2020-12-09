Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71AA2D4DB4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 23:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbgLIW3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 17:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388695AbgLIW24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:28:56 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD183C0613D6;
        Wed,  9 Dec 2020 14:28:12 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id qw4so4454988ejb.12;
        Wed, 09 Dec 2020 14:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGUyP4undF662USfUINJVzmZEb/C1zFli+cZwzjv7lk=;
        b=pjpADPoi+ct6oasFLUM/CCiwcgqcZWe20LDJbqso6UvfBLVuWCsZkWbsSimvXwHEi8
         gcw3mwSE6CCjmiypTCsJz1xAPD8h/yL2c7+G3ircJXUOBL6ZYy9ioFmoU5w//noi5kKM
         7wkSLUcVzv3/E1VMSIhCLS3skcl9ecJ0Yt5t69MJiP2yEAoonfXmiblveF3MVPE5OfT4
         11Cb7fUFd17DGRbcCvxcdAHF5KAcdqMFmQSBdvbovuabbEFHkcScASWVMR83P5iGwyUi
         faj/VzaMf0gZ4lhZd8VIFCdPR9Ln9Wvj0Le4RfBSjAxmjjGZR/Mm9kHQggvhJT5kTAbB
         1IMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGUyP4undF662USfUINJVzmZEb/C1zFli+cZwzjv7lk=;
        b=f+Zm+5FjSoajQ6Bq9sq8slMAF5HipmLY0jYGkMIIoRW/Xe2ulYOV8AH1tuQgmywTpt
         HS7pioWX/CE9gOisi961t20DNgVNS1X8MhTa56i690FxmSBoq723G4c0pkZmmolEw+Zj
         D09sj9rvkWNw9GfFQoJyYXDzgUaxomv5uqEFWAipQWeVExnaJD7QQBjaU7WVow+cFpMq
         i+bEo0VlbawpwW97Dp88ie5sYude1JnJWhdasKaXgD2n2TWuEXKzN1ToXZlgjaZTBYvE
         NhAOvGDuK3dEvtLN9SuFixbC3TSoEcUKGvp74pcaoQxvVCHYXmvfYPT9Bx6/Xht5mBNm
         rAow==
X-Gm-Message-State: AOAM532YWjv0jbmjmJDKH1/3bn8FvDtitVwHC7nPB1Ku87unlgQSzR0P
        v/0oFIXafGDwbmRl9LsLsDq64fAz1lx+9ShOdqKHpy6sAzg=
X-Google-Smtp-Source: ABdhPJw9insVW1Z+fh68pbKnIkhH7m+wHqJGFFO+Oj8OgItrbpkgY/vaAXDf5NKv86sEu4OtMuWHdr2RHYuGBZtYG0I=
X-Received: by 2002:a17:906:268c:: with SMTP id t12mr3818836ejc.91.1607552891473;
 Wed, 09 Dec 2020 14:28:11 -0800 (PST)
MIME-Version: 1.0
References: <1607552733-24292-1-git-send-email-konishi.ryusuke@gmail.com>
In-Reply-To: <1607552733-24292-1-git-send-email-konishi.ryusuke@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 10 Dec 2020 07:27:59 +0900
Message-ID: <CAKFNMonJOj07r-0y6xaF0HX6VDSvCrVNfHDek7L3Ptaui0NXFA@mail.gmail.com>
Subject: Re: [PATCH] fs/nilfs2: remove some unused macros to tame gcc
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Please queue this, a gcc warning fix, for the next merge window.

Thanks,
Ryusuke Konishi

On Thu, Dec 10, 2020 at 7:25 AM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> From: Alex Shi <alex.shi@linux.alibaba.com>
>
> There some macros are unused and cause gcc warning. Remove them.
>
> fs/nilfs2/segment.c:137:0: warning: macro "nilfs_cnt32_gt" is not used
> [-Wunused-macros]
> fs/nilfs2/segment.c:144:0: warning: macro "nilfs_cnt32_le" is not used
> [-Wunused-macros]
> fs/nilfs2/segment.c:143:0: warning: macro "nilfs_cnt32_lt" is not used
> [-Wunused-macros]
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> ---
>  fs/nilfs2/segment.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index e3726aca28ed..cd4da9535aed 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -134,14 +134,9 @@ struct nilfs_sc_operations {
>  static void nilfs_segctor_do_immediate_flush(struct nilfs_sc_info *);
>  static void nilfs_dispose_list(struct the_nilfs *, struct list_head *, int);
>
> -#define nilfs_cnt32_gt(a, b)   \
> -       (typecheck(__u32, a) && typecheck(__u32, b) && \
> -        ((__s32)(b) - (__s32)(a) < 0))
>  #define nilfs_cnt32_ge(a, b)   \
>         (typecheck(__u32, a) && typecheck(__u32, b) && \
>          ((__s32)(a) - (__s32)(b) >= 0))
> -#define nilfs_cnt32_lt(a, b)  nilfs_cnt32_gt(b, a)
> -#define nilfs_cnt32_le(a, b)  nilfs_cnt32_ge(b, a)
>
>  static int nilfs_prepare_segment_lock(struct super_block *sb,
>                                       struct nilfs_transaction_info *ti)
> --
> 1.8.3.1
>
