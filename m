Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F5926D0BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIQBmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:42:14 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:54462 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgIQBmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:42:09 -0400
Received: by mail-io1-f80.google.com with SMTP id q6so597162iod.21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 18:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/sygnsQByh+EwXCfZR6Do2whKxLsSoSrY8B6J/yTUtY=;
        b=ig+ULEFM4K6rcSsz8XLdsFcEahAT6qGjD0oLKPo/w0kEQd5i6etZVA+Ewpb2GHC8zG
         ZMszD6yjVUfrNcgeBMH0wz0FPHgraIgb8OYif5215nwtDn3sj2ETEn9cEvYVXL155Hpk
         YfQWhUewKZ+AYB5hBmRCnhCjCi4l/fyfnvAc35kt128dzxA+3gVBi4tFCQ1dmlY1JThD
         M+QZQFjFuRaVl7Bbuwy7XrJu0U/vs1ygdKvg79whIAOZIwY300kLTVKUbAA/2xI06SlL
         CYsn6PoFlLh0oRPysn+C761ortlnkJiMnEhviWNe4C+Yjy/K4irLtXBA7hsfKOq2WhSK
         G+Fw==
X-Gm-Message-State: AOAM531HP3/icaKNuHQgAMVVerkpu4SI11o8mmqJUS0GDD/vy8CWafpl
        KHpdkCQqrmgWVKJeRKeZFecolOR1WnZvgKHtCoLOALESXCie
X-Google-Smtp-Source: ABdhPJxVMb+uOEerKF5s9Gb1ikE6JGsTujv7BAzkTlHPxkcCj/j3pCJ5o+iyWmzehBveVDnI38KnOrlXHDSc07kAYD3TL0Ym9yYi
MIME-Version: 1.0
X-Received: by 2002:a02:6607:: with SMTP id k7mr24979424jac.91.1600306928703;
 Wed, 16 Sep 2020 18:42:08 -0700 (PDT)
Date:   Wed, 16 Sep 2020 18:42:08 -0700
In-Reply-To: <000000000000391eaf05ac87b74d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004632a05af787ebf@google.com>
Subject: Re: INFO: task hung in io_uring_flush
From:   syzbot <syzbot+6338dcebf269a590b668@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b7ddce3cbf010edbfac6c6d8cc708560a7bcd7a4
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Sat Sep 5 21:45:14 2020 +0000

    io_uring: fix cancel of deferred reqs with ->files

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=173d9b0d900000
start commit:   9123e3a7 Linux 5.9-rc1
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d400a47d1416652
dashboard link: https://syzkaller.appspot.com/bug?extid=6338dcebf269a590b668
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1573f116900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144d3072900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: io_uring: fix cancel of deferred reqs with ->files

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
