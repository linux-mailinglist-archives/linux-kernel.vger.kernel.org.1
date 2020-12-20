Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15592DF4BB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 10:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgLTJhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 04:37:45 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:41468 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgLTJho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 04:37:44 -0500
Received: by mail-il1-f198.google.com with SMTP id f19so6695675ilk.8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 01:37:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0fT5mqBE94g71/WluOC6bf1J/UQhmIMm/DUDfbpZB9U=;
        b=FokUUj6a2CqkphV8QlrFUAZS0Kxv66UDxfFrLQ6eWEbVtKbHzLHW1SYOpbeBR5ID7r
         299Bt5z322O66ghxj8u//jRky8ccPCO/ucapd0wgq3iZzBNKZD7E01EHsrjP3Jr7k3Tx
         GvgAkgFWngC5nHncg61a79tpSc3f9F82tVJpP9RT9K+XFegKcWn+SBm4hQmxBXysgDpZ
         faMcDalzleQGHS5H+8SEWPGoXvAXo1dD1/I8uq+o5OjNqz/qzXkBdtq/3zdAEN1yyA7j
         cWUh3C0h99BF+kN/jJ9B7jqXAMZqQ/rDeRYOGsgN8/SwdacmHyJzccUH8Dkda8ZpVCg5
         vQig==
X-Gm-Message-State: AOAM532YO7xz1yCqAALqq6iaPg2yNYmJtXSDKZOTZeDyl5DjdVE4DhUB
        777CLipjR8TypJwdXzsg/2/vQ9oy4bpMgX5nm5yvmZadRIfL
X-Google-Smtp-Source: ABdhPJy/2OvStEVOk368NFkl05TcHnoLfL9VubxJP+qHGmxR1gjcoH5bassxkyk/ywRnffzn1GiHR9p3jFp67h07+mij430mJ0zN
MIME-Version: 1.0
X-Received: by 2002:a5d:8704:: with SMTP id u4mr10573638iom.3.1608457023536;
 Sun, 20 Dec 2020 01:37:03 -0800 (PST)
Date:   Sun, 20 Dec 2020 01:37:03 -0800
In-Reply-To: <000000000000264c6305a9c74d9b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008647f705b6e215de@google.com>
Subject: Re: INFO: rcu detected stall in tipc_release
From:   syzbot <syzbot+3654c027d861c6df4b06@syzkaller.appspotmail.com>
To:     Markus.Elfring@web.de, bp@alien8.de, coreteam@netfilter.org,
        davem@davemloft.net, fw@strlen.de, fweisbec@gmail.com,
        hdanton@sina.com, hpa@zytor.com, jmaloy@redhat.com,
        jmattson@google.com, joro@8bytes.org, kadlec@netfilter.org,
        kuba@kernel.org, kuznet@ms2.inr.ac.ru, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, subashab@codeaurora.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tuong.t.lien@dektech.com.au, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit cc00bcaa589914096edef7fb87ca5cee4a166b5c
Author: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Date:   Wed Nov 25 18:27:22 2020 +0000

    netfilter: x_tables: Switch synchronization to RCU

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1445cb37500000
start commit:   7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=3654c027d861c6df4b06
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12948233100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11344c05100000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfilter: x_tables: Switch synchronization to RCU

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
