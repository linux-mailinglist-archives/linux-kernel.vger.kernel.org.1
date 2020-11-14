Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528322B2D80
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 14:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgKNNzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 08:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgKNNzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 08:55:52 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951AAC0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 05:55:50 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l11so6240394lfg.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 05:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SK840U8/7axwAqhuwZnwdljtfw13UYNDip/jhTdp73Q=;
        b=QHmF2viG+Y4d2jk2HOORYZ6CTFij1RQL0l/mF05H1Di+7y3DN+W8QcX5RS40laOXaR
         s60ze7q1SBblKD1nrP8JY88f8gvYRIWsOArxM6tOU9MjgXKgUsu0HMOqp2Fawt2qa5wY
         d7lzSIlr7ELnCwPV+8s7gL512Ed1F7IxRvwKrHvGMg4W5uUzwXJeNOaNSA9T6OK+VNdd
         SeU0nlDaaiAUDr3W9m8VwCYreUyYbcjUv9zS5AQ5+8DE2X+rS2dhKan4rfC0xOGo9H7p
         NqEShjchYPqXMJr4mFqex0Rzkay7VDGgLikZyKqd5c7+QXv1jM+RI3Mc2urxFSfTQI42
         /ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SK840U8/7axwAqhuwZnwdljtfw13UYNDip/jhTdp73Q=;
        b=G2E9NWIKp9Bb/haKi69SgypIYH/wmIQjqedlo7ynQZiDm6VZ0zS93ee6U9k9ViFnaU
         X9RTU7udZPTKcxlSS0bs6mQLMxVNT+EghpYIops0UEqp6NW99kP43uFgfDswQJnFt9oB
         oAYRJ6uiDfcEbbNSfBMuAMiNJwW746wIxUMOipd1hcQ0UsfoL3Elt2D4+7/LKAMBqxFt
         h/ls64blnL1RG2PyfH2eRVX0f4fmRHxuXK0viIwLxBrFYnWtwr1Gk0qdnEs989ClSRGn
         SaLtKSraTHY6L+5mJnkgAthji1fNfG3igrA/4e89S+xaWliZsLAwqtyr46p4ThOf6XaN
         hpeQ==
X-Gm-Message-State: AOAM533GefQoPqN51Vlj0kYA5Ybfd47n3jPB7VYS/2iHqkl6HExPlZQV
        SxnYxLLRjg5PHuGIBlP9Vz+ZA6uZLgq0BI7l0kA=
X-Google-Smtp-Source: ABdhPJz2k9AQDEvR32M6/p/JJwuWL834gVamLMoXDA4so/uCOxhVKemscRu8l1ercTVEmD0cgpWm4VbdBqgLd9OpiEQ=
X-Received: by 2002:ac2:5301:: with SMTP id c1mr2391288lfh.72.1605362149030;
 Sat, 14 Nov 2020 05:55:49 -0800 (PST)
MIME-Version: 1.0
References: <CAFcO6XN=cd=_K_2AY9OL7f+HWsazY-nJ81Ufrw4azvkjj-Mpng@mail.gmail.com>
 <e8c8ef27-1f09-40b5-e5e4-facfcc9956dd@oracle.com>
In-Reply-To: <e8c8ef27-1f09-40b5-e5e4-facfcc9956dd@oracle.com>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Sat, 14 Nov 2020 21:55:37 +0800
Message-ID: <CAFcO6XMhrhJXWjRymKUWgFUov6OV7fTk-Nu9Tq=kOyPTMRnTug@mail.gmail.com>
Subject: Re: UBSAN: array-index-out-of-bounds in dbAdjTree
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I have tested the patch, it seem to fix the problem.

Regard,
 butt3rflyh4ck.

On Sat, Nov 14, 2020 at 5:16 AM Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
>
> On 10/8/20 12:00 PM, butt3rflyh4ck wrote:
> > I report a array-index-out-of-bounds bug (in linux-5.9.0-rc6) found by
> > kernel fuzz.
> >
> > kernel config: https://github.com/butterflyhack/syzkaller-fuzz/blob/master/v5.9.0-rc6-config
> >
> > and can reproduce.
> >
> > the dmtree_t is that
> > typedef union dmtree {
> > struct dmaptree t1;
> > struct dmapctl t2;
> > } dmtree_t;
> >
> > the dmaptree is that
> > struct dmaptree {
> > __le32 nleafs; /* 4: number of tree leafs */
> > __le32 l2nleafs; /* 4: l2 number of tree leafs */
> > __le32 leafidx; /* 4: index of first tree leaf */
> > __le32 height; /* 4: height of the tree */
> > s8 budmin; /* 1: min l2 tree leaf value to combine */
> > s8 stree[TREESIZE]; /* TREESIZE: tree */
> > u8 pad[2]; /* 2: pad to word boundary */
> > };
> > the TREESIZE is totally 341, but the leafidx type is __le32.
>
> Does this patch fix the problem?
>
> jfs: Fix array index bounds check in dbAdjTree
>
> Bounds checking tools can flag a bug in dbAdjTree() for an array index
> out of bounds in dmt_stree. Since dmt_stree can refer to the stree in
> both structures dmaptree and dmapctl, use the larger array to eliminate
> the false positive.
>
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>  fs/jfs/jfs_dmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/jfs/jfs_dmap.h b/fs/jfs/jfs_dmap.h
> index 29891fad3f09..aa03a904d5ab 100644
> --- a/fs/jfs/jfs_dmap.h
> +++ b/fs/jfs/jfs_dmap.h
> @@ -183,7 +183,7 @@ typedef union dmtree {
>  #define        dmt_leafidx     t1.leafidx
>  #define        dmt_height      t1.height
>  #define        dmt_budmin      t1.budmin
> -#define        dmt_stree       t1.stree
> +#define        dmt_stree       t2.stree
>
>  /*
>   *     on-disk aggregate disk allocation map descriptor.
> --
> 2.29.2
>
