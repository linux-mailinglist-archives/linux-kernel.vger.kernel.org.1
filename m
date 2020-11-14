Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9B32B2D87
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 14:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgKNN6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 08:58:11 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:44722 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgKNN6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 08:58:10 -0500
Received: by mail-il1-f197.google.com with SMTP id g14so3194242ilc.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 05:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=s0HhNxyEyT0xGFdyySpUNPcIA2PSbHMVzYjn4i6pMDI=;
        b=SDSEs5VbjwqqlduIjOiwtVBiOtX7jiMoQ0YBtPinC4ypFQZyUIewPkE5jJ5ScVGnUj
         Q+vfnSPc8Hp/eUeRhemSYkJJfbE0exxnhrambYjcKYr6POBtm3iaTcT0Z9zfDuMhEXQV
         S4LJj2dTYl3YijsMMi17l2kcctRq9BCV3xEJ6XMOMjGTixBDnLd/eaysYwSw496tCnLG
         sDRnfBxjTtf3Jb8IWJTSYW8foX/oH3dbr6CgflmdnBdIWYEiyZ/6wRygfr2ATJbpMlNM
         ddtYytVtZioRRfaqNUNKJaTRh1DMHey/xJxb++b4rbffS1H4sDeZ8xt+PYFBsVT2DgJL
         Ri2w==
X-Gm-Message-State: AOAM532iG4Z192Sbc92tw96mOTtC4svCFKyEZYPR+KXdOhK75RD1Nfon
        FGsZf709QdJPvJMOB9327S4bzT+w4ytgRpgKoRusfgW9eujv
X-Google-Smtp-Source: ABdhPJyxenFYpCjo1t6qQHP+un9WkzqJ8nRkH6t/5mzElJzi/nBa2BP0nv2C/VxqNPkG7/81c1rM4Zhdl5je9KkdYF+cftwTDBjn
MIME-Version: 1.0
X-Received: by 2002:a6b:ef11:: with SMTP id k17mr3094675ioh.210.1605362289857;
 Sat, 14 Nov 2020 05:58:09 -0800 (PST)
Date:   Sat, 14 Nov 2020 05:58:09 -0800
In-Reply-To: <0000000000004740cd05ac444126@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005d94d05b4118980@google.com>
Subject: Re: KASAN: use-after-free Write in afs_manage_cell
From:   syzbot <syzbot+f59c67285cb61166a0cf@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, foxhlchen@gmail.com, hdanton@sina.com,
        linux-afs@lists.infradead.org, linux-cachefs-bounces@redhat.com,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 1d0e850a49a5b56f8f3cb51e74a11e2fedb96be6
Author: David Howells <dhowells@redhat.com>
Date:   Fri Oct 16 12:21:14 2020 +0000

    afs: Fix cell removal

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b78dba500000
start commit:   da690031 Merge branch 'i2c/for-current' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=de7f697da23057c7
dashboard link: https://syzkaller.appspot.com/bug?extid=f59c67285cb61166a0cf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10960a8b900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e938cf900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: afs: Fix cell removal

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
