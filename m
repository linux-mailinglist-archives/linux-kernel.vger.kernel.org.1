Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B31E2A1B5D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 01:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgKAAVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 20:21:13 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:50501 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgKAAVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 20:21:13 -0400
Received: by mail-il1-f197.google.com with SMTP id e87so7452556ill.17
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 17:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+t+XR/wTDNVTtYlWW7f3zi6b97xo3W0UmbwmNVGd3Gc=;
        b=fwlIOm3Lt8W8QOFET7kojPJH7gurVtalSFdgW+IllYGhpzdpc2GDjOCNRAevjZiXZn
         e9Mv6bjswgqYU8jFtdiaE6OyHvUGkzUt/mv0AlBBrWq/5XxM0LB/kX2SADwsk1RyirL1
         FCybiLjmezs4xDgUIN6cd1/eFpvBPNY6Qg3fng0Tm+MBdIylcbK2Os3frsd2Cog741DJ
         kXxWVcUMkuHOp+PDfwOR6A8X0H21/HRxA5GhFhyRNWUIanDkOXURrGXxzv4RJf7L0FN/
         h7JfO2EJ6LBCdsnzELs+oPuyFWlXMl2jyfJ9CTFEty2KOnY8dn5sGY/cBBYGievtt2dm
         cNWg==
X-Gm-Message-State: AOAM5300xB1LNE6MypWMpSfY1PpS63XX9AdNnbz2wxTir+K1UDu5/l0c
        KVNBiR4ix5p2K9lpLDWACS/eaLikdEpe/uccgCttBLsXyUNE
X-Google-Smtp-Source: ABdhPJx9/DjV+k8sOmvzPjKK32S16JsI+YZVDjMqaLkwalHTfuft4cgC7Y7++4NcGry+VOZXzhj0btnaP4vps+OdMzSL0drKKzEG
MIME-Version: 1.0
X-Received: by 2002:a92:ad03:: with SMTP id w3mr5686873ilh.53.1604190072610;
 Sat, 31 Oct 2020 17:21:12 -0700 (PDT)
Date:   Sat, 31 Oct 2020 17:21:12 -0700
In-Reply-To: <0000000000005b4a3805b05a75f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e29ed05b3009b04@google.com>
Subject: Re: possible deadlock in do_fcntl
From:   syzbot <syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1292881a500000
start commit:   4e78c578 Add linux-next specific files for 20201030
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1192881a500000
console output: https://syzkaller.appspot.com/x/log.txt?x=1692881a500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83318758268dc331
dashboard link: https://syzkaller.appspot.com/bug?extid=e6d5398a02c516ce5e70
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b24ecc500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c01512500000

Reported-by: syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
Fixes: e918188611f0 ("locking: More accurate annotations for read_lock()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
