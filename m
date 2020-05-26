Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217061CCFE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 04:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgEKCxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 22:53:09 -0400
Received: from mail1.windriver.com ([147.11.146.13]:37741 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgEKCxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 22:53:08 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 04B2qoTX002335
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sun, 10 May 2020 19:52:50 -0700 (PDT)
Received: from pek-lpggp2 (128.224.153.75) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0; Sun, 10 May 2020
 19:52:38 -0700
Received: by pek-lpggp2 (Postfix, from userid 20544)    id 1679C724872; Mon, 11
 May 2020 10:52:07 +0800 (CST)
From:   Jiping Ma <jiping.ma2@windriver.com>
To:     <will.deacon@arm.com>, <paul.gortmaker@windriver.com>,
        <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <jiping.ma2@windriver.com>, <bruce.ashfield@gmail.com>,
        <yue.tao@windriver.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhe.he@windriver.com>
Subject: [PATCH][V3] arm64: perf: Get the wrong PC value in REGS_ABI_32 mode
Date:   Mon, 11 May 2020 10:52:07 +0800
Message-ID: <1589165527-188401-1-git-send-email-jiping.ma2@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modified the patch subject and the change description.

PC value is get from regs[15] in REGS_ABI_32 mode, but correct PC
is regs->pc(regs[PERF_REG_ARM64_PC]) in arm64 kernel, which caused
that perf can not parser the backtrace of app with dwarf mode in the 
32bit system and 64bit kernel.

Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
---
 arch/arm64/kernel/perf_regs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 0bbac61..0ef2880 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -32,6 +32,10 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	if ((u32)idx == PERF_REG_ARM64_PC)
 		return regs->pc;
 
+	if (perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32
+		&& idx == 15)
+		return regs->pc;
+
 	return regs->regs[idx];
 }
 
-- 
1.9.1

