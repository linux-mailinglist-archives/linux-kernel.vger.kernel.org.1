Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C17295EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505152AbgJVMkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:40:08 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:54011 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442034AbgJVMkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:40:05 -0400
Received: by mail-il1-f198.google.com with SMTP id c9so893610ilu.20
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 05:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YPsm7wTqwgB7HM8NoGjpzt0jTQrojzltFX1YmnCyMgA=;
        b=PbpNVafd1zMmOuiS7NPrPT5Wg2JrNfEQFPsG928rANIUUB4vp88XI7KuKF0w9ljFxQ
         5HxmAZ0UvETKoGz4pe2BX7THHYYT0yAmVzORQfQfl4YiLahI1tcHcdPrufhYSJdxqCJS
         IaKiY/zmMmY1CKqJuW3BFeh0guSOMWcjjt0flLqeuaKWGA4S6u4eEmFBbgqjovGcEprS
         /T7xtrLdmr6TeeKciuh2UOsf3df7Gp53bCA+qjM87j836tOm/K5bxGH6O1Jhwj9y9iLt
         NezcWIsmQxZfBe5OD4cGTWJinFj4US8CeYfW1QmWjiUQjYHh0pJ33dsWHYvZE23YOxBi
         2h3g==
X-Gm-Message-State: AOAM532FJfThK6kemlXFKuVyaZs+eMygRPrODLChszfX3dk6Mz7CvFAn
        rYBUshPIJMmHTbd/CvfeY4aA+0SvSlt+7MXO6y//77fACKDy
X-Google-Smtp-Source: ABdhPJz6S3j+p9N8Mn8XnEFCZqzaJIEIlYealXw2z4J2EQRPPGK94GoFSGIbIevJK22mOLgyD6udTcjXwHdyUItSiH/g+Idl4r+7
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6ce:: with SMTP id n14mr1671095iox.34.1603370405018;
 Thu, 22 Oct 2020 05:40:05 -0700 (PDT)
Date:   Thu, 22 Oct 2020 05:40:05 -0700
In-Reply-To: <000000000000add83505a8e38c4c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f439b05b241c3c5@google.com>
Subject: Re: WARNING: suspicious RCU usage in ctrl_cmd_new_lookup
From:   syzbot <syzbot+3025b9294f8cb0ede850@syzkaller.appspotmail.com>
To:     anant.thazhemadam@gmail.com, bjorn.andersson@linaro.org,
        colin.king@canonical.com, dan.carpenter@oracle.com,
        davem@davemloft.net, dragonjetli@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a7809ff90ce6c48598d3c4ab54eb599bec1e9c42
Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date:   Sat Sep 26 16:56:25 2020 +0000

    net: qrtr: ns: Protect radix_tree_deref_slot() using rcu read locks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=143867c8500000
start commit:   7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=3025b9294f8cb0ede850
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11802cf9100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144acc03100000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: qrtr: ns: Protect radix_tree_deref_slot() using rcu read locks

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
