Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3952AD133
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbgKJIU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:20:27 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36579 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJIU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:20:27 -0500
Received: by mail-lf1-f65.google.com with SMTP id f11so10003323lfs.3;
        Tue, 10 Nov 2020 00:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IDSxpkxHLT4rWHHSEG+47MZJHtsvhN3aVv1OmkPtH0M=;
        b=Sb8h9kHvMBga7Jpxbh4sn5Z1vh86Lr89Sy9TBJwzRSIJmvjOw0lurUGuIpnMdZC5+g
         tstxSyyQCbbW5fPtdd+QoQcCdmAXlf+uiBeYvKqc9XgvA239vVI0W7iKGkcwFigfltkd
         C8GvzPoKCOhZ5gBq4Owg6mm+96IulV3ABp9lodib0PI3MwJcHgYSq21PvjC9s9Qmt/eE
         bHHv6RaPisA/CoLM5dEHUn+2z+vR5L/9Sh7PfBNemRjUbhBOhXPGH6fVwOrnlgGYwI4V
         k+81Qp5oHFe7yKrewZZLFD/QDJDk+rKh9BNeb9IjN0SPtAi8EgjxuFQql3kq9W1EhpI1
         KkJA==
X-Gm-Message-State: AOAM532Ak8PdolazoigYdWdbKyj5TjA/0Ede1K5HmpquSoIEMaftvNuM
        06M8qzGXLxC6TSXSE9FwFzc=
X-Google-Smtp-Source: ABdhPJxHXj0HApjWxiqo2OFKAOybvwc2pXzmMZ7/tBEKstH5VZM68Pu2HpiknM7iE3TFy9713zs+WQ==
X-Received: by 2002:a19:794:: with SMTP id 142mr184661lfh.232.1604996423735;
        Tue, 10 Nov 2020 00:20:23 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id z5sm2133915ljk.136.2020.11.10.00.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 00:20:23 -0800 (PST)
Date:   Tue, 10 Nov 2020 10:20:17 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [RFC PATCH 3/3] regulator: bd718x7: Support external connection to
 scale voltages
Message-ID: <89b2be87074f307a8823f15f34e1f662023cbf36.1604994184.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1604994184.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1604994184.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setups where regulator (especially the buck8) output voltage is scaled
by adding external connection where some other regulator output is
connected to feedback-pin (over suitable resistors) is getting popular
amongst users of BD71837. This allows for example scaling down the
buck8 voltages to suit lover GPU voltages for projects where buck8 is
(ab)used to supply power for GPU. As a note - some setups do allow DVS
for buck8. This do produce voltage spikes and the HW must be evaluated
to be able to survive them. Thus this commit still keep the DVS disabled
for non DVS bucks by default. Let's not help you burn your proto board.

Allow describing this external connection from DT and scale the
voltages accordingly. This is what the connection should look like:

|------------|
|    buck 8  |-------+----->Vout
|            |       |
|------------|       |
     | FB pin        |
     |               |
     +-------+--R2---+
             |
             R1
             |
     V FB-pull-up

     Here the buck output is sifted according to formula:

Vout_o = Vo - (Vpu - Vo)*R2/R1
Linear_step = step_orig*(R1+R2)/R1

where:
Vout_o is adjusted voltage output at vsel reg value 0
Vo is original voltage output at vsel reg value 0
Vpu is the pull-up voltage V FB-pull-up in the picture
R1 and R2 are resistor values.

Bring support for specifying the Vpu, R1 and R2 from device tree and
scale voltages if they are given.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd718x7-regulator.c | 164 ++++++++++++++++++++++++--
 1 file changed, 157 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 0774467994fb..e6d5d98c3cea 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1323,13 +1323,142 @@ static void mark_hw_controlled(struct device *dev, struct device_node *np,
 	dev_warn(dev, "Bad regulator node\n");
 }
 
