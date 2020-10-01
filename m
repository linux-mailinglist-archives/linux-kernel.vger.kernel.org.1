Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17B2802CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbgJAPeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:34:06 -0400
Received: from mail-io1-f79.google.com ([209.85.166.79]:42001 "EHLO
        mail-io1-f79.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbgJAPeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:34:06 -0400
Received: by mail-io1-f79.google.com with SMTP id w3so3874196iou.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 08:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=p3I8AGMy+YrC12QmQ5gsY3D38zGF8Pag/wYZhM1xiNM=;
        b=heMyWDEvT9NohZIjZbuU2Tm4hkDkHDbHgVO60gKt1rb9dQSEON8Gj96FMd2pkSB7ji
         jAbOeaXd4RTpeB2qYUdZBQrCjfjfznK5bzKtt610je1CtDnU0zThDGOc8InpJWtGH8ZP
         E7R/55wOcXJiREdMdzVTQADOu0G5jHGafn5DfM7mXnu4Tba1S13sLVbFOno0Y+ETmYB9
         /j/GJIHhQL60VaueLqkpadFCrovAeNxtqVHCfGvR+nSwz0rS2rb6jnI+kLoW/fpSWKj1
         0oiIP0uKTSJJPbIomkj/YDaDrWt9npOwkyB4bEGMkZMc8b0KU5ELpLtYIYVHnkaKoF5C
         KD9Q==
X-Gm-Message-State: AOAM5302t9rNnnhL5wUrnMwe+SGl5uM7VXKkzOi3CW8YJXDcvPtS92ap
        Akq2WFqswGTm6oxtzh7uPqRRnQDnE/w88wEtj5UVvaLAsarM
X-Google-Smtp-Source: ABdhPJzWXX40gZdF7EK/pSohyG4bjSkTey+WsRbE2NFpHS3R9P98PRdoZno5HwO3cr2VYcwXmBfh1igws3xj4NbPQiMxM+0aJ+6L
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:e01:: with SMTP id a1mr2940074ilk.162.1601566445088;
 Thu, 01 Oct 2020 08:34:05 -0700 (PDT)
Date:   Thu, 01 Oct 2020 08:34:05 -0700
In-Reply-To: <0000000000009383f505adc8c5a0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b380805b09dbf40@google.com>
Subject: Re: general protection fault in nexthop_is_blackhole
From:   syzbot <syzbot+b2c08a2f5cfef635cc3a@syzkaller.appspotmail.com>
To:     a@unstable.cc, anant.thazhemadam@gmail.com, andriin@fb.com,
        anmol.karan123@gmail.com, ast@kernel.org,
        b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@gmail.com,
        hariprasad.kelam@gmail.com, herbert@gondor.apana.org.au,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, nikolay@cumulusnetworks.com,
        songliubraving@fb.com, steffen.klassert@secunet.com,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit eeaac3634ee0e3f35548be35275efeca888e9b23
Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date:   Sat Aug 22 12:06:36 2020 +0000

    net: nexthop: don't allow empty NHA_GROUP

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116177a7900000
start commit:   c3d8f220 Merge tag 'kbuild-fixes-v5.9' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb68b9e8a8cc842f
dashboard link: https://syzkaller.appspot.com/bug?extid=b2c08a2f5cfef635cc3a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d75e39900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12aea519900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: nexthop: don't allow empty NHA_GROUP

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
