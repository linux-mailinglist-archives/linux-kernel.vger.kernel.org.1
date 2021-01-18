Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFED2F9765
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbhARBmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:42:12 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:43765 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbhARBlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 20:41:53 -0500
Received: by mail-io1-f69.google.com with SMTP id n18so6707145ioo.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 17:41:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zXt1APc63d5cqI4C3FVQzfai/THABxZpNpQe8JJ5MKo=;
        b=Mog352l+AKoDfGMziXiGd9d44zfCWZRZs6yV9HiVFFgAr/hA6EpED0qdHs50QItpXd
         28pAAXvMVZ1N9MUXWid3fPxZGlF32jFRVKY4fqhqGg3rygDRgBuLjS6RpnMDIudMzQZh
         o6okTJnuS4vBB6vp2YCTCeM3SzguktElD+n+ZQA/KVWrG3JY5t60Jl2MP8RUd6z/n+Lk
         FXnZIpFw0c3P5sxeW8GxzMQdawZaAwW1cXuV+j4m5CqvvfYh0pueHORkgc98WJ0FIaIK
         2EK5ZoQ0NM6o0UxW1FY761LcwynRuJvGT/Ei2k3L4wevbZnwCTIgTIb0TQpLQjn2wlo8
         thLA==
X-Gm-Message-State: AOAM533osE2gA976GEezo4mt5c1Y8eyr1+HrzhHgL/lE+9ZLndY8DRcn
        w2snbPnfTGjQPzwI5gBKYY7RQF2jQ7lxwHMY6uVst/G2sWSr
X-Google-Smtp-Source: ABdhPJxhyH2KZ1i2QjJL1genE0aYzGwyDF4fwoVfzFRdAdSet85f0cfW/AbR0mGFCPXl517bIx2GQX6qojJGb9aNthgLSSBy1lKp
MIME-Version: 1.0
X-Received: by 2002:a02:6d10:: with SMTP id m16mr17070188jac.86.1610934072416;
 Sun, 17 Jan 2021 17:41:12 -0800 (PST)
Date:   Sun, 17 Jan 2021 17:41:12 -0800
In-Reply-To: <000000000000872b5405b36f8e31@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024a0ec05b922d186@google.com>
Subject: Re: WARNING in input_register_device
From:   syzbot <syzbot+92340f7b2b4789907fdb@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, ebiggers@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit c318840fb2a42ce25febc95c4c19357acf1ae5ca
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Wed Dec 30 16:20:44 2020 +0000

    USB: Gadget: dummy-hcd: Fix shift-out-of-bounds bug

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10be15d7500000
start commit:   2c85ebc5 Linux 5.10
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aff533d6c635e6
dashboard link: https://syzkaller.appspot.com/bug?extid=92340f7b2b4789907fdb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1763d433500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ef12cb500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: USB: Gadget: dummy-hcd: Fix shift-out-of-bounds bug

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
