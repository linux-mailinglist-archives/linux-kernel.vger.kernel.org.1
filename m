Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BC12DFAC0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 11:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgLUKHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 05:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgLUKHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 05:07:02 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DA8C061257
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 01:08:00 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 22so8163028qkf.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 01:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wOx4tXGx+rKIXQyLoLOpMPZDHfnGdg0gDrSTg/m48M=;
        b=ritNyDWqEu8rSc0lI4d/R9Y0/OWFOzTOTTDG2/yqnNsD5LC1db4dLm5aiBnuomAQhz
         U5TUavNGTl5QmCuQtLf0jnUvMi/mCO2y9Pc/mEZYP/Q0bcformGvhpRXq9/FKdW81tVJ
         pIQfDZ7T94frn+3us2R9TPZL+kru6iEqOlizg/R9glUcfElHY044q0DWfcdzJZQN9ezl
         lQ478PWsYR+AFNw6cvLez7qFCNvh+fBTMzO5zBQMyuYpwXuUepCbZIesPeZTWRz75P9D
         HZKGsPrU3MTEzQtrvPklKTWpbYjfXG1jsuLvZ8YJlf7bNtMZ5vIZlgYACGm+H8xyljQA
         ps7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wOx4tXGx+rKIXQyLoLOpMPZDHfnGdg0gDrSTg/m48M=;
        b=P6ebDo/H26zfqqs1RTjHS7sI/7P08gjVCSlwFuwbejqFAF5gNAk5lkvs2COPRPaCyb
         t8TK5bZzPhQy9sPTQyL5+uWO33825DNaWpWTEOKfPYJ1DV/RR5VaYYly/YyJcTaaBRhW
         6wnQtDvOAcLJp3yo+2R840aVwrCcqq+mcr2ecgIvmGlT0JwR5kCod9pbHX/jDNSXPt8W
         ksjVfykarTlbL0vrifbMgeMSdOhqBCu3oWD9fhnsiwVQ63jficEz8B4XFdgYRQkxiyVk
         hYv/H8iGm+Qd5+hF1gCmG2ts1hhEwbRbDS2CPzIpF+/zOnsIVQFCf59AHsDQO8j9zTYd
         f4CQ==
X-Gm-Message-State: AOAM533dQzi2A7fRkQG/gcI/a1HJ/bgVgElDvRMGnnZewJv6ZMy5CwOx
        TAjnIslZKoNu3s0z5HnXLyUtHFvSvjVUHXIrywJAPA==
X-Google-Smtp-Source: ABdhPJwideAy5C4xFEylnbdBkFX0HuCIa3J5Ek28Q4RyRqYJyEm1Kc0SLV/pWow8o6WOWDJIDKWgFAB6DHsBEt9g7LQ=
X-Received: by 2002:a05:620a:983:: with SMTP id x3mr16876805qkx.231.1608541679828;
 Mon, 21 Dec 2020 01:07:59 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005fbe5e05b6ab2440@google.com>
In-Reply-To: <0000000000005fbe5e05b6ab2440@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 21 Dec 2020 10:07:48 +0100
Message-ID: <CACT4Y+YG5Vh-B+JKsyg_6dyKrS56Vthz=C+oSccWhUjfW=SASw@mail.gmail.com>
Subject: Re: UBSAN: invalid-load in param_get_bool
To:     syzbot <syzbot+438cc6c21c384f9efa5e@syzkaller.appspotmail.com>,
        Kees Cook <keescook@google.com>
Cc:     christian.koenig@amd.com,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, pmenzel@molgen.mpg.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 5:04 PM syzbot
<syzbot+438cc6c21c384f9efa5e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    accefff5 Merge tag 'arm-soc-omap-genpd-5.11' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12385613500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d42216b510180e3
> dashboard link: https://syzkaller.appspot.com/bug?extid=438cc6c21c384f9efa5e
> compiler:       gcc (GCC) 10.1.0-syz 20200507
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+438cc6c21c384f9efa5e@syzkaller.appspotmail.com

+Kees

Now another upstream instance stopped working due to this UBSAN bug.
The bug is always triggered when test machines start, we already have 50K hits.

> ================================================================================
> UBSAN: invalid-load in kernel/params.c:302:33
> load of value 255 is not a valid value for type '_Bool'
> CPU: 0 PID: 8488 Comm: syz-fuzzer Not tainted 5.10.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:120
>  ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
>  __ubsan_handle_load_invalid_value.cold+0x62/0x6c lib/ubsan.c:427
>  param_get_bool.cold+0x14/0x19 kernel/params.c:302
>  param_attr_show+0x14a/0x220 kernel/params.c:549
>  module_attr_show+0x48/0x70 kernel/params.c:884
>  sysfs_kf_seq_show+0x1f8/0x400 fs/sysfs/file.c:61
>  seq_read_iter+0x4d3/0x1220 fs/seq_file.c:227
>  seq_read+0x3dd/0x5b0 fs/seq_file.c:159
>  kernfs_fop_read+0xe9/0x590 fs/kernfs/file.c:251
>  vfs_read+0x1b5/0x570 fs/read_write.c:494
>  ksys_read+0x12d/0x250 fs/read_write.c:634
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x4b3d8b
> Code: ff e9 69 ff ff ff cc cc cc cc cc cc cc cc cc e8 db a1 f8 ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
> RSP: 002b:000000c0000a3740 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 000000c00002c000 RCX: 00000000004b3d8b
> RDX: 0000000000001200 RSI: 000000c000341300 RDI: 0000000000000006
> RBP: 000000c0000a3790 R08: 0000000000000001 R09: 0000000000000002
> R10: 0000000000001200 R11: 0000000000000202 R12: ffffffffffffffff
> R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000005
> ================================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
