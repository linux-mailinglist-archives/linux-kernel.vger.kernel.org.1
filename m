Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2804926D3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 08:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgIQGrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 02:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIQGrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:47:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA369C061788
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:47:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t10so767117wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AaSu1mbinkSllUZXWx/vayonkfswFrhIgZlz/kNiwoM=;
        b=HLb2XfcrqdgVlkkiCIQjz6D4LC81XJuj1soLphCAo3h9Yz+/ds0bXv3kAmw4/qBut5
         j2/QsvrEvqvUVdlNdJW8uR66wOoezmqF9++6XpHsYUwIK2LrnVM+1ypC/xpd20BNuARN
         lI2d260WkIICOJFOYY7ksCh6pt9nOYvfQDWliVJDKvsgZfjC1Ng9GwS6lv/8FaK7cuUk
         wU6bs05oOtfvfQeUAQTLKBvGE47AxQGS67skGuMyG6CnZHK8Jn3oFk0xlWPBw9IC9UvT
         i93NQFriBC9YcWMg4fCSDL3oZVnlynpBglGA5OEJUQ4d7AHZPnBohweJza0zpY+A4mW7
         +bHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AaSu1mbinkSllUZXWx/vayonkfswFrhIgZlz/kNiwoM=;
        b=KywHxJgJQcr5TX/1D0DS6MFQcsqm9YvXnsMLnxTZmmFhJqzCAaAvP4jHIZc1zO+43J
         VGWe34PFrCqnpSxwXf/zQmAuVK7a1iNYi3epyEaLpvvZR17ILmaHiJDvlLObA0iEAZ1v
         nBHJoiaMuqgkqEMGwBdohfn+J//zy+Tje8SWW0ChEyNAMz7l5bNv3r43lcnzCnnbpj2M
         Ul6R8A5ePogF3+VSShpy91+JjVASZRIQjVtlqxqFmq8Vl8QlFjVAKlQy+TdShddHXpqE
         3GvjpQEFxnDeQZ68YomRgfnRuShzaCqhRXFPmYdSSJRd9YwlzNJUTvhT0+qAJAUMGXeW
         3bdA==
X-Gm-Message-State: AOAM531YKzonjKJjLrYY3VBh+Q6pVbkRUaA6smXR3ejXflX2rXF2xAjw
        HVa8ItCwYVMvOX1/qdFcJPK07Q==
X-Google-Smtp-Source: ABdhPJxZHZqXAyOL3Q/e1oXYuulul+alwZKOl8EADEz4t0qhsudAKKhYgCPKNirVAHMHZmKIXVnFVA==
X-Received: by 2002:a5d:4246:: with SMTP id s6mr29880151wrr.414.1600325230154;
        Wed, 16 Sep 2020 23:47:10 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q4sm38516552wru.65.2020.09.16.23.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 23:47:09 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/2] soc: amlogic: meson-ee-pwrc: add support for the Meson AXG SoCs
Date:   Thu, 17 Sep 2020 08:47:02 +0200
Message-Id: <20200917064702.1459-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200917064702.1459-1-narmstrong@baylibre.com>
References: <20200917064702.1459-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Power Controller in the Amlogic AXG SoCs is similar to the GXL one
but with less VPU memory domains to enable and a supplementary Audio
memory power domain.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/soc/amlogic/meson-ee-pwrc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index 43665b77aa9e..9fd97ad02806 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -15,6 +15,7 @@
 #include <linux/reset.h>
 #include <linux/clk.h>
 #include <dt-bindings/power/meson8-power.h>
+#include <dt-bindings/power/meson-axg-power.h>
 #include <dt-bindings/power/meson-g12a-power.h>
 #include <dt-bindings/power/meson-gxbb-power.h>
 #include <dt-bindings/power/meson-sm1-power.h>
@@ -134,6 +135,11 @@ static struct meson_ee_pwrc_top_domain sm1_pwrc_ge2d = SM1_EE_PD(19);
 	{ __reg, BIT(14) },					\
 	{ __reg, BIT(15) }
 
+static struct meson_ee_pwrc_mem_domain axg_pwrc_mem_vpu[] = {
+	VPU_MEMPD(HHI_VPU_MEM_PD_REG0),
+	VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
+};
+
 static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_vpu[] = {
 	VPU_MEMPD(HHI_VPU_MEM_PD_REG0),
 	VPU_MEMPD(HHI_VPU_MEM_PD_REG1),
@@ -190,6 +196,10 @@ static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_ge2d[] = {
 	{ HHI_MEM_PD_REG0, GENMASK(25, 18) },
 };
 
+static struct meson_ee_pwrc_mem_domain axg_pwrc_mem_audio[] = {
+	{ HHI_MEM_PD_REG0, GENMASK(5, 4) },
+};
+
 static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_audio[] = {
 	{ HHI_MEM_PD_REG0, GENMASK(5, 4) },
 	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(1, 0) },
@@ -231,6 +241,13 @@ static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_audio[] = {
 
 static bool pwrc_ee_get_power(struct meson_ee_pwrc_domain *pwrc_domain);
 
+static struct meson_ee_pwrc_domain_desc axg_pwrc_domains[] = {
+	[PWRC_AXG_VPU_ID]  = VPU_PD("VPU", &gx_pwrc_vpu, axg_pwrc_mem_vpu,
+				     pwrc_ee_get_power, 5, 2),
+	[PWRC_AXG_ETHERNET_MEM_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
+	[PWRC_AXG_AUDIO_ID] = MEM_PD("AUDIO", axg_pwrc_mem_audio),
+};
+
 static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
 	[PWRC_G12A_VPU_ID]  = VPU_PD("VPU", &gx_pwrc_vpu, g12a_pwrc_mem_vpu,
 				     pwrc_ee_get_power, 11, 2),
@@ -529,6 +546,11 @@ static struct meson_ee_pwrc_domain_data meson_ee_g12a_pwrc_data = {
 	.domains = g12a_pwrc_domains,
 };
 
+static struct meson_ee_pwrc_domain_data meson_ee_axg_pwrc_data = {
+	.count = ARRAY_SIZE(axg_pwrc_domains),
+	.domains = axg_pwrc_domains,
+};
+
 static struct meson_ee_pwrc_domain_data meson_ee_gxbb_pwrc_data = {
 	.count = ARRAY_SIZE(gxbb_pwrc_domains),
 	.domains = gxbb_pwrc_domains,
@@ -562,6 +584,10 @@ static const struct of_device_id meson_ee_pwrc_match_table[] = {
 		.compatible = "amlogic,meson8m2-pwrc",
 		.data = &meson_ee_m8b_pwrc_data,
 	},
+	{
+		.compatible = "amlogic,meson-axg-pwrc",
+		.data = &meson_ee_axg_pwrc_data,
+	},
 	{
 		.compatible = "amlogic,meson-gxbb-pwrc",
 		.data = &meson_ee_gxbb_pwrc_data,
-- 
2.22.0

