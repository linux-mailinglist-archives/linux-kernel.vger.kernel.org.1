Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E9C2D1AAF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgLGUiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLGUiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:38:46 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9574C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 12:38:05 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2so7449512pfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 12:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VP+hoCqwIWsnA0voqk8jAfDIe0nJXOmy9tu69gSnMlc=;
        b=gCJE3Rt50ppAZPB+JKw2cj9wNqJ3HR/ii1x3QiRBg3oH+/adecdkqAp8wAGkiogsZ9
         qYSvd8IemtQJbMWzyJKxja37OgYXBcmzGwVxs4zRU3c1jMnrYU8V9Cc6QyWBh/xrJshh
         C4cia4dfmlnw7EGRF5tMf1JMGO92UhV9IgfiuUnYoFS/3/kwYCZG8b5eUN3tOPDt1Rp6
         4Wooly49q7WKu5EOfDa4XQmgDSZRGfWX2SQDSJMvNrF1awEeVnL3hKnECHiBOTwTxAa5
         l4oMD82xE4H1voCEPGcblSnsaB//aVwVZCVb6FUtVSgGbysQ14fTZVHMqG2tOXN9m4Tf
         G9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VP+hoCqwIWsnA0voqk8jAfDIe0nJXOmy9tu69gSnMlc=;
        b=MUny4kRg9JpiADpBStWNcRo5U9FJclfl82HKAEg+ebtpGzRsyfJvEQPrGc/f8FSH0k
         ubNlJ7hChSOF4kSV7J033tuL1H0ofXXrhqdm7QpG+vPBhY4T6mF28OSQpnIibA96XeVV
         FcaWtbVREjyopxyfKXoi7eOuW+TOkxDFg4JgaxzRHnkVnTUdDr9Km0daI7yKfQ5NHfWT
         6ai338FyFCs3a+LhOLuAcpwCEWeX6HRDjf9ZuE4mjtQxm9zrvgTSJnurX5lebJXa87Kg
         lWaaZHR5p4g9kcO+O1f1noBtsc2o2KgWT+fNp4zTkkRxTzXuF7CEFkZy/6cd3kE6d5tL
         LIhw==
X-Gm-Message-State: AOAM532y07JHU0CKiuewbD88r8CAx7Ygeu4dv7M2LJvEaUUhozucjf9Y
        ylDftbm4RBOEeM2iVmezVKjtGuzo6lht6XL19rHZwA==
X-Google-Smtp-Source: ABdhPJyc6uzJtb5M9ErOixLBG10zJ+LXfStKPgR4mbT1jVkqtMu/Wcgy6e+0YeZGKv1K7NSx1IYk6IxUSlNpJPAqdX4=
X-Received: by 2002:a17:90a:f683:: with SMTP id cl3mr587604pjb.136.1607373485241;
 Mon, 07 Dec 2020 12:38:05 -0800 (PST)
MIME-Version: 1.0
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 7 Dec 2020 21:37:54 +0100
Message-ID: <CAAeHK+xB0cdJxTvLzRRQuKQkStF+1AN179_8RUvDrpjZy+Utyg@mail.gmail.com>
Subject: Are read-only static labels incompatible with kernel modules?
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting a crash when trying to load a module into a kernel that
uses __ro_after_init static labels, see the crash below. The label is
defined and initialized in the main kernel binary, and is used in the
module. Is this not supported?

Thanks!

====

[   15.088489] Unable to handle kernel write to read-only memory at
virtual address ffffc4faeaa81ac8
Mem abort info:
  ESR = 0x9600004f
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x0000004f
  CM = 0, WnR = 1
swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000004174b000
[ffffc4faeaa81ac8] pgd=00000000bdfff003, p4d=00000000bdfff003,
pud=00000000bdffe003, pmd=00000000bdffb003, pte=0060000041681f83
Internal error: Oops: 9600004f [#1] PREEMPT SMP
Modules linked in: test_kasan_module(+)
CPU: 1 PID: 207 Comm: insmod Not tainted 5.10.0-rc4 #11
Hardware name: linux,dummy-virt (DT)
pstate: 40400005 (nZcv daif +PAN -UAO -TCO BTYPE=--)
pc : static_key_set_linked kernel/jump_label.c:368
pc : jump_label_add_module+0x1ec/0x2dc kernel/jump_label.c:658
lr : jump_label_add_module+0x1a8/0x2dc kernel/jump_label.c:653
sp : ffff800010283ba0
x29: ffff800010283ba0 x28: f8ff0000034baac0
x27: ffffc4faeaa81000 x26: ffffc4fa92d45008
x25: fdff000002c01e00 x24: f9ff000003788c80
x23: f8ff000003788e80 x22: ffffc4faeaa81ac0
x21: ffffc4fa92d45000 x20: ffffc4fa92d45020
x19: ffffc4fa92d46000 x18: dead000000000100
x17: 000000000000003f x16: ffffc4fa92d4c000
x15: 0000000000000000 x14: 0000000000000008
x13: fefefefefefefeff x12: 0000000057d3caa9
x11: 0000000000002000 x10: ff80c4fae9791a1c
x9 : ffffc4fa92d43000 x8 : f9ff000003788c82
x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000001
x3 : 0000000000000dc0 x2 : 00000000000000fe
x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 static_key_set_linked kernel/jump_label.c:368
 jump_label_add_module+0x1ec/0x2dc kernel/jump_label.c:658
 jump_label_module_notify+0x40/0xa4 kernel/jump_label.c:736
 notifier_call_chain kernel/notifier.c:83
 notifier_call_chain_robust kernel/notifier.c:118
 blocking_notifier_call_chain_robust+0x5c/0xe8 kernel/notifier.c:302
 prepare_coming_module kernel/module.c:3854
 load_module+0x2170/0x2cb4 kernel/module.c:4005
 __do_sys_finit_module kernel/module.c:4128
 __se_sys_finit_module kernel/module.c:4105
 __arm64_sys_finit_module+0xb8/0xf4 kernel/module.c:4105
 __invoke_syscall arch/arm64/kernel/syscall.c:36
 invoke_syscall arch/arm64/kernel/syscall.c:48
 el0_svc_common+0xa0/0x178 arch/arm64/kernel/syscall.c:159
 do_el0_svc+0x24/0x80 arch/arm64/kernel/syscall.c:205
 el0_svc arch/arm64/kernel/entry-common.c:236
 el0_sync_handler+0x1f0/0x2ac arch/arm64/kernel/entry-common.c:254
 el0_sync+0x190/0x1c0 arch/arm64/kernel/entry.S:740
Code: f94006c8 92400108 aa180108 b27f0108 (f90006c8)
---[ end trace 6f43f632dca3b2e8 ]---
