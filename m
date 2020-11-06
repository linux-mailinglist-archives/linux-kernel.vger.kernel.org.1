Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156D02A8CC7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgKFC2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKFC2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:28:22 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DBBC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:28:22 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id k7so1727913plk.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OI2O9qBwcer8FBwT8kwD3fyAcbKrenke7SFTi0wM+zw=;
        b=HUbyyeHqM0UEsor4Pdaf7iY685ttM6RXNhjHTYXuAkBIBo+cYtxJ2Ji67VtLeSEABo
         Ngimmgq56azBbvOdpPDLj2YGh+ltEOrd2rfb5i792zlPOxX4mJqIEgxQiB1h+BzgR99k
         Py1wGyHoxOOcNbPS0D4WzdTn8lt+8rPMrXnDyp2wtMlAfAXXJRlbhSfdqcOv1SNGoSxh
         ADzs1qqnwR8eOkDFzf7A9K7n2GA/dVUafBYGm2n6bIX/yz0IzjAleoFRMNl3OdkKAmJs
         RmodTXljzfknVbFxAgayckyNlgT7iIjlQozx15yinsP99ctt8k8zmFnBWLcgb+L3KOz2
         E9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OI2O9qBwcer8FBwT8kwD3fyAcbKrenke7SFTi0wM+zw=;
        b=evgcwZPZkHgcqjDgQgf2uTZuYgFDJPW28eOAc8q/G3wnv5SZ1mtxCATyU2tbjT+Vls
         tPA2XxVKmiYXSg2lQRpiluXKKCu0VPYsWgcwb1WUWYdclXB6lAQoSDsSOlFe2gcKcm/E
         Q3GPl8+uAd31/lHyLGxatEQ1UTDlHKmhB+gUkOt9beGB2fA5JL9YnkWsjDdTbHHya5iW
         hgKD8rOu3oCb2oNUbB5sPaEecWwZCcx1RsHB+cZlVwpBwJlwqcPto4zN6ehCQ4hc4W7R
         5fYR7cZqFomFqFUTSReD9LHeWACIXh7du2AH+QFse2H7iykMVjaIyGOV/bIFeGR6K5yb
         hK8w==
X-Gm-Message-State: AOAM530eFl0B5ZMCQbPXcNHiLajtt0aTSsfXv5VQfJFRE6QDbYtdIPnp
        kHSNg8TZDTk4rTHas7yI6D/pnw==
X-Google-Smtp-Source: ABdhPJxPx2V9sZTR4oHSnUZ5jluNldG/UbHXO1BOKj1TBRaLK9fhTtM/9oY9pfl8EX6Cb3eJj5VVIQ==
X-Received: by 2002:a17:902:9889:b029:d6:5337:a758 with SMTP id s9-20020a1709029889b02900d65337a758mr4645836plp.28.1604629701958;
        Thu, 05 Nov 2020 18:28:21 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:21 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 08/27] mmc: sdhci: add a kernel configuration for enabling UHS-II support
Date:   Fri,  6 Nov 2020 11:27:07 +0900
Message-Id: <20201106022726.19831-9-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
in the following commits to indicate UHS-II specific code in sdhci
controllers.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 31481c9fcc2e..5ca9ac03db40 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -89,6 +89,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 
 	  This is the case for the Nintendo Wii SDHCI.
 
+config MMC_SDHCI_UHS2
+	tristate "UHS2 support on SDHCI controller"
+	depends on MMC_SDHCI
+	help
+	  This option is selected by SDHCI controller drivers that want to
+	  support UHS2-capable devices.
+
+	  If you have a controller with this feature, say Y or M here.
+
 config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
-- 
2.28.0

