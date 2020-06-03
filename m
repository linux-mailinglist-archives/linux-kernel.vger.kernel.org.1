Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F6D1ED72C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 22:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgFCUD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 16:03:56 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:42817 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbgFCUDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:03:52 -0400
Received: from [78.134.115.170] (port=37458 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jgZc3-005dPA-9V; Wed, 03 Jun 2020 22:03:47 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>
Subject: [RFC 1/4] regulator: lp87565: enable voltage regardless of ENx pin
Date:   Wed,  3 Jun 2020 22:03:16 +0200
Message-Id: <20200603200319.16184-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200603200319.16184-1-luca@lucaceresoli.net>
References: <20200603200319.16184-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver enables outputs by setting bit EN_BUCKn in the BUCKn_CTRL1
register. However, if bit EN_PIN_CTRLn in the same register is set, the
output is actually enabled only if EN_BUCKn is set AND an enable pin is
active. Since the driver does not touch EN_PIN_CTRLn, the choice is left to
the hardware, which in turn gets this bit from OTP memory, and in absence
of OTP data it uses a default value that is documented in the datasheet for
LP8752x, but not for LP8756x.

Thus the driver doesn't really "know" whether it is actually enabling the
output or not.

In order to make sure activation is always driver-controlled, just clear
the EN_PIN_CTRLn bit. Now all activation solely depend on the EN_BUCKn bit.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

This is an RFC because there is a potential regression on existing
hardware. If there are boards where the enable pins _are_ used to toggle
power on/off in addition to I2C control, then this patch would make these
board ignore the enable pin as if it were always active.

Whether setups with ENx pins are used or not is hard to say. A Linux system
that needs to set a register _and_ to move a GPIO in order to enable a
regulatore output seems to me a bit weird, but there might be sound use
cases that I ignore.

I suspect the only solution that allows to configure the EN_PIN_CTRLn bits
correctly in all the possible hardware setups would be to tell in device
tree / board info whether each enable pin is connected or not (which is a
hardware _fact_) and which ENx pin should control which regulator output
(which is a policy). But it would make this simple driver considerably more
complex.

Any suggestion about the correct way to handle this situation would be
greatly appreciated.
---
 drivers/regulator/lp87565-regulator.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 5d525dacf959..fbed6bc80c1a 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -11,8 +11,8 @@
 
 #include <linux/mfd/lp87565.h>
 
-#define LP87565_REGULATOR(_name, _id, _of, _ops, _n, _vr, _vm, _er, _em, \
-			 _delay, _lr, _cr)				\
+#define LP87565_REGULATOR(_name, _id, _of, _ops, _n, _vr, _vm,		\
+			  _er, _em, _ev, _delay, _lr, _cr)		\
 	[_id] = {							\
 		.desc = {						\
 			.name			= _name,		\
@@ -28,6 +28,7 @@
 			.vsel_mask		= _vm,			\
 			.enable_reg		= _er,			\
 			.enable_mask		= _em,			\
+			.enable_val		= _ev,			\
 			.ramp_delay		= _delay,		\
 			.linear_ranges		= _lr,			\
 			.n_linear_ranges	= ARRAY_SIZE(_lr),	\
@@ -121,38 +122,54 @@ static const struct lp87565_regulator regulators[] = {
 	LP87565_REGULATOR("BUCK0", LP87565_BUCK_0, "buck0", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK0_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK0_CTRL_1,
+			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_EN_PIN_CTRL,
 			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK0_CTRL_2),
 	LP87565_REGULATOR("BUCK1", LP87565_BUCK_1, "buck1", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK1_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK1_CTRL_1,
+			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_EN_PIN_CTRL,
 			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK1_CTRL_2),
 	LP87565_REGULATOR("BUCK2", LP87565_BUCK_2, "buck2", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK2_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK2_CTRL_1,
+			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_EN_PIN_CTRL,
 			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK2_CTRL_2),
 	LP87565_REGULATOR("BUCK3", LP87565_BUCK_3, "buck3", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK3_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK3_CTRL_1,
+			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_EN_PIN_CTRL,
 			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK3_CTRL_2),
 	LP87565_REGULATOR("BUCK10", LP87565_BUCK_10, "buck10", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK0_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK0_CTRL_1,
 			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_EN_PIN_CTRL |
+			  LP87565_BUCK_CTRL_1_FPWM_MP_0_2,
+			  LP87565_BUCK_CTRL_1_EN |
 			  LP87565_BUCK_CTRL_1_FPWM_MP_0_2, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK0_CTRL_2),
 	LP87565_REGULATOR("BUCK23", LP87565_BUCK_23, "buck23", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK2_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK2_CTRL_1,
+			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_EN_PIN_CTRL,
 			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK2_CTRL_2),
 	LP87565_REGULATOR("BUCK3210", LP87565_BUCK_3210, "buck3210",
 			  lp87565_buck_ops, 256, LP87565_REG_BUCK0_VOUT,
 			  LP87565_BUCK_VSET, LP87565_REG_BUCK0_CTRL_1,
 			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_EN_PIN_CTRL |
+			  LP87565_BUCK_CTRL_1_FPWM_MP_0_2,
+			  LP87565_BUCK_CTRL_1_EN |
 			  LP87565_BUCK_CTRL_1_FPWM_MP_0_2, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK0_CTRL_2),
 };
-- 
2.27.0

