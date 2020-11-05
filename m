Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008D92A7792
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 07:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgKEGvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 01:51:06 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:33542 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgKEGvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 01:51:05 -0500
Received: by mail-il1-f198.google.com with SMTP id p17so403849ilj.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 22:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cXlxyzXPCK3wA1UZI4F1ruEs+BxcdjEXWDq+US8nJxI=;
        b=Gp+yP3HmM8fDu0nqtzl7N1JoU6/nI39UJTxnKNbSKDKwoUucCyiuowKLxPhf1JWKSD
         3eHOqpUbSL/cuSn2b9J3LIwWjxuTOzpoZ55h2GsLxqh7eolx2LKrUDc42FLGqx5xPY/y
         1lcT7JFS3MTbInuITqE5AezzUjK0UUxr3HI04ahq2ykLmQ7OO8qsJ5hUN7fMXTSLEN15
         qQ7xv8+A+F2U+pqgvw12xKFct92F01iHHEOh21b2JRplia4DXCsTfP8UjwgzDQMDzc26
         K/E33oBQvmjH4mn1VmG89ZaDpF9lbi3IPIx60AceeSQ/1GEwTrzpiMYFWKXBVW9lO/x4
         uBmQ==
X-Gm-Message-State: AOAM532A0z9YZxsg8M6lG6WnH88O0MhP6bVyXrhIpv2ixomG1daRSLtd
        iVXclWmEVVJkBrsZE8bRfGBIrglYr6mjEEYKxOPNaVV0p5tI
X-Google-Smtp-Source: ABdhPJxALS0DVWV2QPJFuJm3+R8Z1Pqd1o8qG2Gy4qDOedXlM+a1rm/mTTysetbaTarPtI7AYlyvqZUddW0Ed+55nWGqf7JBV6jN
MIME-Version: 1.0
X-Received: by 2002:a92:690f:: with SMTP id e15mr817269ilc.269.1604559064881;
 Wed, 04 Nov 2020 22:51:04 -0800 (PST)
Date:   Wed, 04 Nov 2020 22:51:04 -0800
In-Reply-To: <000000000000d4b96a05aedda7e2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001560ee05b3568521@google.com>
Subject: Re: possible deadlock in send_sigio (2)
From:   syzbot <syzbot+907b8537e3b0e55151fc@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15fbef32500000
start commit:   4ef8451b Merge tag 'perf-tools-for-v5.10-2020-11-03' of gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17fbef32500000
console output: https://syzkaller.appspot.com/x/log.txt?x=13fbef32500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e93228e2f17fb12
dashboard link: https://syzkaller.appspot.com/bug?extid=907b8537e3b0e55151fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160ab4b2500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cb8e2a500000

Reported-by: syzbot+907b8537e3b0e55151fc@syzkaller.appspotmail.com
Fixes: e918188611f0 ("locking: More accurate annotations for read_lock()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
