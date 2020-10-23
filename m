Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EA52976F1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754822AbgJWSeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754796AbgJWSeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:34:03 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312D2C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:34:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e15so2018462pfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AFHSnr81d30uG8cNRj2D7oeDMiGGuZln0Lff7BivqQ=;
        b=Dd5DYENnhniJLgupPpI6Gzem9UlGx0VEHiRaGn0Y2+Rvi7IQByanT8wkZr5+HCNE1S
         3mcf6zrpiof4ivETIys3TClHldEZOHhE8a51eJQMMsaOlzjID8LU2o0GlmUtAdKX6+Oh
         aDSGArkV6hzL+diQqO4YbSp+sIzqXhTqBEBurOPaeBHR5WccwRVUCRw1zWkD0S91MaMy
         xZJX+PEPAV0y+UaFwnBrjVn3EiH4YFXD1gcaGI42u34yevAL/EH9FLdjgfaSQjxUIxYJ
         ig7NeY3HpvrByr2kQ8spmx4I+1uD8NNOld+NiPUL9sTPkRY4BnWzBY6Csx6wWcXnhMuG
         mmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AFHSnr81d30uG8cNRj2D7oeDMiGGuZln0Lff7BivqQ=;
        b=T1fJaozmcr8h6NF4UkYQ0gI91gLR/EBnhYjIdJhipVnBXqJ/BEdvJ0tANTxQWeoc4i
         h69m2BpeZavHzBbgR91zsXDGRTh15U6NQqaCoiw5yFSpYRrtM5svMa8O0gwPfNfZvGaX
         fDNQiZ147qn+XoZzCv5pg9g57apbv+Vs4nPVmOQD+jyRgelKiO89i8kW13BMt5yncdWL
         lhK5Z1FlT9RuiLKgRWEjghJ4dUWjRaHNBMOic6kwbt4whaoCEXq0t1k4HCuKcl7FPTrL
         BAuRRPKSmQm57zkIRr5wjFyQFJTu0Z6wAixO7vdP58UWr0aNdbIk46gRqazaDATDI5zQ
         MRqA==
X-Gm-Message-State: AOAM532msRr5avP01j6cix6RjXz1miZ8LtgPhj1sRUN5Z7UrZKWBEc8P
        zC/DfkZFDK3XptCKosbc3Q5EFF6pKpt0BDwcNopSdA==
X-Google-Smtp-Source: ABdhPJyW1YEhrETa0y27vXzDzgsVBjmSEcczJRJR0zG8MwxJrXXxnHyg+H6AhTHxiKYllKgESce7BAl6qCPgsexgY80=
X-Received: by 2002:a63:70d:: with SMTP id 13mr3280013pgh.263.1603478042165;
 Fri, 23 Oct 2020 11:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <202010240159.IPld6mlB-lkp@intel.com>
In-Reply-To: <202010240159.IPld6mlB-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 23 Oct 2020 11:33:50 -0700
Message-ID: <CAKwvOdkhcrifOeHY9VjpHbmHjRazxajoj7nV1QrRKx6kQdF15w@mail.gmail.com>
Subject: Re: ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_8)
 is being placed in '.data..L__unnamed_8'
To:     Kees Cook <keescook@chromium.org>
Cc:     David Howells <dhowells@redhat.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://github.com/ClangBuiltLinux/linux/issues/1185

