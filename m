Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA870288775
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 12:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbgJIK6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 06:58:10 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:36913 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732388AbgJIK6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:58:09 -0400
Received: by mail-io1-f80.google.com with SMTP id e21so5873051ioe.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 03:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dWQ9LWp4cwlT/llvEP3Lt5Hhk07N37vidngYWiMcjaQ=;
        b=HjBJODv8uhy5sopRW9hrZ+tvyLFmOI3MuFEKEi0Hwx/kzLV2fw7ZwGzuMxc/tE6JIs
         2Dd4rKOCUHwrXCy+3LKQN23doPdnw4DCdQ6Ew05yhC3FMU6wH+WUAyMcuVD7I8wU5flG
         zKah8tLkbHiXwqss0uV5kkwTPDNYvIFvi7QBmWn/lgq0ZCgh7GGpSrca6T5tg+6Fm4jU
         NMwh7Db0ioQHzmey+2V4A8jhgkTpINA9tnmQ203l/iDtDLyKcZTtEzalm1dfBkr6nWyl
         CLfj/trN2dRMtgmp54sN5oQK5e00TTsnxfwJIbSV9ht90+Py8a7Z3ndvJ7Suu1gWRZHI
         Zf9w==
X-Gm-Message-State: AOAM531N9OcNS5rxofPqrhOsk6FsdS52Wgk5hNjM5oLOZQPwkvs0a3D5
        ZUzneim0Fn+7xnt8HevQ7w+AjFJ51FWUr3MlO3U6vLMDT42/
X-Google-Smtp-Source: ABdhPJwCwWKJ+sFvYCbPhRDxOldxSCciCiHFyzd8zMqs23MB6HP/PEq0ZYaKJ5wgIoWHqXL1Yk2fp+TcOnltEHf5h1bmtU5IOAE1
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:927:: with SMTP id o7mr9695171ilt.275.1602241089330;
 Fri, 09 Oct 2020 03:58:09 -0700 (PDT)
Date:   Fri, 09 Oct 2020 03:58:09 -0700
In-Reply-To: <000000000000cbef4a05a8ffc4ef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9638c05b13ad2a1@google.com>
Subject: Re: BUG: using smp_processor_id() in preemptible code in tipc_crypto_xmit
From:   syzbot <syzbot+263f8c0d007dc09b2dda@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jmaloy@redhat.com, jon.maloy@ericsson.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, tuong.t.lien@dektech.com.au,
        ying.xue@windreiver.com, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit bb8872a1e6bc911869a729240781076ed950764b
Author: Tuong Lien <tuong.t.lien@dektech.com.au>
Date:   Sat Aug 29 19:37:55 2020 +0000

    tipc: fix using smp_processor_id() in preemptible

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=100f5bb8500000
start commit:   6a9dc5fd lib: Revert use of fallthrough pseudo-keyword in ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=263f8c0d007dc09b2dda
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131a8c96900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1747c605900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: tipc: fix using smp_processor_id() in preemptible

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
