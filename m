Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500B4296C28
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461544AbgJWJeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:34:10 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40659 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461426AbgJWJeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:34:09 -0400
Received: by mail-io1-f71.google.com with SMTP id v7so632150ioe.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OR2ITtjdpv4NTvFqagQI/S+gRNI6WwRDFG8I0cp5FOk=;
        b=VmUJTwXNSZBeQSBnAUPzAamnRgR3SORQp+oksMKpeuGUE8KiW7i2C3J246uFWkLiCT
         tHgZ+kurS3hJusfG5ihDaFxML8JjdZ9Zy+YHFMp3stKTG3oDWgl59NX7jpxoRo6A6ruW
         oag99ULjYB9cZC0ZpNAVBUperg/nX581cY/FEZoL/Ag2wW63zxuxCeRbQQge3oTREUeH
         7s8Uoih5U33Rdhoqk8iin3xkGUrF3YQowpHDIT5l5o0tHmdgu9QCIcIWh2Sz8jkJchUQ
         UnZHsYTnsmL5+LVPSMUFFoUM3UsQmi6sHlqWjDXBu2b78fbprm97pMQFB1xgs3ZIrNaT
         SdSA==
X-Gm-Message-State: AOAM531Gbuhx75czYd7XlD1ePeOmdkKxHvjRYRyWbCHWKgkZO+6zVL98
        yylSy34ovdPMPEn+h5XOiCjsAQkwW3TAEsoodBYMXk/CIdqs
X-Google-Smtp-Source: ABdhPJxMZja4L6B6sGY/JPpYNztl7C1nuHzxONB+RpNMHJfRbU0fJGSg1u95xBJuB4lJPtc06eg/hFR9Dv/9cLuxfYBtCYDTm2KV
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13c1:: with SMTP id v1mr974950ilj.254.1603445649127;
 Fri, 23 Oct 2020 02:34:09 -0700 (PDT)
Date:   Fri, 23 Oct 2020 02:34:09 -0700
In-Reply-To: <00000000000069b76105b00bcbfd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055421f05b253489b@google.com>
Subject: Re: INFO: rcu detected stall in sys_newlstat
From:   syzbot <syzbot+60b38542a0dfb2e0f746@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, fweisbec@gmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 1d0e850a49a5b56f8f3cb51e74a11e2fedb96be6
Author: David Howells <dhowells@redhat.com>
Date:   Fri Oct 16 12:21:14 2020 +0000

    afs: Fix cell removal

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103fa33c500000
start commit:   eff48dde Merge tag 'trace-v5.9-rc5' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=af502ec9a451c9fc
dashboard link: https://syzkaller.appspot.com/bug?extid=60b38542a0dfb2e0f746
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ddd69b900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179a69ab900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: afs: Fix cell removal

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
