Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB982EEB1E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbhAHBwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbhAHBwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:52:03 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C27C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 17:51:23 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c12so5228566pfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 17:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/9yRUK3ifPn4jWkGqxydFEM9X/uNu0aPyF+TlRNBzFw=;
        b=qaEUGAlhSBJJz0k547jBxG2kJxrjPzoD7C87YteZVKHStDtMmN+mdXS7ljLfYPMX8D
         bSfj32/jzcvyHmod0BtAVPfUIQR7Jz5xH9mvv+Uizi9FK6+zV0hPsVt96gGUcmc4FtJZ
         /TQB7biXj6E5+tSYoP6WPTU/pAqBQSjUZob4Ciy2Jy6lqvV5fPH0DrlRVs0g5sX4ZcJS
         qS0XxVbe9MD2W35BDeRfnD3FiWiGGS65C4IOpt1HOhfxDWL+RE/ONCaxy0oXkSV6ce5G
         ThoJmGcKGaO4Ygo8wBftsDtjGcCi2RnUSxD6GTPHOcEa+LGu2V/mPoyK7Sfo7jvK/1hB
         IRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/9yRUK3ifPn4jWkGqxydFEM9X/uNu0aPyF+TlRNBzFw=;
        b=VseW/tG5PtuChmk+mKsDejXwW9omjd1yQKEkz7hRPK8LhXEVYTxBLOg0R1jVNvURsI
         USJFRSY6JMTqZ7JiCdNhKtfKmCJT6ZLSnHltFS/IO6qZn60tO7GaODBLHzl+UI4wjmnX
         vNALGy/w3ezk5FaNb0hn2iqOGEVreIK6VfBJo7wSeVe693YiKmO54pvJu6KHEHbSZjws
         ZL9wPsgcfd57AF7PxH/7JX3Wzo3sOXghz7i5KaLoekHjnAkLmRQENyuhdlxUP2da1+vi
         cNvD2k8KFfOGbcc0opv/pLGIZ2wHeV7rmQIc1/PO11mcNwfwZr/PwNVkDqniBUDF65E/
         P30A==
X-Gm-Message-State: AOAM533gyUECmlBKMYsM3WGSBlP18Td87mj78e+qnYDDIoiaS6rq6CHc
        OUEnFN+OY4hD8FoduknHbFlvuJKXgJAj9Q==
X-Google-Smtp-Source: ABdhPJyreAjnxcrKczefp93YqgxrjjRc2/Fen+5GwEWM9pqajXC5EAzflLZ2kqmzioOVLu7KUBwrBw==
X-Received: by 2002:a62:5844:0:b029:1a8:b9dc:77bf with SMTP id m65-20020a6258440000b02901a8b9dc77bfmr1422210pfb.39.1610070682061;
        Thu, 07 Jan 2021 17:51:22 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id fw12sm6142756pjb.43.2021.01.07.17.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 17:51:20 -0800 (PST)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 1/2] usb: dwc3: Trigger a GCTL soft reset when switching modes in DRD
Date:   Fri,  8 Jan 2021 01:51:14 +0000
Message-Id: <20210108015115.27920-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

Just resending this, as discussion died out a bit and I'm not
sure how to make further progress. See here for debug data that
was requested last time around:
  https://lore.kernel.org/lkml/CALAqxLXdnaUfJKx0aN9xWwtfWVjMWigPpy2aqsNj56yvnbU80g@mail.gmail.com/

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

After resubmitting the quirk, Thinh Nguyen pointed out that it
shouldn't be a quirk at all and it is actually mentioned in the
programming guide that it should be done when switching modes
in DRD.

So, to avoid these !COREIDLE lockups seen on HiKey960, this
patch issues GCTL soft reset when switching modes if the
controller is in DRD mode.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
Cc: Yang Fei <fei.yang@intel.com>
Cc: YongQin Liu <yongqin.liu@linaro.org>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Thinh Nguyen <thinhn@synopsys.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Rework to always call the GCTL soft reset in DRD mode,
  rather then using a quirk as suggested by Thinh Nguyen

v3:
* Move GCTL soft reset under the spinlock as suggested by
  Thinh Nguyen
---
 drivers/usb/dwc3/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 841daec70b6e..b6a6b90eb2d5 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -114,10 +114,24 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
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
 	unsigned long flags;
+	int hw_mode;
 	int ret;
 	u32 reg;
 
@@ -156,6 +170,11 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
+	/* Execute a GCTL Core Soft Reset when switch mode in DRD*/
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD)
+		dwc3_gctl_core_soft_reset(dwc);
+
 	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
-- 
2.17.1

