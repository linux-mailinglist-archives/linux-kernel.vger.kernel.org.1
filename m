Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400DC2AA4E6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 13:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgKGMKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 07:10:09 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:49528 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgKGMKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 07:10:07 -0500
Received: by mail-io1-f70.google.com with SMTP id c4so2969845ioi.16
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 04:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=bEPCOFw5S5rBelNwysXtchmzidY5p8w+fdQ9rPQh+s4=;
        b=aS8bM1WEAopLrqnnrc/qsJlKgffpjUw6pdSjHN241nxuHBbY99tLTETFWXC74mVaUf
         kRcpj327CKpYiRyIhnz8CWOrC+7jRwuDmazBCKOp0FlRMHcRFqhxEbBnoxkfHIoql/Wx
         AX6KH2vn7VQmpbEC1bRhb4HE61hnzgORg8eTAGW7SUMuuHiptljPt90IMZCl2ynEnmmk
         WVI5hnwz0/qC+vcKsoD/08y70Da8m0afOjs0963sq79txT0SjPKL1BCD6sp3IQ+JjpH0
         ZA8Om1pHYXZXFsJeF+Gsvsb8fW7uoYw9rK9+8ZB2Oyv00NJuLu8gadz2RqkAmMnRL99t
         Sdlw==
X-Gm-Message-State: AOAM533320HqWinJvbUqCgfYkSNg1ieLiLyhihOxKAgXlxeERFqE5Fhg
        tulURgwp0CH9v4TpVM4LrskXADK+VnD3Fho0vScarJ9XYVpa
X-Google-Smtp-Source: ABdhPJy/fr/95Krh7za4yiITJhgfJeU+W90NQEYDsQN2T1cH8wGjrelyVfzoWNnPmSrQoa+mWN3xe4S+Mr6tLRiC6Ft6svXkCXrw
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11a4:: with SMTP id 4mr359864ilj.141.1604751006170;
 Sat, 07 Nov 2020 04:10:06 -0800 (PST)
Date:   Sat, 07 Nov 2020 04:10:06 -0800
In-Reply-To: <000000000000d03eea0571adfe83@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad052105b383350a@google.com>
Subject: Re: possible deadlock in mnt_want_write
From:   syzbot <syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, ast@kernel.org, dvyukov@google.com,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com, rgoldwyn@suse.de,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, zohar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 146d62e5a5867fbf84490d82455718bfb10fe824
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Thu Apr 18 14:42:08 2019 +0000

    ovl: detect overlapping layers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11e40184500000
start commit:   6d906f99 Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=ae82084b07d0297e566b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111767b7200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1611ab2d200000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ovl: detect overlapping layers

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
