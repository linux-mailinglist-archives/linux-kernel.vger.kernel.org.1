Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C463E2AD941
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbgKJOuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgKJOuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:50:10 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914F2C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:50:10 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id qeq52300F4C55Sk06eq5dC; Tue, 10 Nov 2020 15:50:08 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcUyD-001CZB-3h; Tue, 10 Nov 2020 15:50:05 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcUyC-00DlPq-Fd; Tue, 10 Nov 2020 15:50:04 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ASoC: intel: SND_SOC_INTEL_KEEMBAY should depend on ARCH_KEEMBAY
Date:   Tue, 10 Nov 2020 15:50:01 +0100
Message-Id: <20201110145001.3280479-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel Keem Bay audio module is only present on Intel Keem Bay SoCs.
Hence add a dependency on ARCH_KEEMBAY, to prevent asking the user about
this driver when configuring a kernel without Intel Keem Bay platform
support.

Fixes: c544912bcc2dc806 ("ASoC: Intel: Add makefiles and kconfig changes for KeemBay")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index a5b446d5af19fc2d..c1bf69a0bcfe18c3 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -198,7 +198,7 @@ endif ## SND_SOC_INTEL_SST_TOPLEVEL || SND_SOC_SOF_INTEL_TOPLEVEL
 
 config SND_SOC_INTEL_KEEMBAY
 	tristate "Keembay Platforms"
-	depends on ARM64 || COMPILE_TEST
+	depends on ARCH_KEEMBAY || COMPILE_TEST
 	depends on COMMON_CLK
 	help
 	  If you have a Intel Keembay platform then enable this option
-- 
2.25.1

