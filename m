Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E102EB79F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhAFBax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:30:53 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:40719 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbhAFBax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:30:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609896629; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ETA3clmAvn/B/mpBCmmAdxyVPaH7nyP6YvdiUhf6Ljs=; b=xV+ItI1qHDX1XR4zYZGyE/2XcQrs27pLxjunkt7jnYshS4/5ruy+gTiTt0gL9kksxPhkavwA
 9UglbbDLnzq1AEFjhs0ZzdVzIdcqYWYN/JmmaVArcBl5hhztL9sgqhjz3V/FRwBD6bSZ2IDQ
 WuNTl7XAO6P+eR1RaqkaKETNKJk=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5ff512ace2332e083aa30f83 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 06 Jan 2021 01:30:20
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1FE2EC43461; Wed,  6 Jan 2021 01:30:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-014.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29F53C433C6;
        Wed,  6 Jan 2021 01:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29F53C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Subject: [PATCH 1/1] arm64: make section size configurable for memory hotplug
Date:   Tue,  5 Jan 2021 17:28:46 -0800
Message-Id: <66f79b0c06602c22df4da8ff4a5c2b97c9275250.1609895500.git.sudaraja@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1609895500.git.sudaraja@codeaurora.org>
References: <cover.1609895500.git.sudaraja@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on arm64, memory section size is hard-coded to 1GB.
Make this configurable if memory-hotplug is enabled, to support
more finer granularity for hotplug-able memory.

Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
---
 arch/arm64/Kconfig                 | 11 +++++++++++
 arch/arm64/include/asm/sparsemem.h |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..34124eee65da 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -294,6 +294,17 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 config SMP
 	def_bool y
 
+config HOTPLUG_SIZE_BITS
+	int "Memory hotplug block size(29 => 512MB 30 => 1GB)"
+	depends on SPARSEMEM
+	depends on MEMORY_HOTPLUG
+	range 28 30
+	default 30
+	help
+	 Selects granularity of hotplug memory. Block size for
+	 memory hotplug is represent as a power of 2.
+	 If unsure, stick with default value.
+
 config KERNEL_MODE_NEON
 	def_bool y
 
diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 1f43fcc79738..3d5310f3aad5 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -7,7 +7,11 @@
 
 #ifdef CONFIG_SPARSEMEM
 #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
+#ifndef CONFIG_MEMORY_HOTPLUG
 #define SECTION_SIZE_BITS	30
+#else
+#define SECTION_SIZE_BITS	CONFIG_HOTPLUG_SIZE_BITS
+#endif
 #endif
 
 #endif
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

