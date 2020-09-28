Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D05427AA50
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgI1JJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgI1JI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:08:56 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DED1C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:08:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d9so401908pfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJRxVMr8vNM+4CUUjCxZtsq4epCtaAgvHoQB6YN84/A=;
        b=eFAEw6aSWHNemLtODytMKqio01lJ/bQUg8y8+gR7FwGppG47A1tMMO2K9x9PkIAnYy
         wqKgRBR4T3mfabdTyoPT60UF+gdOD/1PpCl0e5jNKeYWPYFE2s0weU66Y1C3HACmbgJt
         aC2ttLUnzmF8tJUG56oc/W8AAhqW0tvxYoldHnVd7z/gpAHZDDXAsYoFFL9gMZnnl6UZ
         IN3cRWpvPhSYkc8rM2X8CUz9GQJsyx739m/d812fnTj78nXEjXe1uEc3zJBaoaZZ/2Uk
         I3+q+mf2CxMkbIBNtdlM7jYqBrCM+NqhyFlfyS01LuT84sETN6A33DfxbcZlFMafg2Cn
         ypcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJRxVMr8vNM+4CUUjCxZtsq4epCtaAgvHoQB6YN84/A=;
        b=JBbqaJu/gSoN8cv+vJ1zgyqmbKcQ9/dJpTxYUL9LHuYvpY3rqKCvb6q6J4eI4RPB4z
         5OQbvsjO3HiTPFPDeyiFVqyGLhFLZSniqwzjxo6u694CFVEUBZIKBNcm+9jcuSUcgm3k
         yiY8tL1R4KoaVPU5ogsvR1pmctjQpNrz+g9iqPZ+HmVSSujWAvyayvaRnxJ5gFJEzC+H
         pnA1Et9xKxKrakWMLieIlmKNC3l8lA7hNOa73G3KrWxOpVpuJkDXCTKdHWWanNxHIz0n
         HTSTi8iMH5AoedqWViN3mjeFP71xwKShWoJqJSLgZdkKPtTrIrAcYG1sfLG6x2uLvLWe
         ELBg==
X-Gm-Message-State: AOAM5330iMqUUYy6CNAHzUJOHT+vG38T/XpEIahWCDryV+0swij0bwmO
        5IUKVk/GR/EkeovtfWfizcsbFidXx74MwOo+urE=
X-Google-Smtp-Source: ABdhPJyTjOTPaS2GZF5y1LXw+tNypUeYL4fpZiG+gXTE4euVOYASxN50H5CnfJygB/btIwFLp4VjJAmLB45wwwoZ5uQ=
X-Received: by 2002:a62:6287:0:b029:142:2501:35d5 with SMTP id
 w129-20020a6262870000b0290142250135d5mr600296pfb.53.1601284135818; Mon, 28
 Sep 2020 02:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b7551005b05ae3b8@google.com> <CACT4Y+Zc5W9kGUqjVkkuUTBEsLk-1k3eKF5F78-LioWF6XTR0w@mail.gmail.com>
 <CAK+_RLmGVr=ngG+Tqum==sDLEeEEz11su92EnoQVG6Zgm2gxzg@mail.gmail.com> <CACT4Y+Yb9UcpO6g+FMZ+4R1PiadcDqKXj7Em4h8+VMrzCdS=9g@mail.gmail.com>
In-Reply-To: <CACT4Y+Yb9UcpO6g+FMZ+4R1PiadcDqKXj7Em4h8+VMrzCdS=9g@mail.gmail.com>
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Mon, 28 Sep 2020 10:08:44 +0100
Message-ID: <CAK+_RLk6JBKqYj7mVThm+Nrpaj0OoqkGP6rRtb4PaOmphBMRSw@mail.gmail.com>
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

On Mon, 28 Sep 2020 at 09:29, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Sep 28, 2020 at 10:23 AM Tigran Aivazian
> > No, this is not an issue. In the latest change to BFS I added the
> > following comment to the header fs/bfs/bfs.h, which explains it:
> >
> > /* In theory BFS supports up to 512 inodes, numbered from 2 (for /) up
> > to 513 inclusive.
> >    In actual fact, attempting to create the 512th inode (i.e. inode
> > No. 513 or file No. 511)
> >    will fail with ENOSPC in bfs_add_entry(): the root directory cannot
> > contain so many entries, counting '..'.
> >    So, mkfs.bfs(8) should really limit its -N option to 511 and not
> > 512. For now, we just print a warning
> >    if a filesystem is mounted with such "impossible to fill up" number
> > of inodes */
>
> There are rules for use of "WARNING" in output required to support
> kernel testing:
> https://github.com/torvalds/linux/blob/master/include/asm-generic/bug.h#L67-L80
> This seems to be triggerable by exteranal inputs and breaks these rules.

Thank you, I didn't know about these rules. Ok, then, since this
warning does not "need prompt attention if it should ever occur at
runtime", the easiest solution is to change "WARNING" to lower case
"warning" in that printk in fs/bfs/inode.c:

--- fs/bfs/inode.c.0 2020-09-28 10:03:00.658549556 +0100
+++ fs/bfs/inode.c 2020-09-28 10:03:05.408548250 +0100
@@ -351,7 +351,7 @@

  info->si_lasti = (le32_to_cpu(bfs_sb->s_start) - BFS_BSIZE) /
sizeof(struct bfs_inode) + BFS_ROOT_INO - 1;
  if (info->si_lasti == BFS_MAX_LASTI)
- printf("WARNING: filesystem %s was created with 512 inodes, the real
maximum is 511, mounting anyway\n", s->s_id);
+ printf("warning: filesystem %s was created with 512 inodes, the real
maximum is 511, mounting anyway\n", s->s_id);
  else if (info->si_lasti > BFS_MAX_LASTI) {
  printf("Impossible last inode number %lu > %d on %s\n",
info->si_lasti, BFS_MAX_LASTI, s->s_id);
  goto out1;

If you want to submit this patch to the appropriate place(s), feel
free to do this -- I approve it. If the comment in asm/bug.h is
inaccurate and its mention of "BUG/WARNING" implies the lowercase
"bug/warning" also, then one can remove the prefix "warning: " from
the patch altogether and proper case "filesystem" to "Filesystem".

Kind regards,
Tigran

Acked-By: Tigran Aivazian <aivazian.tigran@gmail.com>
Approved-By: Tigran Aivazian <aivazian.tigran@gmail.com>
