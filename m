Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2A12930A7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 23:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733268AbgJSViG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 17:38:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:53025 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733261AbgJSViF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:38:05 -0400
Received: by mail-io1-f71.google.com with SMTP id e10so1162874ioq.19
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 14:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3+pOrgaRKys1ukxYUhRD8eMBk03/5Wr4iYqe05uE/Xs=;
        b=qk/tNL8vmruSzjHg83d7uehXUR2q5tM/72lk8MW1p9MK6NkGhAQq9Y6O/IsPyKtxiw
         5wh7izPA3iVTxzs6EgRy4lhum/t3LVVDCSRmR4WwSu9GXBdmVYd9ji6crxY00+BTUGoc
         Sq0iA72oqkYYF13/JXx7xC8dOVuxTIk2dx7/ejf+8Y6wGai3N5vxE8KhBPK7nOnjxqxF
         jAcLtdhXsDKEc17ECEaGUI37sbPXTWtMvkywl5u1hiarhzexiDMkNk9qbJKOROtcP+aX
         Lod3gDl/UNsWUcq+Iv1I+P9GXk0mtcH9qb289z9MM6QttW330aY1IKWvJwqAKkmsAoFW
         KXXA==
X-Gm-Message-State: AOAM533+9cu5qXjXnplvXZgeFgfrvmPF2pybx6bcxmnYUyTAaQl+vBU9
        5V7w/5feUlIUaAWzlWmm9WmRSBTT/MoZDfnL95NsvhanUkcO
X-Google-Smtp-Source: ABdhPJzkyP3ftUH+EdI/DBK/RuoKcZyjk/u/pLBTvtucJaGpONpWfm+0802shWZpgCUYbK0yjsxi2Bj6hRfFJtqBrifaQfcF+s8V
MIME-Version: 1.0
X-Received: by 2002:a92:1801:: with SMTP id 1mr1325764ily.219.1603143484870;
 Mon, 19 Oct 2020 14:38:04 -0700 (PDT)
Date:   Mon, 19 Oct 2020 14:38:04 -0700
In-Reply-To: <00000000000005f0b605af42ab4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f098f005b20ced50@google.com>
Subject: Re: KASAN: unknown-crash Read in do_exit
From:   syzbot <syzbot+d9ae84069cff753e94bf@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aryabinin@virtuozzo.com,
        b.zolnierkie@samsung.com, christian@brauner.io,
        dan.carpenter@oracle.com, dvyukov@google.com,
        ebiederm@xmission.com, george.kennedy@oracle.com,
        glider@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, sandeen@sandeen.net,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a49145acfb975d921464b84fe00279f99827d816
Author: George Kennedy <george.kennedy@oracle.com>
Date:   Tue Jul 7 19:26:03 2020 +0000

    fbmem: add margin check to fb_check_caps()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ce19c8500000
start commit:   729e3d09 Merge tag 'ceph-for-5.9-rc5' of git://github.com/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c61610091f4ca8c4
dashboard link: https://syzkaller.appspot.com/bug?extid=d9ae84069cff753e94bf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10642545900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141f2bed900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fbmem: add margin check to fb_check_caps()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
