Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB22C2A9142
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 09:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgKFI2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 03:28:06 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:36083 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgKFI2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:28:06 -0500
Received: by mail-io1-f69.google.com with SMTP id q126so430610iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 00:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pPyPSpdVgAkrQqmwI15hvGi5rsu8ZlCbdX9jOZWtvrs=;
        b=guqoIj767LpyTOKZNOai+ue8t7zPV1JvANB54owSuZswenpSKV78riOx4LqAjxqDZa
         SRxwhUCwM1hyLKcgDKtOgVvj+hKyWY1AhEWcTqLbV0bd8KYgVsq68B3vUuZgsg3Jt8FC
         674Ja9yHCxq4VoKi1qjRVlf/kRRO5RxhTo11iV7UjCeEJgk1cms9NhnEhR4B+TjEciw6
         FACI4PH74/IyxptQ4igk8XJAtENYMJj85xsUicTeK9ApakZGZuTmvFJRwb40WsIkWvaJ
         BeJ9COnxZ5bNC11lxan4a02Y67x0WmwygD/HjokYgcfAQQ+fcxTehr50E9cFD7Behixg
         w20A==
X-Gm-Message-State: AOAM533uUs+wkulbWRnPchzE5N+gzD0Eh30/rtqmNYIbM5P8rVjj0QDI
        6KvIj0Sze/nomql1BV6Piq9eeumn20HdhgjRnUFY6Ae8q5RQ
X-Google-Smtp-Source: ABdhPJy+Lj+0hWy5LAXXV8axYD+FlrYxTLBFqLks0d1U7iu2JphAuMbkUeIaynnD7To6XZmhqToUkWFa3hGP/8A3KxhIyc0R1BDN
MIME-Version: 1.0
X-Received: by 2002:a6b:8b0d:: with SMTP id n13mr680816iod.111.1604651285657;
 Fri, 06 Nov 2020 00:28:05 -0800 (PST)
Date:   Fri, 06 Nov 2020 00:28:05 -0800
In-Reply-To: <000000000000106c1305adc89e60@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000debe9105b36bfd65@google.com>
Subject: Re: INFO: rcu detected stall in process_one_work (3)
From:   syzbot <syzbot+f0f857c714a8800e048c@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=117e3684500000
start commit:   abb3438d Merge tag 'm68knommu-for-v5.9-rc3' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=f0f857c714a8800e048c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f47cb9900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14171941900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: afs: Fix cell removal

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
