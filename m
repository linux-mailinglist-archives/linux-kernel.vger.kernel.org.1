Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDA028A756
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 14:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbgJKM2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 08:28:07 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:55846 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387744AbgJKM2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 08:28:06 -0400
Received: by mail-il1-f207.google.com with SMTP id 9so10533284ile.22
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 05:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EDB5NZGw8qQ43rEg6l7KdvPf4RNp1vg5LBmECT+lt9E=;
        b=VPQJrVAUpZftURET9NeW6jB1u0x9q7nNz0o2BiN87PrBx8KlzcSFeF9kJI3jlApo6h
         bzNUhqOT8169MsfhxAbpJIwFDJ2PAq3H9p23VyDxBKaMVFW2qN3aleZ4w4cOE0Qw0Ekh
         oxerB7BrG3yEyKOpBtqVrr/nNYXyePYLxCsmfFhKbzOz01tXgwcRarP7rjM7uZ/pcwrN
         D0e1Px9UAlwgFbR1CIF6eKswg96nrQfji4UjaKvqG63ogrEW4zKAcmZ8yeIIY0qxJIdQ
         akssIvMT4tZr542yEC8vhYvespFWgBGwP4DgAed605W+dTVD96QWcxOGTulfgcdAiHI0
         3Hdg==
X-Gm-Message-State: AOAM532KBUsOJw04L8PVWpG2ef+nqv80iyZU8Rd1B2HbSo14ICwcwHUz
        IJ4seHSz6n1TSwKsZZ5/6mSsDpVpoO8bcP/LMqRBQI5afmaO
X-Google-Smtp-Source: ABdhPJxKSG8HAsmoVPNeZb5m/PDhpBKzzO/MJ5ApKW3AfuxtHLoUiUgm7uB+jBFbva8PBG/P6NibIxqN5tm9YBayUTh7p2qHB5nn
MIME-Version: 1.0
X-Received: by 2002:a92:ba1c:: with SMTP id o28mr15291963ili.182.1602419285649;
 Sun, 11 Oct 2020 05:28:05 -0700 (PDT)
Date:   Sun, 11 Oct 2020 05:28:05 -0700
In-Reply-To: <000000000000e32a8b05b01f808a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d719705b164508d@google.com>
Subject: Re: KASAN: use-after-free Read in fscache_alloc_cookie
From:   syzbot <syzbot+2d0585e5efcd43d113c2@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, hdanton@sina.com,
        linux-afs@lists.infradead.org, linux-cachefs-bounces@redhat.com,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit c99c2171fc61476afac0dfb59fb2c447a01fb1e0
Author: David Howells <dhowells@redhat.com>
Date:   Thu Nov 1 23:07:27 2018 +0000

    afs: Use fs_context to pass parameters over automount

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17960d58500000
start commit:   171d4ff7 Merge tag 'mmc-v5.9-rc4-2' of git://git.kernel.or..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14560d58500000
console output: https://syzkaller.appspot.com/x/log.txt?x=10560d58500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f4c828c9e3cef97
dashboard link: https://syzkaller.appspot.com/bug?extid=2d0585e5efcd43d113c2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a33ad3900000

Reported-by: syzbot+2d0585e5efcd43d113c2@syzkaller.appspotmail.com
Fixes: c99c2171fc61 ("afs: Use fs_context to pass parameters over automount")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
