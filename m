Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554392F41D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbhAMCfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:35:20 -0500
Received: from atcsqr.andestech.com ([60.248.187.195]:46149 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbhAMCfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:35:20 -0500
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 10D2RaEO042340
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 10:27:36 +0800 (GMT-8)
        (envelope-from nylon7@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 10D2Pffl039664;
        Wed, 13 Jan 2021 10:25:41 +0800 (GMT-8)
        (envelope-from nylon7@andestech.com)
Received: from atcfdc88.andestech.com (10.0.15.120) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.487.0; Wed, 13 Jan 2021
 10:28:24 +0800
From:   Nylon Chen <nylon7@andestech.com>
To:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <kasan-dev@googlegroups.com>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <dvyukov@google.com>, <glider@google.com>,
        <aryabinin@virtuozzo.com>, <alankao@andestech.com>,
        <nickhu@andestech.com>, <nylon7@andestech.com>,
        <nylon7717@gmail.com>
Subject: [PATCH 0/1] kasan: support backing vmalloc space for riscv
Date:   Wed, 13 Jan 2021 10:28:21 +0800
Message-ID: <20210113022822.9230-1-nylon7@andestech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.120]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 10D2Pffl039664
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is support KASAN_VMALLOC in riscv.

We reference x86/s390 mailing list discussion for our implement.
https://lwn.net/Articles/797950/

It's also pass `vmalloc-out-of-bounds` of test_kasan.ko

log:
[  235.834318]     # Subtest: kasan
[  235.835190]     1..37
[  235.845238]
==================================================================
[  235.847818] BUG: KASAN: slab-out-of-bounds in
kmalloc_oob_right+0xe2/0x192 [test_kasan]
[  235.850688] Write of size 1 at addr ffffffe0075d5a7b by task
kunit_try_catch/125
[  235.852630]
[  235.853212] CPU: 0 PID: 125 Comm: kunit_try_catch Tainted: G    B
5.11.0-rc3-13940-gb0bb4cd86282-dirty #1
...
[  241.835850]
==================================================================
[1154/67143]
[  241.840884]     ok 36 - kmalloc_double_kzfree
[  241.852642]
==================================================================
[  241.857261] BUG: KASAN: vmalloc-out-of-bounds in
vmalloc_oob+0xcc/0x17c [test_kasan]
[  241.861327] Read of size 1 at addr ffffffd00407ec1c by task
kunit_try_catch/161
[  241.864525]
[  241.865200] CPU: 0 PID: 161 Comm: kunit_try_catch Tainted: G    B
5.11.0-rc3-13940-gb0bb4cd86282-dirty #1
[  241.869887] Call Trace:
[  241.870972] [<ffffffe0000052d2>] walk_stackframe+0x0/0x128
[  241.873353] [<ffffffe000abcff0>] show_stack+0x32/0x3e
[  241.875457] [<ffffffe000ac0d46>] dump_stack+0x84/0xa0
[  241.877806] [<ffffffe000188926>]
print_address_description.constprop.0+0x88/0x362
[  241.881150] [<ffffffe000188e4a>] kasan_report+0x176/0x194
[  241.883604] [<ffffffe000189390>] __asan_load1+0x42/0x4a
[  241.885897] [<ffffffdf81f9f2f4>] vmalloc_oob+0xcc/0x17c [test_kasan]
[  241.889458] [<ffffffdf81f91e8e>] kunit_try_run_case+0x80/0x11a
[kunit]
[  241.892665] [<ffffffdf81f92e16>]
kunit_generic_run_threadfn_adapter+0x2c/0x4e [kunit]
[  241.896568] [<ffffffe000034ac4>] kthread+0x206/0x222
[  241.899219] [<ffffffe00000361a>] ret_from_exception+0x0/0xc
[  241.901700]
[  241.902497]
[  241.903257] Memory state around the buggy address:
[  241.905430]  ffffffd00407eb00: 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
[  241.908661]  ffffffd00407eb80: 00 00 00 00 00 00 00 f8 f8 f8 f8 f8 f8
f8 f8 f8
[  241.911841] >ffffffd00407ec00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
f8 f8 f8
[  241.915037]                             ^
[  241.916053]  ffffffd00407ec80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
f8 f8 f8
[  241.919272]  ffffffd00407ed00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
f8 f8 f8
[  241.922417]
==================================================================
[  242.073698]     ok 37 - vmalloc_oob


Nylon Chen (1):
  riscv/kasan: add KASAN_VMALLOC support

 arch/riscv/Kconfig         |  1 +
 arch/riscv/mm/kasan_init.c | 66 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

-- 
2.17.1

