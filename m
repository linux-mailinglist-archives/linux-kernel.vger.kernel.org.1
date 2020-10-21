Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF502954E3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 00:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506912AbgJUWqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 18:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506904AbgJUWqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 18:46:24 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61ABC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 15:46:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 19so2351890pge.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 15:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Yl4Y/ZzUqbDL5fTVWgJ1VesNcpeRsTPqSs1TyvB5H2Y=;
        b=QTnweYnCBSxbl9b89sHHA2Js7kV+ZTm0DcM5UkLUlAzkP0Pvld2y1wtens9HEwZGsT
         rppkETMLwVDexknu09JBjcK2bQi32XeHHAdP0oXwyl3PgSC/f3vT/jaGQ9TbJnKjKQbu
         xFmU0G/uOkVUNlr/tJdp0sJpzYpF5AwfWrIhoObgpmx6sCswvaeGPSYvHGjLKwqKr2p+
         G8uJ74VHjlCOXrZ+koqFK747eem/sP7Qsv/zNFxeE9EPIZ72o6Mky9Acdto/ZpJ4XYGa
         EN7Vnmt8xh7wNGutYiFuhZPJJWUnt3Zc1Iv/aoVaT8OP5xS65wDKh/i77rxbk2YKMwUX
         TH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yl4Y/ZzUqbDL5fTVWgJ1VesNcpeRsTPqSs1TyvB5H2Y=;
        b=GLN4UU5f7XCJ5aVN+cgkA7ymi/Jmc8hi8NfZXo5NKsw+aNI3O/elKyrNxoz47vfMoI
         TF8vDDzFWmADVaoSnJg9jBBVEbJesZPd2lmwQsCZcfgdgsx6li2qyHgvCMF7FpZKoTEv
         hgNIxIYGR0kGXcgSsmWhwYi4o1ahYVVNtMf/Qo9qJIuRVHnud0AINyrPmCucWRSwdWXN
         iD+b5oKP6XYskL1vPgx0MDb5qMcQOFZC6lBlv/LR683fXtRDl3LzHfZ4MBPIsAxQHvWh
         dRLvYhmoThSNm/22hQOTpPR3kF+ND35ZTogB4ktHzjp2PquY4lYyXoqhDKILglQN5ee3
         UQRQ==
X-Gm-Message-State: AOAM532R0NiJxJQWyGfSDD5tLVK2UJynHhzEMyrUy/ArcO4arxTToomh
        nOeZ4s5dj1w7toXa+vtjlLT85/fX8bIAdw==
X-Google-Smtp-Source: ABdhPJxO62PrV4abUHN2Yj7VIbT+tfAB3XC9h3CbEu9WwUuD0xeTMCm+GIrU1xeH1Fnju0TRZ9UIdg==
X-Received: by 2002:a62:e308:0:b029:152:8cc3:ebdc with SMTP id g8-20020a62e3080000b02901528cc3ebdcmr153798pfh.42.1603320383159;
        Wed, 21 Oct 2020 15:46:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q123sm3327432pfq.56.2020.10.21.15.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 15:46:22 -0700 (PDT)
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
Subject: [PATCH v2] usb: dwc3: Trigger a GCTL soft reset when switching modes in DRD
Date:   Wed, 21 Oct 2020 22:46:19 +0000
Message-Id: <20201021224619.20796-1-john.stultz@linaro.org>
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

After resubmitting the quirk Thinh Nguyen pointed out that it
shouldn't be a quirk and it is actually mentioned in the
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

---
 drivers/usb/dwc3/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index bdf0925da6b6..ca94f3a2a83c 100644
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
 
@@ -154,6 +168,11 @@ static void __dwc3_set_mode(struct work_struct *work)
 		break;
 	}
 
+	/* Execute a GCTL Core Soft Reset when switch mode in DRD*/
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD)
+		dwc3_gctl_core_soft_reset(dwc);
+
 	spin_lock_irqsave(&dwc->lock, flags);
 
 	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
-- 
2.17.1

