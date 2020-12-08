Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28D62D2F6A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgLHQYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:24:44 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:44868 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgLHQYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:24:43 -0500
Received: by mail-il1-f200.google.com with SMTP id c76so6247320ilf.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 08:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HSyExJl7cd4xIkyp8toEOPl4ozCtm+NQv2BdcFpoEZc=;
        b=pU48mCeqdFbiURrRL9brdTLZtCxFY0LUvT87ePko+Qr5mtPHY5aY3eERNMjWiOZHy/
         Cjv2Fd3cc8r0gsE7sDOEW2LzpKnC3AHywv45hLjmtLyOTfB2fVvN47YNw2AgRuegAawI
         /ezqXe019Rar1yAypESp7y75swbtTePnx3T+guvHLDOaBfLoitqekbHm5MuREWgKhex+
         JS8eJ366mEix5Q7/Qm8anDFryV8fXxgNtRBs7MEuPs3mC1j9Gckhn6s2OeRbjM+Wy4qi
         0cdv6Lwld0S90Pp9oKQJKzpjhAwQhYqi8OqQcOTYZJdqyhQKX/Bzhom06IbDSn+4UiVI
         74qg==
X-Gm-Message-State: AOAM5339NMSyZ8/At2P6EddrT33BO5dobToLh/RJ6zoJjx8r9xBKVyRB
        XsgoxxwSm6MS7Z0WTYS5UD/CxApDSsdQqCRfxERLZChTbv/H
X-Google-Smtp-Source: ABdhPJxHYoyiUqUwwYS9+jZI0SJfT9+SzZyPXCYnkfWgYNGZwBVj7ggFtyKt4Au1zc2qCeZTaib8l2L8pQvOMKodUzTGs2Vl/kQM
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b01:: with SMTP id p1mr17378546iov.156.1607444642985;
 Tue, 08 Dec 2020 08:24:02 -0800 (PST)
Date:   Tue, 08 Dec 2020 08:24:02 -0800
In-Reply-To: <20201208160703.GB1298255@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0fb0d05b5f65e64@google.com>
Subject: Re: general protection fault in tower_disconnect
From:   syzbot <syzbot+9be25235b7a69b24d117@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        legousb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, starblue@users.sourceforge.net,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9be25235b7a69b24d117@syzkaller.appspotmail.com

Tested on:

commit:         08a02f95 USB: add RESET_RESUME quirk for Snapscan 1212
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d24ee9ecd7ce968e
dashboard link: https://syzkaller.appspot.com/bug?extid=9be25235b7a69b24d117
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1406a80f500000

Note: testing is done by a robot and is best-effort only.
