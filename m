Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CA92A18B2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 17:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgJaQYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 12:24:08 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:46578 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgJaQYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 12:24:06 -0400
Received: by mail-io1-f70.google.com with SMTP id a2so6233272iod.13
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 09:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Mv3xcfRCmXxA7yeZzp3pp+X7l2iTBcvglJcW5ZIx2F4=;
        b=iG5A1VkkL/3E9EOoP9d0DcmvY9FR6kJO9LzVd0U6bCZen7s3uSP6XRX9U41Ed+BGvO
         FimnOLqxS2g+7w4F6gW171yA/xR9A1Ylv3ufCLrMQJCG7WskYknCGt9X8FihoQWJ0MOh
         4F8hgcpiANkrLLRrrBWojgDV+0hqCLi2WGPM7EFYXNbjnLEms6h/mP1wdCQIhRiIcaDp
         4Cm24G4/vlreguBQ+JMEqMTuWybSrcneqaLijB7ro4DP6Mnxqsjq5ZDdkBNO/NktmcSY
         1+Cnjf/koyYs/p364LsKjxP5AnM3LtWeGHXHvLg/IoHVGhvZYe+7HOuxKq36C9V3T13Y
         c/jQ==
X-Gm-Message-State: AOAM531WrcJnCeOmuuzIrYoq84PTBnUl7UotnuxaA6aMm5rPCPDwfm5/
        3WXwAn8ct8J7dRAV8PYfugie2i8u9CdSXK7KBryl2XZYTNUm
X-Google-Smtp-Source: ABdhPJyU4r7mwvO9AJ8fTdOIleqXapZDkz1+Tnp60EeYs+PWRqoaGbuJEUAzUkPVDDDNCO2Pwd/A+vHAaAeSumff79/B1SgVNHPx
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24cc:: with SMTP id y12mr6015283jat.144.1604161445451;
 Sat, 31 Oct 2020 09:24:05 -0700 (PDT)
Date:   Sat, 31 Oct 2020 09:24:05 -0700
In-Reply-To: <00000000000021315205b29353aa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e5c6b05b2f9f1e5@google.com>
Subject: Re: WARNING in xfrm_alloc_compat
From:   syzbot <syzbot+a7e701c8385bd8543074@syzkaller.appspotmail.com>
To:     0x7f454c46@gmail.com, davem@davemloft.net, dima@arista.com,
        hdanton@sina.com, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 5f3eea6b7e8f58cf5c8a9d4b9679dc19e9e67ba3
Author: Dmitry Safonov <dima@arista.com>
Date:   Mon Sep 21 14:36:53 2020 +0000

    xfrm/compat: Attach xfrm dumps to 64=>32 bit translator

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102aadf4500000
start commit:   2b94f526 net: stmmac: Fix channel lock initialization
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=122aadf4500000
console output: https://syzkaller.appspot.com/x/log.txt?x=142aadf4500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=803dd96a0e492ac1
dashboard link: https://syzkaller.appspot.com/bug?extid=a7e701c8385bd8543074
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a6e324500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1382100c500000

Reported-by: syzbot+a7e701c8385bd8543074@syzkaller.appspotmail.com
Fixes: 5f3eea6b7e8f ("xfrm/compat: Attach xfrm dumps to 64=>32 bit translator")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
