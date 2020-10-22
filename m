Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CEE2956BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 05:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895371AbgJVDZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 23:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443433AbgJVDZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 23:25:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690FAC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 20:25:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh6so219532plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 20:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jxxvL7wHWoXhk6pG78uaYuFXq7yBkOv3Nog2ApQvK5U=;
        b=KTNMPTmQjVQ+eKLVfLK3r90I04XTr6E2Lp+f4wiQigFNl+q9XKvdYXq9u5bRftgVmA
         1YHl144OodsejN1Mhdq94j0yy/nVcjhBZuQXZquW1LaKVtfg/4SzwofPO5ghWaogwzVB
         /2tTtrAZcY+a3L+tx4aQw9QJPrUldMK7bGHv01faJl4qIgLGDmYatxV048104MplImeF
         DM5blLTD7oZd+hmjDuSkGIWYQEjPhBEmbPTab3NF0pvXgufXmZa9KuNasGTBdclyTE4R
         YdHTREf6PaQT/to8AQr1jU4et6jWm63Z0jBBIsuVWbiUrPQkyGdnDNx4Q7Vub8Hvj+HK
         PNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jxxvL7wHWoXhk6pG78uaYuFXq7yBkOv3Nog2ApQvK5U=;
        b=hfjVMbkJWk/MtD3o/uL1xzHezrB/eCQnaoyCI+F16gnYBY6Yy5TI30b2gGPzuEjDKD
         WaEe8xnEUg78mfg6xmmqQ7Ca8GlFgxNTHAeqV8AQDmAramg8hSSzcw/Hd4Cl9VzPz0/i
         JUryVbiAmvdDdusxBTup4KkiN87DtzK4g6gV2nYg9Q46aaa/FsvoYUfmO1zrzAVK4tAN
         KIaJpVoy6ersgOejDCGpUPYpd1VcIHoO7kYhzuuFWirVsjY7hFARWtLFsnkB9F1lDy/n
         l1nCK/QVOjOhoUZsW3A+jICqQzsg1lFoHk0qdK8jYwzs/llA0w64wiGo8wVlON/wktxM
         mb8Q==
X-Gm-Message-State: AOAM533//kjx1WI0+Xjn4Vw+FdIDN2fL96+KtVRiNP6Td1qCr/wm3MEY
        jrpqLcY1zW5u05OHW9F4qgiE5LvKxTK6sA==
X-Google-Smtp-Source: ABdhPJxfsBZBWLBiB1mMmr8WfNcJLp2tjq2bb5j4pqYF63xlczSZJGtdcuQNbywuWOsvmw9WP+7TWA==
X-Received: by 2002:a17:902:d20a:b029:d4:c79c:b156 with SMTP id t10-20020a170902d20ab02900d4c79cb156mr526526ply.46.1603337150600;
        Wed, 21 Oct 2020 20:25:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id 38sm277478pgx.43.2020.10.21.20.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 20:25:49 -0700 (PDT)
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
Date:   Thu, 22 Oct 2020 03:25:46 +0000
Message-Id: <20201022032547.92704-1-john.stultz@linaro.org>
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
index bdf0925da6b6..a2a88284a95b 100644
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

