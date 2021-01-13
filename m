Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6C32F55F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbhANATw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 19:19:52 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:50511 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbhANAEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:04:45 -0500
Received: by mail-io1-f70.google.com with SMTP id l5so5669614ioj.17
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8vA6KH4yTnBPhCjwbGkm46PU7mMjPjZzD/vxDkOo7Gc=;
        b=k8Jl2TZq8pgBg28OYpwOJ18b/s1+cjQqIzKubSRfQK8HEoJNGecF/ewRS6JbEta3S/
         nCB9Id7WwXrJwxn6QXctDcqyBFdD3ZCciSspeKC8+6cIRPLAH93ftUSm9ZHZ5tqFh0mS
         TDMx4Jfoq8mXF6dkS/8wiBwyDLd7diAIUSMp52OBS864qb/tt6xjBQ0h0OEoCjMSd+T0
         esuw/QLwjfpQJrdEySWQDjrHefqExLY2ZqZWLP+u/OnxaT5L2Hvi3v850rG3a/SuYL6c
         B4v0hqucXRc0HjYs5CirdMAXDwNtbYMT+7gmCV3VTfdwniNhqZ+n/KTC2Vc1v1jthFyI
         7BxQ==
X-Gm-Message-State: AOAM530kqmXTUgJVWdH8wf3CjejWMfQUxQVWs1T5dxhzJ/nB114LCN3Q
        ul/Yobaltx5PMYTWp3NtFjujzLTgSLI6pi9X2NqspE3ANKzw
X-Google-Smtp-Source: ABdhPJyhwL31qQQQGIahEokxTy2M35uYNUcO7+u8PL7IugimTmxbyHHSFEY+nHdvbGotyb7u+HkHJ8hr8j+0vf2SMhtXcO2wBbm6
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11a6:: with SMTP id 6mr2381658ilj.87.1610578871736;
 Wed, 13 Jan 2021 15:01:11 -0800 (PST)
Date:   Wed, 13 Jan 2021 15:01:11 -0800
In-Reply-To: <000000000000c19e7b05b4c35440@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000885f7605b8d01d5e@google.com>
Subject: Re: WARNING in cm109_submit_buzz_toggle/usb_submit_urb
From:   syzbot <syzbot+c7e665956b189738fe5e@syzkaller.appspotmail.com>
To:     eli.billauer@gmail.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oneukum@suse.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit c318840fb2a42ce25febc95c4c19357acf1ae5ca
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Wed Dec 30 16:20:44 2020 +0000

    USB: Gadget: dummy-hcd: Fix shift-out-of-bounds bug

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1075dcaf500000
start commit:   fa02fcd9 Merge tag 'media/v5.10-2' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb8d1a3819ba4356
dashboard link: https://syzkaller.appspot.com/bug?extid=c7e665956b189738fe5e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ba912d500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dfad85500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: USB: Gadget: dummy-hcd: Fix shift-out-of-bounds bug

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
