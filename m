Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A8C300807
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 17:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbhAVP7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:59:12 -0500
Received: from mail.thundersoft.com ([114.242.213.35]:40304 "EHLO
        mail1.thundersoft.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbhAVP5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:57:12 -0500
Received: from localhost.localdomain (unknown [192.168.8.82])
        by mail1.thundersoft.com (Postfix) with ESMTPSA id 231A017A3BF5;
        Fri, 22 Jan 2021 23:56:23 +0800 (CST)
From:   Wesley Zhao <zhaowei1102@thundersoft.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, keescook@chromium.org,
        tglx@linutronix.de, kerneldev@karsmulder.nl, nivedita@alum.mit.edu,
        joe@perches.com, gpiccoli@canonical.com, aquini@redhat.com,
        gustavoars@kernel.org, zhaowei1102@thundersoft.com,
        ojeda@kernel.org, ndesaulniers@gooogle.com,
        linux-kernel@vger.kernel.org, david@redhat.com,
        dan.j.williams@intel.com, guohanjun@huawei.com,
        mchehab+huawei@kernel.org
Subject: [PATCH v3 0/2] Make it possible to reserve memory on 64bit platform
Date:   Fri, 22 Jan 2021 07:55:35 -0800
Message-Id: <1611330937-22654-1-git-send-email-zhaowei1102@thundersoft.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to reserve some memory to save logs incase that Android panic or hang and then
I can read the logs from QNX side from the memory reserved before on the Qualcomm 8155 hypervisor platform,
and I find the "reserve=" parameter only support 32bit,so I made some change and send these patches.

I run the cmdline_kunit.c and got these:
[    1.663048] 1..1
[    1.663107]     # Subtest: cmdline
[    1.663145]     1..3
[    1.663795]     ok 1 - cmdline_test_noint
[    1.664139]     ok 2 - cmdline_test_lead_int
[    1.664553]     ok 3 - cmdline_test_tail_int
[    1.664788] ok 1 - cmdline

Additionaly:
	I test on the qemu with some cmdline like[qemu-system-x86_64 -kernel linux-next/arch/x86_64/boot/bzImage
	-hda ubuntu-system.ext4 -append "root=/dev/sda init=/bin/bash console=ttyS0 reserve=0x180000000,0x123456"
	-nographic] and check the /proc/iomem with 180000000-180123455 : reserved.
	And some other tests with the get_option with the parameter(-12345678) and so on


Wesley Zhao (2):
  lib/cmdline: add new function get_option_ull()
  resource: Make it possible to reserve memory on 64bit platform

 include/linux/kernel.h |  2 ++
 kernel/resource.c      |  6 ++--
 lib/cmdline.c          | 94 ++++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 85 insertions(+), 17 deletions(-)

-- 
2.7.4

