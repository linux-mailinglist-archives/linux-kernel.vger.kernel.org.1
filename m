Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784DC2A176C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 13:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgJaMnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 08:43:06 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:45589 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgJaMnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 08:43:06 -0400
Received: by mail-il1-f199.google.com with SMTP id z18so6629144ilb.12
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 05:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PLbcQV3CQNzMNiONV/iIo/BtH9u9OMn0g6YFDavSo4Y=;
        b=ml6u9J0yK6TL4CSR4lzu7qeiYP7HZjLvhQ6NSQthHRhzU/gjYt9m0mfEs03sD8a+K4
         Q48yEgRT2Mes81PZRDZHRl6ngPw3+j6bz9YHsvNWgCva8saRCGBU2+5v308JRnVSi8R8
         ryA1YGTPhsN+/vTZoMhx47qtjEpdWCMk4Otl+vV7JAm5JkjT3FUqMzpqwToT9FYFiWwL
         LyG/n7g0GuVM3hFpCUQDkznUeGXQ+GNRmf1AQKPqfeBTiXKQQ/zbIRUJBZetznCLrWRm
         4MW1YaVLZeJK+SaJxoDhqRWVNDLJDQaItn42Q3MFi4BpEkR8iGFgsM9sj7FQXzJXQmst
         DNCQ==
X-Gm-Message-State: AOAM531N3m/XMU6YGFkyIitlkGJIyJTgg6jPwMj1CKGgGAZdv5G8MB1q
        1nUPnWUnE8r4vrqhgRS4xzAQYzmIQjBmc68yiURjUuqVgTx9
X-Google-Smtp-Source: ABdhPJwdSnQMnKqhQpqOWGJCnQ4jy4D5pDlHd07KEgNof9hw/wBkglwShyh1D3kPvEOpyeQ37a+d+sNXdO7wr2zoodVg81gSIN6U
MIME-Version: 1.0
X-Received: by 2002:a02:a813:: with SMTP id f19mr5306316jaj.2.1604148185206;
 Sat, 31 Oct 2020 05:43:05 -0700 (PDT)
Date:   Sat, 31 Oct 2020 05:43:05 -0700
In-Reply-To: <00000000000061316205b0e750fc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf140d05b2f6dae8@google.com>
Subject: Re: INFO: task can't die in nbd_ioctl
From:   syzbot <syzbot+69a90a5e8f6b59086b2a@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hdanton@sina.com, josef@toxicpanda.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchristi@redhat.com, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e9e006f5fcf2bab59149cb38a48a4817c1b538b4
Author: Mike Christie <mchristi@redhat.com>
Date:   Sun Aug 4 19:10:06 2019 +0000

    nbd: fix max number of supported devs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154dc192500000
start commit:   4e78c578 Add linux-next specific files for 20201030
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=174dc192500000
console output: https://syzkaller.appspot.com/x/log.txt?x=134dc192500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83318758268dc331
dashboard link: https://syzkaller.appspot.com/bug?extid=69a90a5e8f6b59086b2a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e051a8500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bf75b8500000

Reported-by: syzbot+69a90a5e8f6b59086b2a@syzkaller.appspotmail.com
Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
