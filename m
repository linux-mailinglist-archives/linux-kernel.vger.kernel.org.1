Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D532F93BE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 16:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbhAQPvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 10:51:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728499AbhAQPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 10:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610898456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S7lzl9Lt2MjVC8UQX3UTaRWTMvWQodOhj9ejnhEdfCg=;
        b=VJi7LuHdNuseibc8MhewfR6uahJlneQ0H9VPdiPpFuDlRToZpFJiktMFO2KFthwYEWVZhk
        2S24hMJPuf9PwpCthWf7P6Zo5gViTLe8WufIV9X1+jRAbV7zDm+fXJ+FlHb10X6FkS2gx8
        rfAq6yXEqk28qgK8i4lRcyX1IDq9KME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-YiYRAXsIPRGibLaIOYTprQ-1; Sun, 17 Jan 2021 10:47:33 -0500
X-MC-Unique: YiYRAXsIPRGibLaIOYTprQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 582D6107ACE4;
        Sun, 17 Jan 2021 15:47:31 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-7.ams2.redhat.com [10.36.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F9F619C44;
        Sun, 17 Jan 2021 15:47:28 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v2 4/5] ASoC: Intel: Add DMI quirk table to soc_intel_is_byt_cr()
Date:   Sun, 17 Jan 2021 16:47:16 +0100
Message-Id: <20210117154717.77969-5-hdegoede@redhat.com>
In-Reply-To: <20210117154717.77969-1-hdegoede@redhat.com>
References: <20210117154717.77969-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Bay Trail systems:
1. Use a non CR version of the Bay Trail SoC
2. Contain at least 6 interrupt resources so that the
   platform_get_resource(pdev, IORESOURCE_IRQ, 5) check to workaround
   non CR systems which list their IPC IRQ at index 0 despite being
   non CR does not work
3. Despite 1. and 2. still have their IPC IRQ at index 0 rather then 5

Add a DMI quirk table to check for the few known models with this issue,
so that the right IPC IRQ index is used on these systems.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/common/soc-intel-quirks.h | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/intel/common/soc-intel-quirks.h b/sound/soc/intel/common/soc-intel-quirks.h
index b07df3059926..a93987ab7f4d 100644
--- a/sound/soc/intel/common/soc-intel-quirks.h
+++ b/sound/soc/intel/common/soc-intel-quirks.h
@@ -11,6 +11,7 @@
 
 #if IS_ENABLED(CONFIG_X86)
 
+#include <linux/dmi.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/iosf_mbi.h>
@@ -38,12 +39,36 @@ SOC_INTEL_IS_CPU(cml, KABYLAKE_L);
 
 static inline bool soc_intel_is_byt_cr(struct platform_device *pdev)
 {
+	/*
+	 * List of systems which:
+	 * 1. Use a non CR version of the Bay Trail SoC
+	 * 2. Contain at least 6 interrupt resources so that the
+	 *    platform_get_resource(pdev, IORESOURCE_IRQ, 5) check below
+	 *    succeeds
+	 * 3. Despite 1. and 2. still have their IPC IRQ at index 0 rather then 5
+	 *
+	 * This needs to be here so that it can be shared between the SST and
+	 * SOF drivers. We rely on the compiler to optimize this out in files
+	 * where soc_intel_is_byt_cr is not used.
+	 */
+	static const struct dmi_system_id force_bytcr_table[] = {
+		{	/* Lenovo Yoga Tablet 2 series */
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+				DMI_MATCH(DMI_PRODUCT_FAMILY, "YOGATablet2"),
+			},
+		},
+		{}
+	};
 	struct device *dev = &pdev->dev;
 	int status = 0;
 
 	if (!soc_intel_is_byt())
 		return false;
 
+	if (dmi_check_system(force_bytcr_table))
+		return true;
+
 	if (iosf_mbi_available()) {
 		u32 bios_status;
 
-- 
2.28.0

