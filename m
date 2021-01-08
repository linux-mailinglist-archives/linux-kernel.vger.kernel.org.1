Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE0B2EEB20
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbhAHBwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbhAHBwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:52:04 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95503C0612F8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 17:51:24 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n25so6642856pgb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 17:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eaHrQpKpeurHZv+OYTMBBGGPpB4FZE1mWJW48Z/oiNs=;
        b=AP8eKNDXK+f3yABttnermAH/48jx7jQD5O+GUTNSbdHW4WUqvESmttKvccFPZgp9Sz
         A/YcciJTOSsQ6+nNIXjhfmrvn0z5OHXeNczZZtuJ9rOh7lSh2pqKfx1H2QasQsPXu2uW
         b1XW6ubHyF2oGGSxPTrqhF2hOxNrVgHdoUz0tmPRsD9X+RpmSPMkEOi+kpNicXxGr+Uh
         dly3HIYPB8GjbhlHvWkUJleD9z8FLiohhDzF1EsJjM3RLPjrtmilqEhb2JCvPpLx5+jP
         zvTUmqdeh6WWeEkQNyu6ssL4OkK/K2O/JsOZIJZzTcpa872nVlRHmbZtZOl5GIBDIbrq
         36WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eaHrQpKpeurHZv+OYTMBBGGPpB4FZE1mWJW48Z/oiNs=;
        b=bD7kXw3uDVnNw8DwmR36rRVWgGniTZVXr+BrYtez/PaE4kofgwl2FFv67g0LVn95aX
         1uYxsxK0JqhSNQ1uNe+LJaPA2+9pZONyrBLIHMr4Nk1+eSvRUMYZ2HqoyciJGHoCrFkW
         wyi88jMmmhOSfW2HDXs07ZZ6ZhI60GsXbQujj3Ye+gRTO6zO2Ie0XDQXXX6liMjxurrA
         xMeMZAtJJChvNsLnuJt1jcsS/04gek0cWFfRpI7PK3ZKQ+tExOjEh4Yio9CnZGx+UF5L
         KVVI95AJTn/KUYHvc9HH7I8JfhxCkX+tKS3gAXgZLg8x1BX+DvTxcroyvWPchOSk4AaX
         1QiQ==
X-Gm-Message-State: AOAM530dmIm8x5PtCusumsKYoZe8VlcVwGlF1Q1wdFJAKlEKuG3L3V2c
        Hdm+/k/Moi0SbBggMRnE+NK5YRUNDBW1Rg==
X-Google-Smtp-Source: ABdhPJxSbJhBpM2A0dR5cqQKxAWgztVnTaKnRROtWkb337/i7shPcaEJlVeBtCPmt827WMdg7g/VlA==
X-Received: by 2002:a63:1261:: with SMTP id 33mr4538228pgs.213.1610070683769;
        Thu, 07 Jan 2021 17:51:23 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id fw12sm6142756pjb.43.2021.01.07.17.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 17:51:22 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH v3 2/2] usb: dwc3: Fix DRD mode change sequence following programming guide
Date:   Fri,  8 Jan 2021 01:51:15 +0000
Message-Id: <20210108015115.27920-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108015115.27920-1-john.stultz@linaro.org>
References: <20210108015115.27920-1-john.stultz@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In reviewing the previous patch, Thinh Nguyen pointed out that
the DRD mode change sequence should be like the following when
switching from host -> device according to the programming guide
(for all DRD IPs):
1. Reset controller with GCTL.CoreSoftReset
2. Set GCTL.PrtCapDir(device)
3. Soft reset with DCTL.CSftRst
4. Then follow up with the initializing registers sequence

The current code does:
a. Soft reset with DCTL.CSftRst on driver probe
b. Reset controller with GCTL.CoreSoftReset (added in previous
   patch)
c. Set GCTL.PrtCapDir(device)
d. < missing DCTL.CSftRst >
e. Then follow up with initializing registers sequence

So this patch adds the DCTL.CSftRst soft reset that was currently
missing from the dwc3 mode switching.

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
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
Feedback would be appreciated. I'm a little worried I should be
conditionalizing the DCTL.CSftRst on DRD mode controllers, but
I'm really not sure what the right thing to do is for non-DRD
mode controllers.
---
 drivers/usb/dwc3/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b6a6b90eb2d5..71f8b07ecb99 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -40,6 +40,8 @@
 
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
+static int dwc3_core_soft_reset(struct dwc3 *dwc);
+
 /**
  * dwc3_get_dr_mode - Validates and sets dr_mode
  * @dwc: pointer to our context structure
@@ -177,6 +179,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
 
+	dwc3_core_soft_reset(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	switch (dwc->desired_dr_role) {
-- 
2.17.1

