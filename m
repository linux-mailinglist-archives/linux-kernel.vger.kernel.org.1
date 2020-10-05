Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054B728318B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgJEIKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:10:07 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:44854 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJEIKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:10:06 -0400
Received: by mail-io1-f77.google.com with SMTP id d135so1119089iof.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 01:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wVHJQXmamaTzNpIjudJa+tJEi3PnCwIpctdvTdQM7gU=;
        b=cJU7L55yKaDqYb1HAH6d4g/AFMwc3/w0bAXxv0za9OCaDIn/etn9jbG3VlZD88Iv+3
         jL1HbJHp/RymZFFULX0ojL1oXBu90IoJYxXa/NwLjlXtblX6QkRRWzjAH6Y2CReAxO/q
         4mQVgensTW7ogUXIlHQWgo9uOcQlziDHAJWXCy0kdgIb+x206leicPyMqh/TIVHO6FWa
         mvFSeG6ovUBsluJ8c7sUy27383BPFC7CgGFvendCsNaizLH01HT9X47MK7Zv/PXRMEwI
         0W87cMXS5qWF2fPfOCztJB6AapWudVwO44qbN0aZlm8oLHRvnmjT8gaXAFkA6J7gpfjj
         mdUQ==
X-Gm-Message-State: AOAM531L28CTxwz7MFULnkUBlcvV2ysBmIXE64AEsYHs11/AarY1bd8u
        BXGqvOTATetErIHd8ZdK250Qj9E7PQxVbFl8/aHDd3KxVt2G
X-Google-Smtp-Source: ABdhPJwLFvux9XYUgBTicBVZllZd+7+bLCC5QFjPKgmFSYx/o/20y7IdqANtYLl/dIXDmonWHbc42u2/up4MKxAISa6o88CQ0kNC
MIME-Version: 1.0
X-Received: by 2002:a02:887:: with SMTP id 129mr12505574jac.130.1601885405765;
 Mon, 05 Oct 2020 01:10:05 -0700 (PDT)
Date:   Mon, 05 Oct 2020 01:10:05 -0700
In-Reply-To: <000000000000b3d57105b05ab856@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094e3c805b0e802a8@google.com>
Subject: Re: BUG: unable to handle kernel paging request in tcf_action_dump_terse
From:   syzbot <syzbot+5f66662adc70969940fd@syzkaller.appspotmail.com>
To:     davem@davemloft.net, hdanton@sina.com, jhs@mojatatu.com,
        jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 0fedc63fadf0404a729e73a35349481c8009c02f
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed Sep 23 03:56:24 2020 +0000

    net_sched: commit action insertions together

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c20657900000
start commit:   2172e358 Add linux-next specific files for 20201002
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11c20657900000
console output: https://syzkaller.appspot.com/x/log.txt?x=16c20657900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70698f530a7e856f
dashboard link: https://syzkaller.appspot.com/bug?extid=5f66662adc70969940fd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142fd4af900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ffcdeb900000

Reported-by: syzbot+5f66662adc70969940fd@syzkaller.appspotmail.com
Fixes: 0fedc63fadf0 ("net_sched: commit action insertions together")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
