Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD832A5746
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732826AbgKCVk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:40:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40208 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732749AbgKCVk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:40:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id 33so9190819wrl.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 13:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4fT2E7MYhDKFaFabaGASL5b/mrY20HfSgTKAJK4rWnU=;
        b=qNegZusKbfWwGTptvr5qNc9hx59P+0q2XGM/S+wlMedgU+CgKFK5Q5PNfDrNZUXo04
         /VDl+QaeE8gnwQ3+l/vJpXrZ42tjj5C0GM1+A+NeBhLpqMN+UNN6kRpTV/Wp12G49XtR
         amrJShZdE6di689DkQGveQ+QbUl0QCkz9zpa1/Es10viX1H6LZgOIWhLlbijAHIz1zGT
         Gvypp/n4ukkabYiiBMBVMKp2GKuHuAgFXHsCQkL1gmottHbkOtemwYZ2th9ZphN6fib8
         PmReZR80cn1L4zEx8S/M73H+27Rt9XF7ptSZn7NTG0pGY4RDO0juA5jNSvn/EhSqzaZB
         UnzQ==
X-Gm-Message-State: AOAM533UjjrN3w24fw6L1qYwUcAMcv+lOU+UfG8J/8CQLcErel34rCYA
        3LW8Zimv16vj3FB2Bb347dKHzMCWRoXKshVP
X-Google-Smtp-Source: ABdhPJyFCQ29g8Z00bdzHkGjTrJrBdPhPbJB2kV3LtANKdOKOoCqkNBy8EJ//MbPvME9Q1XBeI7F8w==
X-Received: by 2002:adf:f181:: with SMTP id h1mr29173427wro.374.1604439653995;
        Tue, 03 Nov 2020 13:40:53 -0800 (PST)
Received: from msft-t490s.teknoraver.net (net-5-95-179-145.cust.vodafonedsl.it. [5.95.179.145])
        by smtp.gmail.com with ESMTPSA id o63sm84450wmo.2.2020.11.03.13.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 13:40:53 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>, Petr Mladek <pmladek@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Robin Holt <robinmholt@gmail.com>,
        Fabian Frederick <fabf@skynet.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 2/3] reboot: fix overflow parsing reboot cpu number
Date:   Tue,  3 Nov 2020 22:40:24 +0100
Message-Id: <20201103214025.116799-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103214025.116799-1-mcroce@linux.microsoft.com>
References: <20201103214025.116799-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Limit the CPU number to num_possible_cpus(), because setting it
to a value lower than INT_MAX but higher than NR_CPUS produces the
following error on reboot and shutdown:

    BUG: unable to handle page fault for address: ffffffff90ab1bb0
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 1c09067 P4D 1c09067 PUD 1c0a063 PMD 0
    Oops: 0000 [#1] SMP
    CPU: 1 PID: 1 Comm: systemd-shutdow Not tainted 5.9.0-rc8-kvm #110
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
    RIP: 0010:migrate_to_reboot_cpu+0xe/0x60
    Code: ea ea 00 48 89 fa 48 c7 c7 30 57 f1 81 e9 fa ef ff ff 66 2e 0f 1f 84 00 00 00 00 00 53 8b 1d d5 ea ea 00 e8 14 33 fe ff 89 da <48> 0f a3 15 ea fc bd 00 48 89 d0 73 29 89 c2 c1 e8 06 65 48 8b 3c
    RSP: 0018:ffffc90000013e08 EFLAGS: 00010246
    RAX: ffff88801f0a0000 RBX: 0000000077359400 RCX: 0000000000000000
    RDX: 0000000077359400 RSI: 0000000000000002 RDI: ffffffff81c199e0
    RBP: ffffffff81c1e3c0 R08: ffff88801f41f000 R09: ffffffff81c1e348
    R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
    R13: 00007f32bedf8830 R14: 00000000fee1dead R15: 0000000000000000
    FS:  00007f32bedf8980(0000) GS:ffff88801f480000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: ffffffff90ab1bb0 CR3: 000000001d057000 CR4: 00000000000006a0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    Call Trace:
    __do_sys_reboot.cold+0x34/0x5b
    ? vfs_writev+0x92/0xc0
    ? do_writev+0x52/0xd0
    do_syscall_64+0x2d/0x40
    entry_SYSCALL_64_after_hwframe+0x44/0xa9
    RIP: 0033:0x7f32bfaaecd3
    Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 89 81 0c 00 f7 d8
    RSP: 002b:00007fff6265fb58 EFLAGS: 00000202 ORIG_RAX: 00000000000000a9
    RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f32bfaaecd3
    RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
    RBP: 0000000000000000 R08: 0000000000008020 R09: 00007fff6265ef60
    R10: 00007f32bedf8830 R11: 0000000000000202 R12: 0000000000000000
    R13: 0000557bba2c51c0 R14: 0000000000000000 R15: 00007fff6265fbc8
    CR2: ffffffff90ab1bb0
    ---[ end trace b813e80157136563 ]---
    RIP: 0010:migrate_to_reboot_cpu+0xe/0x60
    Code: ea ea 00 48 89 fa 48 c7 c7 30 57 f1 81 e9 fa ef ff ff 66 2e 0f 1f 84 00 00 00 00 00 53 8b 1d d5 ea ea 00 e8 14 33 fe ff 89 da <48> 0f a3 15 ea fc bd 00 48 89 d0 73 29 89 c2 c1 e8 06 65 48 8b 3c
    RSP: 0018:ffffc90000013e08 EFLAGS: 00010246
    RAX: ffff88801f0a0000 RBX: 0000000077359400 RCX: 0000000000000000
    RDX: 0000000077359400 RSI: 0000000000000002 RDI: ffffffff81c199e0
    RBP: ffffffff81c1e3c0 R08: ffff88801f41f000 R09: ffffffff81c1e348
    R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
    R13: 00007f32bedf8830 R14: 00000000fee1dead R15: 0000000000000000
    FS:  00007f32bedf8980(0000) GS:ffff88801f480000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: ffffffff90ab1bb0 CR3: 000000001d057000 CR4: 00000000000006a0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
    Kernel Offset: disabled
    ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---

Fixes: 1b3a5d02ee07 ("reboot: move arch/x86 reboot= handling to generic kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 kernel/reboot.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 8fbba433725e..af6f23d8bea1 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -558,6 +558,13 @@ static int __init reboot_setup(char *str)
 				reboot_cpu = simple_strtoul(str+3, NULL, 0);
 			else
 				*mode = REBOOT_SOFT;
+			if (reboot_cpu >= num_possible_cpus()) {
+				pr_err("Ignoring the CPU number in reboot= option. "
+				       "CPU %d exceeds possible cpu number %d\n",
+				       reboot_cpu, num_possible_cpus());
+				reboot_cpu = 0;
+				break;
+			}
 			break;
 
 		case 'g':
-- 
2.28.0

