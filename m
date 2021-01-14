Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF152F6868
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbhANRyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbhANRyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:54:37 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C27C0613CF;
        Thu, 14 Jan 2021 09:53:55 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e7so7436916ljg.10;
        Thu, 14 Jan 2021 09:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BU9666H9+n3AaCfLwxbz0at2GSU/MFKAb/8IHarZuEU=;
        b=ZsEYcypOVxGCT7YdVGPF1Ik+C+D9XPpnSOYyBZG8Xco849c7C9XhUxABgTn2VOpbW2
         XVWZwFdSnw6pbyfkKuMoSu3FnplehAEyJt/NcnQQQ3WpfcX9C4Tj1VsTrtk3bsg7EKsQ
         +8/8x/ae0+nRdTL14sXmhETgbrVIP9Av7bgwKNkJWFUbTgeU5UJVbR9LUXjxv+lRLiBH
         7Syod26vpgG9Mqkfg2Fad/KFwvMkedILYhOSZYip8Fa8lYP7FNFz88WLFKD3Q0NVxBN7
         8Dtn7AQSxj9WpSG/gIVtZh8MsXlpbdM55o716MYDhpoKI915dTOn76eRswWED/k1EpC0
         fF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BU9666H9+n3AaCfLwxbz0at2GSU/MFKAb/8IHarZuEU=;
        b=UL291jdg38UgJkDHLTXb64c5bcBJpi1QLhaysFVVJ00ze5HV2w5MwNBSUh/HHRgOvv
         K0i/Lu1YYrEJPFjI4V7MOrIXo4noK9Wi3frFSrR7kLOouOv3Bhy5mWMfdCbraBUf2Hii
         c2ffmx3Z1Q6acrTPLviQVvVi71fY6nZ+FRu/sb1WgCksIjD3CpYbxKPzG6pk5u4r6ld7
         ysxnCBJHRi19mVDfQMO8fvK75XZjhv2BRd6Kb98uMQeKYoZobxESOFpG3kikgfth1Tii
         4g+eYLPriPs0vwxkMy69f2aNOCsHlB+WBYEV8XoqzjR4gAnc7cEFTeUkS4asiZ/uibvL
         5wZw==
X-Gm-Message-State: AOAM531pW08L7RImLtdvU0B6cbiGiTXH3YWDcrZ6QMOIJpin/QNw/+KD
        zbQq2ooq8AXKy01sw3HZBZ0=
X-Google-Smtp-Source: ABdhPJyXaxZmSrSs5h2yMr9FOyFerohvwk+W7ejq6/RaLOf3mW9JzXWIKzz9syCuxQzT5aLbRqYJWw==
X-Received: by 2002:a2e:8188:: with SMTP id e8mr3613476ljg.157.1610646833527;
        Thu, 14 Jan 2021 09:53:53 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id a24sm610103lfg.256.2021.01.14.09.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:53:52 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH Broadcom/stblinux 2/2] soc: bcm: bcm-pmb: add BCM63138 SATA support
Date:   Thu, 14 Jan 2021 18:53:39 +0100
Message-Id: <20210114175339.19920-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210114175339.19920-1-zajec5@gmail.com>
References: <20210114175339.19920-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM63138 has SATA controller that needs to be powered up using PMB.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
Florian: this is based on your patches
ARM: dts: BCM63xx: enable SATA PHY and AHCI controller
reset: bcm63xx: Add Broadcom BCM63138 reset controller driver

I didn't test it as I don't own any bcm63xx devices.
---
 drivers/soc/bcm/bcm63xx/bcm-pmb.c | 30 ++++++++++++++++++++++++++++++
 include/dt-bindings/soc/bcm-pmb.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/soc/bcm/bcm63xx/bcm-pmb.c b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
index c223023dc64f..774465c119be 100644
--- a/drivers/soc/bcm/bcm63xx/bcm-pmb.c
+++ b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
@@ -209,6 +209,28 @@ static int bcm_pmb_power_on_device(struct bcm_pmb *pmb, int bus, u8 device)
 	return err;
 }
 
+static int bcm_pmb_power_on_sata(struct bcm_pmb *pmb, int bus, u8 device)
+{
+	int err;
+
+	err = bcm_pmb_power_on_zone(pmb, bus, device, 0);
+	if (err)
+		return err;
+
+	/* Does not apply to the BCM963158 */
+	err = bcm_pmb_bpcm_write(pmb, bus, device, BPCM_MISC_CONTROL, 0);
+	if (err)
+		return err;
+
+	err = bcm_pmb_bpcm_write(pmb, bus, device, BPCM_SR_CONTROL, 0xffffffff);
+	if (err)
+		return err;
+
+	err = bcm_pmb_bpcm_write(pmb, bus, device, BPCM_SR_CONTROL, 0);
+
+	return err;
+}
+
 static int bcm_pmb_power_on(struct generic_pm_domain *genpd)
 {
 	struct bcm_pmb_pm_domain *pd = container_of(genpd, struct bcm_pmb_pm_domain, genpd);
@@ -222,6 +244,8 @@ static int bcm_pmb_power_on(struct generic_pm_domain *genpd)
 		return bcm_pmb_power_on_zone(pmb, data->bus, data->device, 0);
 	case BCM_PMB_HOST_USB:
 		return bcm_pmb_power_on_device(pmb, data->bus, data->device);
+	case BCM_PMB_SATA:
+		return bcm_pmb_power_on_sata(pmb, data->bus, data->device);
 	default:
 		dev_err(pmb->dev, "unsupported device id: %d\n", data->id);
 		return -EINVAL;
@@ -317,8 +341,14 @@ static const struct bcm_pmb_pd_data bcm_pmb_bcm4908_data[] = {
 	{ },
 };
 
+static const struct bcm_pmb_pd_data bcm_pmb_bcm63138_data[] = {
+	{ .name = "sata", .id = BCM_PMB_SATA, .bus = 0, .device = 3, },
+	{ },
+};
+
 static const struct of_device_id bcm_pmb_of_match[] = {
 	{ .compatible = "brcm,bcm4908-pmb", .data = &bcm_pmb_bcm4908_data, },
+	{ .compatible = "brcm,bcm63138-pmb", .data = &bcm_pmb_bcm63138_data, },
 	{ },
 };
 
diff --git a/include/dt-bindings/soc/bcm-pmb.h b/include/dt-bindings/soc/bcm-pmb.h
index 744dc3af4d41..385884468007 100644
--- a/include/dt-bindings/soc/bcm-pmb.h
+++ b/include/dt-bindings/soc/bcm-pmb.h
@@ -7,5 +7,6 @@
 #define BCM_PMB_PCIE1				0x02
 #define BCM_PMB_PCIE2				0x03
 #define BCM_PMB_HOST_USB			0x04
+#define BCM_PMB_SATA				0x05
 
 #endif
-- 
2.26.2

