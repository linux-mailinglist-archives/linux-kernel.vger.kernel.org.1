Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E1327A972
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgI1IXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1IXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:23:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BACDC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:23:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fa1so220221pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVpW8QjWomvLTOG7ypvY0stHPoXAjnZTF6Q+uGjF1Ik=;
        b=DDaaxN7m7wPWCReaeGsKFTKZ/zZX0KBHn9l0g8XF90C1zt+t9uMSChB7mS1FfBrExz
         6oWE+UDz2LkkmGcb1Q71Qr1hLPy/jbixssu3zooSKVzyNtWP+sJyBXhH6mpSYHm7aq4J
         +T55/Yy3g+b5GFNF2STWbFQ4flMR0rC8QZqAtRn6C3WKJinMC/TGwKoTOH3wOqcvq6dZ
         qMPRNqFrxb41lzgqOj6PpU560Cv6DmtpoYZ7w33hBniAzEFDMLxQRkXcD4mKBIj/eFlD
         0X++du9WopF5lGxVLO5s5wTcj4/Wi0Cgleexo3v9APAOtQWE5dTmpRVc+1VbNldhYUVK
         svVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVpW8QjWomvLTOG7ypvY0stHPoXAjnZTF6Q+uGjF1Ik=;
        b=psb/vyIPqII4PdUL5zrnbmI5Wf5nTjHFWgEt4dITZAj7WzLmBFJo6c9wgN6XnGBzoS
         w/nuqQpq7NlhkTlRrYIqpLL30XRHSSUHuoEq/F7RLrDZeuHntGgxnXYeiVcMEAnoviAo
         vE22TBeBRddtA6httbjUgpM20ln6X64b+Z4zGK2FGn+r2qVqwDdsayaBXKL4vjxUK9qy
         0TKh6LbIvjW7oL+7Ty51v8lu+oBcR8O7LPUtYYxN3IMYQEISEeU8bk2xcNwgI3gw/adM
         0BEp6y8ic9RkjLOBeOsLkS3/53ShJzuAKeNF9itgO7GkuPFSRKhTsHYMq7NOlyo2iM6f
         YcZA==
X-Gm-Message-State: AOAM533r3M6jVQA4foVE28X5bhmjiDvWmJiSDlZjUvwp7jXgVDlCLR9P
        oVHavjbi2lKi3JPyxOEmVPh1kwvgW/Ys3p109Uo=
X-Google-Smtp-Source: ABdhPJz/r8tQaKkgwGVkbDmOrTFyfNKYIoAhyqYaD71iD4Z3nAYXqy86umI8KkPzzr23YGjLOjQrJWZ5cnsbNNZp1fw=
X-Received: by 2002:a17:90a:ea08:: with SMTP id w8mr312228pjy.41.1601281430936;
 Mon, 28 Sep 2020 01:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b7551005b05ae3b8@google.com> <CACT4Y+Zc5W9kGUqjVkkuUTBEsLk-1k3eKF5F78-LioWF6XTR0w@mail.gmail.com>
In-Reply-To: <CACT4Y+Zc5W9kGUqjVkkuUTBEsLk-1k3eKF5F78-LioWF6XTR0w@mail.gmail.com>
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Mon, 28 Sep 2020 09:23:40 +0100
Message-ID: <CAK+_RLmGVr=ngG+Tqum==sDLEeEEz11su92EnoQVG6Zgm2gxzg@mail.gmail.com>
Subject: Re: WARNING: filesystem loop0 was created with 512 inodes, the real
 maximum is 511, mounting anyway
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+54b10a5da9e59f1ed979@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

On Mon, 28 Sep 2020 at 08:51, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Sep 28, 2020 at 9:48 AM syzbot
> <syzbot+54b10a5da9e59f1ed979@syzkaller.appspotmail.com> wrote:
> > BFS-fs: bfs_fill_super(): WARNING: filesystem loop0 was created with 512 inodes, the real maximum is 511, mounting anyway
>
> This looks like a BFS issue. +BFS maintainers.

No, this is not an issue. In the latest change to BFS I added the
following comment to the header fs/bfs/bfs.h, which explains it:

/* In theory BFS supports up to 512 inodes, numbered from 2 (for /) up
to 513 inclusive.
   In actual fact, attempting to create the 512th inode (i.e. inode
No. 513 or file No. 511)
   will fail with ENOSPC in bfs_add_entry(): the root directory cannot
contain so many entries, counting '..'.
   So, mkfs.bfs(8) should really limit its -N option to 511 and not
512. For now, we just print a warning
   if a filesystem is mounted with such "impossible to fill up" number
of inodes */

Kind regards,
Tigran
