Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A48926924E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgINQ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:58:32 -0400
Received: from node.akkea.ca ([192.155.83.177]:44356 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgINQ46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:56:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 8CDE74E204B;
        Mon, 14 Sep 2020 16:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1600102043; bh=0Pzbd17e7CbhuElLViFYyyzSJECTVZA1vmwBVT9Ng34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WwdngWC1GUqBzXTWSDnRkhez3SNXb0Bd8Qn8MqqWdN2m2lfA3o5t2891qXvii3+Zh
         mbr5oDHEFnaWKRNUZ9A9OTjOWPnA8Hw9pRI7scK73Wrb+u1gU3daEPiVSIMRiHm/9S
         zbCyyLFCmC3Y4SCgCXhAx1kH2TVUy1l17n+l4iHw=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2YUEemsaHCiz; Mon, 14 Sep 2020 16:47:22 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 5D5E94E201F;
        Mon, 14 Sep 2020 16:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1600102042; bh=0Pzbd17e7CbhuElLViFYyyzSJECTVZA1vmwBVT9Ng34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SQnMAEm76y+6Vy313sZFIPJTIl1pwg2XjXI1vdAFb7WZQ3r2eBEoHVFdP5RywHvUH
         4tJmBteA1VXviIo6oAmavHbXA6jmsLu0V8aOGMdaqtS9kSHw1NlQhYmoM62kZPRVGX
         zYKOlnDTf64oIxhfzyE/jVx7OuhRrlQ5+s1Y9anM=
From:   Angus Ainslie <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bryan.odonoghue@linaro.org, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH 4/4] usb: typec: tps6598x: Add the power delivery irq
Date:   Mon, 14 Sep 2020 09:46:39 -0700
Message-Id: <20200914164639.1487650-5-angus@akkea.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914164639.1487650-1-angus@akkea.ca>
References: <20200914164639.1487650-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the PD irq and decode the contract.

Signed-off-by: Angus Ainslie <angus@akkea.ca>
---
 drivers/usb/typec/tps6598x.c | 386 ++++++++++++++++++++++++++++++++---
 1 file changed, 360 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
index d5aa58c9da0a..2eb883ff822c 100644
--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -30,11 +30,19 @@
 #define TPS_REG_STATUS			0x1a
 #define TPS_REG_SYSTEM_CONF		0x28
 #define TPS_REG_CTRL_CONF		0x29
+#define TPS_REG_ACTIVE_CONTRACT_PDO	0x34
+#define TPS_REG_ACTIVE_CONTRACT_RDO	0x35
 #define TPS_REG_POWER_STATUS		0x3f
 #define TPS_REG_RX_IDENTITY_SOP		0x48
+#define TPS_REG_DATA_STATUS		0x5f
 
 /* TPS_REG_INT_* bits */
 #define TPS_REG_INT_PLUG_EVENT		BIT(3)
+#define TPS_REG_INT_NEW_CONTRACT_SNK	BIT(12)
+#define TPS_REG_INT_PWR_STATUS_UPDATE	BIT(24)
+#define TPS_REG_INT_DATA_STATUS_UPDATE	BIT(25)
+#define TPS_REG_INT_STATUS_UPDATE	BIT(26)
+#define TPS_REG_INT_PD_STATUS_UPDATE	BIT(27)
 
 /* TPS_REG_STATUS bits */
 #define TPS_STATUS_PLUG_PRESENT		BIT(0)
@@ -57,8 +65,16 @@ enum {
 };
 
 /* TPS_REG_POWER_STATUS bits */
+#define TPS_POWER_STATUS_CONNECTION	BIT(0)
 #define TPS_POWER_STATUS_SOURCESINK	BIT(1)
+#define TPS_POWER_STATUS_BC12_CON	BIT(4)
+#define TPS_POWER_STATUS_BC_SDP		0
+#define TPS_POWER_STATUS_BC_CDP		2
+#define TPS_POWER_STATUS_BC_DCP		3
+
+#define TPS_POWER_STATUS_BCOPMODE(p)	(((p) & GENMASK(6, 5)) >> 5)
 #define TPS_POWER_STATUS_PWROPMODE(p)	(((p) & GENMASK(3, 2)) >> 2)
