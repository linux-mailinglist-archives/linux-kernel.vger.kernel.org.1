Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3261A2F060D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 09:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbhAJIpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 03:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbhAJIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 03:45:37 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A1C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 00:44:57 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 22so12270285qkf.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 00:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDTTzsmnGEAXoK0NnqAqOHJFsLHtEzx8WaLLVuBMk8I=;
        b=FltGPlS6q1gZUkcI4ZMgHjqiRUOhu6f8YNybdsZ5tNp9/5Eb0QqfmZg4IYxca3+Tlb
         YxjJClBKbQ/y3NxGkkLpDYUqGxGodmaIqtVd8sBSCjL5YVWsRHANNX2HdrTFZ8tnr1WF
         kUQcgVYLIazjOxGuOUyg37NnD3dIPOZWOd8i47pLtvII9SzYSi1bYd9p2nM/yBiHX1sK
         7eD7274Yc64a7Fh9S1OkukYr8ZocFziQL+TZV4P0iP5uDUCQCctN/b4p9hj5i0Nw8Cx8
         08jgK+34nhr9ZhwKRfEPPc40i70h0ynPjj0Cj0nNC+DIXr4bO5AyoBH9RMvuKw4fO0cM
         S9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDTTzsmnGEAXoK0NnqAqOHJFsLHtEzx8WaLLVuBMk8I=;
        b=O8D/cjXy+hXti9JaNAQCyJcffKJ9Tbee2/6V9n1NPHRdA7V8wAvNI74ZoIRlqN99hv
         6li55t5wdnQ5qG0dzezt30IlVEpC2Awf1gUNVoSaUjmnI76H1C05u623+uShVdLKhZKc
         yYgZusuxHl+ArHaluGkpeUXFKp6BtuMJHnzNuYvgYXYjXyGv7HUGKeP1pve+UpczLMX0
         ge6VlI/QSVfkzOrxh/UtcCK/nbi8lOShqJRGzq/O9N8CtJlRgNUraZChjs4PKrAOV/NU
         bAjyGCp0/1HmEJ0pWLW47aaKG3qIAkS1CG4sQEdeP1xmkz37DnS3URhBRBjq9pJ7hTji
         HDSQ==
X-Gm-Message-State: AOAM533pfXcI926zYxn96laEBRsVSTDWwnCvTkxQETP0btjpNCsJna6H
        wcMA4AZ5EelFvMdSW2du4ofnTRM9Ms6mAMqlgoBEew==
X-Google-Smtp-Source: ABdhPJwyjbvFq8W425Lp4OzXjuy/XxshU0KVZvrOzWAlAaqAaPoA30kFvfqMEpOEtcjAZ3MJ/OShYD56koOq7m/zxgc=
X-Received: by 2002:a37:9a97:: with SMTP id c145mr11534992qke.350.1610268296425;
 Sun, 10 Jan 2021 00:44:56 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001bc23b05b2b6fd8a@google.com> <CACT4Y+b0-Rw+_aNtGnbwKj7FFM2yKDAsPFO3XP5DnirCRCbbNg@mail.gmail.com>
 <20210109143410.eed9923407f73c00535bb450@linux-foundation.org>
In-Reply-To: <20210109143410.eed9923407f73c00535bb450@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 10 Jan 2021 09:44:44 +0100
Message-ID: <CACT4Y+Ybd4ZYU-3KrASHvNhHqZwMyEAvgmZMBgKPVAXPc4hfug@mail.gmail.com>
Subject: Re: upstream build error (11)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+5b0d0de84d6c65b8dd2b@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 11:34 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat, 9 Jan 2021 21:41:23 +0100 Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > On Wed, Oct 28, 2020 at 9:31 AM syzbot
> > <syzbot+5b0d0de84d6c65b8dd2b@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    4d09c1d9 Merge tag 'devicetree-fixes-for-5.10-1' of git://..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1615899c500000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a5c844e56cc50cdb
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=5b0d0de84d6c65b8dd2b
> > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+5b0d0de84d6c65b8dd2b@syzkaller.appspotmail.com
> > >
> > > mm/process_vm_access.c:277:5: error: implicit declaration of function 'in_compat_syscall'; did you mean 'in_ia32_syscall'? [-Werror=implicit-function-declaration]
> >
> > Other build failures are piling behind this.
> >
> > #syz fix: mm/process_vm_access: Add missing #include <linux/compat.h>

/\/\/\/\/\/\/\/\

This was already fixed by this commit:
https://www.spinics.net/lists/linux-mm/msg232500.html



> For some reason I cant reproduce this with that .config, but presumably
> this is the fix?
>
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm/process_vm_access.c: include compat.h
>
> mm/process_vm_access.c:277:5: error: implicit declaration of function 'in_compat_syscall'; did you mean 'in_ia32_syscall'? [-Werror=implicit-function-declaration]
>
> Fixes: 38dc5079da7081e "Fix compat regression in process_vm_rw()"
> Reported-by: syzbot+5b0d0de84d6c65b8dd2b@syzkaller.appspotmail.com
> Cc: Kyle Huey <me@kylehuey.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  mm/process_vm_access.c |    1 +
>  1 file changed, 1 insertion(+)
>
> --- a/mm/process_vm_access.c~a
> +++ a/mm/process_vm_access.c
> @@ -9,6 +9,7 @@
>  #include <linux/mm.h>
>  #include <linux/uio.h>
>  #include <linux/sched.h>
> +#include <linux/compat.h>
>  #include <linux/sched/mm.h>
>  #include <linux/highmem.h>
>  #include <linux/ptrace.h>
> _
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20210109143410.eed9923407f73c00535bb450%40linux-foundation.org.
