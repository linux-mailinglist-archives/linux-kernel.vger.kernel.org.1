Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972FE2EFE3E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 08:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbhAIHUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 02:20:49 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:40604 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbhAIHUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 02:20:49 -0500
Received: by mail-il1-f199.google.com with SMTP id g1so12505093ilq.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 23:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pwlzMsvPhHWdCYhkogMUXxJRp4tYIVlfkKGPQ7+nxL0=;
        b=DbnpwlAzZj7EscU7Fak2LaqZHqP1jrFjQksiwRoCCbh1/Ec+py7IuYT2rW0B/4aQld
         a4LYScgqdd+/A0351fPNIqT8oUiwckP8wtVWmqlpR4j+MITpP7vQpz+h+fCZ2esSNhkd
         3iHaeR/+jv+cqe5HmjnhFpUy/LJs5cEQGUiZkxBc0+TKRSbPzqF7aKNDQFWnhHpzNxKD
         sLEKrOnr6SyjDPSJFtHcmQYcFHvIWe5xTRD4Nf8H8caesCkzxn8VwjTWc/ndDeFGQan+
         Q1p/bhWnKcb30azDCiDKaJNaVbQ7qHxil5Q51nwoSxDa8yPByEa+VZAFVg2fGdrlfeTx
         Akrg==
X-Gm-Message-State: AOAM533NCtA2lIKVnPPJdjjg4AW3dzQK7+rYLSqTl/C4uZrHFmPxJJVW
        47oOoY4CogG/fikkJUQj9vWGZXFamBzQH84oa1b2ibaxQncK
X-Google-Smtp-Source: ABdhPJwA+Mc5PFaC0yCPB3v9+L1044sATU8eG2faM5z6IFbIQfEP8SliAOyimFLXQ8J471KSRH0b3iip2QE9qZrE/Flj+Aslg+9g
MIME-Version: 1.0
X-Received: by 2002:a05:6602:93:: with SMTP id h19mr8312686iob.59.1610176808615;
 Fri, 08 Jan 2021 23:20:08 -0800 (PST)
Date:   Fri, 08 Jan 2021 23:20:08 -0800
In-Reply-To: <000000000000b0bbc905b05ab8d5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4098905b872801e@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in __lookup_slow
From:   syzbot <syzbot+3db80bbf66b88d68af9d@syzkaller.appspotmail.com>
To:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rkovhaev@gmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit d24396c5290ba8ab04ba505176874c4e04a2d53c
Author: Rustam Kovhaev <rkovhaev@gmail.com>
Date:   Sun Nov 1 14:09:58 2020 +0000

    reiserfs: add check for an invalid ih_entry_count

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111480e7500000
start commit:   a68a0262 mm/madvise: remove racy mm ownership check
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e597c2b53c984cd8
dashboard link: https://syzkaller.appspot.com/bug?extid=3db80bbf66b88d68af9d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1737b8a7500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1697246b500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: reiserfs: add check for an invalid ih_entry_count

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
