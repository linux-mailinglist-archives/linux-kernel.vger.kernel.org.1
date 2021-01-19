Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC5F2FB2FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 08:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbhASHaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 02:30:12 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:34166 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730665AbhASH2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 02:28:45 -0500
Received: by mail-lj1-f173.google.com with SMTP id m10so20787076lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 23:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eaOYBiL5MXVrC05vfR6FoJO/7agNJvhqI5fcqiW01po=;
        b=U/HXC7no9n6gqGg0LVHwCopcFKiKqbGCT+PZ1IwCjEI/PCSUR04Qd1T6/v6fH/L0wL
         YHWI0G3jrnhTaZ8pBwnkmL0YIJzwmod7sxK/oY7KUga19GxBXyjdGcZVtL2adI1Lm+lj
         SkvF4laHfp48pcStL9gy0BscYXqzt/8pDn+1ItlMkN2x39qogA0ma1+B343/Eweps1JM
         EJ/RUjfGDYImLu9OJWDHvZ4LZaLd8QE4SvoBleW3eSkrFcCpFKk1bImkqSotUbRkHbkr
         +2CQLLaLpZwTycJcaOA5doNl2XZb9WzlfItyM7rfn6FualbEsQy4ZyDkmZksgkFzYczC
         ri/g==
X-Gm-Message-State: AOAM533VZ5BEZQozcKao4W2vwG8x6h6PTgRMB3y8AngJTLV1nkAucpa4
        MGI+mhQqipNdc3VknVe8wU8=
X-Google-Smtp-Source: ABdhPJyfmRCeHeegczOkWGxUbNiQl7Mh9vrYHgWc7BGRfWh2Y0vzazNpkTvh2KS1JSZJgSDWMA2WZA==
X-Received: by 2002:a2e:9250:: with SMTP id v16mr1349696ljg.256.1611041282679;
        Mon, 18 Jan 2021 23:28:02 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id x29sm2187341lfn.166.2021.01.18.23.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 23:28:02 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:27:56 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com
Subject: [PATCH v2 13/17] regulator: rohm-regulator: Support SNVS HW state.
Message-ID: <2d01ea7101deb7430a2134af76186f78595be116.1611037866.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1611037866.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1611037866.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ROHM BD71815 supports setting voltage levels/regulator status
for HW-states "RUN", "SUSPEND", "LPSR" and "SNVS". Add DT parsing
helper also for SNVS state.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
Changes since v1:
New patch (split patch).

 drivers/regulator/rohm-regulator.c | 6 ++++++
 include/linux/mfd/rohm-generic.h   | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/rohm-regulator.c b/drivers/regulator/rohm-regulator.c
index 63aabb8c7786..6e0d9c08ec1c 100644
--- a/drivers/regulator/rohm-regulator.c
+++ b/drivers/regulator/rohm-regulator.c
@@ -95,6 +95,12 @@ int rohm_regulator_set_dvs_levels(const struct rohm_dvs_config *dvs,
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
index bbf07a49823c..baed47fd0ff3 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -25,7 +25,8 @@ struct rohm_regmap_dev {
 #define ROHM_DVS_LEVEL_IDLE		BIT(1)
 #define ROHM_DVS_LEVEL_SUSPEND		BIT(2)
 #define ROHM_DVS_LEVEL_LPSR		BIT(3)
-#define ROHM_DVS_LEVEL_VALID_AMOUNT	4
+#define ROHM_DVS_LEVEL_SNVS		BIT(4)
+#define ROHM_DVS_LEVEL_VALID_AMOUNT	5
 #define ROHM_DVS_LEVEL_UNKNOWN		0
 
 /**
@@ -64,6 +65,9 @@ struct rohm_dvs_config {
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
