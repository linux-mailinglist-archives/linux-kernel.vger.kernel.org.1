Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DCA29352D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 08:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404548AbgJTGsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 02:48:07 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:39234 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404540AbgJTGsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 02:48:06 -0400
Received: by mail-il1-f199.google.com with SMTP id b6so1106797ilm.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 23:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xoUgzEnPQ6/X80FmYbYW0/0mCz5nmTUL7rKcid47d28=;
        b=fJJOc2khO9CqYqjsMJrjBJK2kITw6i/GyECVtAuQjnOngkq0Mf8jloQGaQdS+fWvYR
         S801v+e6jMVd+xDJxhz8A5bCOEsbvUZr6gAH8KiTKrubunGqBJ3kwBKdfPQp5FsjKxG/
         oD0CF62hPLKVXB6uziWVAMBDMsSwaBobK0h2TLdurmEnk+utfF+oHFkjYc29tGdQL9Ii
         Wm1gSQmQli5eCfBD8XjTKiG49KS+Grfcb0JkfimSyJsS3h3Z3IMU/My/DeAQ/H6b/pmF
         BCIBZTgqQ3neFNf2LxsioWNF7q/kQjJUarAwE1PQWeqkXg5vzF0kgBaxS8uWdAFKJ1WP
         7ysA==
X-Gm-Message-State: AOAM530njB03CgR7LKbNi6WrPUxERocFP/kjvWopmZMgsbXnmQ4wWC34
        8RmSpIQl/HU8D5BIqCTs1eI/WYMh5HeALHQCtvt+l1KUyHr/
X-Google-Smtp-Source: ABdhPJyGMNov82rgny3Yeg72erq1MjQrtHmagsPQohT0VIL9IxEQU8WhTJSlS7CKYOXFkxq0a20bZYFdJkYVTr/yvtrHpzZZH3hB
MIME-Version: 1.0
X-Received: by 2002:a92:a307:: with SMTP id a7mr824391ili.97.1603176485856;
 Mon, 19 Oct 2020 23:48:05 -0700 (PDT)
Date:   Mon, 19 Oct 2020 23:48:05 -0700
In-Reply-To: <0000000000009dd95205a7b7f3bf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3ad7805b2149c19@google.com>
Subject: Re: general protection fault in __switch_to_asm
From:   syzbot <syzbot+fe6eeea133f070606074@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de, daniel.vetter@ffwll.ch,
        ggherdovich@suse.cz, gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        mhiramat@kernel.org, mingo@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        rafael.j.wysocki@intel.com, rkovhaev@gmail.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 033724d6864245a11f8e04c066002e6ad22b3fd0
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Wed Jul 15 01:51:02 2020 +0000

    fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f3766f900000
start commit:   04300d66 Merge tag 'riscv-for-linus-5.8-rc7' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f87a5e4232fdb267
dashboard link: https://syzkaller.appspot.com/bug?extid=fe6eeea133f070606074
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1575d102900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dd6ac0900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
