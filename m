Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D656205738
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbgFWQaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 12:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732224AbgFWQaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:30:05 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7AAC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:30:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y18so9335716plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvUlmAgaOlEv+y6BanvWiE6s1/Lag7n3+CMI66JEh+s=;
        b=cl7AT4Tzf+CETjubxfkcvaSJGN1BK2c+PDYZWzfJd/GQWfsVwbzD11f+2BSsR/UMAW
         2HuX4QZhVgcGtjHuERO5y2WLxw+ij/sVm0BeraELAqhPpEKXzG8qp6/Ciuc2wqMetHrV
         +2Wh8soczDp85b5vDx/MwtqcKxL1Lj3XenYiE/pRsngBxVqJ1r+8TuvjfnVMrlwJXQH8
         RUWRBWcRX+TugGxQPAKRq50Tw1WVKBf6rjlq4ujNCkUwr1dviAtMvhQUEgZbWtNdapJo
         LE9DTztHP6H4ikW+DGwo4VIYNlwf/r2pA6koJGmiAMOt07XhIY+F00yVLavxajCpfQ6S
         ding==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvUlmAgaOlEv+y6BanvWiE6s1/Lag7n3+CMI66JEh+s=;
        b=HCcV391Jl20Q3hRAX2VKmNwGgH4dFDpDisbiTBkJNEyt1eK+b0Jc1xvXdwU4NhHgSi
         w7EGI3i4PzOUyWLV/ZRgnAaM9Qzfl6BEaOm/mMQpXc/yO+1mjOvJIu2eSYhLWzT1pGup
         77O9LDcWuZgCeNq0RYsrauoSqsIJUKHnj5jvh1+pndXF0eRL/0igOFwM1VJt0VDswyww
         nXlmy8PaZPD51sD2fgTR+dGh71q898IfgKoFXalTbANXrSQH+l0UIj8hVhgSkfwSk1qr
         DuqWOJ/vpfUrY97BO81CwDoEUmIYFVW4JPery4q2FBHA3EIVjLsjGBffR/13QvDuWWDo
         NArg==
X-Gm-Message-State: AOAM530jr8BDKcNbOS4YQOHgq1D+OMAYamlOqjJrsK+qHx/vTQyC5BcT
        CLaK/PVAZkTwSQNv3P2rH4/G3eGA4ddBSK8L
X-Google-Smtp-Source: ABdhPJxSB4oaPmGIoV7um96NDP/GdLDz8c1l+Lz6Z0yO1fcqTpNHP7WLMOBV4G7cZ7I6MkN9Ll/Zvw==
X-Received: by 2002:a17:90a:bf0b:: with SMTP id c11mr25108576pjs.47.1592929804491;
        Tue, 23 Jun 2020 09:30:04 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id n12sm13753969pgr.88.2020.06.23.09.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 09:30:03 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH 0/3] x86/dumpstack: Print registers with the same log level as the backtrace
Date:   Tue, 23 Jun 2020 17:29:55 +0100
Message-Id: <20200623162958.331051-1-dima@arista.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show_trace_log_lvl() provides x86 platform-specific way to unwind
backtrace with a given log level. Unfortunately, registers dump(s) are
not printed with the same log level - instead, KERN_DEFAULT is always
used.

Arista's switches uses quite common setup with rsyslog, where only
urgent messages goes to console (console_log_level=KERN_ERR), everything
else goes into /var/log/ as the console baud-rate often is indecently
slow (9600 bps).

Backtrace dumps without registers printed have proven to be as useful as
morning standups. Furthermore, in order to introduce KERN_UNSUPPRESSED
(which I believe is still the most elegant way to fix raciness of sysrq[1])
the log level should be passed down the stack to register dumping
functions. Besides, I have a potential use-case for printing traces
with KERN_DEBUG level [2] (where registers dump shouldn't appear with
higher log level than the backtrace).

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/
[2]: https://lore.kernel.org/linux-doc/20190724170249.9644-1-dima@arista.com/

Dmitry Safonov (3):
  x86/dumpstack: Add log_lvl to show_iret_regs()
  x86/dumpstack: Add log_lvl to __show_regs()
  x86/dumpstack: Show registers dump with trace's log level

 arch/x86/include/asm/kdebug.h |  5 ++--
 arch/x86/kernel/dumpstack.c   | 23 +++++++++-------
 arch/x86/kernel/process_32.c  | 29 ++++++++++----------
 arch/x86/kernel/process_64.c  | 51 ++++++++++++++++++-----------------
 4 files changed, 57 insertions(+), 51 deletions(-)

-- 
2.27.0

