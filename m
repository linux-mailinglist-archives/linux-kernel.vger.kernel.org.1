Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED972EF350
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbhAHNnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:43:21 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:37336 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbhAHNnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:43:20 -0500
Received: by mail-lf1-f42.google.com with SMTP id o17so23019969lfg.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 05:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ogF5UDnjBHSgreSOVnNE1Uvze0jR6ejZG+wB+GZuI3Q=;
        b=oeQBo8x5N4xHrNQktoFfhI3/iCR6/nybW+a7vBz1PXOk6u9aBn9vH/QtfPWPSWwIeq
         2TEqc/o5aQ7pnxhefGLfWqZPh7WYFJ8eSfdFza59PSLQxsRvGcI1wlF3dF/tnTwW0m+3
         LvdTuackI7ciVDKAmizM72YwOi7lPbQjRUJsTC1L2zYgoI45UiPzarj2/GWigEwD5zun
         LPem8c0hy5l/dLN49v+x6/uO9ZHUsugLBihLxDli52e7n3evVldr8KYkSb3yOrXLTTEZ
         73wtX6eNYPiI6gKE89MzXUr+dA80Vh2rn1wb49roKRJVyzsK5BbkRdiP54vpXzWQausb
         L8fw==
X-Gm-Message-State: AOAM530Fqz07z3nVGY5vMWqN2C/aLocKr5UvmtSfvJyCrl6E98CgVvzP
        f+yJLPqkd6UlwVLm1uL3hLQ=
X-Google-Smtp-Source: ABdhPJzjFf57EB/xgCLCBqCzsQzawOVL0X/tMS06shnef+KNQNtWAK3VM8jYnWol3V40Ywln0hr0KQ==
X-Received: by 2002:a05:651c:512:: with SMTP id o18mr1460093ljp.367.1610113358130;
        Fri, 08 Jan 2021 05:42:38 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id y15sm1988298lfg.209.2021.01.08.05.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 05:42:37 -0800 (PST)
Date:   Fri, 8 Jan 2021 15:42:31 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com
Subject: [PATCH 11/15] regulator: rohm-regulator: SNVS dvs and linear voltage
 support
Message-ID: <f0af653b3d3d56bd1852468502518a54b31b1f10.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper for obtaining HW-state based DVS voltage levels currently only
works for regulators using linear-ranges. Extend support to regulators with
simple linear mappings and add also proper error path if pickable-ranges
regulators call this.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/rohm-regulator.c | 23 +++++++++++++++++++++--
 include/linux/mfd/rohm-generic.h   |  6 +++++-
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/rohm-regulator.c b/drivers/regulator/rohm-regulator.c
index 399002383b28..9248bd63afa9 100644
--- a/drivers/regulator/rohm-regulator.c
+++ b/drivers/regulator/rohm-regulator.c
@@ -22,13 +22,26 @@ static int set_dvs_level(const struct regulator_desc *desc,
 			return ret;
 		return 0;
 	}
-
+	/* If voltage is set to 0 => disable */
 	if (uv == 0) {
 		if (omask)
 			return regmap_update_bits(regmap, oreg, omask, 0);
 	}
+	/* Some setups don't allow setting own voltage but do allow enabling */
+	if (!mask) {
+		if (omask)
+			return regmap_update_bits(regmap, oreg, omask, omask);
+
+		return -EINVAL;
+	}
 	for (i = 0; i < desc->n_voltages; i++) {
-		ret = regulator_desc_list_voltage_linear_range(desc, i);
+		/* NOTE to next hacker - Does not support pickable ranges */
+		if (desc->linear_range_selectors)
+			return -EINVAL;
+		if (desc->n_linear_ranges)
+			ret = regulator_desc_list_voltage_linear_range(desc, i);
+		else
+			ret = regulator_desc_list_voltage_linear(desc, i);
 		if (ret < 0)
 			continue;
 		if (ret == uv) {
@@ -79,6 +92,12 @@ int rohm_regulator_set_dvs_levels(const struct rohm_dvs_config *dvs,
 				mask = dvs->lpsr_mask;
 				omask = dvs->lpsr_on_mask;
 				break;
+			case ROHM_DVS_LEVEL_SNVS:
+				prop = "rohm,dvs-snvs-voltage";
+				reg = dvs->snvs_reg;
+				mask = dvs->snvs_mask;
+				omask = dvs->snvs_on_mask;
+				break;
 			default:
 				return -EINVAL;
 			}
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-generic.h
index e99e569d3cc1..2f5fbfd0c6b3 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -27,7 +27,8 @@ enum {
 	ROHM_DVS_LEVEL_IDLE,
 	ROHM_DVS_LEVEL_SUSPEND,
 	ROHM_DVS_LEVEL_LPSR,
-	ROHM_DVS_LEVEL_MAX = ROHM_DVS_LEVEL_LPSR,
+	ROHM_DVS_LEVEL_SNVS,
+	ROHM_DVS_LEVEL_MAX = ROHM_DVS_LEVEL_SNVS,
 };
 
 /**
@@ -66,6 +67,9 @@ struct rohm_dvs_config {
 	unsigned int lpsr_reg;
 	unsigned int lpsr_mask;
 	unsigned int lpsr_on_mask;
+	unsigned int snvs_reg;
+	unsigned int snvs_mask;
+	unsigned int snvs_on_mask;
 };
 
 #if IS_ENABLED(CONFIG_REGULATOR_ROHM)
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
