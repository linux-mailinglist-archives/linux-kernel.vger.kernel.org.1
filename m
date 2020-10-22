Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6D52956BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 05:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895381AbgJVDZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 23:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895333AbgJVDZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 23:25:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54236C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 20:25:56 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v22so205595ply.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 20:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ngSdRwMa25UhXHnCwnmxdkdheVQeg1wNUdsVKJm9YQM=;
        b=haD2xKf2ynvjI+pEYi/hxeNtcvmlNEFg29lkUjgwDGT8SxV1YDk+fyC+Q0hfRaylHi
         ahYmg4oBiAFd3cnamNF97VeIXfHWuUjSa8vjn5Kxh8oSAYRUd4NHFlSDQUU6NSG+eliW
         9e4QHB3QVJUeVFmiYQekryl7aaYyKWGfl8bbhfFT6DTWYIi9EVKvXwrEzSlfhp8+7R9f
         fqFlnKxy4kcQBuwVM7Y5S3RoRSNtD+8opMLMXwwdJCXQBPnfwFe7gN85ghWKATBym7Rt
         A29qvhvHDDqbFtXmR2Fh3I3nrtvwfGjhgPpTFXWPBhAwzydQ3YYmTDPIRxCAN0I+pYFm
         pmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ngSdRwMa25UhXHnCwnmxdkdheVQeg1wNUdsVKJm9YQM=;
        b=b+UgWvKN2fzm/kAKl/LTd7M56HgY5CCrvitt35wYBmkLJJmz+uGw+w9MmvlNix7neL
         Z9782PHOd62lO+kDbXjhm+Cm+2XnV1sa99L5hO2Ke+04WalsjxiecNq7sct68CHK8gwI
         mz1WcAbbfs9ah7TM6zck304F8Y1eNvXzeCbLp7iCq77/C0T1TzQykpBVrezEC/l+IUyN
         CTAnPggS6OQ4Sed0+3FIo27qjfGHV+vDBgqj9stocFb+dtDqKVT0d/7KnOqKCDwQL0rh
         OkwmV94Lv8D6An3CaaTwAQSMRN7A+DL739q3dVLET4sSesGOJsY09oJsJsfnXqfVXdYO
         AfBg==
X-Gm-Message-State: AOAM530yq1gkiSLtuIg6Th8KUKlCfnLJfqlIMWv405YIqHvqMGLoOevh
        NtpSmcl19yb8qqUaipw0a2kcsvQ5a5Ph3A==
X-Google-Smtp-Source: ABdhPJxL442674qgXukUAHwueJ+DfOYjsMW4FOKi1EMZzt45PqOHGGYVFYTElJaQjPOCgUjzWoDwYA==
X-Received: by 2002:a17:90a:3f0f:: with SMTP id l15mr511280pjc.190.1603337155653;
        Wed, 21 Oct 2020 20:25:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id 38sm277478pgx.43.2020.10.21.20.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 20:25:54 -0700 (PDT)
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
Date:   Thu, 22 Oct 2020 03:25:47 +0000
Message-Id: <20201022032547.92704-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022032547.92704-1-john.stultz@linaro.org>
References: <20201022032547.92704-1-john.stultz@linaro.org>
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
index a2a88284a95b..c87d8add19e4 100644
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

