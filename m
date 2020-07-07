Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F01D216B77
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 13:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgGGL1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 07:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGGL1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:27:10 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56753C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:27:10 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o38so31398103qtf.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S/3PCAPfoxjGBDIjaZGp6+CalyT9Vs4Hs7aWN08fHIU=;
        b=NjHjc/P7fmDgZed8pANwRNAML3xmnqNssiiYmOrhnjV/bvIQ22gKhbyes5Vt/TSWmX
         qQLblKrx3BpyKYTO9NgM4eRsbRyTEv5NEWbMS+a08Vn3kxnEKk3+I0oZaaF0L2W422Nd
         gx4dX5ZMrSrbOxHKUbCTJq1x1YyD9N3O3OfWdq/1OvO0II6S5C1pkdyOnjKzH6W5OltO
         /Nfh5kPJn90NcSeCDEyPzBdV5EBoOXWZR6kzVNilIhYQ/B4jQBqnCn1v1XRQbztjT41A
         syamgNh4AEfLBlpDtx1aNud7umPUhdDCPx2r1geuWq0a6qE+UzBxulPRhiYpDgYRhicA
         DJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S/3PCAPfoxjGBDIjaZGp6+CalyT9Vs4Hs7aWN08fHIU=;
        b=dKCb2Xtp58sN+G0LklTcp9/x+m+rRJKbkVOUNQC9wREdpPtuWX/iAHy7+4nII6eL4B
         dIwPSKgZgnHEeUKfVpH/iL0fCxxPS2wQLa6cXwoOrEkT04nHUZfwD9ULVTCrm3yvkDCd
         w6R2dcqOZNZPyennuXnVZHICVYdjThG7r/+/CaA7VzVCWrSFAxew3o1FisqDppbNieCo
         AmAAfxvRN5gmiRq1waVzXLaEqXnAkFL4QCXgkUoRXrnL6YKHkaEVpPrmrEng864Yxpp6
         w/uRcq17//315kNUXFa1fXhZY7hzdlL+CGs0BGFRsQ4QpHy9ovXkTfSb+4Ppb6tVnOb6
         J2Ow==
X-Gm-Message-State: AOAM533qNVWZP2/Z++5eY/PB4brjKzdxHqgn+0unM3XoJnhMkJXpzUJY
        LEy0QmpdR4IxR2VeyqQ15wrZx//umfr3zzqZPEU=
X-Google-Smtp-Source: ABdhPJzISarwTOC7dTcyKLSH3O194wGhx9+uJw36v4j6vyj/0MSpRT+hObOa20ibKb8uAg/xfOihvN2uV8eq+SFdv/Q=
X-Received: by 2002:aed:27c7:: with SMTP id m7mr55886324qtg.13.1594121229629;
 Tue, 07 Jul 2020 04:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200701112643.726986-1-chengzhihao1@huawei.com>
In-Reply-To: <20200701112643.726986-1-chengzhihao1@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 7 Jul 2020 13:26:58 +0200
Message-ID: <CAFLxGvyO_aXGfgoO0mrNsoGP4Bfh3n6CUQxDx=ecH6o2ZDNYDg@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Fix a potential space leak problem while linking tmpfile
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 1:28 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote=
:
>
> There is a potential space leak problem while linking tmpfile, in which
> case, inode node (with nlink=3D0) is valid in tnc (on flash), which leads
> to space leak. Meanwhile, the corresponding data nodes won't be released
> from tnc. For example, (A reproducer can be found in Link):
>
> $ mount UBIFS
>   [process A]            [process B]         [TNC]         [orphan area]
>
>  ubifs_tmpfile                          inode_A (nlink=3D0)     inode_A
>                           do_commit     inode_A (nlink=3D0)     inode_A
>                                =E2=86=91
>       (comment: It makes sure not replay inode_A in next mount)
>  ubifs_link                             inode_A (nlink=3D0)     inode_A
>    ubifs_delete_orphan                  inode_A (nlink=3D0)
>                           do_commit     inode_A (nlink=3D0)
>                            ---> POWERCUT <---
>    (ubifs_jnl_update)
>
> $ mount UBIFS
>   inode_A will neither be replayed in ubifs_replay_journal() nor
>   ubifs_mount_orphans(). inode_A (nlink=3D0) with its data nodes will
>   always on tnc, it occupy space but is non-visable for users.
>
> Commit ee1438ce5dc4d ("ubifs: Check link count of inodes when killing
> orphans.") handles problem in mistakenly deleting relinked tmpfile
> while replaying orphan area. Since that, tmpfile inode should always
> live in orphan area even it is linked. Fix it by reverting commit
> 32fe905c17f001 ("ubifs: Fix O_TMPFILE corner case in ubifs_link()").

Well, by reverting this commit you re-introduce the issue it fixes. ;-\

--=20
Thanks,
//richard
