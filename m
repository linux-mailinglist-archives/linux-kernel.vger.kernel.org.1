Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F363726BA59
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgIPCuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:50:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbgIPCt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:49:59 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 92173D65FF03895370B7;
        Wed, 16 Sep 2020 10:49:57 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 10:49:49 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: [PATCH v3 0/2] ARM: support PHYS_OFFSET minimum aligned at 64KiB boundary
Date:   Wed, 16 Sep 2020 10:49:25 +0800
Message-ID: <20200916024927.3191-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 --> v3:
1. cancel send to "patches@armlinux.org.uk", the patches should have been reviewed first.
2. drop the "default n" of the configuration option ARM_PATCH_PHYS_VIRT_RADICAL.
3. remove an unnecessary cast: below (unsigned long). "t" is already unsigned long.
   __pv_stub((unsigned long) t, t, "sub", __PV_BITS_23_16);


v1 --> v2:
Nothing changed, but add mail list: patches@armlinux.org.uk

v1:
Currently, only support the kernels where the base of physical memory is
at a 16MiB boundary. Because the add/sub instructions only contains 8bits
unrotated value. But we can use one more "add/sub" instructions to handle
bits 23-16, to support PHYS_OFFSET minimum aligned at 64KiB boundary.

This function is required at least by some Huawei boards, such as Hi1380
board. Becuase the kernel Image is loaded at 2MiB boundary.

Zhen Lei (2):
  ARM: fix trivial comments in head.S
  ARM: support PHYS_OFFSET minimum aligned at 64KiB boundary

 arch/arm/Kconfig              | 17 ++++++++++++++++-
 arch/arm/include/asm/memory.h | 16 +++++++++++++---
 arch/arm/kernel/head.S        | 31 ++++++++++++++++++++++---------
 3 files changed, 51 insertions(+), 13 deletions(-)

-- 
1.8.3


