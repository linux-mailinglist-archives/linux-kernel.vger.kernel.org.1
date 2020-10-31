Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3C72A1A93
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 21:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgJaUlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 16:41:06 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:49511 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgJaUlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 16:41:06 -0400
Received: by mail-il1-f198.google.com with SMTP id v29so7216837ilk.16
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 13:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VYLP/QhHc95cphBqd95y5wUSHypbFcFLNHr2N+7vC6g=;
        b=Y2RbswfzuuxSa7YUVU46tnUKc+t2Pkd6BLMWBM7I2M0KDulFFmZQ6ps0au4s1jWng3
         xvJ2QW8qTt/j9kpPVIFQp/UdFjDrR+XKfTQ1x1F9FXGzsSF8FTKGb8PkbBQNkoLAeQWJ
         5aAzxuWltjoWLeQ+Gg4GdjLYHrrUhXCJAlg0GrGdXwRA5vgjZ+tq67+L+d12ZnbCJq1Y
         NgQhtW7rWqreGHXZceg1uRJT39nS2ax+2MKF2Pp5R8dur60VBsgKJ2xlhNlpDeXqb7HL
         FHNHoEwrv0J0pIbwX+HcE6OyCzSQgPOPM141gmN0guQRm7olDSmFNTzIHO0jn8xNy2lX
         Zqaw==
X-Gm-Message-State: AOAM530SY92tOc3614nyog+XaXUvN9Jt4wyzrbf34fQK3Vam5X99Ews5
        0It8VnQp6DjeEs4nIgOGcpBqTF0xZBY8OB1W08KTbR95qj3z
X-Google-Smtp-Source: ABdhPJyK0IXC4aBQ3Cp5HfYblqD07EDNrsoG3k+zUlOkQFKBxsB1vIYRGxZHd/yE65xFwQ737kuB36TiaA0k2pIsWkfkUGL1bu8i
MIME-Version: 1.0
X-Received: by 2002:a02:ccd6:: with SMTP id k22mr480720jaq.93.1604176865647;
 Sat, 31 Oct 2020 13:41:05 -0700 (PDT)
Date:   Sat, 31 Oct 2020 13:41:05 -0700
In-Reply-To: <000000000000341a4705aedd87e0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003be64605b2fd88b2@google.com>
Subject: Re: INFO: rcu detected stall in sys_mount (5)
From:   syzbot <syzbot+dc8c077c7091175cbdb1@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132fe914500000
start commit:   02de58b2 Merge tag 'devicetree-fixes-for-5.9-3' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
dashboard link: https://syzkaller.appspot.com/bug?extid=dc8c077c7091175cbdb1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a40297900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110b7a2f900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: afs: Fix cell removal

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
