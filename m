Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39B4269245
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgINQ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:57:38 -0400
Received: from node.akkea.ca ([192.155.83.177]:44350 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgINQ4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:56:32 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Sep 2020 12:56:27 EDT
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id A1D7B4E2058;
        Mon, 14 Sep 2020 16:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1600102041; bh=E0GRQ2PpBo0S2NNbZCxY7J3VCK/b7Tg+kD/diSGlsCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mmPOkoL/KAzpxSan6HB+PUKDLC5HxVViarOTUGe5q52AkTioWuhAQF8AQlHY5s8HQ
         Ub5QRDF5gmt0CPqHEVPRuu1H1ilhwlnryWPkFEHRfUK0cQzinpR8meRK27gyMkv+yW
         8jn0++sP0lpiZY1uAKGDLCg7nlriswsZ7jESTkLM=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jFoZ_ECfCITF; Mon, 14 Sep 2020 16:47:21 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 109844E201F;
        Mon, 14 Sep 2020 16:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1600102041; bh=E0GRQ2PpBo0S2NNbZCxY7J3VCK/b7Tg+kD/diSGlsCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mmPOkoL/KAzpxSan6HB+PUKDLC5HxVViarOTUGe5q52AkTioWuhAQF8AQlHY5s8HQ
         Ub5QRDF5gmt0CPqHEVPRuu1H1ilhwlnryWPkFEHRfUK0cQzinpR8meRK27gyMkv+yW
         8jn0++sP0lpiZY1uAKGDLCg7nlriswsZ7jESTkLM=
From:   Angus Ainslie <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bryan.odonoghue@linaro.org, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH 1/4] extcon: Add USB VBUS properties
Date:   Mon, 14 Sep 2020 09:46:36 -0700
Message-Id: <20200914164639.1487650-2-angus@akkea.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914164639.1487650-1-angus@akkea.ca>
References: <20200914164639.1487650-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB type C, USB BC1.2 and USB power delivery allow different voltages
and currents for VBUS so we need these additional properties.

Also USB type C allows separate device and power roles so add a VBUS SRC
property.

Signed-off-by: Angus Ainslie <angus@akkea.ca>
---
 include/linux/extcon.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index fd183fb9c20f..c4d48f4f74c4 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -117,14 +117,29 @@
  * @type:       integer (intval)
  * @value:      0 (USB/USB2) or 1 (USB3)
  * @default:    0 (USB/USB2)
+ * - EXTCON_PROP_USB_VBUS_SRC
+ * @type:	integer (intval)
+ * @value:	0 (sink) or 1 (source)
+ * @default:	0 (sink)
+ * - EXTCON_PROP_USB_VBUS_VOLTAGE
+ * @type:	integer (intval)
+ * @value:	negotiated vbus voltage in mV
+ * @default:	5000
+ * - EXTCON_PROP_USB_VBUS_CURRENT
+ * @type:	integer (intval)
+ * @value:	negotiated vbus current in mA
+ * @default:	100
  *
  */
 #define EXTCON_PROP_USB_VBUS		0
 #define EXTCON_PROP_USB_TYPEC_POLARITY	1
 #define EXTCON_PROP_USB_SS		2
+#define EXTCON_PROP_USB_VBUS_SRC	3
+#define EXTCON_PROP_USB_VBUS_VOLTAGE	4
+#define EXTCON_PROP_USB_VBUS_CURRENT	5
 
 #define EXTCON_PROP_USB_MIN		0
-#define EXTCON_PROP_USB_MAX		2
+#define EXTCON_PROP_USB_MAX		5
 #define EXTCON_PROP_USB_CNT	(EXTCON_PROP_USB_MAX - EXTCON_PROP_USB_MIN + 1)
 
 /* Properties of EXTCON_TYPE_CHG. */
-- 
2.25.1

