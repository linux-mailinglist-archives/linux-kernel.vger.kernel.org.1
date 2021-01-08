Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A751A2EF181
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbhAHLkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:40:49 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:45514 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbhAHLks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:40:48 -0500
Received: by mail-il1-f198.google.com with SMTP id x10so9932761ilq.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 03:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0FfIg8opJqjhv3NhypIdDPDQF53TqZVQeNLaGTZ+HOU=;
        b=NEzBJdHqnotAO7bYCA4WGxKqf1PBrfq8u5jhsXG0irys+o2cI6yXG6uqH+kZEenSFT
         S3N5uFFYstdlIJ2Vzrh8hXkCF7oGySYkHNpCAPAmNp22Q9PWy2DOghvjnRTtR/f8ea+C
         q8ThFsrrCHap4akOzIN+P7lSJ7TECmOxYc0QiALN1vIsfZjkf8kOe/OcbElhjLgnqBA2
         ZMfodhCUyZ6NCJWz3zokZqKnTfO8oFfSSRBfs6UhyHtBvZNbZ0h10TfVHwpswZRCh3hZ
         +CSxlsBF4pORXnYd5FIj1bvjTNjXs+vXPmeT17XOc3NVS1cmJqXy7ELFCN35beLHLAyf
         6+nQ==
X-Gm-Message-State: AOAM5325V11Eale1FcDS28k9HJXTbMGK6cQMPE1cHbkS+fXB7YJJeBfE
        nNGeHaCcam1WEZzwvEFxM/Zz8WbK5I450QVuiwkLpE/iP6MJ
X-Google-Smtp-Source: ABdhPJy8m6MzgQbqJH4dSzI+5UtH/XcehItBi43kkLMtYEbpCktGVKvnVXzlsnZSaHs06eHziw7Z4qNEWmdvMTfGjjGF4Z88NT4o
MIME-Version: 1.0
X-Received: by 2002:a6b:8ec9:: with SMTP id q192mr5169815iod.28.1610106008258;
 Fri, 08 Jan 2021 03:40:08 -0800 (PST)
Date:   Fri, 08 Jan 2021 03:40:08 -0800
In-Reply-To: <000000000000eba11705afd3d759@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac50ae05b862040d@google.com>
Subject: Re: kernel BUG at fs/reiserfs/prints.c:LINE!
From:   syzbot <syzbot+1541a3226994c0781b29@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        rkovhaev@gmail.com, syzkaller-bugs@googlegroups.com,
        zhengbin13@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit d24396c5290ba8ab04ba505176874c4e04a2d53c
Author: Rustam Kovhaev <rkovhaev@gmail.com>
Date:   Sun Nov 1 14:09:58 2020 +0000

    reiserfs: add check for an invalid ih_entry_count

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1731e8f7500000
start commit:   521b619a Merge tag 'linux-kselftest-kunit-fixes-5.10-rc3' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e93228e2f17fb12
dashboard link: https://syzkaller.appspot.com/bug?extid=1541a3226994c0781b29
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1446e7a8500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c56f5c500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: reiserfs: add check for an invalid ih_entry_count

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
