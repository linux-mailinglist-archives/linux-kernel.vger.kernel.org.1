Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23CC2C8DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbgK3TX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:23:56 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:55062 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgK3TXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:23:47 -0500
Received: by mail-il1-f200.google.com with SMTP id z8so11335237ilq.21
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 11:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uf/aZgeXPqEFjXuJZzr2FsvsM6z9f8DkBMhU/AhY4B4=;
        b=A39wbuAbg0w+EBCLrMFW2X5XmE5Avnl3gtoIoFtMM58UcBFwQfc+62L2HURmWS4oPw
         5poph9PQp/MI01AUjYRUsjxJJl0QzCDj8IuGtQhDHt51yg9EE72n80lyni0j4ZcbbWaO
         EjIjuTSpRu8K/MjPorac3XJsrUuByCFOI1fYDuytW7sgayOb0XFgLnhrJDPnaWtEwbku
         TP0Gq9AHpO+igbaUYJ9sMK0aEyPOE+4HFZzezT4HJUsE+OpSuKw9cV7ETmo7ucAPy9Hc
         YDLN8O+PjWH2Oiu+08D82m/7gdj/9ByTnChbGLUq9KgMhlA1vw5bwW2A5t2uKgS1bYjz
         xvCg==
X-Gm-Message-State: AOAM5312svMegwyLTmiEXPfTTuBM1GbM+2UFat5BDz+RVheWFfsNTnC6
        YD0yipZuHD0FhOt8eLDldoRfllkIg9cBw9Qq4uU5x2hJyg5M
X-Google-Smtp-Source: ABdhPJy1LqIVueVQnUzmecAD0qfntY0qn6d19XP+O81iSfXCPD0VyAXXg8u9XiqkW0yIcc0/lYI943TSZMavOE7gVSbCOgl3XBP5
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a3:: with SMTP id h3mr20119593ilo.164.1606764187097;
 Mon, 30 Nov 2020 11:23:07 -0800 (PST)
Date:   Mon, 30 Nov 2020 11:23:07 -0800
In-Reply-To: <000000000000bf710a05b05ae3f6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c212f05b557f00a@google.com>
Subject: Re: possible deadlock in f_getown
From:   syzbot <syzbot+8073030e235a5a84dd31@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, boqun.feng@gmail.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e918188611f073063415f40fae568fa4d86d9044
Author: Boqun Feng <boqun.feng@gmail.com>
Date:   Fri Aug 7 07:42:20 2020 +0000

    locking: More accurate annotations for read_lock()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122fe51d500000
start commit:   b6505459 Linux 5.10-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=112fe51d500000
console output: https://syzkaller.appspot.com/x/log.txt?x=162fe51d500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3a044ccf5b03ac4
dashboard link: https://syzkaller.appspot.com/bug?extid=8073030e235a5a84dd31
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b43d79500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f2ed79500000

Reported-by: syzbot+8073030e235a5a84dd31@syzkaller.appspotmail.com
Fixes: e918188611f0 ("locking: More accurate annotations for read_lock()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
