Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5DD225304
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 19:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgGSRQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 13:16:08 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:52290 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgGSRQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:16:07 -0400
Received: by mail-io1-f70.google.com with SMTP id k12so9754679iom.19
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 10:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uWsaInl6El+/D5enNDY+jTmOBPyNvNc8dNA1QiA0S0c=;
        b=fRMQRKwDi5qgkF8eA5PHas/4QMcOXl63QM7VtiBIvkgLEEadq0864r7r7UXIbuB5BJ
         8MSB2A+zD4wnC1e/Cwda4SaaGDoOMtzgVPdR3ZRVn0Gu+JzHrHTTBQRwEPfFu607Z9qV
         tRNSFA9o8ff/ERGj8k0e3n+akUnQlJ/Hbdc5qsAFnuGS9Nrzfze6ivFbyrX0FUASR49t
         vILESY+iWcvXsdqb8YZTtnHggSRg2LnYs6HhMcgB1N0QZ+txUdiequAjLmBNqN+eFdEm
         DFVxyj2jaMu3WrVu6g3ilhfhS909nGZjCWs4XxVR0lwPbGM4Ow4d1rNpvcWZjL7+xYD4
         lGLA==
X-Gm-Message-State: AOAM531gRdNSHxNdeTiDp+vZxTUZRwLpm+OYwStqcWyZOOKRceOkdSiw
        vdKpbxtSZmACTn+fUGj60GJaxYr2GQFH4vs2P9yasXnUYQA7
X-Google-Smtp-Source: ABdhPJyqtWSRK+J0kwgjyR9dCgOB/4uCy+2pVK5gDCT/d7MyHs2xxFLVTglqQ0deuai/N8yljwZPA1Qoe/b/OkExASNGKUx+4h19
MIME-Version: 1.0
X-Received: by 2002:a92:58d6:: with SMTP id z83mr19077343ilf.186.1595178967166;
 Sun, 19 Jul 2020 10:16:07 -0700 (PDT)
Date:   Sun, 19 Jul 2020 10:16:07 -0700
In-Reply-To: <000000000000418fc105aa4243aa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0fb8b05aace8b8e@google.com>
Subject: Re: INFO: rcu detected stall in sys_clock_settime
From:   syzbot <syzbot+f3bd350a4124f10acdae@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, davem@davemloft.net, jhs@mojatatu.com,
        jiri@resnulli.us, linux-kernel@vger.kernel.org, mingo@elte.hu,
        netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167142f0900000
start commit:   e9919e11 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=157142f0900000
console output: https://syzkaller.appspot.com/x/log.txt?x=117142f0900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a160d1053fc89af5
dashboard link: https://syzkaller.appspot.com/bug?extid=f3bd350a4124f10acdae
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1353c420900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130f8ef7100000

Reported-by: syzbot+f3bd350a4124f10acdae@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
