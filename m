Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CCC2DB2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 18:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbgLORjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 12:39:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:53280 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbgLORin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 12:38:43 -0500
Received: by mail-il1-f197.google.com with SMTP id q2so17065988ilt.20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 09:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0OLNIQyK8a72e/CXENRYrk13L6iFjI2wtKw1eTofk+Q=;
        b=qD6qE5N/OsBb8HAEvDDBsSueoCAsddF8O/2AEpTqP9XEx9yUzDuyyhNjaoD/5p/5IQ
         HFqPjbH+aPvrjCWhVKKG3dd47204rt3pg8ibkzvDg7EhsP49AFNVuZtpN2z3cIXO4zkE
         5h5/5iXwRBp0CFIgXc/e9sNYILoryybB5TsuWdeH/M0a8t63ZZF7RuaaiQFw8o1azHZ2
         pYhu4hh5EFalF/RtroBRs8FHmIIFBI6knDxpZXSdkLJSOj45EfA5VeKcrqvdstFzLa6o
         Xho/oEHIAmOer8puQGrgRTnSjYOnJJY0tF/lbMIT4NtR0anm7yBodKXGdv5ZGXdz0q14
         hYig==
X-Gm-Message-State: AOAM531TUEIHY55YIS/Fwb9N5b6AG80gcQCbR++TBCZPhM+0V4ZFBHqz
        dESSC3UCTDsna3d1voR6l/PZuP3zb5ivk6tHrUvq0porfTzD
X-Google-Smtp-Source: ABdhPJz79w/Ax+6EdXIoCXGIwQP1O5JGuVGnUMkE31v73NzNq2fiI6IerHlZnSlI9W+AYO0hQI+5T3uSDxZ6mhsb4jAfKLHLZIPS
MIME-Version: 1.0
X-Received: by 2002:a6b:3b92:: with SMTP id i140mr38166000ioa.49.1608053882696;
 Tue, 15 Dec 2020 09:38:02 -0800 (PST)
Date:   Tue, 15 Dec 2020 09:38:02 -0800
In-Reply-To: <000000000000bd226505b67d9989@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000753add05b6843897@google.com>
Subject: Re: general protection fault in taprio_dequeue_soft
From:   syzbot <syzbot+8971da381fb5a31f542d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit b5b73b26b3ca34574124ed7ae9c5ba8391a7f176
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Thu Sep 10 00:03:11 2020 +0000

    taprio: Fix allowing too small intervals

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13c8eadf500000
start commit:   7f376f19 Merge tag 'mtd/fixes-for-5.10-rc8' of git://git.k..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1028eadf500000
console output: https://syzkaller.appspot.com/x/log.txt?x=17c8eadf500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3416bb960d5c705d
dashboard link: https://syzkaller.appspot.com/bug?extid=8971da381fb5a31f542d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128c5745500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a1f123500000

Reported-by: syzbot+8971da381fb5a31f542d@syzkaller.appspotmail.com
Fixes: b5b73b26b3ca ("taprio: Fix allowing too small intervals")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
