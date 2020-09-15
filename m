Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D3269BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIOByl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:54:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42052 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbgIOByk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:54:40 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E12E2864617F7E237BD5;
        Tue, 15 Sep 2020 09:54:37 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 09:54:29 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: [PATCH 0/2] ARM: support PHYS_OFFSET minimum aligned at 64KiB boundary
Date:   Tue, 15 Sep 2020 09:52:02 +0800
Message-ID: <20200915015204.2971-1-thunder.leizhen@huawei.com>
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


