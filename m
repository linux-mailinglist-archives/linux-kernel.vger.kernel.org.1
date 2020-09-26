Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4826A279A0F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 16:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgIZOPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 10:15:10 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:50367 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgIZOPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 10:15:10 -0400
Received: by mail-il1-f197.google.com with SMTP id u20so4722783ilk.17
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 07:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HwmCPWTIkgbEGZ/8XPswh0ymyUWqTxojzs4EteOI0oI=;
        b=IFTOxINO2cW9oTl1u8Fm99EJkCATDR9fxFeAIWcYxC5lfSiZQpH2kVXckgf0HoSi7A
         fl8KCn11F2kgVFEHdAXOpfpqSXEd3q0kg0e6L5AT37qXO3c8T1Sch4l4MJcZgBJQzFY9
         6Vmha7pTN/Oo0OKEmZOQF7+t7th0vXAj69X70NRuiIEu9Wycx84PjfUt3s8qUTY3iciP
         vS1bjOVHP5Uk3cBQvtfbQfv/AgtoM9ctxOR0Bw7RoEVTG4j9l8nNqPl2w1npgtlv5vmu
         pm9MRB05kbkVFtJ6Tma7ei0lX7/Um10V1vurqXS20kv0/SRwCw4+kFM8Ob2uuR7IRm/o
         xMQw==
X-Gm-Message-State: AOAM531hWQieCmHfHBHEUwhVXjp5Z6s6zFNUoIAjYKOWez4kF7OYjpLh
        njClnT3CjZ9GIGksYm4mq9jLQ1/EuQK/EtyVL71E5c85WH96
X-Google-Smtp-Source: ABdhPJzP66eKvWYkv61MfW0FnGK+nWFCGDClVgDMl1tg7kxSm9jI8sqCeWZEobb84wJHGaCWQIJpQrNgfTmvYXb6PJHaAILdZudU
MIME-Version: 1.0
X-Received: by 2002:a5e:8e0a:: with SMTP id a10mr2298570ion.200.1601129709294;
 Sat, 26 Sep 2020 07:15:09 -0700 (PDT)
Date:   Sat, 26 Sep 2020 07:15:09 -0700
In-Reply-To: <35306a33-70b5-5e7d-a582-4ba5235953a8@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008fddee05b0380f03@google.com>
Subject: Re: KASAN: use-after-free Read in io_wqe_worker
From:   syzbot <syzbot+9af99580130003da82b1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9af99580130003da82b1@syzkaller.appspotmail.com

Tested on:

commit:         41d5f92f io-wq: fix worker refcount race
git tree:       git://git.kernel.dk/linux-block.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d31db37354c30905
dashboard link: https://syzkaller.appspot.com/bug?extid=9af99580130003da82b1
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Note: testing is done by a robot and is best-effort only.
