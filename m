Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9802C2F9AED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387496AbhARICM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733312AbhARIBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:01:06 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D46FC061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:00:26 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id n2so13965389iom.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8OfZKb4cqcXMoBH9fvApxmM17l0hGSZVwx3GOAoWeqU=;
        b=GTI+2rwfbYgzvXpaL2iOMBdCRom0RLZnhBN0yF0GB6DMwUY1qD/yxrZQe4SVb0AYjj
         xdne9urxn6WWzK+kiDNoeJ6WFa/tJ1nDITyWzSc3zNDa7rjTkDv2sJvLdmfbrxFRTUXc
         GIoJFFq7Sdv0H7QNlXL8kgFoJhQJBXyTKCTV6KrXH9/6r5d8uYCfTMe3DSo2zHvYft+l
         kRr8RZ1AlKhmeUn3v3iVQ86Z27rkcDOepViecLl7fBH8hxhAXmvwNI9/r+1LZ9FRNA1t
         BJ4rHC+Jy4JT/S6HcsZYt8ThR01wt877DSTK3KW98zMSqWROydqgTy57OIrFKyJGjtnd
         Cguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OfZKb4cqcXMoBH9fvApxmM17l0hGSZVwx3GOAoWeqU=;
        b=nPHqLnS0vQC+o0uFOYDLVMzXMXRmgwHu9jaX5pYCQWpH5j+0nkiaskpXEzSvrW9wfu
         Up7MLnvuTFgN/E9CwP5h95D0I/orwXfTSocgXFX41cHO8sRdrOfsEC0DlgJ7f6xRXOxb
         +pz6TIq8dLRZ5oQjNrTG42vFspDCgZOQWcMRXQrMgnkdGpsmyePQCwyfIeCH26SjgZXm
         CScoSUTUAZw1oSQUlaANJHFd2hFn1C6Py4jyDQXzJLdztsUpM7r0rApZ7+QvKiRf5Wfc
         3cWg9tYwQAu/lBm1Wxiaf8DR2CLmuF1fHqarBLYRlk8G1kBaypil+er5o/+jdjR8spVK
         FivA==
X-Gm-Message-State: AOAM532/ERm1aH4aGXzsZKBpqf/E2TodmbIM1esraQC31V2C1+rE2PeC
        Ui3BbpNlt2zyd2a8Bi9YbYbaIlujfCwkOc7lt5E=
X-Google-Smtp-Source: ABdhPJxzPecy7qQPpLGcoebsgs9HIYdJPJHkOIppOn5WtuIVKJfLmi4iSgUfcQHPEKX1w++PTlfjKnhuBAgF/Egn7ms=
X-Received: by 2002:a92:c692:: with SMTP id o18mr20192560ilg.215.1610956825641;
 Mon, 18 Jan 2021 00:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20210116090910.5671-1-linmiaohe@huawei.com>
In-Reply-To: <20210116090910.5671-1-linmiaohe@huawei.com>
From:   Muchun Song <smuchun@gmail.com>
Date:   Mon, 18 Jan 2021 15:59:48 +0800
Message-ID: <CAPSr9jFQRujOEa_HcqQ6=+hf-jWiGA=+CeWjgwQK+-993gd4Ow@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: make BUG_ON(!inode) takes effect in hugetlbfs_setattr
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 5:11 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> When we reach here with inode = NULL, we should have crashed as inode has
> already been dereferenced via hstate_inode. In order to make BUG_ON(!inode)
> takes effect, we should defer initializing hstate until we really need it.
> Also do this for hugetlbfs_inode_info as it's only used when ia_valid is
> verified with ATTR_SIZE.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 740693d7f255..9b221b87fbea 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -755,10 +755,8 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  static int hugetlbfs_setattr(struct dentry *dentry, struct iattr *attr)
>  {
>         struct inode *inode = d_inode(dentry);
> -       struct hstate *h = hstate_inode(inode);

If inode == NULL, it will panic here when we access inode->i_sb.
I have seen many other file system implementations about setattr,
they all think that d_inode() will return a non-NULL pointer. So
I prefer to just remove the BUG_ON().

Thanks.


>         int error;
>         unsigned int ia_valid = attr->ia_valid;
> -       struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
>
>         BUG_ON(!inode);
>
> @@ -767,6 +765,8 @@ static int hugetlbfs_setattr(struct dentry *dentry, struct iattr *attr)
>                 return error;
>
>         if (ia_valid & ATTR_SIZE) {
> +               struct hstate *h = hstate_inode(inode);
> +               struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
>                 loff_t oldsize = inode->i_size;
>                 loff_t newsize = attr->ia_size;
>
> --
> 2.19.1
>
