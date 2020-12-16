Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E012DC508
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 18:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgLPRGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 12:06:50 -0500
Received: from mib.mailinblack.com ([137.74.84.110]:50864 "EHLO
        mib.mailinblack.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgLPRGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 12:06:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by mib.mailinblack.com (Postfix) with ESMTP id C07141A5836
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 17:00:01 +0000 (UTC)
Received: from mib.mailinblack.com (localhost [127.0.0.1])
        by mib.mailinblack.com
        with SMTP (Mib Daemon ) id KIRNUFG8;
        Wed, 16 Dec 2020 17:00:01 +0000 (UTC)
Received: from zimbra2.kalray.eu (zimbra2.kalray.eu [92.103.151.219])
        by mib.mailinblack.com (Postfix) with ESMTPS id 858751A5833;
        Wed, 16 Dec 2020 17:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 5DD5527E073C;
        Wed, 16 Dec 2020 18:00:01 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LdRLSQV6iX63; Wed, 16 Dec 2020 18:00:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id B503227E072A;
        Wed, 16 Dec 2020 18:00:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu B503227E072A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1608138000;
        bh=luYzFtV2U00TFka/Tl1Qa5x4XSe1JBfdn48AvPrA1nU=;
        h=From:To:Date:Message-Id;
        b=NznviWo+DXI63vG/BMsfJ3+Voru02WnlfhKsiUrAdrtjTgaP74EYBrRM8oo1+rgBb
         DnjUzD5QHVeRmpH7YN/MfX8LLt/cWoWlNF1N2ZGMmHEKGXOzzR6SChcMtiL7MiLbs2
         wsR/qYjheIFPQHAw5+2vPOTIiAole7xuSP78RNBQ=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cvWQL9wjT6GJ; Wed, 16 Dec 2020 18:00:00 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 95DF127E04F7;
        Wed, 16 Dec 2020 18:00:00 +0100 (CET)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Minas Harutyunyan <hminas@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jules Maselbas <jmaselbas@kalray.eu>
Subject: [RFC PATCH] usb: dwc2: Try usb_get_phy_by_phandle instead of usb_get_phy
Date:   Wed, 16 Dec 2020 17:59:35 +0100
Message-Id: <20201216165935.9149-1-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On probe the dwc2 driver tries two path to get an usb phy, first calling
devm_phy_get() and secondly with devm_usb_get_phy().

However the current implementation of devm_phy_get() never return a valid
phy for usb-nop-xceiv. And the current implementation of devm_usb_get_phy
only check for phy that's has already been registered.

During boot, I see the dwc2 driver being probed before the usb-nop-xceiv
probe, this means that during the dwc2 probe the function devm_usb_get_phy
never finds the a phy (because it hasn't been registered yet) but never
cause the dwc2 probe to defer.

I tried to follow what is done by dwc3_core_get_phy(): if the current
device has an of_node then try to get the usb_phy by phandle instead of
using devm_usb_get_phy(). This way when the probe order is not good the
devm_usb_get_phy_by_phandle() function will return -EPROBE_DEFER.

Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
--- 8< ---

A snippet of the device-tree source I am using:
        &usb0 {
                phys = <&usb_phy0>;
                phy-names = "usb2-phy";
        };
        &usb_phy0 {
                #phy-cells = <0>;
                compatible = "usb-nop-xceiv";
                reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
        };
---
 drivers/usb/dwc2/platform.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index db9fd4bd1a38..b58ce996add7 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -251,7 +251,12 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 	}
 
 	if (!hsotg->phy) {
-		hsotg->uphy = devm_usb_get_phy(hsotg->dev, USB_PHY_TYPE_USB2);
+		if (hsotg->dev->of_node)
+			i = of_property_match_string(hsotg->dev->of_node, "phy-names", "usb2-phy");
+		if (hsotg->dev->of_node && i >= 0)
+			hsotg->uphy = devm_usb_get_phy_by_phandle(hsotg->dev, "phys", i);
+		else
+			hsotg->uphy = devm_usb_get_phy(hsotg->dev, USB_PHY_TYPE_USB2);
 		if (IS_ERR(hsotg->uphy)) {
 			ret = PTR_ERR(hsotg->uphy);
 			switch (ret) {
-- 
2.17.1


