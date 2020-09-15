Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A41426B7B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgIPA1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:27:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12291 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726787AbgIOOHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:07:20 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 29262AC767A3A43DF749;
        Tue, 15 Sep 2020 21:19:13 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 21:19:05 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        patches-armlinux <patches@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: [PATCH v2 0/2] ARM: support PHYS_OFFSET minimum aligned at 64KiB boundary
Date:   Tue, 15 Sep 2020 21:16:13 +0800
Message-ID: <20200915131615.3138-1-thunder.leizhen@huawei.com>
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

 arch/arm/Kconfig              | 18 +++++++++++++++++-
 arch/arm/include/asm/memory.h | 16 +++++++++++++---
 arch/arm/kernel/head.S        | 31 ++++++++++++++++++++++---------
 3 files changed, 52 insertions(+), 13 deletions(-)

-- 
1.8.3


