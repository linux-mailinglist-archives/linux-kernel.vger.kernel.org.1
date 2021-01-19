Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA96A2FB783
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405065AbhASLCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:02:19 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:44945 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404887AbhASK4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:56:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UMEz1Js_1611053711;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UMEz1Js_1611053711)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Jan 2021 18:55:19 +0800
From:   Liguang Zhang <zhangliguang@linux.alibaba.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, gustavoars@kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liguang Zhang <zhangliguang@linux.alibaba.com>
Subject: [PATCH] arm64/cpuinfo: Show right CPU architecture information
Date:   Tue, 19 Jan 2021 18:55:10 +0800
Message-Id: <20210119105510.27836-1-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU architecture is assigned to be a fixed value, it should be obtained
from midr register.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 arch/arm64/kernel/cpuinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 77605aec25fe..0bd11e0fe9f2 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -191,7 +191,7 @@ static int c_show(struct seq_file *m, void *v)
 
 		seq_printf(m, "CPU implementer\t: 0x%02x\n",
 			   MIDR_IMPLEMENTOR(midr));
-		seq_printf(m, "CPU architecture: 8\n");
+		seq_printf(m, "CPU architecture: %d\n", MIDR_ARCHITECTURE(midr));
 		seq_printf(m, "CPU variant\t: 0x%x\n", MIDR_VARIANT(midr));
 		seq_printf(m, "CPU part\t: 0x%03x\n", MIDR_PARTNUM(midr));
 		seq_printf(m, "CPU revision\t: %d\n\n", MIDR_REVISION(midr));
-- 
2.19.1.6.gb485710b

