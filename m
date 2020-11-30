Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80DB2C8BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgK3Rt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:49:29 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:34822 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729251AbgK3Rt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:49:29 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0UH3N1OB_1606758525;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UH3N1OB_1606758525)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Dec 2020 01:48:47 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, shawnguo@kernel.org
Cc:     vkoul@kernel.org, geert+renesas@glider.be, Anson.Huang@nxp.com,
        michael@walle.cc, krzk@kernel.org, olof@lixom.net,
        vincenzo.frascino@arm.com, ardb@kernel.org, masahiroy@kernel.org,
        gshan@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64:msr: Enable MSR ARM driver
Date:   Tue,  1 Dec 2020 01:48:33 +0800
Message-Id: <20201130174833.41315-4-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, MSR-ARM is compiled as a module.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5cfe3cf..952cf6a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1092,3 +1092,4 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 CONFIG_MEMTEST=y
+CONFIG_ARM64_MSR=m
-- 
1.8.3.1

