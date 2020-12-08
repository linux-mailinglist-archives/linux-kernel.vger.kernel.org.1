Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA8E2D27C2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgLHJfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:35:01 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:52083 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgLHJe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:34:59 -0500
Received: from orion.localdomain ([95.117.39.192]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MT9v5-1kZbsd3Jc7-00UYHj; Tue, 08 Dec 2020 10:32:08 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     duncan.sands@free.fr, accessrunner-general@lists.sourceforge.net,
        linux-usb@vger.kernel.org
Subject: [PATCH 2/3] drivers: usb: atm: use atm_info() instead of atm_printk(KERN_INFO ...
Date:   Tue,  8 Dec 2020 10:32:05 +0100
Message-Id: <20201208093206.24780-2-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201208093206.24780-1-info@metux.net>
References: <20201208093206.24780-1-info@metux.net>
X-Provags-ID: V03:K1:EVW5sgMO+Nyr6/Q7JBQAJOvjGhq05Kh+Cj5rkzAExWOPkxyWWb2
 Pe9+Ug2XazTTvII0br64umsuX6qQZBOf92wRShZl3uxZA2kF9KeDaiu/vCdlrSeXiIS44kP
 9DpoZxBW6CcdAfMWZkUwajX0synUR/+Fu7D1N6/HW1w8K6IgF/DiMpUauYRChvO0Tb4/e1Z
 dETVTz9RHu3v2hW+B9S2Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3PdhFh3YYsA=:0t+VHXXSdko9VDnfUq9SQ5
 zHcqtISVphoQ6FGf4PhyBlQROuECywFWYiyPrpK7Ks0+vnsE5tcTTHoqRw2oJHbgOXSOPqSTK
 ANxRq4ISEctHnHwNLBedQrPlUd3wc0ZVHGh+PfGyMrUFSuFOlYrAuj3CJC2otWP+4V3/Ti5qu
 cutEkTFdZ/cpmgT8QBc/cnNOt6dSCqk/70n6j4V0KbmrV+9xtipedTONRjLuqljG7/0tvjdUP
 jBT581EsGl1EuB/CGmp1lUlVz6uwsQUkgqqMefzr5f3YgJDLbcu25ew02TFoh6WhWdWNDHY+I
 cWh7NLHnQ6ePSPeTExa71S4Wm2A9MqX1TakUflI1IGiR29kpif5izweysHkAeAQlM984pC1MY
 brgPQtzj4LwxFPdpahRN2lxlk5x9is9ZQqcSH/7520r275ydGQt1YUJp6wni0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we already have the useful atm_info() macro, use it instead of
raw atm_printk()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/usb/atm/cxacru.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 0114cc54e622..4d3947476f0e 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -849,15 +849,15 @@ static void cxacru_poll_status(struct work_struct *work)
 
 		switch (instance->adsl_status) {
 		case 0:
-			atm_printk(KERN_INFO, usbatm, "ADSL state: running\n");
+			atm_info(usbatm, "ADSL state: running\n");
 			break;
 
 		case 1:
-			atm_printk(KERN_INFO, usbatm, "ADSL state: stopped\n");
+			atm_info(usbatm, "ADSL state: stopped\n");
 			break;
 
 		default:
-			atm_printk(KERN_INFO, usbatm, "Unknown adsl status %02x\n", instance->adsl_status);
+			atm_info(usbatm, "Unknown adsl status %02x\n", instance->adsl_status);
 			break;
 		}
 	}
-- 
2.11.0

