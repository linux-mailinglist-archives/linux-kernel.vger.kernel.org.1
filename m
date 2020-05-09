Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14291CC1E2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 15:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgEINtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 09:49:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4384 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727863AbgEINtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 09:49:13 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 156EF275F844D64B3B40;
        Sat,  9 May 2020 21:49:09 +0800 (CST)
Received: from euler.huawei.com (10.175.101.6) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 21:49:07 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <daniel.thompson@linaro.org>, <jason.wessel@windriver.com>,
        <dianders@chromium.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
        <mhiramat@kernel.org>, <davem@davemloft.net>, <will@kernel.org>,
        <catalin.marinas@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liwei1412@163.com>
Subject: [PATCH 0/4] arm64: kgdb/kdb: Fix single-step debugging issues
Date:   Sun, 10 May 2020 05:41:55 +0800
Message-ID: <20200509214159.19680-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to fix several issues of single-step debugging
in kgdb/kdb on arm64.

It seems that these issues have been shelved a very long time,
but i still hope to solve them, as the single-step debugging
is an useful feature.

Note:
Based on patch "arm64: cacheflush: Fix KGDB trap detection",
https://www.spinics.net/lists/arm-kernel/msg803741.html

Wei Li (4):
  arm64: kgdb: Fix single-step exception handling oops
  arm64: Extract kprobes_save_local_irqflag() and
    kprobes_restore_local_irqflag()
  arm64: kgdb: Fix single-stepping into the irq handler wrongly
  arm64: kgdb: Set PSTATE.SS to 1 to reenable single-step

 arch/arm64/include/asm/debug-monitors.h |  6 ++++++
 arch/arm64/kernel/debug-monitors.c      | 28 ++++++++++++++++++++++++-
 arch/arm64/kernel/kgdb.c                | 16 +++++++++++---
 arch/arm64/kernel/probes/kprobes.c      | 28 ++-----------------------
 4 files changed, 48 insertions(+), 30 deletions(-)

-- 
2.17.1

