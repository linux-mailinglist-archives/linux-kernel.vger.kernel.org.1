Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9A91EA0DB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 11:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgFAJTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 05:19:21 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:51578 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727935AbgFAJTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:19:12 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Jun 2020 12:19:05 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0519IsSt003135;
        Mon, 1 Jun 2020 12:19:05 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v1 5/8] platform/mellanox: mlxreg-io: Add support for complex attributes
Date:   Mon,  1 Jun 2020 12:18:48 +0300
Message-Id: <20200601091851.5491-6-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200601091851.5491-1-vadimp@mellanox.com>
References: <20200601091851.5491-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for attributes composed from few registers.
Such attributes could occupy from 2 to 4 sequential registers.
For word size register space complex attribute can occupy up to two
register, for byte size - up to four. These attributes can carry, for
example, CPLD or FPGA versioning, power consuming info, etcetera.
Such registers contain read only data.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/mellanox/mlxreg-io.c | 47 ++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-io.c b/drivers/platform/mellanox/mlxreg-io.c
index acfaf64ffde6..93dbbe381bc4 100644
--- a/drivers/platform/mellanox/mlxreg-io.c
+++ b/drivers/platform/mellanox/mlxreg-io.c
@@ -30,6 +30,7 @@
  * @mlxreg_io_dev_attr: sysfs sensor device attribute array;
  * @group: sysfs attribute group;
  * @groups: list of sysfs attribute group for hwmon registration;
+ * @regsize: size of a register value;
  */
 struct mlxreg_io_priv_data {
 	struct platform_device *pdev;
@@ -39,27 +40,30 @@ struct mlxreg_io_priv_data {
 	struct sensor_device_attribute mlxreg_io_dev_attr[MLXREG_IO_ATT_NUM];
 	struct attribute_group group;
 	const struct attribute_group *groups[2];
+	int regsize;
 };
 
 static int
 mlxreg_io_get_reg(void *regmap, struct mlxreg_core_data *data, u32 in_val,
-		  bool rw_flag, u32 *regval)
+		  bool rw_flag, int regsize, u32 *regval)
 {
-	int ret;
+	int i, val, ret;
 
 	ret = regmap_read(regmap, data->reg, regval);
 	if (ret)
 		goto access_error;
 
 	/*
-	 * There are three kinds of attributes: single bit, full register's
-	 * bits and bit sequence. For the first kind field mask indicates which
-	 * bits are not related and field bit is set zero. For the second kind
-	 * field mask is set to zero and field bit is set with all bits one.
-	 * No special handling for such kind of attributes - pass value as is.
-	 * For the third kind, field mask indicates which bits are related and
-	 * field bit is set to the first bit number (from 1 to 32) is the bit
-	 * sequence.
+	 * There are four kinds of attributes: single bit, full register's
+	 * bits, bit sequence, bits in few registers For the first kind field
+	 * mask indicates which bits are not related and field bit is set zero.
+	 * For the second kind field mask is set to zero and field bit is set
+	 * with all bits one. No special handling for such kind of attributes -
+	 * pass value as is. For the third kind, field mask indicates which
+	 * bits are related and field bit is set to the first bit number (from
+	 * 1 to 32) is the bit sequence. For the fourth kind - the number of
+	 * registers which should be read for getting an attribute are specified
+	 * through 'data->regnum' field.
 	 */
 	if (!data->bit) {
 		/* Single bit. */
@@ -83,6 +87,21 @@ mlxreg_io_get_reg(void *regmap, struct mlxreg_core_data *data, u32 in_val,
 			/* Clear relevant bits and set them to new value. */
 			*regval = (*regval & ~data->mask) | in_val;
 		}
+	} else {
+		/*
+		 * Some attributes could occupied few registers in case regmap
+		 * bit size is 8 or 16. Compose such attribute from 'regnum'
+		 * registers. Such attributes contain read only data.
+		 */
+		if (data->regnum > 1 && !rw_flag)
+			return -EINVAL;
+		for (i = 1; i < data->regnum; i++) {
+			ret = regmap_read(regmap, data->reg + i, &val);
+			if (ret)
+				goto access_error;
+
+			*regval |= rol32(val, regsize * i);
+		}
 	}
 
 access_error:
@@ -99,7 +118,8 @@ mlxreg_io_attr_show(struct device *dev, struct device_attribute *attr,
 	u32 regval = 0;
 	int ret;
 
-	ret = mlxreg_io_get_reg(priv->pdata->regmap, data, 0, true, &regval);
+	ret = mlxreg_io_get_reg(priv->pdata->regmap, data, 0, true,
+				priv->regsize, &regval);
 	if (ret)
 		goto access_error;
 
@@ -128,7 +148,7 @@ mlxreg_io_attr_store(struct device *dev, struct device_attribute *attr,
 		return ret;
 
 	ret = mlxreg_io_get_reg(priv->pdata->regmap, data, input_val, false,
-				&regval);
+				priv->regsize, &regval);
 	if (ret)
 		goto access_error;
 
@@ -207,6 +227,9 @@ static int mlxreg_io_probe(struct platform_device *pdev)
 	}
 
 	priv->pdev = pdev;
+	priv->regsize = regmap_get_val_bytes(priv->pdata->regmap);
+	if (priv->regsize < 0)
+		return priv->regsize;
 
 	err = mlxreg_io_attr_init(priv);
 	if (err) {
-- 
2.11.0

