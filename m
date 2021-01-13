Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9032F4394
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 06:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbhAMFUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 00:20:51 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:42991 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbhAMFUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 00:20:51 -0500
Received: by mail-io1-f69.google.com with SMTP id m9so1116113ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:20:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=f3w8YmotzycWgtKOf4Jx9VcbaQsT2/8mcCaEgBgOL8w=;
        b=GC9LL29qWS2BeUC8oP/inbXQL3VSuHerIQpJrYneo+7xYochxWeNOHu3oHqnTVHpBt
         7bbPepL7w+kHH+4jZOUQV+cuEpDDlz9GzZs096Xk2Uh18pBgX8HZfs0muNJvV3S/9/81
         8YMX1TAPkui+zVv36Nw8+x7a+MDh5UUumdfwtnZpltR830awgOzmgLcWjh5VqJhDHbTs
         imdOj+w1VrjVKuzbvwDjBCbqPDv5qFX+XyX7LitzTL0oqj+b7P4wiqRvEtoUaqxbgjXy
         AdONvCEwXShqQK+rHquinhwtL7yjwOklbXUNxOMQLzGfL/HgQm5XDIQVC7sx6Pq/acXR
         C2zQ==
X-Gm-Message-State: AOAM532EeDNEREubsxVQLEXBSJeXyT4Gr0T3ZVoslgXHJ0huLSUys9hK
        CLUxcGnRdWo4VhR0OywtwsNFL1fXzQEKp1CoeKjBsdPSSLkd
X-Google-Smtp-Source: ABdhPJxUro/y1+jFu8HyZFNGVd1BDblhHSlj39Gz7j8JGYd1Sbc2y9v9Q+fBvbem6gHz8+wjCeTw5SRnzYogNoQDNov43ww/AlDh
MIME-Version: 1.0
X-Received: by 2002:a02:999a:: with SMTP id a26mr828258jal.103.1610515210274;
 Tue, 12 Jan 2021 21:20:10 -0800 (PST)
Date:   Tue, 12 Jan 2021 21:20:10 -0800
In-Reply-To: <0000000000001cc99505b48b5094@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000039dd005b8c14b6e@google.com>
Subject: Re: WARNING in corrupted/usb_submit_urb (2)
From:   syzbot <syzbot+4feb9bb7280fb554f021@syzkaller.appspotmail.com>
To:     eli.billauer@gmail.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit c318840fb2a42ce25febc95c4c19357acf1ae5ca
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Wed Dec 30 16:20:44 2020 +0000

    USB: Gadget: dummy-hcd: Fix shift-out-of-bounds bug

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a8972f500000
start commit:   cd796ed3 Merge tag 'trace-v5.10-rc7' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=59df2a4dced5f928
dashboard link: https://syzkaller.appspot.com/bug?extid=4feb9bb7280fb554f021
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1653b8a7500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170d946b500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: USB: Gadget: dummy-hcd: Fix shift-out-of-bounds bug

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
