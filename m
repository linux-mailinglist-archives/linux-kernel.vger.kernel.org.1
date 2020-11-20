Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D242BA68F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgKTJui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgKTJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:50:37 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1C6C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:50:37 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id 142so9383502ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+lvM0oe2csxAdgkijCshZJQ9aSiN+9+WmHYhC9WJtA=;
        b=qtMggYAdJf1aw4+cMpfp/iom82fLnRQp6EBvBByIIavdGTqYBTerpCmF6Bkn0HlXfy
         9ODbKv0z1uWs0g8Wzcdkeqwe7Jq3wFv132D0+fgkw4T1YT3EC6b2DlsouJ6Fah7uvBoz
         WqYY2Z58ts/+lxxErpcIkuSSVOq6HfrCNYAio+odE6ORDsrSqUgtp8fPuIulyzCzDcXw
         kuHBBeAOw3kKoh7Ui8H25NTALqb+cMWmPHq2+zRLQ21IavnzdLcK3X9ANSq/14ymK30L
         MeycMwP6XNdd1ZJiTEwnuAxdek8Qvdpnjwv3GJvJ4Cc622BUBeh7Srfbrw5KuRZZUupJ
         Lo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+lvM0oe2csxAdgkijCshZJQ9aSiN+9+WmHYhC9WJtA=;
        b=UvR0RiYL4idTITNoRw8oFf6Vi+aEQMEcHjizVDbwVzVfWhPXEXyQdVM/wl3Y0bfMuZ
         CjMKxrqKOg654ziZ2ZPocxKv/UocYl5tYhN9SAAnmbeT/aUbF/4Vpz1vQnNdH9uoh3Cx
         W81vXIod+QdQdpEn5LukoLHdu1tOTK88d5GrSZ/SGxYttwz8oQCd6lYQEa1xulwgJjsx
         c2brzmXuopfQhZbmjHHUwNgkWrSinB+2CvDiTpNN25UPDNmeY4oAuKVCAyeJixUKdqJ9
         JqX2XgOzhMZumyGaNUaf2Q3wnq9RDlSVy+J1JXXzAhXhy7aO7T8g1fWTnkVpGqnhfYXu
         Pgvg==
X-Gm-Message-State: AOAM533zMWc7vC3KHNi6wL0Dqp/n45SG7u4WwIePE0pbzfYXw9hCn8wQ
        LukoY/DDdIHMfGEQ8Hm7R115vXr1BBdOFOboipc=
X-Google-Smtp-Source: ABdhPJyW/LZr4X9CYLjbuFt8en5R66Y7CjYyYmY9uPKecVPFtsgX++l7o3f2yu2M+CANSzxoxSzmK25HTlnKLb9HLvs=
X-Received: by 2002:a2e:54e:: with SMTP id 75mr7390121ljf.381.1605865835824;
 Fri, 20 Nov 2020 01:50:35 -0800 (PST)
MIME-Version: 1.0
References: <CAFcO6XN=cd=_K_2AY9OL7f+HWsazY-nJ81Ufrw4azvkjj-Mpng@mail.gmail.com>
 <e8c8ef27-1f09-40b5-e5e4-facfcc9956dd@oracle.com> <CAFcO6XMhrhJXWjRymKUWgFUov6OV7fTk-Nu9Tq=kOyPTMRnTug@mail.gmail.com>
 <298485e2-01de-048d-5515-44ac254167e4@oracle.com>
In-Reply-To: <298485e2-01de-048d-5515-44ac254167e4@oracle.com>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Fri, 20 Nov 2020 17:50:24 +0800
Message-ID: <CAFcO6XOOOCLwdcK3enSV3Ap-PZmY8RTu2ifgKRJX+pdmhaq5uA@mail.gmail.com>
Subject: Re: UBSAN: array-index-out-of-bounds in dbAdjTree
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You are welcome and have you submitted the patch to linux upstream ?
If you have no time do that and I can do it.

On Sun, Nov 15, 2020 at 12:17 AM Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
>
> Thanks for reporting and testing this!
>
> Shaggy
>
> On 11/14/20 7:55 AM, butt3rflyh4ck wrote:
> > Yes, I have tested the patch, it seem to fix the problem.
> >
> > Regard,
> >  butt3rflyh4ck.
> >
> > On Sat, Nov 14, 2020 at 5:16 AM Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
> >>
> >> On 10/8/20 12:00 PM, butt3rflyh4ck wrote:
> >>> I report a array-index-out-of-bounds bug (in linux-5.9.0-rc6) found by
> >>> kernel fuzz.
> >>>
> >>> kernel config: https://github.com/butterflyhack/syzkaller-fuzz/blob/master/v5.9.0-rc6-config
> >>>
> >>> and can reproduce.
> >>>
> >>> the dmtree_t is that
> >>> typedef union dmtree {
> >>> struct dmaptree t1;
> >>> struct dmapctl t2;
> >>> } dmtree_t;
> >>>
> >>> the dmaptree is that
> >>> struct dmaptree {
> >>> __le32 nleafs; /* 4: number of tree leafs */
> >>> __le32 l2nleafs; /* 4: l2 number of tree leafs */
> >>> __le32 leafidx; /* 4: index of first tree leaf */
> >>> __le32 height; /* 4: height of the tree */
> >>> s8 budmin; /* 1: min l2 tree leaf value to combine */
> >>> s8 stree[TREESIZE]; /* TREESIZE: tree */
> >>> u8 pad[2]; /* 2: pad to word boundary */
> >>> };
> >>> the TREESIZE is totally 341, but the leafidx type is __le32.
> >>
> >> Does this patch fix the problem?
> >>
> >> jfs: Fix array index bounds check in dbAdjTree
> >>
> >> Bounds checking tools can flag a bug in dbAdjTree() for an array index
> >> out of bounds in dmt_stree. Since dmt_stree can refer to the stree in
> >> both structures dmaptree and dmapctl, use the larger array to eliminate
> >> the false positive.
> >>
> >> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> >> ---
> >>  fs/jfs/jfs_dmap.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/jfs/jfs_dmap.h b/fs/jfs/jfs_dmap.h
> >> index 29891fad3f09..aa03a904d5ab 100644
> >> --- a/fs/jfs/jfs_dmap.h
> >> +++ b/fs/jfs/jfs_dmap.h
> >> @@ -183,7 +183,7 @@ typedef union dmtree {
> >>  #define        dmt_leafidx     t1.leafidx
> >>  #define        dmt_height      t1.height
> >>  #define        dmt_budmin      t1.budmin
> >> -#define        dmt_stree       t1.stree
> >> +#define        dmt_stree       t2.stree
> >>
> >>  /*
> >>   *     on-disk aggregate disk allocation map descriptor.
> >> --
> >> 2.29.2
> >>
