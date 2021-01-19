Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0A02FB2FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 08:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbhASH3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 02:29:23 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:45346 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbhASH1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 02:27:25 -0500
Received: by mail-lf1-f41.google.com with SMTP id q12so636943lfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 23:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SGDZocYTMRwn3rHznDVoOYGXMuXKuTLqJcjZTlDcqTY=;
        b=jullFCgGvUDSuFT8BF9KL6wHEMfj1mUtUQoSkU0PXs3/i1A8itRbpmvp376T5v1c6E
         t7nLMVm2kFvBPAD1BVsiuXyd535nPZf2P3XN70DFwDlT7k3gUaEBIOeY4MjjRH+BVPJb
         08TF8fWy2tUIY/C5ah9wCDKcOi2kOVehGMEq1W3m5MJGtRI0W4d9J8mN4YjAtA9qS0/Z
         Yzlp7kFjbCB2BC6wYmmNF/L81djm0CyczVjDlv/f7i+52du/GzZ0Rvx7c87SOTUgBFME
         Z43+knVhNrO3IETmqRUWFYYIszzjDfZf967EwqxjvNudViljefFwyTS5l91QY9MzhE/1
         5/VQ==
X-Gm-Message-State: AOAM532VlW1dC1GcIktozpvk+Z7RVHJtTBIhldtvnxlkim/VNvRcZl+F
        wq2KU/paqc8KQ1g8EL5Fur0=
X-Google-Smtp-Source: ABdhPJyZT0CEQgeXeTVntR9ZfAVKmo7eQAsjWors/RYuZAS/1+EWBqtTvKPZugZG1MSREO00MvNEzg==
X-Received: by 2002:a19:c30e:: with SMTP id t14mr1226433lff.521.1611041200314;
        Mon, 18 Jan 2021 23:26:40 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id i27sm2189016lfc.31.2021.01.18.23.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 23:26:39 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:26:33 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com
Subject: [PATCH v2 12/17] regulator: rohm-regulator: linear voltage support
Message-ID: <e6288a1ba44181700ef46029d2dd2ea09e8dd286.1611037866.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1611037866.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1611037866.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper for obtaining HW-state based DVS voltage levels currently only
works for regulators using linear-ranges. Extend support to regulators with
simple linear mappings and add also proper error path if pickable-ranges
regulators call this.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
Changes since v1:
  - moved SNVS level adding to own patch

 drivers/regulator/rohm-regulator.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rohm-regulator.c b/drivers/regulator/rohm-regulator.c
index 5c558b153d55..63aabb8c7786 100644
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
