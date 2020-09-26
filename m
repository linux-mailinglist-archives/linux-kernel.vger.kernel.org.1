Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4EC2799E8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 15:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgIZN5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 09:57:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49886 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgIZN5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 09:57:06 -0400
Received: by mail-io1-f70.google.com with SMTP id k133so4039194iof.16
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 06:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=98+aEA9pvx2wg/3Mq+Ya25XYLOCXE6/GNWyXPqnMQmI=;
        b=uMg0XvMjfq/g9keiFOnQqfpohGxLmpJmFUj5EBJbEgTpteTl+daypE6wGeOTl/un0i
         9mDXBo8i0cCU0iY0j/TUaeL6FaPEQnyZbVxspoQN3W/a4XOfoT/TLfy2PMBzTIutFPYV
         4xxuxKQk/LsznydfMdgqS1+WEQJk84kxuMUGyBmwHcgjq2q5mMXHWZtFIlGpo29JVlEA
         cgi+lGOD24bBP1KHidY1rX46a6ZsJq855lRvck7tTJ62KGJkyDGnHQjAxuleTBm4KolN
         VVqQVrXzpZXQoDh0OvgYWdPwiB5WbUwsPiuykQeZWA9YM/lNyDO6bKl8KOkB/2ILT1Ca
         GLfA==
X-Gm-Message-State: AOAM532RN8O/31mfqSlqHeghRiDge3Yr+Gr7Xcmy4rIJvlXc26708EOZ
        rnAXUK9g+swF3N+Q4eWSMn1Jh1IYIrrx1D6iH/fqx8ju+LsG
X-Google-Smtp-Source: ABdhPJwEHUlQ7HZTMy++EzUl9C4w2PR6M7+lIWTJyZZEkxOLPOY2re8GinnzmhAw17RwQpcBBponj46l6L60OPKDUvtr7Dl6PEhi
MIME-Version: 1.0
X-Received: by 2002:a92:3554:: with SMTP id c81mr4125160ila.265.1601128625954;
 Sat, 26 Sep 2020 06:57:05 -0700 (PDT)
Date:   Sat, 26 Sep 2020 06:57:05 -0700
In-Reply-To: <aa342b42-8bbc-059d-46bf-0ee694c3f67d@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd66ac05b037ce27@google.com>
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
git tree:       git://git.kernel.dk/linux-block io_uring-5.9
kernel config:  https://syzkaller.appspot.com/x/.config?x=d31db37354c30905
dashboard link: https://syzkaller.appspot.com/bug?extid=9af99580130003da82b1
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Note: testing is done by a robot and is best-effort only.
