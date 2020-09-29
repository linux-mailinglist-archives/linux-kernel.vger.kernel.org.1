Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440D927BAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 04:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgI2Ckc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 22:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgI2Ck3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 22:40:29 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F84C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 19:40:29 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id f4so1766259qvw.15
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 19:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FDE8JH5iPBDdMZrcw0lHN45wyLg7MEGTUUjFxal7+nQ=;
        b=raUIMniWFSZ0XB/SBEGAMmIRKuxTIUmhAwfUPEeRgwKwrS0VhS9LFiMv4ov9J76dWm
         MAiICCi//cuOlghcOvFW+lTvn0blowtmmfMjdzZ2OzW2DODV/5Q2ntkJPww93OL/OVws
         FhBm/h/6uBTJteA/Nr5UGyS1bolh7zak8xpPrZJGRf6VYVoau5S4h2TX98vfSVDa4Kb0
         /kCh5vLbfT4b8oTO7+aZFPcWJLoYYOm0smXmwwl7MndyL7F+z6wmrIrg3T6QU/tkcXXR
         oxWnGdncgc08GfbOJdog4xjlExV+/n/Iq3BrEpyM0Mi2JmRuaqczcZF6lBH8GQlWJiGb
         f3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FDE8JH5iPBDdMZrcw0lHN45wyLg7MEGTUUjFxal7+nQ=;
        b=HFRODWUTNSc+oI7OpZHcNQlcDMapJ//OVMCPP6IG0fr/Z1TnhjKpe/7w761ESYhZc+
         xa5ESOBMFEIxhW+dcwQx/wu+bsJLTbhVFTyHnJDtR5vsTZfedN9feDM+KFsORwEWHYWA
         yEXQFfseUcacUD5rIUzqFwuhxBHtbaU2u/fBvlcLgYHh+jiBybF9+nA1OOsdV7tnalR1
         V0IIgcDYijCnVxBX5S+zcumscj1tmfMxWpKKblrqodfnk30QaP6l2ink2VeiZrdUYOpJ
         q+3qOvrHnxbn27XqiuWXb0AX1lomDc1JY49JKL1M8h9D3IdH6ikKqkq2n3L5205Ovt+y
         xTWQ==
X-Gm-Message-State: AOAM531XxWM3cB71T8vRiQ/8AjULoNdCn9PHB3TDaaQFxhDJ1HucKM6c
        jFAxfUCIfWQnX6FlQF2NVNTsO+BecQc=
X-Google-Smtp-Source: ABdhPJyZs/dmhKwr7BM1wdaY5P3GGRaW3k2Mgh5jtN8BX2KtLRIlyMDXyL73gFUCdW+/5EluuTcoWKsJFVc=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:ad4:4891:: with SMTP id bv17mr2555873qvb.20.1601347228391;
 Mon, 28 Sep 2020 19:40:28 -0700 (PDT)
Date:   Mon, 28 Sep 2020 19:39:58 -0700
In-Reply-To: <20200929024004.244992-1-badhri@google.com>
Message-Id: <20200929024004.244992-10-badhri@google.com>
Mime-Version: 1.0
References: <20200929024004.244992-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v9 09/15] usb: typec: tcpm: frs sourcing vbus callback
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During FRS hardware autonomously starts to source vbus. Provide
callback to perform chip specific operations.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 9 +++++++++
 include/linux/usb/tcpm.h      | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 55535c4f66bf..02b7f623f584 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4090,7 +4090,16 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
 	case SRC_TRY_DEBOUNCE:
 		/* Do nothing, waiting for sink detection */
 		break;
+	case FR_SWAP_SEND:
+	case FR_SWAP_SEND_TIMEOUT:
+	case FR_SWAP_SNK_SRC_TRANSITION_TO_OFF:
+	case FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED:
+		if (port->tcpc->frs_sourcing_vbus)
+			port->tcpc->frs_sourcing_vbus(port->tcpc);
+		break;
 	case FR_SWAP_SNK_SRC_NEW_SINK_READY:
+		if (port->tcpc->frs_sourcing_vbus)
+			port->tcpc->frs_sourcing_vbus(port->tcpc);
 		tcpm_set_state(port, FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED, 0);
 		break;
 
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 09762d26fa0c..7303f518ba49 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -83,6 +83,9 @@ enum tcpm_transmit_type {
  *		Optional; Called to enable/disable PD 3.0 fast role swap.
  *		Enabling frs is accessory dependent as not all PD3.0
  *		accessories support fast role swap.
+ * @frs_sourcing_vbus:
+ *		Optional; Called to notify that vbus is now being sourced.
+ *		Low level drivers can perform chip specific operations, if any.
  */
 struct tcpc_dev {
 	struct fwnode_handle *fwnode;
@@ -109,6 +112,7 @@ struct tcpc_dev {
 			   const struct pd_message *msg);
 	int (*set_bist_data)(struct tcpc_dev *dev, bool on);
 	int (*enable_frs)(struct tcpc_dev *dev, bool enable);
+	void (*frs_sourcing_vbus)(struct tcpc_dev *dev);
 };
 
 struct tcpm_port;
-- 
2.28.0.709.gb0816b6eb0-goog