-static int get_hw_controlled_regulators(struct device *dev,
-					struct bd718xx_regulator_data *reg_data,
-					unsigned int num_reg_data, int *info)
+/*
+ * Setups where regulator (especially the buck8) output voltage is scaled
+ * by adding external connection where some other regulator output is connected
+ * to feedback-pin (over suitable resistors) is getting popular amongst users
+ * of BD71837. (This allows for example scaling down the buck8 voltages to suit
+ * lover GPU voltages for projects where buck8 is (ab)used to supply power
+ * for GPU. Additionally some setups do allow DVS for buck8 but as this do
+ * produce voltage spikes the HW must be evaluated to be able to survive this
+ * - hence I keep the DVS disabled for non DVS bucks by default. I don't want
+ * to help you burn your proto board)
+ *
+ * So we allow describing this external connection from DT and scale the
+ * voltages accordingly. This is what the connection should look like:
+ *
+ * |------------|
+ * |	buck 8  |-------+----->Vout
+ * |		|	|
+ * |------------|	|
+ *	| FB pin	|
+ *	|		|
+ *	+-------+--R2---+
+ *		|
+ *		R1
+ *		|
+ *	V FB-pull-up
+ *
+ *	Here the buck output is sifted according to formula:
+ *
+ * Vout_o = Vo - (Vpu - Vo)*R2/R1
+ * Linear_step = step_orig*(R1+R2)/R1
+ *
+ * where:
+ * Vout_o is adjusted voltage output at vsel reg value 0
+ * Vo is original voltage output at vsel reg value 0
+ * Vpu is the pull-up voltage V FB-pull-up in the picture
+ * R1 and R2 are resistor values.
+ *
+ * As a real world example for buck8 and a specific GPU:
+ * VLDO = 1.6V (used as FB-pull-up)
+ * R1 = 1000ohms
+ * R2 = 150ohms
+ * VSEL 0x0 => 0.8V – (VLDO – 0.8) * R2 / R1 = 0.68V
+ * Linear Step = 10mV * (R1 + R2) / R1 = 11.5mV
+ */
+static int setup_feedback_loop(struct device *dev, struct device_node *np,
+			       struct bd718xx_regulator_data *reg_data,
+			       unsigned int num_reg_data, int fb_uv)
 {
+	int i, r1, r2, ret;
+
+	/*
+	 * We do adjust the values in the global desc based on DT settings.
+	 * This may not be best approach as it can cause problems if more than
+	 * one PMIC is controlled from same processor. I don't see such use-case
+	 * for BD718x7 now - so we spare some bits.
+	 *
+	 * If this will point out to be a problem - then we can allocate new
+	 * bd718xx_regulator_data array at probe and just use the global
+	 * array as a template where we copy initial values. Then we can
+	 * use allocated descs for regultor registration and do IC specific
+	 * modifications to this copy while leaving other PMICs untouched. But
+	 * that means allocating new array for each PMIC - and currently I see
+	 * no need for that.
+	 */
+
+	for (i = 0; i < num_reg_data; i++) {
+		struct regulator_desc *desc = &reg_data[i].desc;
+		int j;
+
+		if (!of_node_name_eq(np, desc->of_match))
+			continue;
+
+		pr_info("Looking at node '%s'\n", desc->of_match);
+
+		/* The feedback loop connection does not make sense for LDOs */
+		if (desc->id >= BD718XX_LDO1)
+			return -EINVAL;
+
+		ret = of_property_read_u32(np, "rohm,feedback-pull-up-r1-ohms",
+					   &r1);
+		if (ret)
+			return ret;
+
+		if (!r1)
+			return -EINVAL;
+
+		ret = of_property_read_u32(np, "rohm,feedback-pull-up-r2-ohms",
+					   &r2);
+		if (ret)
+			return ret;
+
+		if (desc->n_linear_ranges && desc->linear_ranges) {
+			struct linear_range *new;
+
+			new = devm_kzalloc(dev, desc->n_linear_ranges *
+					   sizeof(struct linear_range),
+					   GFP_KERNEL);
+			if (!new)
+				return -ENOMEM;
+
+			for (j = 0; j < desc->n_linear_ranges; j++) {
+				int min = desc->linear_ranges[j].min;
+				int step = desc->linear_ranges[j].step;
+
+				min -= (fb_uv - min)*r2/r1;
+				step = step * (r1 + r2);
+				step /= r1;
+
+				new[j].min = min;
+				new[j].step = step;
+
+				dev_dbg(dev, "%s: old range min %d, step %d\n",
+					desc->name, desc->linear_ranges[j].min,
+					desc->linear_ranges[j].step);
+				dev_dbg(dev, "new range min %d, step %d\n", min,
+					step);
+			}
+			desc->linear_ranges = new;
+		}
+		dev_dbg(dev, "regulator '%s' has FB pull-up configured\n",
+			desc->name);
+
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+static int get_special_regulators(struct device *dev,
+				  struct bd718xx_regulator_data *reg_data,
+				  unsigned int num_reg_data, int *info)
+{
+	int ret;
 	struct device_node *np;
 	struct device_node *nproot = dev->of_node;
-	const char *prop = "rohm,no-regulator-enable-control";
+	int uv;
 
 	*info = 0;
 
@@ -1338,13 +1467,32 @@ static int get_hw_controlled_regulators(struct device *dev,
 		dev_err(dev, "failed to find regulators node\n");
 		return -ENODEV;
 	}
-	for_each_child_of_node(nproot, np)
-		if (of_property_read_bool(np, prop))
+	for_each_child_of_node(nproot, np) {
+		if (of_property_read_bool(np, "rohm,no-regulator-enable-control"))
 			mark_hw_controlled(dev, np, reg_data, num_reg_data,
 					   info);
+		ret = of_property_read_u32(np, "rohm,fb-pull-up-microvolt",
+					   &uv);
+		if (ret) {
+			if (ret == -EINVAL)
+				continue;
+			else
+				goto err_out;
+		}
+
+		ret = setup_feedback_loop(dev, np, reg_data, num_reg_data, uv);
+		if (ret)
+			goto err_out;
+	}
 
 	of_node_put(nproot);
 	return 0;
+
+err_out:
+	of_node_put(np);
+	of_node_put(nproot);
+
+	return ret;
 }
 
 static int bd718xx_probe(struct platform_device *pdev)
@@ -1432,8 +1580,10 @@ static int bd718xx_probe(struct platform_device *pdev)
 	 * be affected by PMIC state machine - Eg. regulator is likely to stay
 	 * on even in SUSPEND
 	 */
-	get_hw_controlled_regulators(pdev->dev.parent, reg_data, num_reg_data,
+	err = get_special_regulators(pdev->dev.parent, reg_data, num_reg_data,
 				     &omit_enable);
+	if (err)
+		return err;
 
 	for (i = 0; i < num_reg_data; i++) {
 
-- 
2.21.3


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
