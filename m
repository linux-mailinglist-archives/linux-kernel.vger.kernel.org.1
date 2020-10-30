Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA5529FC37
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgJ3DcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:32:11 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54689 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgJ3DcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:32:10 -0400
Received: by mail-io1-f70.google.com with SMTP id s10so3371338iot.21
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0gWbIpsSTzXNygO6c58tnJifaEc8ywsuOsx2ut44wuA=;
        b=kM2XIn+1yGkiC+jE+WFRpAwcOCt/iXauZ5G7Dl6CwZZkBbiv/GpT7acPXlDIlXmrQD
         pdWlP1WhMQCo+IRi83CQpZEPMHDBJfN0BvEUb567y+HvbaDKjvTRP8vNLCOyIHOoVn7m
         1jkk5kPiJcJims32Uh4AzGT8I6A6IU5BVypIo7VPHLoFsGTQ+VaXkwISBYOSFmGUTvR3
         s16ttxmWDhCyloHrN0WkFEZVtN7WG7fBfne2xl7oksyXiXWs216QidZT4J1JrB03qUU8
         OZGOXFfDQ8Y9oyEcsHCpLgXcsFCe74IFowGpJeabLYRXmN/Pafoceerzq/yfIteRT9kC
         IJHA==
X-Gm-Message-State: AOAM530aZois8BffF/n0duTXuOo90U92eIeCeHftQShJOpNKNSgRBdQU
        qryqOf7dJ/omrPmh0ACc/sWD9C8BVTNMsJSFku6XnRKfqdjN
X-Google-Smtp-Source: ABdhPJw5c2LMOPMt3I+nORNDZdoQ3e2XlV4FSnmtPJRE9wFruGS49tCYvqy3C/365WdkMfsHYBkhNSW5PQrQfSsySZwedRCk+cHv
MIME-Version: 1.0
X-Received: by 2002:a92:d5d0:: with SMTP id d16mr465346ilq.223.1604028730168;
 Thu, 29 Oct 2020 20:32:10 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:32:10 -0700
In-Reply-To: <000000000000addbdd05ae6b39e8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000abdde905b2db0a11@google.com>
Subject: Re: INFO: rcu detected stall in ip_list_rcv
From:   syzbot <syzbot+14189f93c40e0e6b19cd@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, fweisbec@gmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 1d0e850a49a5b56f8f3cb51e74a11e2fedb96be6
Author: David Howells <dhowells@redhat.com>
Date:   Fri Oct 16 12:21:14 2020 +0000

    afs: Fix cell removal

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164fdca8500000
start commit:   fb0155a0 Merge tag 'nfs-for-5.9-3' of git://git.linux-nfs...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=41b736b7ce1b3ea4
dashboard link: https://syzkaller.appspot.com/bug?extid=14189f93c40e0e6b19cd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12baea37900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172f27cf900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: afs: Fix cell removal

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
