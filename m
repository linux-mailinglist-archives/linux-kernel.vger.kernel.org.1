Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2FE2DA146
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502710AbgLNUP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:15:26 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:48202 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503095AbgLNUMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:12:44 -0500
Received: by mail-il1-f200.google.com with SMTP id f4so11845858ilu.15
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qwOdLt+7OtBCq8ntrHqjxb5zguAuKgGyZJXiIAiKLL8=;
        b=D/io+9JT9GWnViDcyK18QljXwhIiY4rB3sDHuqoWVYlDFCocoavSytK9B4rjFpBmQ8
         kdzLKWNmcaSFuFBruvr5ze4Jhx1YwOQDK0ZqQDh6tl1/CJmC9yWWaTqRT1BTKdkETX7O
         J4NqJqiGQ4tYGRdxB1T0+D7s3dXWS/AAtjFtEt6MshAkjA/i2ZWK2CHXw26V+5k/Qr06
         44NO6sHWbWuaADlYGPRa2qKzq0egctZ3a0MD0YMU37To7nL0wdwXvQ+81btVsR/YDxPI
         lD3MCjAsPfLZsZBQrgySwcsBbiNsEdRSN8rs/bCNcFhaiFmk+PIIITCTkc3amguCROef
         Ijcg==
X-Gm-Message-State: AOAM531u87L1ScZZuYycPre5FkrXt9kYr1BV4GpuD/ihIJhdKW4N+7Ca
        znNjNLwvnrlxKOgjyES+f39cSu/kek/mpYStEDOsPJl4x8d6
X-Google-Smtp-Source: ABdhPJxGk6qAN5y8QjwxmUH3VlUQvFFxBo49Eb4LJWyrkVn0YnMAjOK56iPxkABY0ATpU1RkoIaq5zvsHOalHb71CYGDQ0WV6ub+
MIME-Version: 1.0
X-Received: by 2002:a92:9a58:: with SMTP id t85mr38019496ili.172.1607976723542;
 Mon, 14 Dec 2020 12:12:03 -0800 (PST)
Date:   Mon, 14 Dec 2020 12:12:03 -0800
In-Reply-To: <X9eB5ZZMq6q5j4eW@localhost>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069fb4f05b6724198@google.com>
Subject: Re: WARNING in yurex_write/usb_submit_urb
From:   syzbot <syzbot+e87ebe0f7913f71f2ea5@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stable@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e87ebe0f7913f71f2ea5@syzkaller.appspotmail.com

Tested on:

commit:         a256e240 usb: phy: convert comma to semicolon
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
kernel config:  https://syzkaller.appspot.com/x/.config?x=4536e7f93c2bc8e9
dashboard link: https://syzkaller.appspot.com/bug?extid=e87ebe0f7913f71f2ea5
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a9f703500000

Note: testing is done by a robot and is best-effort only.
