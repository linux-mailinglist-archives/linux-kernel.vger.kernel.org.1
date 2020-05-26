Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1EA1C05A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 21:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgD3TGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 15:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgD3TGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:06:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2E3C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:06:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 145so271468pfw.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O52djhHmK7M4A1HwqhvSw4on/9rW+xT0L0CMrNKNv+Q=;
        b=uVyX6ILdRfLa0H+KKEgcl6KCnHmDJU5kzmBnzbsjwHj/7OMc1KbtkUtmXddsoi7PRb
         M+qulLDqixLc54j/1OPPKUJHlsiBrrpkvkPhZk/vKaX4m4woL8B3/r4ssSaEKKbrmSA/
         7yiRUdpfXGS2hOn7Vv2jSpsMy1CPr54fHuMYT/VaEMkOU0WiOmKOgczMn6cQb6ZcVcAh
         2ekaHG/w4zFkz3GQ47zNCHXj7NAwR0jOUMDOFlLMy0fsUXSY1DjERDFwNrZjX4p/5PPM
         HaiopqEICpMjcIsRYsZtrWZMFYgW17Fwi5m/Sq6MjeUZIqVJ3KV+SUkSrdOq1ilME+Yu
         x27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O52djhHmK7M4A1HwqhvSw4on/9rW+xT0L0CMrNKNv+Q=;
        b=hI0voBHMHMHeZqvRNQHWZEUVQoXb08TSLB5UvAS5Yx6AhMLdvstcwIPSwHi5U2QB5L
         IZ0f+yWcg/XyQmbAAIACUEsI8k++J9ayIRQhNE+2yV+nWPliUmyBqQjkpw+NgpF/U0YN
         urWIKKEtYfAg7+WrPgijK2vhGH8vfT0d8t7ePxLRq9ceuFxVx6wjVKKiJ/LdmlDoj6gz
         oARcV0Qtq7TsRgsCXonwTlH8f5fJ5/7b8mm8d+Qk2Jf7yTv4Ve7VrwSdsArZgbx+koV5
         YN0DdZuzjvhtwyMWkZ2WSXALgcTWyYXjAFh+SE00USH53V7x7x7YBcBAwPaERIVSIuZA
         Hq4A==
X-Gm-Message-State: AGi0PuZCXA4UbOeBMNmn1mvroMG4pQh5ORhClyUSCtEdpramMXkqo+zd
        Gl1/HqaB+6a6ECWOQnKKD4Qs
X-Google-Smtp-Source: APiQypItt/3A0S35o798IOq0uO8f+IKlszzegenfSsXsflkF2hdpzUZkwGUuKDYX7hMxX+thiQQ6hw==
X-Received: by 2002:a63:b649:: with SMTP id v9mr358899pgt.402.1588273591813;
        Thu, 30 Apr 2020 12:06:31 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6081:946c:419e:a71:7237:1613])
        by smtp.gmail.com with ESMTPSA id l37sm467863pje.12.2020.04.30.12.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:06:31 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6/6] bus: mhi: core: Fix channel device name conflict
Date:   Fri,  1 May 2020 00:35:55 +0530
Message-Id: <20200430190555.32741-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430190555.32741-1-manivannan.sadhasivam@linaro.org>
References: <20200430190555.32741-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jhugo@codeaurora.org>

When multiple instances of the same MHI product are present in a system,
we can see a splat from mhi_create_devices() - "sysfs: cannot create
duplicate filename".

This is because the device names assigned to the MHI channel devices are
non-unique.  They consist of the channel's name, and the channel's pipe
id.  For identical products, each instance is going to have the same
set of channel (both in name and pipe id).

To fix this, we prepend the device name of the parent device that the
MHI channels belong to.  Since different instances of the same product
should have unique device names, this makes the MHI channel devices for
each product also unique.

Additionally, remove the pipe id from the MHI channel device name.  This
is an internal detail to the MHI product that provides little value, and
imposes too much device specific internal details to userspace.  It is
expected that channel with a specific name (ie "SAHARA") has a specific
client, and it does not matter what pipe id that channel is enumerated on.
The pipe id is an internal detail between the MHI bus, and the hardware.
The client is not expected to make decisions based on the pipe id, and to
do so would require the client to have intimate knowledge of the hardware,
which is inappropiate as it may violate the layering provided by the MHI
bus.  The limitation of doing this is that each product may only have one
instance of a channel by a unique name.  This limitation is appropriate
given the usecases of MHI channels.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 0cc85753d9d6..a8b5c4846e1c 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -328,7 +328,8 @@ void mhi_create_devices(struct mhi_controller *mhi_cntrl)
 
 		/* Channel name is same for both UL and DL */
 		mhi_dev->chan_name = mhi_chan->name;
-		dev_set_name(&mhi_dev->dev, "%04x_%s", mhi_chan->chan,
+		dev_set_name(&mhi_dev->dev, "%s_%s",
+			     dev_name(mhi_cntrl->cntrl_dev),
 			     mhi_dev->chan_name);
 
 		/* Init wakeup source if available */
-- 
2.17.1

