Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DFE2C84B2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgK3NIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:08:55 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:44351 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgK3NIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:08:54 -0500
Received: by mail-io1-f71.google.com with SMTP id a1so471585ioa.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rRssb1RG/kVfj9BXppmJh4PLBuJGRMgyZUW2mrbT0Iw=;
        b=sgGROMFawlSpD723qAtlEvwDm51UT3KKO0f7xM/g8I/jeRsSDUFpgz2hWcggrLBDy8
         8p+5rchoT0NKFafHc0u89yEFsRC+UMFf5PIOYy/toGJllKxWI+g+gE8Xjj9WwSB+MI1f
         yBZ4vQ3Au9GtU1oAPmDcOAadvCriQ0vFwRWV9JAn/2gXynR5y2yM9rRtO/guvERvVS83
         Faq0/ajMIqSkE9MkJNomOu91W3fR1OhGco+TRBLWXY5jl/sRLsmjYhfrrL5DhshBMbBe
         jEUXRYFE2zJcEZy+dfAOVARmC0mMBrBHIOFKO1ngN5N7XjaGWRuhJE6ajoxZ3G+vAVNm
         eTwQ==
X-Gm-Message-State: AOAM532pv05rniBUdhN4N/rm2rOiSVTm3OTNvvC6mKWDrqUJBcKCpyuX
        4dz4bQmnOioHj2DzKVeW0t9rMFCMT5xcvsjgRfFEl52hI1bR
X-Google-Smtp-Source: ABdhPJxSLN0kD1nuaHczO+upJ1xtHcOKFyWTuZsa4dIoHVU2hsy50Y7Bd4ZokCuo5JbAIXbX7jV7haKv9+Np8H71t9simuiO+6wS
MIME-Version: 1.0
X-Received: by 2002:a02:cd87:: with SMTP id l7mr2834400jap.117.1606741692313;
 Mon, 30 Nov 2020 05:08:12 -0800 (PST)
Date:   Mon, 30 Nov 2020 05:08:12 -0800
In-Reply-To: <000000000000b8a70905b54ef5ca@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0f2fb05b552b3f3@google.com>
Subject: Re: KASAN: use-after-free Write in kernfs_path_from_node_locked
From:   syzbot <syzbot+19e6dd9943972fa1c58a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axelrasmussen@google.com,
        davem@davemloft.net, dsahern@kernel.org,
        gregkh@linuxfoundation.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, liuhangbin@gmail.com,
        netdev@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, tj@kernel.org, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 0f818c4bc1f3dc0d6d0ea916e0ab30cf5e75f4c0
Author: Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue Nov 24 05:37:42 2020 +0000

    mm: mmap_lock: add tracepoints around lock acquisition

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1626291d500000
start commit:   6174f052 Add linux-next specific files for 20201127
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1526291d500000
console output: https://syzkaller.appspot.com/x/log.txt?x=1126291d500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79c69cf2521bef9c
dashboard link: https://syzkaller.appspot.com/bug?extid=19e6dd9943972fa1c58a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c3351d500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c28809500000

Reported-by: syzbot+19e6dd9943972fa1c58a@syzkaller.appspotmail.com
Fixes: 0f818c4bc1f3 ("mm: mmap_lock: add tracepoints around lock acquisition")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
