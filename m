Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428842AAC96
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 18:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgKHRWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 12:22:08 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:38301 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHRWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 12:22:08 -0500
Received: by mail-io1-f72.google.com with SMTP id e21so4233062iod.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 09:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eZACx1XpHn/TCjzHcQemMkrViEyAo5WxQGRjHxgnnxQ=;
        b=swZsxmLRxVubv90TjJn1k2PwxpegrNuKaBEUPLyLBMgj46vx2j1m0Iy3AuT+vUNcuk
         teRKs5eaWsntaSeNCsEo0rmqds/zaaIX2jbhw5NqeD/S6iyeR4jibFX0w+YWKy6KUjSk
         2ydogdIV96NL3oxxiBSSJUmyevZTc2iUxd9nFOIqaV9HR+iXqPEibYAnoG/46RO2bCB+
         qwElezJal+hHfYoTcNCEMO7fbg7OOFosjejkpZncZQ5LAR2jpco3IJ+y+xEbuYSlrMRT
         RXIr5KaUyX8LlrJoe/p9H3+AGoMbS3ZZPmSqGYU9QQzCva0YovmEOPTiDa7gqmE8NUEG
         AYGA==
X-Gm-Message-State: AOAM532KvDTMIu5UkaWwRbLTQFbgGfqhsa2srfxvOItNwG5Df050CjT4
        NIUinXJR9v1IeYgHjIOPRK+9fcmBWCP8QJ+VwXXy907tbEwD
X-Google-Smtp-Source: ABdhPJz6eJZhahQVk2GSxFF4Y7ogqWeAQpCf2TE9sSWZqAr0QdPmPHWIO6Z1oJXfYR80t+8pyzXk7yNWshTaYh62WzNcf/NmGeIq
MIME-Version: 1.0
X-Received: by 2002:a6b:d21a:: with SMTP id q26mr7285163iob.128.1604856127764;
 Sun, 08 Nov 2020 09:22:07 -0800 (PST)
Date:   Sun, 08 Nov 2020 09:22:07 -0800
In-Reply-To: <00000000000018a47605af074c7d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006942a305b39baf75@google.com>
Subject: Re: WARNING in syscall_exit_to_user_mode
From:   syzbot <syzbot+7ffc7214b893651d52b8@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, christian@brauner.io,
        dan.carpenter@oracle.com, george.kennedy@oracle.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@kernel.org, peterz@infradead.org,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a21f32500000
start commit:   f4d51dff Linux 5.9-rc4
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
dashboard link: https://syzkaller.appspot.com/bug?extid=7ffc7214b893651d52b8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122d7335900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cea1a5900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fbmem: add margin check to fb_check_caps()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
