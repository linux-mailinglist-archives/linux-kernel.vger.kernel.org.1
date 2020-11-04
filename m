Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9293B2A6412
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgKDMSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:18:12 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:38459 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDMSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:18:10 -0500
Received: by mail-il1-f197.google.com with SMTP id p17so15231151ilb.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 04:18:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+3EjKaDTd8bhaaIGhp9ZVJ/VUs7Zj0b/Msvp2PVH4gg=;
        b=boGyd2Tp3RnmIjxZd2/ul/63vIwxINJ/3DeNIcix5GX/IXedOganyZf2rgPVO61F2e
         gJgiIg8yx4sKX3oneOJyFK4PA/bD99ARWoJFZTok3WUfLYFhor2h/xDYtMbSZD0NR81B
         6CZCnfRxfrEAQdeLvdMRpm1XV4ydb5LShlgqLcVEaV8sd4nuHjTMCcP3VyFZCTr9O+B0
         zvZxHoeQ58es/jxwIDWMcymCAbuxqZYoXh3cfvUWb2K2PyOkMXZJE48bgUCTmdte9c0B
         +Z4mdn8CUY7Yhpn08LwCdtC1gR1b/YsKek3UdY8XUMkIhZl17rIicmm6B1sk21XbRWbu
         l37w==
X-Gm-Message-State: AOAM530OJ9/p/sc9K33Go/tCO8rpuujnyRuCS14zr5IHEWPOsUOtaxcR
        TWA7bJT4Q3mevqCthsPIdUsCzhhWaxJGCR9OzbCqcVRYr7TD
X-Google-Smtp-Source: ABdhPJx43kLEHlPlcB2tF4af+p51UNM9dagQ/w/3EDMbobnb0+j3mIWJht6+ajpgiMpjQbM7TAl0eyXZmtWS3Bt5hZGQs7pYhJLn
MIME-Version: 1.0
X-Received: by 2002:a92:ba5c:: with SMTP id o89mr17503306ili.248.1604492288180;
 Wed, 04 Nov 2020 04:18:08 -0800 (PST)
Date:   Wed, 04 Nov 2020 04:18:08 -0800
In-Reply-To: <0000000000009d056805b252e883@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1c72705b346f8e6@google.com>
Subject: Re: possible deadlock in send_sigurg (2)
From:   syzbot <syzbot+c5e32344981ad9f33750@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14142732500000
start commit:   4ef8451b Merge tag 'perf-tools-for-v5.10-2020-11-03' of gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16142732500000
console output: https://syzkaller.appspot.com/x/log.txt?x=12142732500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
dashboard link: https://syzkaller.appspot.com/bug?extid=c5e32344981ad9f33750
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15197862500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c59f6c500000

Reported-by: syzbot+c5e32344981ad9f33750@syzkaller.appspotmail.com
Fixes: e918188611f0 ("locking: More accurate annotations for read_lock()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
