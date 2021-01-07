Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B2B2ECAC4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 08:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbhAGHDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 02:03:50 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:37330 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbhAGHDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 02:03:49 -0500
Received: by mail-il1-f199.google.com with SMTP id g10so5495021ile.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 23:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ucf7AyuSHfh9bNDOrZnScHCuoM7E4jcmLmsdWXty8X4=;
        b=a2kK0cfPVLK/rAEmiZ3Qem9OWwr9JrqEUXzRDKiL5Nr2W9Z/Gld/chSur6fJuWCOKx
         ub1OUBjEkJXPwz8OWXW/OY91MwLVnVk+kYLaSYR/e+TSpvLbC1KILmuCAhdS04WfvHLg
         Axyf1aiVZs22twRPCE/vWdL4xkRecafQUGt9Uh8NMpkCVTMAWqkRmYo5HIa3tkloeOKa
         hhVWTJuUVjNSO0GCysjbDwK6XwSbZiXYirS9TPUqJ92vnTV65b8J9jWJYoxtCnu5oQGD
         R1VV+arc6PnbY4fIRyraIgSH16omCFr4KH7G6MpllFxl48SRXkF3n4imtmIfyguxbFWB
         5/gw==
X-Gm-Message-State: AOAM533cvQs2CSWWkDetg9/dV5er6q//qFzZEgu277pWuY7qGnAeM/NO
        8WCH70SFVSzjbnbysP98PYgLDxNWNeYSVqv0au0RSUdg26NA
X-Google-Smtp-Source: ABdhPJzgOkTOlqWPD2AGLe7feZpqc5+9HIgYLKJhdyUMDa2mEIf5pnZwLJ95GDYSTEs+PSnnMgoCQgILv3fejmAGALojWIbaQ1VK
MIME-Version: 1.0
X-Received: by 2002:a6b:3b92:: with SMTP id i140mr300092ioa.49.1610002989029;
 Wed, 06 Jan 2021 23:03:09 -0800 (PST)
Date:   Wed, 06 Jan 2021 23:03:09 -0800
In-Reply-To: <000000000000209d7205a7c7ab09@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003fa24b05b84a0886@google.com>
Subject: Re: INFO: task hung in do_truncate (2)
From:   syzbot <syzbot+18b2ab4c697021ee8369@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit dfefd226b0bf7c435a58d75a0ce2f9273b9825f6
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Tue Dec 15 03:15:03 2020 +0000

    mm: cleanup kstrto*() usage

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111aa0cf500000
start commit:   7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=18b2ab4c697021ee8369
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cec296100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153a741e100000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: cleanup kstrto*() usage

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
