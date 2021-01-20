Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2B62FDA62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392768AbhATUHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387823AbhATT6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:58:32 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40A7C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:57:46 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id i141so13133715yba.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ya1LpK8/RXmf6DXoqwnu4lj4b1TvWkLPwrDTMUqdfN4=;
        b=YHVP0fFZTcVomhP8RD9OiXpFhB+5PLESu8BFdFDW0Q7a6onwnLIICmTSzADYmL0cOZ
         xxy+XkQVQMoB3XPv6PYKYsLgbWPjq/w3URgj/RK4sklLbZ44pdmz8WZTxFhE58GVCmH5
         +be9JC1nCx9pc0IyA8pQfCzPPJo+FtFitcd9RaRhO0NztcFpRaihJA3K2I/FCT0fM7yW
         hrZ1vtGyV4+xI/+n2HhjE+Hf/MmYxBuWpi/K0bTnjWyrl4kr30atZLkF05ISiey5hfId
         O0biVxUnq2vzb+9ouatgNK8m9zsZBf9rH+25f469cWinWHEYJiq4v3LoZAP7/ab70Zsr
         Akpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ya1LpK8/RXmf6DXoqwnu4lj4b1TvWkLPwrDTMUqdfN4=;
        b=t+3J+t982fnm8XWa2nuusWrz8GrIvoYLB8sW+3XGizDjUzLsHgO1w0yT06fKZbAfxt
         vGqDN0XtWBd3yyf2Uu0Ti3FNawyvAb02mC4K3sY6dfPukC7l1ySojgT8GEsqC2yWUBSn
         G4oXutkUCcgatzzthx0mDitf16XSfflia6YNq1o2oKQBBR9IAwmC8zxhNGVYUuXddVnW
         f2lXAC1nMjCTnPIbmGoEm5enEuF+0FpTuGmWnZBvwAYHfZnDmtnltAA08Yge9J6tChvV
         mohFB+/qP+6k/goDE3yBGVXG2+sungNUVVekELCqHyHJHApX4K8h8FDrALZlHedcgPVU
         pLYg==
X-Gm-Message-State: AOAM530nOJeBmmoHMhzVDnGWczQdjM0J3h+RcZzMukxpHcdFv6KCJPxT
        9dUjpVbDUOv7RDCA2suAXmBbIgTUKs42q8VUL2M=
X-Google-Smtp-Source: ABdhPJxGQQnZL9zTpV6vNovU0E1SMjAfecQoZtovzYm5OeBSJVHvNlGoGtLCZJZjlL93a0aqpvdjkBnvmSfDpgAywPY=
X-Received: by 2002:a25:3bd2:: with SMTP id i201mr15745831yba.302.1611172666185;
 Wed, 20 Jan 2021 11:57:46 -0800 (PST)
MIME-Version: 1.0
References: <CAFcO6XN=cd=_K_2AY9OL7f+HWsazY-nJ81Ufrw4azvkjj-Mpng@mail.gmail.com>
 <e8c8ef27-1f09-40b5-e5e4-facfcc9956dd@oracle.com> <CAFcO6XMhrhJXWjRymKUWgFUov6OV7fTk-Nu9Tq=kOyPTMRnTug@mail.gmail.com>
 <298485e2-01de-048d-5515-44ac254167e4@oracle.com> <CAFcO6XOvx2W1EvN7PORomgYj4U7kcyzjBC=OiQp9bfRZ33gBMg@mail.gmail.com>
 <225bea89-73ed-5227-3ca1-d74fc86e986f@oracle.com>
In-Reply-To: <225bea89-73ed-5227-3ca1-d74fc86e986f@oracle.com>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Thu, 21 Jan 2021 03:57:35 +0800
Message-ID: <CAFcO6XPunmpMRk03eVzbG3HwPj6oFrRSu1CCW_vMGihU33GKOw@mail.gmail.com>
Subject: Re: UBSAN: array-index-out-of-bounds in dbAdjTree
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was assigned CVE-2020-27815 via redhat.

Regards.
butt3rflyh4ck.


On Fri, Nov 20, 2020 at 11:01 PM Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
>
> On 11/20/20 3:52 AM, butt3rflyh4ck wrote:
> > You are welcome and have you submitted the patch to linux upstream ?
> > If you have no time do that and I can do it.
>
> Yes, it's in linux-next now. I'll push it to upstream in the v5.11 window.
>
> Shaggy
>
> >
> > Regard,
> >  butt3rflyh4ck.
> >
> > On Sun, Nov 15, 2020 at 12:17 AM Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
> >>
> >> Thanks for reporting and testing this!
> >>
> >> Shaggy
> >>
> >> On 11/14/20 7:55 AM, butt3rflyh4ck wrote:
> >>> Yes, I have tested the patch, it seem to fix the problem.
> >>>
> >>> Regard,
> >>>  butt3rflyh4ck.
> >>>
> >>> On Sat, Nov 14, 2020 at 5:16 AM Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
> >>>>
> >>>> On 10/8/20 12:00 PM, butt3rflyh4ck wrote:
> >>>>> I report a array-index-out-of-bounds bug (in linux-5.9.0-rc6) found by
> >>>>> kernel fuzz.
> >>>>>
> >>>>> kernel config: https://github.com/butterflyhack/syzkaller-fuzz/blob/master/v5.9.0-rc6-config
> >>>>>
> >>>>> and can reproduce.
> >>>>>
> >>>>> the dmtree_t is that
> >>>>> typedef union dmtree {
> >>>>> struct dmaptree t1;
> >>>>> struct dmapctl t2;
> >>>>> } dmtree_t;
> >>>>>
> >>>>> the dmaptree is that
> >>>>> struct dmaptree {
> >>>>> __le32 nleafs; /* 4: number of tree leafs */
> >>>>> __le32 l2nleafs; /* 4: l2 number of tree leafs */
> >>>>> __le32 leafidx; /* 4: index of first tree leaf */
> >>>>> __le32 height; /* 4: height of the tree */
> >>>>> s8 budmin; /* 1: min l2 tree leaf value to combine */
> >>>>> s8 stree[TREESIZE]; /* TREESIZE: tree */
> >>>>> u8 pad[2]; /* 2: pad to word boundary */
> >>>>> };
> >>>>> the TREESIZE is totally 341, but the leafidx type is __le32.
> >>>>
> >>>> Does this patch fix the problem?
> >>>>
> >>>> jfs: Fix array index bounds check in dbAdjTree
> >>>>
> >>>> Bounds checking tools can flag a bug in dbAdjTree() for an array index
> >>>> out of bounds in dmt_stree. Since dmt_stree can refer to the stree in
> >>>> both structures dmaptree and dmapctl, use the larger array to eliminate
> >>>> the false positive.
> >>>>
> >>>> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> >>>> ---
> >>>>  fs/jfs/jfs_dmap.h | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/jfs/jfs_dmap.h b/fs/jfs/jfs_dmap.h
> >>>> index 29891fad3f09..aa03a904d5ab 100644
> >>>> --- a/fs/jfs/jfs_dmap.h
> >>>> +++ b/fs/jfs/jfs_dmap.h
> >>>> @@ -183,7 +183,7 @@ typedef union dmtree {
> >>>>  #define        dmt_leafidx     t1.leafidx
> >>>>  #define        dmt_height      t1.height
> >>>>  #define        dmt_budmin      t1.budmin
> >>>> -#define        dmt_stree       t1.stree
> >>>> +#define        dmt_stree       t2.stree
> >>>>
> >>>>  /*
> >>>>   *     on-disk aggregate disk allocation map descriptor.
> >>>> --
> >>>> 2.29.2
> >>>>
