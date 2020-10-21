Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63D529520C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503966AbgJUSSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438604AbgJUSSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:18:08 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F242C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:18:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id hk7so1553544pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3omciefNF/8rK7REiU69Pg1B4V8AnGbEcVyKqjDCirA=;
        b=Ha7l5R98oB/ER10E4Gz4sjCU3MrXiqMpsKcXCYkmH661Y48J2VXO2y1IySbOE54XJ6
         962iFUeEVPbKbspIC0gD/XD+cvehDOuH9LzhNNLdQPx+Km1CjbYPxrbaWFppgBkzUsLQ
         9Y6/EmrzynHjunomSYaPYNojopW78pAwldLPpkCQMZbEs/l5Uq8aaEHExSxnKvGM++/Z
         ZqLnGKZaRfqPaTq+Dz6aQxQHsDhmn+w/8gg4ma+orx8gV5IXG+C0HcvjP8GNG82m33kv
         nn2pPxPAXvRHWpIM46C/TMmuKj0OK1pM6t8Uut1OHRZY/E2bu21uSJ1aMvxNWnW7Yh0k
         PwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3omciefNF/8rK7REiU69Pg1B4V8AnGbEcVyKqjDCirA=;
        b=t3BA9FlUd72oVV4LM7nXAnNKbRfaKqPtRGkCDlpmd0bvtdVPyXLtdJyblE/vG+zwLw
         CQLxzNhjA35M4I+SV2xjB2WwyxB2cF0yXF+GAO7l4Aj6XqoVokqCgdwtm+nws7U3sLcA
         HnHxptPpYCbMTntlSTENaGAtIOfiaJIHFbE+4+XSJ4FoN/hIlcB32mWEzwVo7H6dCbCE
         pbanZZkdiRNAK5Jr3BctxPTx75+J3vUOMFqsOO9/F7JoPTdBjdHwO1zcdTUe8AlKS9kT
         0GsKSmAQ+M/Z/MVtYLzWpa6/vKIWw9j/zOrZ5GM1zjSzOycStiIKc5bVUcWk7mCw7GSM
         MoKA==
X-Gm-Message-State: AOAM5305g0VevYKlw8DO6ojGsQ8Au4MZASlX+D/Xf9EXe7K4j6AZ+iBf
        FTZd9O6GCc/1/myrgX/SlcXwL7PbF+2T+w==
X-Google-Smtp-Source: ABdhPJyxo3fqlXGJoJi+YiR/yXFHmwCcORlzemwww3j9P71T4oqSmV6laLgGR4Ickw7NMWjdTF/NYQ==
X-Received: by 2002:a17:90a:3d03:: with SMTP id h3mr4550138pjc.11.1603304287546;
        Wed, 21 Oct 2020 11:18:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id js21sm2513630pjb.14.2020.10.21.11.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 11:18:06 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH] usb: dwc3: Add quirk to trigger a GCTL soft reset for Hisilicon Kirin Soc Platform
Date:   Wed, 21 Oct 2020 18:18:03 +0000
Message-Id: <20201021181803.79650-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

With the current dwc3 code on the HiKey960 we often see the
COREIDLE flag get stuck off in __dwc3_gadget_start(), which
seems to prevent the reset irq and causes the USB gadget to
fail to initialize.

We had seen occasional initialization failures with older
kernels but with recent 5.x era kernels it seemed to be becoming
much more common, so I dug back through some older trees and
realized I dropped this quirk from Yu Chen during upstreaming
as I couldn't provide a proper rational for it and it didn't
seem to be necessary. I now realize I was wrong.

On the upside, I can now understand more why such a quirk is
needed.

So to address a quirk in the DesignWare USB3 DRD Core of
Hisilicon Kirin SoCs, this patch adds a quirk flag which
executes a GCTL soft reset when we switch modes.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
Cc: Yang Fei <fei.yang@intel.com>
Cc: YongQin Liu <yongqin.liu@linaro.org>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Thinh Nguyen <thinhn@synopsys.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../devicetree/bindings/usb/dwc3.txt          |  3 +++
 drivers/usb/dwc3/core.c                       | 19 +++++++++++++++++++
 drivers/usb/dwc3/core.h                       |  1 +
 3 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 1aae2b6160c1..f435bae0f172 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -81,6 +81,9 @@ Optional properties:
  - snps,dis-split-quirk: when set, change the way URBs are handled by the
 			 driver. Needed to avoid -EPROTO errors with usbhid
 			 on some devices (Hikey 970).
+ - snps,gctl-reset-quirk: When set, execute a soft reset on mode changes.
+                        Needed to avoid COREIDLE getting stuck off and the
+                        gadget to fail to initialize (HiKey960).
  - snps,is-utmi-l1-suspend: true when DWC3 asserts output signal
 			utmi_l1_suspend_n, false when asserts utmi_sleep_n
  - snps,hird-threshold: HIRD threshold
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index bdf0925da6b6..b138c67e3892 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -114,6 +114,19 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 	dwc->current_dr_role = mode;
 }
 
+static void dwc3_gctl_core_soft_reset(struct dwc3 *dwc)
+{
+	int reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+	reg |= (DWC3_GCTL_CORESOFTRESET);
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+	reg &= ~(DWC3_GCTL_CORESOFTRESET);
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+}
+
 static void __dwc3_set_mode(struct work_struct *work)
 {
 	struct dwc3 *dwc = work_to_dwc(work);
@@ -178,6 +191,10 @@ static void __dwc3_set_mode(struct work_struct *work)
 		}
 		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
+		/* Execute a GCTL Core Soft Reset when switch mode */
+		if (dwc->gctl_reset_quirk)
+			dwc3_gctl_core_soft_reset(dwc);
+
 		dwc3_event_buffers_setup(dwc);
 
 		if (dwc->usb2_phy)
@@ -1357,6 +1374,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 
 	dwc->dis_split_quirk = device_property_read_bool(dev,
 				"snps,dis-split-quirk");
+	dwc->gctl_reset_quirk = device_property_read_bool(dev,
+				"snps,gctl-reset-quirk");
 
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 74323b10a64a..993f243aedc8 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1252,6 +1252,7 @@ struct dwc3 {
 	unsigned		dis_metastability_quirk:1;
 
 	unsigned		dis_split_quirk:1;
+	unsigned		gctl_reset_quirk:1;
 
 	u16			imod_interval;
 };
-- 
2.17.1

