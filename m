Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CD82F8CDB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 11:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbhAPKnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 05:43:50 -0500
Received: from mail.thundersoft.com ([114.242.213.61]:43149 "EHLO
        mail2.thundersoft.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbhAPKnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 05:43:49 -0500
Received: from localhost.localdomain (unknown [192.168.8.81])
        by mail2.thundersoft.com (Postfix) with ESMTPSA id 5B677E6096B;
        Sat, 16 Jan 2021 18:43:32 +0800 (CST)
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
Subject: [PATCH v2 0/2] Make it possible to reserve memory on 64bit platform
Date:   Sat, 16 Jan 2021 02:41:11 -0800
Message-Id: <1610793673-64008-1-git-send-email-zhaowei1102@thundersoft.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to reserve some memory to save logs incase that Android panic or hang and then
I can read the logs from QNX side from the memory reserved before on the Qualcomm 8155 hypervisor platform,
and I find the "reserve=" parameter only support 32bit,so I made some change and send these patches.

testcase:
	I test on the qemu with some cmdline like[qemu-system-x86_64 -kernel linux-next/arch/x86_64/boot/bzImage
	-hda ubuntu-system.ext4 -append "root=/dev/sda init=/bin/bash console=ttyS0 reserve=0x180000000,0x123456"
	-nographic]	and check the /proc/iomem with 180000000-180123455 : reserved.
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

