Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3251E4FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 22:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgE0Uxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 16:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgE0Uxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:53:50 -0400
Received: from localhost.localdomain (unknown [194.230.155.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A95620899;
        Wed, 27 May 2020 20:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590612830;
        bh=hLSGZEQWdxHnGb3NCznVMrshFsU5QAvYHIqnrYcr84c=;
        h=From:To:Cc:Subject:Date:From;
        b=2p+OzkZ7KrA7OzseKO3cDoyHNMEgzbhNWnZwV+vC/BGjhqCAnnTDUcsWjtYb8Siyu
         1hAW7RIIhMcyNgj11SaLZRG5Zwe8PNBgKeeTFEYsQMOsH2SoNDjjzgwq2RctW+oCuF
         Wzc3i6lBAOMM2d2Z0G/tIlY7Qny+hRFkaT4A53Q0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH v2] sh: sh4a: Bring back tmu3_device early device
Date:   Wed, 27 May 2020 22:53:41 +0200
Message-Id: <20200527205341.26232-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1399c195ef50 ("sh: Switch to new style TMU device") converted
tmu3_device platform device to new style of platform data but removed it
from sh7786_early_devices array effectively removing last three timers
and causing a warning:

    arch/sh/kernel/cpu/sh4a/setup-sh7786.c:243:31:
        warning: ‘tmu3_device’ defined but not used [-Wunused-variable]

Fixes: 1399c195ef50 ("sh: Switch to new style TMU device")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---

Changes since v1:
1. Add tmu3_device to early device list, as suggested by Geert.
2. Add Fixes tag.
---
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index 4b0db8259e3d..74620f30b19b 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -391,6 +391,7 @@ static struct platform_device *sh7786_early_devices[] __initdata = {
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
+	&tmu3_device,
 };
 
 static struct platform_device *sh7786_devices[] __initdata = {
-- 
2.17.1

