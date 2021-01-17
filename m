Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBED2F93EC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 17:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbhAQQPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 11:15:46 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:33819 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbhAQQOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 11:14:48 -0500
Received: by mail-io1-f69.google.com with SMTP id r16so24974641ioa.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 08:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7wRcMMariHwqlI4TwHzc8rWIHn72k7o7eSivI4COV+s=;
        b=BiUkUcbu4/LAXVe14/LpmwRWwA1Dr+D13f8JsDmaEJuQanYuW3wM6G4YuH6bR4Sd67
         Zv0ycKtlVcWtPBNjSxPL1FtKeORb5jmN9wkpWGYXyrsjeRG3O41r2gse0OuaEBECWjf0
         a0TUtze/v4FIcxcIIzan9Qd4EMjJcnSjhREbMlkQV0/bgOdyyowLwfp5IbwXJ2x5JISo
         zQfcHZ8+GCHZmwUPPzA9d1vzijUJ6c0pjdHp2zXh1LdsOGc7ypMdQvdHQDSSFy0BC3sM
         cBHyEorcZLZprewogGmEo9eX9KoKYPei1ulURjSjxmGNqcRsja0wHqdGq2WwxKVsLFNW
         d0Jg==
X-Gm-Message-State: AOAM533sWwMAM2Zldw84lTAT8NZnI+oAf85WI0Wv4CF+EfI1Sb7VAuMa
        PSSFE8AwJMja7UJfnq6AVNmeHPMphbhrKbHmggPlL2HJjN36
X-Google-Smtp-Source: ABdhPJxYKgANZp1DuXdut649JU//lEyIr6KJNP0VSqw14Skr4Rp0cfOAh8VJpIMTZzFsIgTS6ePeh8+kUYaRDfsqx8xDOZpenYGO
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1010:: with SMTP id n16mr17661202ilj.3.1610900047611;
 Sun, 17 Jan 2021 08:14:07 -0800 (PST)
Date:   Sun, 17 Jan 2021 08:14:07 -0800
In-Reply-To: <000000000000418c7705afcff2e1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b4eeb05b91ae518@google.com>
Subject: Re: general protection fault in jffs2_parse_param
From:   syzbot <syzbot+9765367bb86a19d38732@syzkaller.appspotmail.com>
To:     anmol.karan123@gmail.com, dhowells@redhat.com, dwmw2@infradead.org,
        jamie@nuviainc.com, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        lizhe67@huawei.com, richard@nod.at, sandeen@sandeen.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a61df3c413e49b0042f9caf774c58512d1cc71b7
Author: Jamie Iles <jamie@nuviainc.com>
Date:   Mon Oct 12 13:12:04 2020 +0000

    jffs2: Fix NULL pointer dereference in rp_size fs option parsing

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15cb91e7500000
start commit:   bf3e7628 Merge branch 'mtd/fixes' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
dashboard link: https://syzkaller.appspot.com/bug?extid=9765367bb86a19d38732
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d81f32500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13516852500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: jffs2: Fix NULL pointer dereference in rp_size fs option parsing

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