On Fri, Oct 23, 2020 at 10:24 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f9893351acaecf0a414baf9942b48d5bb5c688c6
> commit: 88c853c3f5c0a07c5db61b494ee25152535cfeee afs: Fix cell refcounting by splitting the usage counter
> date:   7 days ago
> config: powerpc64-randconfig-r004-20201022 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project ee6abef5323d59b983129bf3514ef6775d1d6cd5)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc64 cross compiling tool for clang build
>         # apt-get install binutils-powerpc64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=88c853c3f5c0a07c5db61b494ee25152535cfeee
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 88c853c3f5c0a07c5db61b494ee25152535cfeee
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_20) is being placed in '.data..L__unnamed_20'
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_21) is being placed in '.data..L__unnamed_21'
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_23) is being placed in '.data..L__unnamed_23'
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_22) is being placed in '.data..L__unnamed_22'
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_26) is being placed in '.data..L__unnamed_26'
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_25) is being placed in '.data..L__unnamed_25'
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_24) is being placed in '.data..L__unnamed_24'
>    ld.lld: warning: fs/built-in.a(ubifs/journal.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/dir.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/dir.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/super.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(ubifs/super.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/super.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/super.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(ubifs/sb.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/sb.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/sb.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_8) is being placed in '.data..L__unnamed_8'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_9) is being placed in '.data..L__unnamed_9'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_10) is being placed in '.data..L__unnamed_10'
>    ld.lld: warning: fs/built-in.a(ubifs/master.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/master.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/scan.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/scan.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/replay.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/budget.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(ubifs/budget.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/budget.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/budget.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(ubifs/tnc_commit.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/tnc_commit.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/tnc_commit.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_13) is being placed in '.data..L__unnamed_13'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_14) is being placed in '.data..L__unnamed_14'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_15) is being placed in '.data..L__unnamed_15'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_16) is being placed in '.data..L__unnamed_16'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_17) is being placed in '.data..L__unnamed_17'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_18) is being placed in '.data..L__unnamed_18'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_8) is being placed in '.data..L__unnamed_8'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_9) is being placed in '.data..L__unnamed_9'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_10) is being placed in '.data..L__unnamed_10'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_11) is being placed in '.data..L__unnamed_11'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_12) is being placed in '.data..L__unnamed_12'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_19) is being placed in '.data..L__unnamed_19'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt_commit.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt_commit.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt_commit.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt_commit.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt_commit.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt_commit.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(ubifs/debug.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/debug.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(fuse/dev.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(fuse/dev.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(fuse/dir.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_8) is being placed in '.data..L__unnamed_8'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_11) is being placed in '.data..L__unnamed_11'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_9) is being placed in '.data..L__unnamed_9'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_10) is being placed in '.data..L__unnamed_10'
>    ld.lld: warning: fs/built-in.a(fuse/inode.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(fuse/readdir.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(fuse/readdir.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(fuse/virtio_fs.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(fuse/virtio_fs.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(orangefs/inode.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(orangefs/devorangefs-req.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(orangefs/devorangefs-req.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(orangefs/orangefs-bufmap.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(orangefs/orangefs-bufmap.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(9p/vfs_super.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(9p/vfs_file.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/addr_list.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/callback.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
> >> ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_8) is being placed in '.data..L__unnamed_8'
>    ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/cmservice.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_8) is being placed in '.data..L__unnamed_8'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_10) is being placed in '.data..L__unnamed_10'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_9) is being placed in '.data..L__unnamed_9'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_11) is being placed in '.data..L__unnamed_11'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_12) is being placed in '.data..L__unnamed_12'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_13) is being placed in '.data..L__unnamed_13'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_14) is being placed in '.data..L__unnamed_14'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_15) is being placed in '.data..L__unnamed_15'
>    ld.lld: warning: fs/built-in.a(afs/dir_edit.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/dir_edit.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/dir_edit.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/dir_edit.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/dir_edit.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/dir_edit.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/dynroot.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/file.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/file.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/flock.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/flock.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/flock.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/flock.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/flock.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/fsclient.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/fsclient.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/fsclient.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/fsclient.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/fsclient.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/fsclient.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/fs_operation.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/fs_probe.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/fs_probe.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/fs_probe.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/fs_probe.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/inode.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/inode.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/inode.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/inode.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/inode.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/inode.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/misc.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/mntpt.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/rotate.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/rotate.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/rotate.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/rotate.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(afs/rotate.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/rotate.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/rotate.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_13) is being placed in '.data..L__unnamed_13'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_14) is being placed in '.data..L__unnamed_14'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_8) is being placed in '.data..L__unnamed_8'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_10) is being placed in '.data..L__unnamed_10'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_11) is being placed in '.data..L__unnamed_11'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_9) is being placed in '.data..L__unnamed_9'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_15) is being placed in '.data..L__unnamed_15'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_21) is being placed in '.data..L__unnamed_21'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_12) is being placed in '.data..L__unnamed_12'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_18) is being placed in '.data..L__unnamed_18'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_19) is being placed in '.data..L__unnamed_19'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_17) is being placed in '.data..L__unnamed_17'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_16) is being placed in '.data..L__unnamed_16'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_20) is being placed in '.data..L__unnamed_20'
>    ld.lld: warning: fs/built-in.a(afs/security.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/security.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/security.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/security.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/security.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/server.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/server.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/server.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/server.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_13) is being placed in '.data..L__unnamed_13'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_14) is being placed in '.data..L__unnamed_14'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_8) is being placed in '.data..L__unnamed_8'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_9) is being placed in '.data..L__unnamed_9'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_10) is being placed in '.data..L__unnamed_10'
> --
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_20) is being placed in '.data..L__unnamed_20'
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_21) is being placed in '.data..L__unnamed_21'
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_23) is being placed in '.data..L__unnamed_23'
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_22) is being placed in '.data..L__unnamed_22'
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_26) is being placed in '.data..L__unnamed_26'
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_25) is being placed in '.data..L__unnamed_25'
>    ld.lld: warning: fs/built-in.a(jffs2/wbuf.o):(.data..L__unnamed_24) is being placed in '.data..L__unnamed_24'
>    ld.lld: warning: fs/built-in.a(ubifs/journal.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/dir.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/dir.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/super.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(ubifs/super.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/super.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/super.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(ubifs/sb.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/sb.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/sb.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_8) is being placed in '.data..L__unnamed_8'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_9) is being placed in '.data..L__unnamed_9'
>    ld.lld: warning: fs/built-in.a(ubifs/io.o):(.data..L__unnamed_10) is being placed in '.data..L__unnamed_10'
>    ld.lld: warning: fs/built-in.a(ubifs/master.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/master.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/scan.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/scan.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/replay.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/budget.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(ubifs/budget.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/budget.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/budget.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(ubifs/tnc_commit.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/tnc_commit.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/tnc_commit.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_13) is being placed in '.data..L__unnamed_13'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_14) is being placed in '.data..L__unnamed_14'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_15) is being placed in '.data..L__unnamed_15'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_16) is being placed in '.data..L__unnamed_16'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_17) is being placed in '.data..L__unnamed_17'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_18) is being placed in '.data..L__unnamed_18'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_8) is being placed in '.data..L__unnamed_8'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_9) is being placed in '.data..L__unnamed_9'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_10) is being placed in '.data..L__unnamed_10'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_11) is being placed in '.data..L__unnamed_11'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_12) is being placed in '.data..L__unnamed_12'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt.o):(.data..L__unnamed_19) is being placed in '.data..L__unnamed_19'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt_commit.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt_commit.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt_commit.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt_commit.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt_commit.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(ubifs/lpt_commit.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(ubifs/debug.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(ubifs/debug.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(fuse/dev.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(fuse/dev.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(fuse/dir.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_8) is being placed in '.data..L__unnamed_8'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_11) is being placed in '.data..L__unnamed_11'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_9) is being placed in '.data..L__unnamed_9'
>    ld.lld: warning: fs/built-in.a(fuse/file.o):(.data..L__unnamed_10) is being placed in '.data..L__unnamed_10'
>    ld.lld: warning: fs/built-in.a(fuse/inode.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(fuse/readdir.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(fuse/readdir.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(fuse/virtio_fs.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(fuse/virtio_fs.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(orangefs/inode.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(orangefs/devorangefs-req.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(orangefs/devorangefs-req.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(orangefs/orangefs-bufmap.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(orangefs/orangefs-bufmap.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(9p/vfs_super.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(9p/vfs_file.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/addr_list.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/callback.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
> >> ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_8) is being placed in '.data..L__unnamed_8'
>    ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/cell.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/cmservice.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_8) is being placed in '.data..L__unnamed_8'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_10) is being placed in '.data..L__unnamed_10'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_9) is being placed in '.data..L__unnamed_9'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_11) is being placed in '.data..L__unnamed_11'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_12) is being placed in '.data..L__unnamed_12'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_13) is being placed in '.data..L__unnamed_13'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_14) is being placed in '.data..L__unnamed_14'
>    ld.lld: warning: fs/built-in.a(afs/dir.o):(.data..L__unnamed_15) is being placed in '.data..L__unnamed_15'
>    ld.lld: warning: fs/built-in.a(afs/dir_edit.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/dir_edit.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/dir_edit.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/dir_edit.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/dir_edit.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/dir_edit.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/dynroot.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/file.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/file.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/flock.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/flock.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/flock.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/flock.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/flock.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/fsclient.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/fsclient.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/fsclient.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/fsclient.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/fsclient.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/fsclient.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/fs_operation.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/fs_probe.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/fs_probe.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/fs_probe.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/fs_probe.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/inode.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/inode.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/inode.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/inode.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/inode.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/inode.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/misc.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/mntpt.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/rotate.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/rotate.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/rotate.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/rotate.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(afs/rotate.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/rotate.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/rotate.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_13) is being placed in '.data..L__unnamed_13'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_14) is being placed in '.data..L__unnamed_14'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_8) is being placed in '.data..L__unnamed_8'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_10) is being placed in '.data..L__unnamed_10'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_11) is being placed in '.data..L__unnamed_11'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_9) is being placed in '.data..L__unnamed_9'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_15) is being placed in '.data..L__unnamed_15'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_21) is being placed in '.data..L__unnamed_21'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_12) is being placed in '.data..L__unnamed_12'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_18) is being placed in '.data..L__unnamed_18'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_19) is being placed in '.data..L__unnamed_19'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_17) is being placed in '.data..L__unnamed_17'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_16) is being placed in '.data..L__unnamed_16'
>    ld.lld: warning: fs/built-in.a(afs/rxrpc.o):(.data..L__unnamed_20) is being placed in '.data..L__unnamed_20'
>    ld.lld: warning: fs/built-in.a(afs/security.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/security.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/security.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/security.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/security.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/server.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/server.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/server.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/server.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_2) is being placed in '.data..L__unnamed_2'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_1) is being placed in '.data..L__unnamed_1'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_7) is being placed in '.data..L__unnamed_7'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_3) is being placed in '.data..L__unnamed_3'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_4) is being placed in '.data..L__unnamed_4'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_5) is being placed in '.data..L__unnamed_5'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_6) is being placed in '.data..L__unnamed_6'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_13) is being placed in '.data..L__unnamed_13'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_14) is being placed in '.data..L__unnamed_14'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_8) is being placed in '.data..L__unnamed_8'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_9) is being placed in '.data..L__unnamed_9'
>    ld.lld: warning: fs/built-in.a(afs/super.o):(.data..L__unnamed_10) is being placed in '.data..L__unnamed_10'
> ..
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202010240159.IPld6mlB-lkp%40intel.com.



-- 
Thanks,
~Nick Desaulniers