+#define TPS_POWER_STATUS_SRC(p)		(!(((p) & BIT(1)) >> 1))
 
 /* TPS_REG_RX_IDENTITY_SOP */
 struct tps6598x_rx_identity_reg {
@@ -217,21 +233,237 @@ static void tps6598x_set_data_role(struct tps6598x *tps,
 }
 
 #ifdef CONFIG_EXTCON
-static void tps6589x_set_extcon_state(struct tps6598x *tps,
-				      u32 status, u16 pwr_status, bool state)
+
+/*
+ *   the PDO decoding comes from here
+ *   https://www.ti.com/lit/an/slva842/slva842.pdf
+ */
+
+struct contract_terms {
+	u8 type;
+	bool dr_power;
+	bool dr_data;
+	bool higher_cap;
+	bool ext_powered;
+	bool usb_comms;
+	int max_voltage;
+	int max_current;
+	int max_power;
+};
+
+#define PDO_CONTRACT_TYPE(x)	(x >> 30 & 0x3)
+#define PDO_CONTRACT_FIXED	0
+#define PDO_CONTRACT_BATTERY	1
+#define PDO_CONTRACT_VARIABLE	2
+
+#define PDO_CONTRACT_DR_POWER		BIT(29)
+#define PDO_CONTRACT_HIGHER_CAP		BIT(28)
+#define PDO_CONTRACT_EXTERNAL_PWR	BIT(27)
+#define PDO_CONTRACT_USB_COMMS		BIT(26)
+#define PDO_CONTRACT_DR_DATA		BIT(25)
+
+#define PDO_CONTRACT_VOLTAGE(x)		((x >> 10 & 0x3ff) * 50)
+#define PDO_CONTRACT_MIN_VOLTAGE(x)	PDO_CONTRACT_VOLTAGE(x)
+#define PDO_CONTRACT_MAX_VOLTAGE(x)	((x >> 20 & 0x3ff) * 50)
+#define PDO_CONTRACT_CURRENT(x)		((x & 0x3ff) * 10)
+#define PDO_CONTRACT_POWER(x)		((x & 0x3ff) * 250)
+
+static int tps6598x_decode_pdo_contract(struct tps6598x *tps, u32 contract,
+					struct contract_terms *terms)
+{
+	int min_voltage = 5000; // mV
+
+	memset(terms, 0, sizeof(struct contract_terms));
+
+	dev_dbg(tps->dev, "%s 0x%x\n", __func__, contract);
+
+	switch (PDO_CONTRACT_TYPE(contract)) {
+	case PDO_CONTRACT_FIXED:
+		terms->type = PDO_CONTRACT_FIXED;
+		if (contract & PDO_CONTRACT_DR_POWER) {
+			dev_dbg(tps->dev, "Dual role power\n");
+			terms->dr_power = true;
+		}
+		if (contract & PDO_CONTRACT_DR_DATA) {
+			dev_dbg(tps->dev, "Dual role data\n");
+			terms->dr_data = true;
+		}
+		if (contract & PDO_CONTRACT_HIGHER_CAP) {
+			dev_dbg(tps->dev, "Higher capbility\n");
+			terms->higher_cap = true;
+		}
+		if (contract & PDO_CONTRACT_EXTERNAL_PWR) {
+			dev_dbg(tps->dev, "Externally powered\n");
+			terms->ext_powered = true;
+		}
+		if (contract & PDO_CONTRACT_USB_COMMS) {
+			dev_dbg(tps->dev, "USB communications capable\n");
+			terms->usb_comms = true;
+		}
+		terms->max_voltage = PDO_CONTRACT_VOLTAGE(contract);
+		terms->max_current = PDO_CONTRACT_CURRENT(contract);
+		terms->max_power = (terms->max_voltage * terms->max_current) / 1000;
+		dev_dbg(tps->dev, "Fixed contract uVMIN:uVMAX:uA:uW %d:%d:%d:%d\n",
+			min_voltage, terms->max_voltage, terms->max_current,
+			terms->max_power);
+		break;
+	case PDO_CONTRACT_BATTERY:
+		min_voltage = PDO_CONTRACT_MIN_VOLTAGE(contract);
+		terms->max_voltage = PDO_CONTRACT_MAX_VOLTAGE(contract);
+		terms->max_power = PDO_CONTRACT_POWER(contract);
+		terms->max_current = terms->max_power / (terms->max_voltage / 1000);
+		dev_dbg(tps->dev, "Battery contract uVMIN:uVMAX:uA:uW %d:%d:%d:%d\n",
+			min_voltage, terms->max_voltage, terms->max_current,
+			terms->max_power);
+		break;
+	case PDO_CONTRACT_VARIABLE:
+		min_voltage = PDO_CONTRACT_MIN_VOLTAGE(contract);
+		terms->max_voltage = PDO_CONTRACT_MAX_VOLTAGE(contract);
+		terms->max_current = PDO_CONTRACT_CURRENT(contract);
+		terms->max_power = (terms->max_voltage * terms->max_current) / 1000;
+		dev_dbg(tps->dev, "Variable contract uVMIN:uVMAX:uA:uW %d:%d:%d:%d\n",
+			min_voltage, terms->max_voltage, terms->max_current,
+			terms->max_power);
+		break;
+	default:
+		dev_warn(tps->dev, "Unknown supply\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tps6598x_pdo_contract(struct tps6598x *tps, u32 contract)
 {
 	union extcon_property_value val;
-	int max_current;
+	struct contract_terms terms;
 
-	if (TPS_STATUS_DATAROLE(status)) {
-		extcon_set_state(tps->edev, EXTCON_USB, false);
-		extcon_set_state(tps->edev, EXTCON_USB_HOST, state);
+	tps6598x_decode_pdo_contract(tps, contract, &terms);
+
+	val.intval = terms.max_current;
+	extcon_set_property(tps->edev, EXTCON_USB,
+			    EXTCON_PROP_USB_VBUS_CURRENT,
+			    val);
+	extcon_set_property(tps->edev, EXTCON_USB_HOST,
+			    EXTCON_PROP_USB_VBUS_CURRENT,
+			    val);
+
+	val.intval = terms.max_voltage;
+	extcon_set_property(tps->edev, EXTCON_USB,
+			    EXTCON_PROP_USB_VBUS_VOLTAGE,
+			    val);
+	extcon_set_property(tps->edev, EXTCON_USB_HOST,
+			    EXTCON_PROP_USB_VBUS_VOLTAGE,
+			    val);
+
+	return terms.max_current;
+}
+
+#define RDO_CONTRACT_OBJ_POSITION		BIT(29)
+#define RDO_CONTRACT_CAPABILITY_MISMATCH	BIT(27)
+#define RDO_CONTRACT_USB_COMMS			BIT(26)
+#define RDO_CONTRACT_NO_SUSPEND			BIT(25)
+
+#define RDO_CONTRACT_CURRENT(x)		((x >> 10 & 0x3ff) * 10)
+#define RDO_CONTRACT_POWER(x)		((x >> 10 & 0x3ff) * 250)
+#define RDO_CONTRACT_MAX_CURRENT(x)	((x & 0x3ff) * 10)
+#define RDO_CONTRACT_MAX_POWER(x)	((x & 0x3ff) * 250)
+
+static int tps6598x_decode_rdo_contract(struct tps6598x *tps, u32 contract, bool battery,
+					struct contract_terms *terms)
+{
+	memset(terms, 0, sizeof(struct contract_terms));
+
+	if (contract & RDO_CONTRACT_OBJ_POSITION)
+		dev_dbg(tps->dev, "Object position\n");
+	if (contract & RDO_CONTRACT_CAPABILITY_MISMATCH)
+		dev_dbg(tps->dev, "Capbility mismatch\n");
+	if (contract & RDO_CONTRACT_USB_COMMS)
+		dev_dbg(tps->dev, "USB communications capable\n");
+	if (contract & RDO_CONTRACT_NO_SUSPEND)
+		dev_dbg(tps->dev, "No USB suspend\n");
+	if (battery) {
+		terms->max_power = RDO_CONTRACT_MAX_POWER(contract);
+		dev_dbg(tps->dev, "Power %d max power %d\n", RDO_CONTRACT_POWER(contract),
+			terms->max_power);
 	} else {
-		extcon_set_state(tps->edev, EXTCON_USB, state);
-		extcon_set_state(tps->edev, EXTCON_USB_HOST, false);
+		terms->max_current = RDO_CONTRACT_MAX_CURRENT(contract); /* mA */
+		dev_dbg(tps->dev, "Current %d max current %d\n", RDO_CONTRACT_CURRENT(contract),
+			terms->max_current);
 	}
 
-	val.intval = TPS_STATUS_PORTROLE(status);
+	return 0;
+}
+
+static int tps6598x_rdo_contract(struct tps6598x *tps, u32 contract, bool battery)
+{
+	union extcon_property_value val;
+	struct contract_terms terms;
+
+	if (battery)
+		dev_dbg(tps->dev, "Battery supply\n");
+
+	tps6598x_decode_rdo_contract(tps, contract, battery, &terms);
+
+	if (terms.max_current > 0) {
+		val.intval = terms.max_current;
+		extcon_set_property(tps->edev, EXTCON_USB,
+				    EXTCON_PROP_USB_VBUS_CURRENT,
+				    val);
+		extcon_set_property(tps->edev, EXTCON_USB_HOST,
+				    EXTCON_PROP_USB_VBUS_CURRENT,
+				    val);
+
+	}
+
+	return terms.max_current;
+}
+
+static int tps6598x_set_extcon_pd_state(struct tps6598x *tps, bool state)
+{
+	u32 pdo_contract, rdo_contract;
+	int ret, max_current;
+
+	ret = tps6598x_read32(tps,
+			      TPS_REG_ACTIVE_CONTRACT_RDO,
+			      &rdo_contract);
+	if (ret) {
+		dev_dbg(tps->dev,
+			"failed to read RDO contract - try PDO contract\n");
+		rdo_contract = 0;
+	}
+
+	if (rdo_contract != 0) {
+		max_current = tps6598x_rdo_contract(tps, rdo_contract, false);
+	} else {
+		ret = tps6598x_read32(tps,
+				      TPS_REG_ACTIVE_CONTRACT_PDO,
+				      &pdo_contract);
+		max_current = tps6598x_pdo_contract(tps, pdo_contract);
+		if (ret || pdo_contract == 0)
+			dev_err(tps->dev, "failed to read PDO contract\n");
+	}
+
+	extcon_set_state(tps->edev, EXTCON_CHG_USB_PD, state);
+	extcon_sync(tps->edev, EXTCON_CHG_USB_PD);
+
+	return max_current;
+}
+
+static void tps6598x_set_extcon_power_state(struct tps6598x *tps, u32 status,
+					    u16 pwr_status)
+{
+	int max_current = 100;
+	union extcon_property_value val;
+	u8 connected;
+
+	/* USB C power source */
+	val.intval = TPS_POWER_STATUS_SRC(pwr_status) &&
+		TPS_STATUS_PORTROLE(status);
+
+	dev_dbg(tps->dev, "Power status 0x%x Source %d\n", pwr_status,
+		val.intval);
+
 	extcon_set_property(tps->edev, EXTCON_USB_HOST,
 			    EXTCON_PROP_USB_VBUS_SRC,
 			    val);
@@ -240,28 +472,55 @@ static void tps6589x_set_extcon_state(struct tps6598x *tps,
 			    EXTCON_PROP_USB_VBUS_SRC,
 			    val);
 
-	extcon_set_state(tps->edev, EXTCON_CHG_USB_SDP, 0);
-	extcon_set_state(tps->edev, EXTCON_CHG_USB_DCP, 0);
-	extcon_set_state(tps->edev, EXTCON_CHG_USB_CDP, 0);
-	extcon_set_state(tps->edev, EXTCON_CHG_USB_SLOW, 0);
-	extcon_set_state(tps->edev, EXTCON_CHG_USB_FAST, 0);
+	connected = pwr_status & TPS_POWER_STATUS_CONNECTION;
+
+	if (pwr_status & TPS_POWER_STATUS_BC12_CON) {
+		switch (TPS_POWER_STATUS_BCOPMODE(pwr_status)) {
+		case TPS_POWER_STATUS_BC_SDP:
+			/* TODO: detect USB3 900mA */
+			extcon_set_state(tps->edev,
+					 EXTCON_CHG_USB_SLOW, connected);
+			dev_dbg(tps->dev, "BC1.2 SDP detected\n");
+			extcon_set_state(tps->edev,
+					 EXTCON_CHG_USB_SDP, connected);
+			break;
+		case TPS_POWER_STATUS_BC_CDP:
+			dev_dbg(tps->dev, "BC1.2 CDP detected\n");
+			extcon_set_state(tps->edev,
+					 EXTCON_CHG_USB_CDP, connected);
+			break;
+		case TPS_POWER_STATUS_BC_DCP:
+			dev_dbg(tps->dev, "BC1.2 DCP detected\n");
+			extcon_set_state(tps->edev,
+					 EXTCON_CHG_USB_DCP, connected);
+			break;
+		default:
+			dev_dbg(tps->dev, "BC1.2 unknown - reserved\n");
+			break;
+
+		}
+	}
 
 	switch (TPS_POWER_STATUS_PWROPMODE(pwr_status)) {
 	case TYPEC_PWR_MODE_USB:
-		max_current = val.intval = 500;
-		extcon_set_state(tps->edev, EXTCON_CHG_USB_SDP, state);
-		extcon_set_state(tps->edev, EXTCON_CHG_USB_SLOW, state);
+		if (max_current < 500)
+			max_current = 500;
+		/* TODO: detect UBS3 900mA */
+		extcon_set_state(tps->edev, EXTCON_CHG_USB_SLOW, connected);
+		extcon_set_state(tps->edev, EXTCON_CHG_USB_SDP, connected);
 		break;
 	case TYPEC_PWR_MODE_1_5A:
-		max_current = val.intval = 1500;
-		extcon_set_state(tps->edev, EXTCON_CHG_USB_CDP, state);
+		if (max_current < 1500)
+			max_current = 1500;
+		extcon_set_state(tps->edev, EXTCON_CHG_USB_CDP, connected);
 		break;
 	case TYPEC_PWR_MODE_3_0A:
-		max_current = val.intval = 3000;
-		extcon_set_state(tps->edev, EXTCON_CHG_USB_CDP, state);
+		if (max_current < 3000)
+			max_current = 3000;
 		break;
 	case TYPEC_PWR_MODE_PD:
-		max_current = 500;
+		extcon_set_state(tps->edev, EXTCON_CHG_USB_PD, connected);
+		max_current = tps6598x_set_extcon_pd_state(tps, connected);
 		break;
 	}
 
@@ -272,6 +531,38 @@ static void tps6589x_set_extcon_state(struct tps6598x *tps,
 	extcon_set_property(tps->edev, EXTCON_USB_HOST,
 			    EXTCON_PROP_USB_VBUS_CURRENT,
 			    val);
+}
+
+static void tps6598x_set_extcon_state(struct tps6598x *tps,
+				      u32 status, u16 pwr_status, bool state)
+{
+	union extcon_property_value val;
+
+	if (TPS_STATUS_DATAROLE(status)) {
+		extcon_set_state(tps->edev, EXTCON_USB, false);
+		extcon_set_state(tps->edev, EXTCON_USB_HOST, state);
+	} else {
+		extcon_set_state(tps->edev, EXTCON_USB, state);
+		extcon_set_state(tps->edev, EXTCON_USB_HOST, false);
+	}
+
+	val.intval = TPS_STATUS_PORTROLE(status);
+	extcon_set_property(tps->edev, EXTCON_USB_HOST,
+			    EXTCON_PROP_USB_VBUS,
+			    val);
+
+	extcon_set_property(tps->edev, EXTCON_USB,
+			    EXTCON_PROP_USB_VBUS,
+			    val);
+
+	extcon_set_state(tps->edev, EXTCON_CHG_USB_SDP, 0);
+	extcon_set_state(tps->edev, EXTCON_CHG_USB_DCP, 0);
+	extcon_set_state(tps->edev, EXTCON_CHG_USB_CDP, 0);
+	extcon_set_state(tps->edev, EXTCON_CHG_USB_SLOW, 0);
+	extcon_set_state(tps->edev, EXTCON_CHG_USB_FAST, 0);
+	extcon_set_state(tps->edev, EXTCON_CHG_USB_PD, 0);
+
+	tps6598x_set_extcon_power_state(tps, status, pwr_status);
 
 	extcon_sync(tps->edev, EXTCON_CHG_USB_SDP);
 	extcon_sync(tps->edev, EXTCON_CHG_USB_CDP);
@@ -323,9 +614,9 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
 	if (desc.identity)
 		typec_partner_set_identity(tps->partner);
 
-#ifdef CONFIG_EXTCON
-	tps6598x_set_extcon_state(tps, status, pwr_status, true);
-#endif
+	dev_dbg(tps->dev, "%s: mode 0x%x pwr_role %d vconn_role %d data_role %d\n",
+		__func__, mode, TPS_STATUS_PORTROLE(status),
+		TPS_STATUS_VCONN(status), TPS_STATUS_DATAROLE(status));
 
 	return 0;
 }
@@ -494,7 +785,12 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	u64 event1;
 	u64 event2;
 	u32 status;
+	u32 data_status;
+	u16 power_status;
 	int ret;
+#ifdef CONFIG_EXTCON
+	bool connected;
+#endif
 
 	mutex_lock(&tps->lock);
 
@@ -514,8 +810,20 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 		goto err_clear_ints;
 	}
 
+	connected = status & TPS_STATUS_PLUG_PRESENT;
+	ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &power_status);
+	if (ret < 0)
+		goto err_clear_ints;
+
+	ret = tps6598x_read32(tps, TPS_REG_DATA_STATUS, &data_status);
+	if (ret < 0)
+		goto err_clear_ints;
+
+	dev_dbg(tps->dev, "Status: 0x%x data: 0x%x power: 0x%x", status,
+		data_status, power_status);
+
 	/* Handle plug insert or removal */
-	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT) {
+	if ((event1 | event2) & (TPS_REG_INT_PLUG_EVENT)) {
 		if (status & TPS_STATUS_PLUG_PRESENT) {
 			ret = tps6598x_connect(tps, status);
 			if (ret)
@@ -526,6 +834,19 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 		}
 	}
 
+#ifdef CONFIG_EXTCON
+	/* updated power or data status register */
+	/* power bits sometimes change without triggering an interrupt */
+	if ((event1 | event2) & (TPS_REG_INT_STATUS_UPDATE |
+				 TPS_REG_INT_PWR_STATUS_UPDATE |
+				 TPS_REG_INT_DATA_STATUS_UPDATE |
+				 TPS_REG_INT_NEW_CONTRACT_SNK |
+				 TPS_REG_INT_PD_STATUS_UPDATE)) {
+		dev_dbg(tps->dev, "%s: update extcon\n", __func__);
+		tps6598x_set_extcon_state(tps, status, power_status, connected);
+	}
+#endif
+
 err_clear_ints:
 	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
 	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
@@ -591,6 +912,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	u32 conf;
 	u32 vid;
 	int ret;
+	u64 mask;
 
 	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
 	if (!tps)
@@ -735,6 +1057,18 @@ static int tps6598x_probe(struct i2c_client *client)
 		goto err_role_put;
 	}
 
+	mask = TPS_REG_INT_NEW_CONTRACT_SNK
+		| TPS_REG_INT_PLUG_EVENT
+		| TPS_REG_INT_PWR_STATUS_UPDATE
+		| TPS_REG_INT_DATA_STATUS_UPDATE
+		| TPS_REG_INT_STATUS_UPDATE
+		| TPS_REG_INT_PD_STATUS_UPDATE;
+
+	ret = tps6598x_write64(tps, TPS_REG_INT_MASK1, mask);
+	ret |= tps6598x_write64(tps, TPS_REG_INT_MASK2, mask);
+	if (ret < 0)
+		dev_err(&client->dev, "failed to set irq mask %d\n", ret);
+
 	i2c_set_clientdata(client, tps);
 
 	return 0;
-- 
2.25.1

