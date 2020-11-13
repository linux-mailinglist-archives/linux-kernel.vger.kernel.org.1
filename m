Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F8D2B1E56
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgKMPLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMPL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:11:29 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808F6C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:11:29 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so8780512wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6VwhXEWzIxAjTrN5P8ESFIqLC67o1cisz3fZ1XPv9o=;
        b=a5b+WVAGN5XmIvG/bHyahn6BSKS3xeIPR95Kk+ZUqKW/GbEvdnMB8eCh2uNjsCf2lV
         hmoPLDfy3hzkVMV0k2n3ZfiisUMQmaStyPRfS7xi/MmNoZiENBxWEirBKXvrwt2iMWnU
         x981P8XJ9fhYm6INRf7coxixw2jQN+wrpVPLQjbS3knalA2Hiuj8IpfNbhxQ++lHsdYA
         Yp1w7c76ZddrPOXxYWWD4DOwkF8IGV/Xyq+wue749cNRz20jYtT2W7esQTc7tPdVjesi
         ljeblh8P+CQeCBX8bYaw8PhkpWuFRAw40HMLx8BCjgkfDDcsWilYAFPfgg6lhz/Xl96K
         pkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6VwhXEWzIxAjTrN5P8ESFIqLC67o1cisz3fZ1XPv9o=;
        b=IEmsAn/+oVfoqGEbfGK2OB9Lpdo1VAPlR9VIiCSU8eNI/0bSALgCSymGpSfr1PKP+4
         dhoof6vjOc88T6hrsbhewkKnISu97uMrZtYGJDrXPow6d5FYmlkACwmADWS3ds85/9vW
         f+vr9HztP4fMSZsQIV9iHpgBVASRc7eCBab3F+9p50VG1NvGWA/WQrMlDMd1EE+5aynm
         F7DUY9IDGOCNJGXX0QdE/Nr+m164Aa+vZOn5Z7czhNcQd3TvTxBYCT3Fo40e/eJ9xVei
         c71x8McVQIeR4WKff0YtLtGX+8qd3YgV97y1o1Ze9gHB2hcQI4cG9GJJfrg55hhURhPa
         b8Ww==
X-Gm-Message-State: AOAM533DVQPjI5CYQfa4lujh4CgBpsoIAqqm+mo6BVWQ0TYRNqMVClh9
        nMqkijfBseaNpPU/r+dNYHIudA==
X-Google-Smtp-Source: ABdhPJxcdAGdkWH7XdI2lyr8s7kOWxOMBuM0gpVkYlgYRrZRkz68QFknsykGt4Ao45py0+WaLfbQsw==
X-Received: by 2002:a1c:6302:: with SMTP id x2mr3067471wmb.56.1605280287570;
        Fri, 13 Nov 2020 07:11:27 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n9sm10527195wmd.4.2020.11.13.07.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:11:26 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] phy: qualcomm: usb: Fix SuperSpeed PHY OF dependency
Date:   Fri, 13 Nov 2020 15:12:24 +0000
Message-Id: <20201113151225.1657600-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113151225.1657600-1-bryan.odonoghue@linaro.org>
References: <20201113151225.1657600-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Kconfig entry should declare a dependency on OF

Fixes: 6076967a500c ("phy: qualcomm: usb: Add SuperSpeed PHY driver")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lkml.org/lkml/2020/11/13/414
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/phy/qualcomm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 928db510b86c..9129c4b8bb9b 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -98,7 +98,7 @@ config PHY_QCOM_USB_HS_28NM
 
 config PHY_QCOM_USB_SS
 	tristate "Qualcomm USB Super-Speed PHY driver"
-	depends on ARCH_QCOM || COMPILE_TEST
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	depends on EXTCON || !EXTCON # if EXTCON=m, this cannot be built-in
 	select GENERIC_PHY
 	help
-- 
2.28.0

