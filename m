Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B80A2A1AA9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 22:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgJaVN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 17:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgJaVN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 17:13:28 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1C1C0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 14:13:28 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z6so8297448qkz.4
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 14:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KZODEmvXyflv6SQKdmBGuZIGTDEH0YI52o0/uFD+i6M=;
        b=bFztuJ6y/haedJQw5hF/nF6VbGHZV7ZTnjVcNG7oCf7oFghBazkx6bAKOmRQr2nZ0k
         pxyCTssBMyZtOqJqIW4pQdEEEPS03fcbGqn8u3UezI7qTB7N/KRcy9VE7O+FXZLh9DDF
         /lMpUVi/7GYzAL+ap/+rMoI8+gOEP+TXYXojZHa1qJKDmHrjXBOWlzqtaVi3g03cpu3B
         WvtkeKgykpf86L9dLtTHygEHclwQK3/N5/r2fvjEfHGEVE+IcgIfPlyKYbDzRhIPv7af
         refKZp1p3v/VWKHF4YpTK25NmSNfs4Bic6fkFilMQFfBE/KyFTAi29kF6zhIL1QOqND9
         eJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KZODEmvXyflv6SQKdmBGuZIGTDEH0YI52o0/uFD+i6M=;
        b=D2oNHYCiDb1S/F1I+MbYh4Lep9/2ffQD2vTm9Ea1HcoqvmF12sTL8bfytCiX0DO1PY
         lc5dDbYwkp8N5hL1UYeX/+bYQGZsITjHGCvddIFXEQHnEqd0pfSVDNh8/CiC8W6+M4iZ
         246aNrzl9MnmkHvjeZP65yC19lE+CsSBRnmzdNeJmnn2AStcpVi3r1yBBlRsVYUXmQh1
         fiUJhWQR0ExzaKQ+ZUXO/KS8lFtMsSSgYm/7WaxM56Pms1ksK4rs0zAo12+G+xrhNiLX
         FcUpYPl4F8/KPpkuBycUKdUOPj7aFo/q5V5h5yXXMeo/xOtuYGBQ4gyLYKiJnjpN0pE1
         L+Hg==
X-Gm-Message-State: AOAM530pc/huBqKzdDXzufXMRCZIGWwyV1g1pqE71nofxAyJRTzJMFoU
        FRJ6oE/gsWq3oWA1lam7zrVQYoWP9WJBZyV91tdVjgfT+qI=
X-Google-Smtp-Source: ABdhPJyUC9i+NKGsq7Bn8TpUuFeIFGl325Ap8ciy9Tuc2ocVvLGPm0dOau+UrW0L3GepkgvlUq4gBBHL0skxpWbPDb4=
X-Received: by 2002:a37:4b4f:: with SMTP id y76mr8735825qka.108.1604178807385;
 Sat, 31 Oct 2020 14:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200616071146.2607061-1-chengzhihao1@huawei.com> <f22055d4-47c8-d83d-f650-6fd82ce54a29@huawei.com>
In-Reply-To: <f22055d4-47c8-d83d-f650-6fd82ce54a29@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sat, 31 Oct 2020 22:13:16 +0100
Message-ID: <CAFLxGvyi1hVLmQ3Q8+nGZT-wgHVjwBewmg4NdEQ=iX5svJsY2Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] ubifs: Prevent memory oob accessing while dumping node
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>, liu.song11@zte.com.cn,
        "zhangyi (F)" <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 5:13 AM Zhihao Cheng <chengzhihao1@huawei.com> wrot=
e:
>
> =E5=9C=A8 2020/6/16 15:11, Zhihao Cheng =E5=86=99=E9=81=93:
> > We use function ubifs_dump_node() to dump bad node caused by some
> > reasons (Such as bit flipping caused by hardware error, writing bypass
> > ubifs or unknown bugs in ubifs). The node content can not be trusted
> > anymore, so we should prevent memory out-of-bounds accessing while
> > dumping node in following situations:
> >
> > 1. bad node_len: Dumping data according to 'ch->len' which may exceed
> >     the size of memory allocated for node.
> > 2. bad node content: Some kinds of node can record additional data, eg.
> >     index node and orphan node, make sure the size of additional data
> >     not beyond the node length.
> > 3. node_type changes: Read data according to type A, but expected type
> >     B, before that, node is allocated according to type B's size. Lengt=
h
> >     of type A node is greater than type B node.
> >
> > Commit acc5af3efa303d5f3 ("ubifs: Fix out-of-bounds memory access cause=
d
> > by abnormal value of node_len") handles situation 1 for data node only,
> > it would be better if we can solve problems in above situations for all
> > kinds of nodes.
> >
> > Patch 1 adds a new parameter 'node_len'(size of memory which is allocat=
ed
> > for the node) in function ubifs_dump_node(), safe dumping length of the
> > node should be: minimum(ch->len, c->ranges[node_type].max_len, node_len=
).
> > Besides, c->ranges[node_type].min_len can not greater than safe dumping
> > length, which may caused by node_type changes(situation 3).
> >
> > Patch 2 reverts commit acc5af3efa303d5f ("ubifs: Fix out-of-bounds memo=
ry
> > access caused by abnormal value of node_len") to prepare for patch 3.
> >
> > Patch 3 replaces modified function ubifs_dump_node() in all node dumpin=
g
> > places except for ubifs_dump_sleb().
> >
> > Patch 4 removes unused function ubifs_dump_sleb(),
> >
> > Patch 5 allows ubifs_dump_node() to dump all branches of the index node=
.
> >
> > Some tests after patchset applied:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D208203
> >
> > Zhihao Cheng (5):
> >    ubifs: Limit dumping length by size of memory which is allocated for
> >      the node
> >    Revert "ubifs: Fix out-of-bounds memory access caused by abnormal
> >      value of node_len"
> >    ubifs: Pass node length in all node dumping callers
> >    ubifs: ubifs_dump_sleb: Remove unused function
> >    ubifs: ubifs_dump_node: Dump all branches of the index node
> >
> >   fs/ubifs/commit.c   |   4 +-
> >   fs/ubifs/debug.c    | 111 ++++++++++++++++++++++++++-----------------=
-
> >   fs/ubifs/debug.h    |   5 +-
> >   fs/ubifs/file.c     |   2 +-
> >   fs/ubifs/io.c       |  37 +++++----------
> >   fs/ubifs/journal.c  |   3 +-
> >   fs/ubifs/master.c   |   4 +-
> >   fs/ubifs/orphan.c   |   6 ++-
> >   fs/ubifs/recovery.c |   6 +--
> >   fs/ubifs/replay.c   |   4 +-
> >   fs/ubifs/sb.c       |   2 +-
> >   fs/ubifs/scan.c     |   4 +-
> >   fs/ubifs/super.c    |   2 +-
> >   fs/ubifs/tnc.c      |   8 ++--
> >   fs/ubifs/tnc_misc.c |   4 +-
> >   fs/ubifs/ubifs.h    |   4 +-
> >   16 files changed, 108 insertions(+), 98 deletions(-)
> >
> ping, although it is not a serious problem for ubifs, but dumping extra
> memory by formating specified ubifs img may cause security problem.

Thanks for reminding me, yes this needs fixing.
I'll give it a try and then apply it for next.

--=20
Thanks,
//richard
