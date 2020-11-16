Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C522B4BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbgKPQ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732311AbgKPQ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:58:55 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEBEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:58:54 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id i17so19841780ljd.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGChrTBrZJsggpW03AOkpiiphcJ8H+xELnUURmwatiM=;
        b=uvgorTVbXz68LTrFGdBb+P3In3xnhYXxO8W9iic7sfuvP260E9h7dtmEliaNqZQFdz
         Q066ldcvppN/l3MFaGwTCh4OjOVcRlFPAl1QxN/tRlx6WTxNDHQw3GuxyC6DaCN1h9Bd
         4zihe+D5qYU2rkDcxtv2r2ILEuZlOeMz+DK0Iid3gkUCq1QdYTNt6pZW01dTtmZ0oF5E
         PsaDZ+jodcwR6yO8R4ChhOuU+fZfZDaKtu4IsJ+rYxQ8RdSB8xrAH+9GSy5oGxFxYWi4
         tDfjXybarRT170Nq7jmW33F3G7tYAZJQuHr7FTyxJ6WRnhhJ+/PJpVcBZUARDkv+irxQ
         ekpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGChrTBrZJsggpW03AOkpiiphcJ8H+xELnUURmwatiM=;
        b=W2pjJply8wwXiQmoIiLi+6HUgGsYAlPn79auoIgAwIvm52isVTB+nthqtv6za091TW
         BWtam+sZNHjDTMWIF4MDYpFlzqidxNiCODkAVFxeSGmjWJxGpF5EiOgq90f1Tnvog8ZF
         aEG/WuWX+a4+B45SQJttJInaQQdmBgfAhQ/wVHMyUcZ0s0biwkbtL010J+xcBpUSV9na
         LMANan2bsROXGMfNEDf8Kw0UnTPupCMdynMzAooqCE93kcvW41KS4NeTzJuyNWyGFil5
         UReoIzDgnK8OmSzxMSoE4E5d6bntU6KsqCd1QMberOeFE8CHtj9aWxo3MvbnTyJ3bRg+
         K7gA==
X-Gm-Message-State: AOAM530Xeu4K8/seg+LHOoecfY6rohCUMf9u+K2AQP59ZNW/B8arzUzz
        oupjpMAs9ssqqQgcxm2B3Cdjr5UsQkKGYg==
X-Google-Smtp-Source: ABdhPJyWs/NyvGjAvFhUiBPkuGr5OOPK4zX9FnOwRTsMwiae0puYbe3ghQnECKSPRirdQauYQH2Iow==
X-Received: by 2002:a2e:b0d3:: with SMTP id g19mr117180ljl.19.1605545933485;
        Mon, 16 Nov 2020 08:58:53 -0800 (PST)
Received: from localhost.localdomain ([2.92.120.24])
        by smtp.googlemail.com with ESMTPSA id m6sm201967ljp.70.2020.11.16.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:58:52 -0800 (PST)
From:   Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>,
        Evgeny Boger <boger@wirenboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: mxs: Add serial number support for i.MX23, i.MX28 SoCs
Date:   Mon, 16 Nov 2020 19:58:26 +0300
Message-Id: <20201116165826.51570-1-ivan.zaentsev@wirenboard.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX23 and i.MX28 SoCs unique identifiers are factory-programmed
in On-Chip OTP memory. i.MX28's 64-bit unique id is in
HW_OCOTP_OPS2:HW_OCOTP_OPS3 (see MCIMX28 Ref. Man., sec. 20.4.22-23).

i.MX23 provides 32-bit long unique id in HW_OCOTP_OPS3.
Though not clearly documented, there is a clue in sec. 35.9.3.

The unique id is reported in /sys/devices/soc0/serial_number
and in /proc/cpuinfo

Signed-off-by: Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
Suggested-by: Evgeny Boger <boger@wirenboard.com>
---
Changes in v2:

1. Sort #includes aphabetically.
2. Use tabs instead of spaces for indent.
3. Remove unnecessary newline.

 arch/arm/mach-mxs/mach-mxs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index c109f47e9cbc..25c9d184fa4c 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -22,6 +22,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
+#include <asm/system_info.h>
 #include <asm/system_misc.h>
 
 #include "pm.h"
@@ -51,6 +52,9 @@
 #define MXS_CLR_ADDR		0x8
 #define MXS_TOG_ADDR		0xc
 
+#define HW_OCOTP_OPS2		19	/* offset 0x150 */
+#define HW_OCOTP_OPS3		20	/* offset 0x160 */
+
 static u32 chipid;
 static u32 socid;
 
@@ -379,6 +383,8 @@ static void __init mxs_machine_init(void)
 	struct device *parent;
 	struct soc_device *soc_dev;
 	struct soc_device_attribute *soc_dev_attr;
+	u64 soc_uid = 0;
+	const u32 *ocotp = mxs_get_ocotp();
 	int ret;
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
@@ -394,8 +400,21 @@ static void __init mxs_machine_init(void)
 	soc_dev_attr->soc_id = mxs_get_soc_id();
 	soc_dev_attr->revision = mxs_get_revision();
 
+	if (socid == HW_DIGCTL_CHIPID_MX23) {
+		soc_uid = system_serial_low = ocotp[HW_OCOTP_OPS3];
+	} else if (socid == HW_DIGCTL_CHIPID_MX28) {
+		soc_uid = system_serial_high = ocotp[HW_OCOTP_OPS2];
+		soc_uid <<= 32;
+		system_serial_low = ocotp[HW_OCOTP_OPS3];
+		soc_uid |= system_serial_low;
+	}
+
+	if (soc_uid)
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->serial_number);
 		kfree(soc_dev_attr->revision);
 		kfree(soc_dev_attr);
 		return;
-- 
2.25.1

