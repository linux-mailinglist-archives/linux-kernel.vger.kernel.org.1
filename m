Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D677D220973
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbgGOKEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 06:04:06 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:40320 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgGOKEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:04:05 -0400
Received: by mail-il1-f198.google.com with SMTP id z16so1034575ill.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 03:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lZUjqSiBJwDYPm36WdPBclDG5mrQQmRv25qcSv9nR2k=;
        b=WJHUusYBbACk3i29yrWFCeiGO2SXxKs3AixwNb51v4RjQnOcrj5a0Slu0OrWTQn8W2
         BQufMWqqm4KNekdYtb7CxME8usrqFF2TRaqo92p+JRgu77o8oVaYBsL4KpBlcTO+qOQ0
         gT5zeLcj5hOEXU8PqLsa9ZHcdpl76HiaboTaG43XW01JmaInzVtwpCtHUsRIFrvi8311
         dkBjFR9kfXn4HzbWRnTITyhLn5Y9WWnzptNUQjqGdOO1FPmYp3M/VYgAuWSSZaiTgUIJ
         h+zO1RIMQ8A044d6UZGGnaUOFiWhm6M/rVnd5y/BeIrZ6EHWw1XepWU/Mtuvmr+S8IiJ
         8X3A==
X-Gm-Message-State: AOAM530m19I4XPp0aSKi8L1Plt49qGUCgUt+eBL7283OBgxF8hTR8la7
        CXmoko+rrhRaABwghfJTi0dsdz76uJoTeVb8LuiyTZv08YVf
X-Google-Smtp-Source: ABdhPJyycIp0AkfnugimTuwXQFSQQrRqDsnXwJhn4PoiwmUZVLf3foo73PthW2MSKGMpHMirmBnKlHZU4uzD7gjkdcVFSe3C9xDx
MIME-Version: 1.0
X-Received: by 2002:a92:7309:: with SMTP id o9mr8619036ilc.5.1594807444150;
 Wed, 15 Jul 2020 03:04:04 -0700 (PDT)
Date:   Wed, 15 Jul 2020 03:04:04 -0700
In-Reply-To: <000000000000e6807f05aa4608b7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031a14405aa780bdb@google.com>
Subject: Re: WARNING in kthread_queue_work
From:   syzbot <syzbot+fa64e680a1ff32087778@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, qiang.zhang@windriver.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 4977caef05aa154f5e45a232fc4f0e1c74a0c739
Author: Zhang Qiang <qiang.zhang@windriver.com>
Date:   Tue Jul 7 02:29:47 2020 +0000

    kthread: work could not be queued when worker being destroyed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c58f57100000
start commit:   89032636 Add linux-next specific files for 20200708
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11c58f57100000
console output: https://syzkaller.appspot.com/x/log.txt?x=16c58f57100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64a250ebabc6c320
dashboard link: https://syzkaller.appspot.com/bug?extid=fa64e680a1ff32087778
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bf9f2f100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118380ed100000

Reported-by: syzbot+fa64e680a1ff32087778@syzkaller.appspotmail.com
Fixes: 4977caef05aa ("kthread: work could not be queued when worker being destroyed")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
