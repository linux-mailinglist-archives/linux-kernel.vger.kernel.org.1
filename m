Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265C127A985
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgI1I3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1I3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:29:22 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1C0C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:29:22 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o21so136612qtp.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 01:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4/SD7sDkhkzjSmNCqnhnzxoSGKZx4XDrWdqdQe3XZ4=;
        b=FuiT47fmOQx6DCBlqkiTikuEAjM+gEeegjVBcLz9fChgT+Vqev1yjRHhl+fxLrs8Y1
         DQ+9/cWC/kMR5b3Vo6+g+5TY/tOwJLb/2yiQxHLzw94JxofxKRwoeYRTFBrphQKF+ZE4
         oBto8rP0m3U92NUQBarcpKHRJCUztbR/Nx0ngvkPUewmdNbEFb27FJl5wiBwdhZVPH4A
         egvrMy8phOfMO9JUPEqwb2MaiB0jSCgoXkK+pJSbzX1QSmPKdoV/6c/kkOFPE4SuS7fv
         TFGTrMWYHUPcW5z81C9wIYBILvrpU0oayb8sTfpJg5Vtrq592+1+e0iu3QYJQfoNnNlI
         /fJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4/SD7sDkhkzjSmNCqnhnzxoSGKZx4XDrWdqdQe3XZ4=;
        b=MdwU1SifGx/yISI9S8Dt2nwf3Ypd12ayI8fsX6dS1Pj815b4gU0dFlUonWqTgN7hJO
         ZRTIp+OYSmOrK9FmdfkReHKfE1zaYGZ752Juyq18IomNkbn5VG/+w9VYbs3ec+kOAjYH
         0tJkVWn+Phtp90LLlXKY52kO6UvkxyfDTsT0mqBW8/2Mswoa686dkuzYiifz19O6q/UI
         9SO8AqGsv6oqyEXB2+rGgeke8kslyKDr15QR3TXr1inBjiQlfGBs5wn65DjOtd+f/GSi
         YjSiUwr28hjjsDHYyayZAJZRzNSEWHXLbE1KPUEWbW0DUU6+nY0SdUrEKEExD3dAAsOU
         zL2g==
X-Gm-Message-State: AOAM530/UlDjmbg1mZNOhvsJD3WO8UzeB32C9OzNX8s3AqIcbfLlM+GS
        fw0U3Py167aCmo5RoNC4TBh2QYKeEOvXGQrZcuGZIQ==
X-Google-Smtp-Source: ABdhPJzaa/1aeT7Sp8XzYrn+XtACxFlI58A4KZZtsp4tdU4fhXceB8gr1c4Jy/+RD5bcyV2Lk+xfWT4wo6lww4Xo2Lk=
X-Received: by 2002:ac8:4658:: with SMTP id f24mr444266qto.158.1601281761299;
 Mon, 28 Sep 2020 01:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b7551005b05ae3b8@google.com> <CACT4Y+Zc5W9kGUqjVkkuUTBEsLk-1k3eKF5F78-LioWF6XTR0w@mail.gmail.com>
 <CAK+_RLmGVr=ngG+Tqum==sDLEeEEz11su92EnoQVG6Zgm2gxzg@mail.gmail.com>
In-Reply-To: <CAK+_RLmGVr=ngG+Tqum==sDLEeEEz11su92EnoQVG6Zgm2gxzg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 28 Sep 2020 10:29:10 +0200
Message-ID: <CACT4Y+Yb9UcpO6g+FMZ+4R1PiadcDqKXj7Em4h8+VMrzCdS=9g@mail.gmail.com>
Subject: Re: WARNING: filesystem loop0 was created with 512 inodes, the real
 maximum is 511, mounting anyway
To:     Tigran Aivazian <aivazian.tigran@gmail.com>
Cc:     syzbot <syzbot+54b10a5da9e59f1ed979@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:23 AM Tigran Aivazian
<aivazian.tigran@gmail.com> wrote:
>
> Hello Dmitry,
>
> On Mon, 28 Sep 2020 at 08:51, Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Mon, Sep 28, 2020 at 9:48 AM syzbot
> > <syzbot+54b10a5da9e59f1ed979@syzkaller.appspotmail.com> wrote:
> > > BFS-fs: bfs_fill_super(): WARNING: filesystem loop0 was created with 512 inodes, the real maximum is 511, mounting anyway
> >
> > This looks like a BFS issue. +BFS maintainers.
>
> No, this is not an issue. In the latest change to BFS I added the
> following comment to the header fs/bfs/bfs.h, which explains it:
>
> /* In theory BFS supports up to 512 inodes, numbered from 2 (for /) up
> to 513 inclusive.
>    In actual fact, attempting to create the 512th inode (i.e. inode
> No. 513 or file No. 511)
>    will fail with ENOSPC in bfs_add_entry(): the root directory cannot
> contain so many entries, counting '..'.
>    So, mkfs.bfs(8) should really limit its -N option to 511 and not
> 512. For now, we just print a warning
>    if a filesystem is mounted with such "impossible to fill up" number
> of inodes */

Hi Tigran,

There are rules for use of "WARNING" in output required to support
kernel testing:
https://github.com/torvalds/linux/blob/master/include/asm-generic/bug.h#L67-L80
This seems to be triggerable by exteranal inputs and breaks these rules.
