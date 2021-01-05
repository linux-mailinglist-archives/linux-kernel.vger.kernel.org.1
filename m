Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476742EA63B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 09:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbhAEIAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 03:00:47 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:49664 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbhAEIAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 03:00:46 -0500
Received: by mail-il1-f199.google.com with SMTP id x13so23202130ilv.16
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 00:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=v0aLP7+SVCJDOwVeUU00W89DTHctRBaiPpMSLTiojoE=;
        b=TzAtSSBdquYbBMxDJFA12bIm+DD0GVevD5GQ+wMsinsdN6OGyozKT2YjneqjsOW1UA
         sBrNxqAvmfkGfe6wyWP9rnq8kDKDaYfqSNsRVxwGDD4HHr2zC79m9qd38tPmKzRA9BN7
         VuilW40LuO4Q8OmgcIrg5L/S9dCskeyeOqFg3WsBnerD9W5BFZsz58okPjH69Hz6RxLR
         Y62uVeHcx5bVPoZlEeEq+XpZnOIplbv2NNWA7NidJ6peypM1VR9xy5vEqpmrUMVFx/N3
         x8ULnWMy7AFJSp5OeRyT1NKAoY7aFkP0AM1FYU4qBp/9WKC5c/DZgJsUBm70zRNOqbLb
         3sxA==
X-Gm-Message-State: AOAM5310HMDi1T3baBORjvPhK++DYu9IUi5Bn+qgt9vd7ElrrhqSBjxM
        6npAAn+5XB5veQMI8E61SpcnMV9DK1cBlicrMEfVikFe6CAR
X-Google-Smtp-Source: ABdhPJwchYQCU3tzdeyfNH2QEfmn+W0GmyjpiHJY3qTGEemMutDJZUr5gaobY0Rj0X93/3L0IjaR4Wrz48S3eomTKs/QUo1AkKGH
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1525:: with SMTP id i5mr75088809ilu.14.1609833605943;
 Tue, 05 Jan 2021 00:00:05 -0800 (PST)
Date:   Tue, 05 Jan 2021 00:00:05 -0800
In-Reply-To: <000000000000b51b6b05b5dc833b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ad7db05b8229802@google.com>
Subject: Re: KASAN: use-after-free Read in reiserfs_fill_super
From:   syzbot <syzbot+2b5c012223e37b7c2a88@syzkaller.appspotmail.com>
To:     ebiggers@google.com, jack@suse.cz, jhubbard@nvidia.com,
        junxiao.bi@oracle.com, liao.pingfang@zte.com.cn,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        rkovhaev@gmail.com, syzkaller-bugs@googlegroups.com,
        william.kucharski@oracle.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit d24396c5290ba8ab04ba505176874c4e04a2d53c
Author: Rustam Kovhaev <rkovhaev@gmail.com>
Date:   Sun Nov 1 14:09:58 2020 +0000

    reiserfs: add check for an invalid ih_entry_count

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113a2d57500000
start commit:   b3298500 Merge tag 'for-5.10/dm-fixes' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e49433cfed49b7d9
dashboard link: https://syzkaller.appspot.com/bug?extid=2b5c012223e37b7c2a88
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ad719b500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11193117500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: reiserfs: add check for an invalid ih_entry_count

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
