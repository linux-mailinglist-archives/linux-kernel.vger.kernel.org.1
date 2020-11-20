Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89152BA69B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgKTJww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgKTJwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:52:49 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098F3C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:52:49 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id z21so12542564lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PBTsmNKv8vadYJg1/1024EHHBUem4NxR3vymSZL1jbg=;
        b=fisWQZXUBIbv24FaTk612Nxy3lgfUzxISMMVSOnsg25d+wmMusuLXY/3ULelqap4nK
         MEhR3Z7RnJFBv2j/bEMM3jnT8HBZZA4uIH0Mpu6TyHuB+xLBbcubXs8zc/dzq7L31p4P
         UuWZEe4GlOdeSdWbVN0CGE/VvSjXdpMcfMG4cmYwwb/XCj8q7ae9F/IQBk/GTujSrHqt
         xC6K0mTcaO3wNH2fAKRseLo2MPLJYWATL16BtbKB6d5Ikrc5JtbVz94CKNoaBkbhVQae
         +tLzSA72EC5LUegS+sno/1Bi7lm4ql72ydNSZXgjmRpbaWns9gxxjvtU3aWyBRJX50jy
         LLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBTsmNKv8vadYJg1/1024EHHBUem4NxR3vymSZL1jbg=;
        b=s1qyEAyLtsQwMlPyIvG3JXf7A2UZsJITdFaWvWlYZJ4ecUSbcDZHsxjyakO+9LfnLs
         bQIKLBNCzoB2QZYmMOdPdTCnsUpzZZNynmSoH0ITc4Z4nEKycr6ypHceMw7p6dBNIE/n
         +1iT8xHd+Gn3o4xNKZwmVbXDNj1gSdH2sr3Nz9++Pqk1FdUxgNrNzcO0cqNsdRI+nU7F
         QeddigD6+7xPVbWyAbZ3Wvsd2xSUUA7WJvEaLqAszGLwtAeFJMDrpNUfXtPgmhqCkI47
         5ztv09bU7vcL7l2JETMoKrRnboqORiRUxrV8mI20rROdTh/9AfF8c6orcm5vza4SMBSz
         i78g==
X-Gm-Message-State: AOAM532o6L/rmpZE+a5+e1i6V/37ooqew4bFB7zczfI1c7jzV4cdDjp0
        XhQ7jgOhR96YN0fhmgkkZVxW1pHNWLK5AHX/SLE=
X-Google-Smtp-Source: ABdhPJx7IrNUc4/8BSBYVjO06wUwht/PU30NkY5hhoJJbLJ/3l7pec9BERrOd2eA/gC17gHvg8MGafFJO4cnYsgJpRU=
X-Received: by 2002:a19:6e4c:: with SMTP id q12mr7149047lfk.162.1605865967567;
 Fri, 20 Nov 2020 01:52:47 -0800 (PST)
MIME-Version: 1.0
References: <CAFcO6XN=cd=_K_2AY9OL7f+HWsazY-nJ81Ufrw4azvkjj-Mpng@mail.gmail.com>
 <e8c8ef27-1f09-40b5-e5e4-facfcc9956dd@oracle.com> <CAFcO6XMhrhJXWjRymKUWgFUov6OV7fTk-Nu9Tq=kOyPTMRnTug@mail.gmail.com>
 <298485e2-01de-048d-5515-44ac254167e4@oracle.com>
In-Reply-To: <298485e2-01de-048d-5515-44ac254167e4@oracle.com>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Fri, 20 Nov 2020 17:52:36 +0800
Message-ID: <CAFcO6XOvx2W1EvN7PORomgYj4U7kcyzjBC=OiQp9bfRZ33gBMg@mail.gmail.com>
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

Regard,
 butt3rflyh4ck.

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
