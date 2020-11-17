Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D213E2B7216
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgKQXTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:19:13 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:47017 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKQXTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:19:13 -0500
Received: by mail-il1-f198.google.com with SMTP id q5so144854ilc.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sCJOc52f+ykN2k2Nsk4q5GEkZUdIbCHBG3TzWEYybVs=;
        b=Zne53bLA/6uxnWcdLmvt3YIhfu/GSKwr/cw7dQihgqDmXfn5YhdQ62fuvtuQ2O4p9K
         6ia93fmci+BaHg04RZT69S4CCgIfj5L4+/ChaP1bYkdqWolW4L11OntDdHW/hegQwZWv
         YztDfpBuXtRplcy3ts3xtCCclPfly/YRqgtkTP2AG6ObXGYu8+iSA+es6CdDjt7Xcg2c
         HNQe4zifY/NEBGbrHaZLPBKTfXNuuAZ0QIQtZlKMIyryG6osjE2lDgwL6ND8e8G0KoxQ
         XvB40Mxq7foIfboic6r/a2UtrH8lmYfl+e4KzjhW7ghHKySzZhxgPVhZTthhQqY5+b6W
         kFjg==
X-Gm-Message-State: AOAM530j/prxkcIIHjWaG8MRlxEmkveo8y9LkYKSRzpsWyrD+40cuRFD
        7NfrehGkR8yOBYRdtu07+Ks0rIn1+cW2epU/dhgX6CkSLyCE
X-Google-Smtp-Source: ABdhPJxChT34/B8KR5M9iyDfeWrPy5FLGPrzPfIfrP0j6CGCmLNUnK5X6P3va84cfBm0fFQ6ORDCOH2TTHVDnJZpXsuI7FTYs+Ub
MIME-Version: 1.0
X-Received: by 2002:a92:c70b:: with SMTP id a11mr5696524ilp.151.1605655150607;
 Tue, 17 Nov 2020 15:19:10 -0800 (PST)
Date:   Tue, 17 Nov 2020 15:19:10 -0800
In-Reply-To: <0000000000009c775805b0c1b811@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2437705b455b8bb@google.com>
Subject: Re: possible deadlock in kill_fasync
From:   syzbot <syzbot+3e12e14ee01b675e1af2@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b46429500000
start commit:   7c8ca812 Add linux-next specific files for 20201117
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12b46429500000
console output: https://syzkaller.appspot.com/x/log.txt?x=14b46429500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff4bc71371dc5b13
dashboard link: https://syzkaller.appspot.com/bug?extid=3e12e14ee01b675e1af2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b1dba6500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12de8636500000

Reported-by: syzbot+3e12e14ee01b675e1af2@syzkaller.appspotmail.com
Fixes: e918188611f0 ("locking: More accurate annotations for read_lock()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
