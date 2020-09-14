Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161EF268C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgINNSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgINNHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:07:25 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44C11221E2;
        Mon, 14 Sep 2020 13:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600088802;
        bh=D4/cEZu2x9a8Nu2OwwGSUOUrmtuWtJMWUM1sdQah7Qk=;
        h=From:To:Cc:Subject:Date:From;
        b=u/e7SHkBYchmQZKC3BbDLpd7Nmkt2ceNqPOF382U3/hlXhO14L97YzFwOInd+uWTA
         suO8Iwv17dBwknCjhkfMCemvjBFZo+rVdD9IL4tN0SGqqLf32OVbsiG/5FlhyTNsRg
         nEZNDKdOrPVQv8JFNPAJnF+VdkiSl5rQPl+oDEtg=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kHoBs-00BgY1-An; Mon, 14 Sep 2020 14:06:40 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] usb: dwc2: Always disable regulators on driver teardown
Date:   Mon, 14 Sep 2020 14:06:34 +0100
Message-Id: <20200914130634.2424496-1-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@android.com, hminas@synopsys.com, gregkh@linuxfoundation.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the dwc2 driver fails to probe after having enabled the regulators,
it ends up being unregistered with regulators enabled, something the
core regulator code is legitimately upset about:

   dwc2 ff400000.usb: supply vusb_d not found, using dummy regulator
   dwc2 ff400000.usb: supply vusb_a not found, using dummy regulator
   dwc2 ff400000.usb: dwc2_core_reset: HANG! AHB Idle timeout GRSTCTL GRSTCTL_AHBIDLE
   WARNING: CPU: 2 PID: 112 at drivers/regulator/core.c:2074 _regulator_put.part.0+0x16c/0x174
   Modules linked in: dwc2(E+) dwc3(E) udc_core(E) rtc_hym8563(E) dwmac_generic(E) ulpi(E) usbcore(E) dwc3_meson_g12a(E) roles(E) meson_gx_mmc(E+) i2c_meson(E) mdio_mux_meson_g12a(E) mdio_mux(E) dwmac_meson8b(E) stmmac_platform(E) stmmac(E) mdio_xpcs(E) phylink(E) of_mdio(E) fixed_phy(E) libphy(E) pwm_regulator(E) fixed(E)
   CPU: 2 PID: 112 Comm: systemd-udevd Tainted: G            E     5.9.0-rc4-00102-g423583bc8cf9 #1840
   Hardware name: amlogic w400/w400, BIOS 2020.04 05/22/2020
   pstate: 80400009 (Nzcv daif +PAN -UAO BTYPE=--)
   pc : _regulator_put.part.0+0x16c/0x174
   lr : regulator_bulk_free+0x6c/0x9c
   sp : ffffffc012353820
   x29: ffffffc012353820 x28: ffffff805a4b7000
   x27: ffffff8059c2eac0 x26: ffffff8059c2e810
   x25: ffffff805a4b7d00 x24: ffffffc008cf3028
   x23: ffffffc011729ef8 x22: ffffff807e2761d8
   x21: ffffffc01171df78 x20: ffffff805a4b7700
   x19: ffffff805a4b7700 x18: 0000000000000030
   x17: 0000000000000000 x16: 0000000000000000
   x15: ffffff807ea8d178 x14: 3935312820435455
   x13: 2038323a36313a37 x12: ffffffffffffffff
   x11: 0000000000000040 x10: 0000000000000007
   x9 : ffffffc0106f77d0 x8 : ffffffffffffffe0
   x7 : ffffffffffffffff x6 : 0000000000017702
   x5 : ffffff805a4b7400 x4 : 0000000000000000
   x3 : ffffffc01171df78 x2 : ffffff807ea8cc40
   x1 : 0000000000000000 x0 : 0000000000000001
   Call trace:
    _regulator_put.part.0+0x16c/0x174
    regulator_bulk_free+0x6c/0x9c
    devm_regulator_bulk_release+0x28/0x3c
    release_nodes+0x1c8/0x2c0
    devres_release_all+0x44/0x6c
    really_probe+0x1ec/0x504
    driver_probe_device+0x100/0x170
    device_driver_attach+0xcc/0xd4
    __driver_attach+0xb0/0x17c
    bus_for_each_dev+0x7c/0xd4
    driver_attach+0x30/0x3c
    bus_add_driver+0x154/0x250
    driver_register+0x84/0x140
    __platform_driver_register+0x54/0x60
    dwc2_platform_driver_init+0x2c/0x1000 [dwc2]
    do_one_initcall+0x54/0x2d0
    do_init_module+0x68/0x29c

In order to fix this, tie the regulator disabling to the teardown
process by registering a devm action callback. This makes sure that
the regulators are disabled at the right time (just before they are
released).

Cc: Minas Harutyunyan <hminas@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/usb/dwc2/platform.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index db9fd4bd1a38..44b78f1c5e1a 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -121,6 +121,13 @@ static int dwc2_get_dr_mode(struct dwc2_hsotg *hsotg)
 	return 0;
 }
 
+static void __dwc2_disable_regulators(void *data)
+{
+	struct dwc2_hsotg *hsotg = data;
+
+	regulator_bulk_disable(ARRAY_SIZE(hsotg->supplies), hsotg->supplies);
+}
+
 static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 {
 	struct platform_device *pdev = to_platform_device(hsotg->dev);
@@ -131,6 +138,11 @@ static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       __dwc2_disable_regulators, hsotg);
+	if (ret)
+		return ret;
+
 	if (hsotg->clk) {
 		ret = clk_prepare_enable(hsotg->clk);
 		if (ret)
@@ -186,10 +198,7 @@ static int __dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg)
 	if (hsotg->clk)
 		clk_disable_unprepare(hsotg->clk);
 
-	ret = regulator_bulk_disable(ARRAY_SIZE(hsotg->supplies),
-				     hsotg->supplies);
-
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.28.0

