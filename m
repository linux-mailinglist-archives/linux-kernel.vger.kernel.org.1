Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9702EBE92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbhAFNX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbhAFNXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:23:24 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7105DC061357;
        Wed,  6 Jan 2021 05:22:43 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o13so6509511lfr.3;
        Wed, 06 Jan 2021 05:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kQKlYjkEsXTqfe1rTtXK6ODUo/QOHx815FNAJpR+HA=;
        b=CWBkig62PfZI4rnc4SEiLV9zMROmn+DFZ8GmGinkuRf8fTPBKSmJjmsM9KDfe5Fj7B
         Q2NSeHVxUtU+AKWE6FE06nWbHqU1urnPvAcIquo1G9IgJ1Q+Hk8UmMAVXjZxAtxOgC5W
         G7RgxfF7V0Fi11gIw50ywSF8hoXljij+7HP3DGW7uEx27MO0bar1tJXFw0pj7UmsdcK7
         3vP31/jh74G7NvUwFbE+bYFsSxvmnmmrmorxlwl36FCbNbawCl8Oxyst+kg+xz9epDsz
         T6bbi+RH0R0xs8SeBe4c9KtamN06mB72XE5Ixeh2laSk2vRCOoegpkXbeGkrO0Vpm4B9
         38GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kQKlYjkEsXTqfe1rTtXK6ODUo/QOHx815FNAJpR+HA=;
        b=NE3ulo9fj+U/OoQx3YZRbhr0AL7gHCYEiKziG5mfcIEgzimfePp3i4tbVYAh9Gbcvd
         Os2WTXfQgFHXr9qHAsqZZ2s+4TQR/RurVCP0nuPNnV9IOq0Vea1dFhbBmeDP/++oVW7U
         aL9olXoR9nSXWM4yte167BMmU0fZbClqVh0RynKv1rlB0n0Jh1KizBm/DtkjS/VRG0Qn
         sWtj2VCrDijzVF2WP/uUxyajoveqAdvIeI3QogCe8Jj+dDPI411vfquq4f5B4X5lxb2t
         HiVUz+gehpWG8PIiFhtSEUhDlQmM5K2rnbIgs6iLyYvMlB4CSVN6vMN/SZtJj2BGPUzf
         MO7g==
X-Gm-Message-State: AOAM530yozEZOE5iaCmPP79bJYM7UQDLPC4HqE93LgvLXVHFwQTHtXKv
        cMJEEr6B5o9HLUEOlVzLeiM=
X-Google-Smtp-Source: ABdhPJygA16yJH4CB8TGW2vKBapSc7buDn/Xh4hf37PvVIUQ1akyW4JZjWmzi4+kGYxLmSIf2gUing==
X-Received: by 2002:a05:651c:30f:: with SMTP id a15mr1923152ljp.503.1609939361196;
        Wed, 06 Jan 2021 05:22:41 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id j12sm361118lfc.99.2021.01.06.05.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:22:40 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 3/3] phy: phy-brcm-usb: support PHY on the BCM4908
Date:   Wed,  6 Jan 2021 14:22:25 +0100
Message-Id: <20210106132225.21215-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210106132225.21215-1-zajec5@gmail.com>
References: <20210106132225.21215-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM4908 seems to have slightly different registers but works when
programmed just like the STB one.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Update Kconfig as well
---
 drivers/phy/broadcom/Kconfig        | 3 ++-
 drivers/phy/broadcom/phy-brcm-usb.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
index a1f1a9c90d0d..09256339bd04 100644
--- a/drivers/phy/broadcom/Kconfig
+++ b/drivers/phy/broadcom/Kconfig
@@ -91,10 +91,11 @@ config PHY_BRCM_SATA
 
 config PHY_BRCM_USB
 	tristate "Broadcom STB USB PHY driver"
-	depends on ARCH_BRCMSTB || COMPILE_TEST
+	depends on ARCH_BCM4908 || ARCH_BRCMSTB || COMPILE_TEST
 	depends on OF
 	select GENERIC_PHY
 	select SOC_BRCMSTB
+	default ARCH_BCM4908
 	default ARCH_BRCMSTB
 	help
 	  Enable this to support the Broadcom STB USB PHY.
diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 99fbc7e4138b..63f922a5f29b 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -285,6 +285,10 @@ static const struct match_chip_info chip_info_7445 = {
 };
 
 static const struct of_device_id brcm_usb_dt_ids[] = {
+	{
+		.compatible = "brcm,bcm4908-usb-phy",
+		.data = &chip_info_7445,
+	},
 	{
 		.compatible = "brcm,bcm7216-usb-phy",
 		.data = &chip_info_7216,
-- 
2.26.2

