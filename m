Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F70274807
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIVSTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:19:08 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:42584 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVSTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:19:08 -0400
Received: from [192.168.254.6] (unknown [50.46.158.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id C7FEC13C2B0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:19:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C7FEC13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1600798746;
        bh=CCzmNJTdAkXhe5umn97EkUT5UOJ+XYTs0zy3Jma/Kg0=;
        h=To:From:Subject:Date:From;
        b=KBTCyn1kTZ9PZnrfq28cnqKSbYO4sEk0Eqube9odQu0pYQpzHX7LVkO8qnJOfHEoD
         NunFsRt4D39RZngq0DxceZxTBpwnVOtZv0qI9EYTTQkw9NKrG8x2+oYMutfYH5uX+d
         66tP9dZFY2B5q7Gl/zskSqwBZpQgNlTc6bd5FA1o=
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: BUG: Invalid wait context, related to serial console?
Organization: Candela Technologies
Message-ID: <f575655b-92cf-b59f-659a-3d649a8a5713@candelatech.com>
Date:   Tue, 22 Sep 2020 11:19:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I saw this booting yesterday's 5.9.0-rc6+.  I have one small patch applied, quite unlikely
to cause any problems I think.  Platform is apu2, fedora-27 linux, with serial console attached.


[    0.624831] =============================
[    0.624831] [ BUG: Invalid wait context ]
[    0.624831] 5.9.0-rc6+ #1 Not tainted
[    0.624831] -----------------------------
[    0.624831] swapper/1/0 is trying to lock:
[    0.624831] ffffffff85523218 (&port_lock_key){....}-{3:3}, at: serial8250_console_write+0xfd/0x520
[    0.624831] other info that might help us debug this:
[    0.624831] context-{2:2}
[    0.624831] 2 locks held by swapper/1/0:
[    0.624831]  #0: ffffffff83338a60 (console_lock){+.+.}-{0:0}, at: printk+0xad/0xde
[    0.624831]  #1: ffffffff83338820 (console_owner){-...}-{0:0}, at: console_unlock+0x291/0x840
[    0.624831] stack backtrace:
[    0.624831] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0-rc6+ #1
[    0.624831] Hardware name: PC Engines APU2/APU2, BIOS 4.0.7 02/28/2017
[    0.624831] Call Trace:
[    0.624831]  dump_stack+0xae/0xe8
[    0.624831]  __lock_acquire.cold+0x1b9/0x34d
[    0.624831]  ? save_trace+0x345/0x440
[    0.624831]  ? lockdep_hardirqs_on_prepare+0x260/0x260
[    0.624831]  ? mark_lock+0x90/0xb00
[    0.624831]  lock_acquire+0x14f/0x5f0
[    0.624831]  ? serial8250_console_write+0xfd/0x520
[    0.624831]  ? lock_release+0x440/0x440
[    0.624831]  ? lockdep_hardirqs_on_prepare+0x260/0x260
[    0.624831]  ? __lock_acquire+0x85c/0x2f10
[    0.624831]  _raw_spin_lock_irqsave+0x43/0x60
[    0.624831]  ? serial8250_console_write+0xfd/0x520
[    0.624831]  serial8250_console_write+0xfd/0x520
[    0.624831]  ? serial8250_config_port+0x1630/0x1630
[    0.624831]  ? lock_downgrade+0x3a0/0x3a0
[    0.624831]  ? do_raw_spin_lock+0x114/0x1a0
[    0.624831]  ? rwlock_bug.part.0+0x50/0x50
[    0.624831]  console_unlock+0x582/0x840
[    0.624831]  ? devkmsg_open+0x170/0x170
[    0.624831]  ? do_raw_spin_unlock+0x8e/0xe0
[    0.624831]  ? printk+0xad/0xde
[    0.624831]  vprintk_emit+0x165/0x3e0
[    0.624831]  printk+0xad/0xde
[    0.624831]  ? kmsg_dump_rewind_nolock+0x54/0x54
[    0.624831]  ? lock_acquire+0x14f/0x5f0
[    0.624831]  ? do_raw_spin_unlock+0x8e/0xe0
[    0.624831]  ? do_raw_spin_unlock+0x7f/0xe0
[    0.624831]  common_interrupt+0x16c/0x180
[    0.624831]  asm_common_interrupt+0x1e/0x40
[    0.624831] RIP: 0010:start_secondary+0x1b6/0x230
[    0.624831] Code: 65 8b 3d 1d 97 f7 7e e8 48 f0 14 00 48 c7 c7 d0 d4 04 83 e8 4c 15 45 00 ff 15 76 d8 fa 01 e8 31 6f 2b 00 fb 66 0f 1f 44 00 00 <48> c7 c7 40 
33 29 83 e8 2e 15 45 00 ff 15 c8 36 1f 02 0f ae f8 bf
[    0.624831] RSP: 0000:ffff8880cda3fed8 EFLAGS: 00000202
[    0.624831] RAX: 0000000000000001 RBX: 0000000000000001 RCX: dffffc0000000000
[    0.624831] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8109fc5f
[    0.624831] RBP: 1ffff11019b47fdb R08: 0000000000000001 R09: 0000000000000001
[    0.624831] R10: ffffed101a494179 R11: 0000000000000001 R12: 00000000000f3aac
[    0.624831] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    0.624831]  ? start_secondary+0x1af/0x230
[    0.624831]  ? start_secondary+0x1af/0x230
[    0.624831]  ? set_cpu_sibling_map+0xc70/0xc70
[    0.624831]  secondary_startup_64+0xa4/0xb0
[    2.531065]  #2
[    0.624831] __common_interrupt: 2.55 No irq handler for vector
[    2.542389]  #3
[    0.624831] __common_interrupt: 3.55 No irq handler for vector


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
