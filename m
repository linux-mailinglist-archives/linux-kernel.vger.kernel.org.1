Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131592AE240
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbgKJV40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKJV4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:56:25 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F167C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:56:25 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 10so109602pfp.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ixwwp1tp0QJ1czDiV+Ee/USu0gGUVFj7T0q8Sqh5cbY=;
        b=x2MLkGt2Kwxwa/HHIMbv11SZFn90oPX7JoStsS2efox7c3/KZbj2Ao/6N6ij4UdCCj
         q6KUmDWvn6uVsIs3NR/2/+FtTKtU/sdZ0s4inpDiewYBuunv7Mn9cLoyNqE6mjqgtp+J
         it9nzw/HAqCFP83xqB/MldOvypoYuS1zR5lG8DdZjKKDxTLwn1OCC42rnLMrPgcSa797
         9I2YJh918SdJMEtnoGa3SuHGw+UJQVwn0P9W2huMmMcNCcc3PO6OcxtTJhR2gLw1TtWP
         P74uE8tF1ZrfVoBYhwM1+pZsn51iCB2H5XD6FqwWB7xka6d06Q2hENyckPNSepCHE991
         7EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ixwwp1tp0QJ1czDiV+Ee/USu0gGUVFj7T0q8Sqh5cbY=;
        b=WZtmnpbnDxr+52l69DVv2LaqBlsJZ0TOhyodydwhoB/Q9e7C5yJClKF8CMd4lvb8iL
         Qy8V99HtFc0xaVdY+fI+fCymc83RV55RUFKwd1LXzwL3nUOSp5eB9weCLXAQnMZedQJG
         jJiMUpQ651/KI9f8Y0Z4RHv566QYRZxrO3AmyJ15JB9bKDapFa+aVoErcpJo7UF0r2UB
         IOweMR8E0dLAdd0P9glF/qZI4iQ+mOn+I8gzlkDlv99yd8HTjt3n6sX+YKozS4AQjln0
         4BXDRtMIedNDps/3ArL893ePJGwvQfJruxciGhYjvU2hn8pXqnZEVBTioc9HpapnL9nw
         iUeQ==
X-Gm-Message-State: AOAM532ALxrmufOq0OZ7qPxX9LoOYiI+hjzVvOWorH0zRQ9A6/pZdeMJ
        QtbNpUv5TUMNU/foKpgmqMwunYPste7RZw==
X-Google-Smtp-Source: ABdhPJzx1zz5qx84FHMuwtUBJos+r15YzAWmoHyEyJtRcgfi/PqG9NhmRDy7ODxu0ONbm8LI+4F6gw==
X-Received: by 2002:a17:90b:1741:: with SMTP id jf1mr232895pjb.144.1605045384898;
        Tue, 10 Nov 2020 13:56:24 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id n1sm14414390pgl.31.2020.11.10.13.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:56:24 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Vladimir Lypak <junak.pub@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH v2] pinctrl: qcom: Fix msm8953 Kconfig entry to depend on, not select PINCTRL_MSM
Date:   Tue, 10 Nov 2020 21:56:19 +0000
Message-Id: <20201110215619.86076-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One fixup following my patch commit be117ca32261 ("pinctrl:
qcom: Kconfig: Rework PINCTRL_MSM to be a depenency rather then
a selected config") being queued in LinusW's tree, as a new
config entry was added for the msm8953 that also needs the
change.

Applies to LinusW's pinctrl devel tree.

Cc: Andy Gross <agross@kernel.org>
Cc: Prasad Sodagudi <psodagud@codeaurora.org>
Cc: Vladimir Lypak <junak.pub@gmail.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
Change-Id: I9e8e83b1ea57aff338074be9174fce53cef29eff
---
v2:
* Fix flipped numbers in the soc name, pointed out by
  Jeffrey Hugo
---
 drivers/pinctrl/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 8bdf878fe970c..cf56e029cd9c7 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -115,7 +115,7 @@ config PINCTRL_MSM8916
 config PINCTRL_MSM8953
 	tristate "Qualcomm 8953 pin controller driver"
 	depends on GPIOLIB && OF
-	select PINCTRL_MSM
+	depends on PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm TLMM block found on the Qualcomm MSM8953 platform.
-- 
2.17.1

