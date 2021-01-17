Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568CD2F9204
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 12:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbhAQLai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 06:30:38 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:35601 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbhAQL3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 06:29:46 -0500
Received: by mail-io1-f69.google.com with SMTP id a1so24174761ios.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 03:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=P/d1FEPC5iUSKICunGAq3DjPk63uAX3l81ePhtYb8N0=;
        b=JcMSlyZQfkvpm+DrASFZeWAZsAZvCN+pgB8hUnAZ5k7I+YqauyvVGYQJxZ6Cci/MOA
         pHEiHAMm4UgeibDDiBwFApSY4d/eupNR7FhCnyjI3F5mQKJ8/m39cyelbywnfff8bu+G
         9j9jhfGqRjRkyfA1XmfcYwc7W0Q9Tf9p7NjdjseEQmLOxxzTBq8XVeL9xT2SSm6PvCkS
         fgPWhwqNPLaxhELGFwz4ZzL1gbkwe1zlxUpkNot2HB0LA31m1cyKRk6mTB6CZOcJ/jTk
         ga0c80JfXJMPaI5UGlxmgRcbzSCKzUqBlj6UJD7XcbbghDFR1xfd2/x5PNAlXhTtpxcY
         o54w==
X-Gm-Message-State: AOAM533qFu2JiRa2Lsp8kmQdUcGRsPjjREWrKo0BeoB3pw9+iUhiab7s
        J9A9NFqticMiEWoh54kUVoABd7mWbniwp+pJBlKGiutLGuIi
X-Google-Smtp-Source: ABdhPJx5wlmIgilxar3mPnrNpenLIHXRB8QsmmaXtwL5co5ZgqUuD4L6Odq9Is16TpVeRpNjHvh4NXgVuwKnnAtq+1m2JAFvsRlf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:411:: with SMTP id p17mr8267172ilr.33.1610882945873;
 Sun, 17 Jan 2021 03:29:05 -0800 (PST)
Date:   Sun, 17 Jan 2021 03:29:05 -0800
In-Reply-To: <00000000000091111005b435456e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c37b3a05b916e95a@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in fbcon_cursor
From:   syzbot <syzbot+b67aaae8d3a927f68d20@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        daniel.vetter@intel.com, dri-devel@lists.freedesktop.org,
        george.kennedy@oracle.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, melissa.srw@gmail.com,
        natechancellor@gmail.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de,
        yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit ea40d7857d5250e5400f38c69ef9e17321e9c4a2
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri Oct 9 23:21:56 2020 +0000

    drm/vkms: fbdev emulation support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148e2748d00000
start commit:   b3a3cbde Add linux-next specific files for 20210115
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=168e2748d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=128e2748d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ea08dae6aab586f
dashboard link: https://syzkaller.appspot.com/bug?extid=b67aaae8d3a927f68d20
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cd8fe0d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17af5258d00000

Reported-by: syzbot+b67aaae8d3a927f68d20@syzkaller.appspotmail.com
Fixes: ea40d7857d52 ("drm/vkms: fbdev emulation support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
