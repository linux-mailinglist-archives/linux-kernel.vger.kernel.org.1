Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49ECE2A5F38
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgKDIRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:17:55 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47]:64471 "EHLO
        esa1.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbgKDIRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:17:52 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2020 03:17:52 EST
IronPort-SDR: VK6qtypJl4kOt9mmetILz4DvPTk28+dhVSBdnXcwOsVwGqsWJoKTKccfTF1mtgtINWzo5uQbLP
 o9U5skKvXVuuq69L2Et7YtdnNGWxEvlOKYDvCt5P0pRRZ8Rt2gQ6PxAEwgnu8IohguRJBg6um9
 K41Agz1LWckxrzvwYA0rC9aiWzfRKLi7kYx2UrbslKHpGRVpBeG8y2CHvw972Ae7jZs8hhQBwh
 TMFFX7fcO5DquFunW2JzEw5IPgUA8kukkc24zUkFVHEV6HrinDTZ8FAhFxpXZtyY78Lm5+4WcD
 ZQ0=
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="2258702"
X-IronPort-AV: E=Sophos;i="5.77,450,1596466800"; 
   d="scan'208";a="2258702"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Nov 2020 17:10:44 +0900
Received: from yt-mxoi1.gw.nic.fujitsu.com (unknown [192.168.83.48])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id A8363A80C0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 17:10:42 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id A248FAC0144
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 17:10:41 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1016)
        id 46F05B9A9; Wed,  4 Nov 2020 17:08:03 +0900 (JST)
From:   Yuichi Ito <ito-yuichi@fujitsu.com>
To:     maz@kernel.org, sumit.garg@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yuichi Ito <ito-yuichi@fujitsu.com>
Subject: [PATCH v2 3/3] arm64: smp: Disable priority masking when NMI is enable on PSR.I section
Date:   Wed,  4 Nov 2020 17:05:39 +0900
Message-Id: <20201104080539.3205889-4-ito-yuichi@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104080539.3205889-1-ito-yuichi@fujitsu.com>
References: <20201104080539.3205889-1-ito-yuichi@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be prohibitted to use priority masking in NMI context.

Using local_irq_disable() under the above conditions causes a WARNING.
Then, there will be also a mismatch between the PSR.I values and PMR GIC_PRIO_PSR_I_SET.

Signed-off-by: Yuichi Ito <ito-yuichi@fujitsu.com>
---
 arch/arm64/kernel/smp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index fd59bc7..3c49f06 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -872,7 +872,9 @@ static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 
 	atomic_dec(&waiting_for_crash_ipi);
 
-	local_irq_disable();
+	if(!in_nmi())
+		local_irq_disable();
+
 	sdei_mask_local_cpu();
 
 	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
-- 
1.8.3.1

