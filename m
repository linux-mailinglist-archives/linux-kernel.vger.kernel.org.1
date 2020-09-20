Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281632711AE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 03:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgITBfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 21:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgITBfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 21:35:39 -0400
X-Greylist: delayed 1916 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Sep 2020 18:35:39 PDT
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612A8C061755
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 18:35:39 -0700 (PDT)
Received: from [2400:4160:1877:2b00:4503:de6f:d4c3:660f] (helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1kJnlQ-0003OW-Fh; Sun, 20 Sep 2020 01:03:39 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <glandium@goemon>)
        id 1kJnlK-0002rY-5p; Sun, 20 Sep 2020 10:03:30 +0900
From:   Mike Hommey <mh@glandium.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Mike Hommey <mh@glandium.org>
Subject: [PATCH] x86/boot: Delay BSP init until after FPU initialization
Date:   Sun, 20 Sep 2020 10:03:10 +0900
Message-Id: <20200920010310.10961-1-mh@glandium.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RDNS_NONE,SPF_FAIL,SPF_HELO_FAIL autolearn=disabled version=3.4.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FPU initialization handles the clearcpuid command line argument. If it
comes after BSP init, clearcpuid cannot be used to disable features that
trigger some parts of the BSP init code.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 arch/x86/kernel/cpu/common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

I was trying to use clearcpuid=440 to disable X86_FEATURES_AMD_SSBD to
reproduce the behavior that happens on Zen/Zen+ on a Zen2 machine, but
that didn't work because the command line is handled after the setup for
X86_FEATURE_LS_CFG_SSBD.

I tought about either moving the command line handling earlier, but it
seems there wasn't a specific reason for BSP init being earlier than FPU
initialization so I went with reordering those instead.

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c5d6f17d9b9d..c3bbca91a14b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1261,9 +1261,6 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 		c->cpu_index = 0;
 		filter_cpuid_features(c, false);
-
-		if (this_cpu->c_bsp_init)
-			this_cpu->c_bsp_init(c);
 	} else {
 		setup_clear_cpu_cap(X86_FEATURE_CPUID);
 	}
@@ -1276,6 +1273,10 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	fpu__init_system(c);
 
+	if (have_cpuid_p()) {
+		if (this_cpu->c_bsp_init)
+			this_cpu->c_bsp_init(c);
+	}
 #ifdef CONFIG_X86_32
 	/*
 	 * Regardless of whether PCID is enumerated, the SDM says
-- 
2.28.0

