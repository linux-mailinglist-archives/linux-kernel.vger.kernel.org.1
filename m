Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472772D1A3B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgLGUGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:06:44 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:34149 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgLGUGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:06:44 -0500
Received: by mail-io1-f72.google.com with SMTP id r16so12811262ioa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 12:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=f91Cn9JrjQvLKYOBpSApGIvFk2qNoHy/Rwzqofllw7c=;
        b=iw8irQ1GUHgnXVN3WbEZsDjFSIPv2lgXPtfeEw1BCr5g+bnYkAcX+ADSo7nVxR9alV
         FPqIMzKOPkQ1KD4yl7Z1bDbupfDu8f46znmjOuwvojbir1RMuyvxAUdgMmXJosXvu+R/
         Qdq5qqsmXlH6hQMcq0nYJljjZxFzUQEy+48pbduEsl/nhY6Q8cpTuAa/4hHFbQjxF5B4
         T7sACQmvCg5CGeY93zd+eVS8zb6g78XyanmjBUaQKPM2mZlyg+8Wzmwtx8ZTfNVZBPv3
         3HIkL/B/w92xemW4w6hZvXsjSg7HzHPmHHYFSkhtvmQe5qvjN2xGpVczeRzuQAUgpY8Z
         NJUg==
X-Gm-Message-State: AOAM5311y8uZXKp8UuPh+2/QBc3quxR8kVis4dYmCLxeBkuesttZwLBi
        9QTLGyXgI7BNtN8XfhUWFh4aI9CPJuFeOyEpewJK0K2JMeqv
X-Google-Smtp-Source: ABdhPJyC6SF3czRBHkW4WdJ75PP3mMjjj8Q5VVBEpf059Kgwd3BbGABo0E0O6VkZWmJEU+fuGvmA86O2Z28ozOmG75cjRlZ5noxa
MIME-Version: 1.0
X-Received: by 2002:a02:4ec4:: with SMTP id r187mr23352536jaa.65.1607371563715;
 Mon, 07 Dec 2020 12:06:03 -0800 (PST)
Date:   Mon, 07 Dec 2020 12:06:03 -0800
In-Reply-To: <0000000000009caba805a9c7b840@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013d25705b5e55be6@google.com>
Subject: Re: INFO: rcu detected stall in __se_sys_mount
From:   syzbot <syzbot+3f2db34df769d77edf8c@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, fweisbec@gmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 1d0e850a49a5b56f8f3cb51e74a11e2fedb96be6
Author: David Howells <dhowells@redhat.com>
Date:   Fri Oct 16 12:21:14 2020 +0000

    afs: Fix cell removal

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=162cebcf500000
start commit:   c85fb28b Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=de7f697da23057c7
dashboard link: https://syzkaller.appspot.com/bug?extid=3f2db34df769d77edf8c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11df5d4f900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157851e0500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: afs: Fix cell removal

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
