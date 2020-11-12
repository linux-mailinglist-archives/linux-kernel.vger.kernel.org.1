Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCCC2AFE21
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgKLFeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:34:17 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:34281 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgKLCBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 21:01:07 -0500
Received: by mail-il1-f198.google.com with SMTP id e14so2813974ilr.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 18:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fPIpTU7XObV/aYDTsKckMsY4XN1O/uddxk60AMVHEAQ=;
        b=AmvF/1Aaaugr6aI2B0deW028yonGsaG2cp7prtAXON8t6V/aJMxREqpQ48xp6E+06y
         DyiL3dC+5SQYGxBGdpuAmwmUU6s2LMN8lBvMn8CKrUvokPxpE3WATSpA8M82zE3RbSm2
         wxq/0nBibBwll5eI06scvCYePZVciI4j7bqxLelSanrfUUskMO8naGR1kzlYQLIJ9FHn
         k+UvBxcNgzTQwtE86VO/7QHHBAGlxBRMTY5WX4/A27IxDqiYSS0tpM/vT+EdVRuM0moD
         ua2aKNVhsR/ARVu1Vv328Mm0COeTF9SVgFna2i0Cd+eXTtsvfPr8hd696msnNPMXZxRS
         /8fA==
X-Gm-Message-State: AOAM533HNZ8deSdKNUgKjIoLvHtDx7ksks/CUkhzWDTStlk55fFFd7MD
        ODO6oKBmgZmGqQgp/WOh9oM0SmvprPJ3cV22n24hmF2ixJZu
X-Google-Smtp-Source: ABdhPJxRq6op6jH+XFV81MEo+Uqj06/yeOnZF4JHAkF7bFjxQuUOeRHmwI4tVPwVw0sB95Foed8WGs0//pHSCSRZbem9r7DODjE/
MIME-Version: 1.0
X-Received: by 2002:a6b:5f05:: with SMTP id t5mr20978286iob.67.1605146467728;
 Wed, 11 Nov 2020 18:01:07 -0800 (PST)
Date:   Wed, 11 Nov 2020 18:01:07 -0800
In-Reply-To: <000000000000e3068105ac405407@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005858405b3df4904@google.com>
Subject: Re: WARNING in irqentry_exit
From:   syzbot <syzbot+d4336c84ed0099fdbe47@syzkaller.appspotmail.com>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 4d004099a668c41522242aa146a38cc4eb59cb1e
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Oct 2 09:04:21 2020 +0000

    lockdep: Fix lockdep recursion

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1202919a500000
start commit:   f873db9a Merge tag 'io_uring-5.9-2020-08-21' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
dashboard link: https://syzkaller.appspot.com/bug?extid=d4336c84ed0099fdbe47
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15312a66900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b01641900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: lockdep: Fix lockdep recursion

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
