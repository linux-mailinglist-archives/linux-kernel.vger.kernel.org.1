Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173E9290CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 22:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408070AbgJPUqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 16:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407904AbgJPUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 16:46:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BB6C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 13:46:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y12so4484174wrp.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z34pjZEl/yAj35BmeMPeQ2AuzmLDkr4JaiqOt/ocOb0=;
        b=umGeLcj4PeucC6Uf/5Tp5/oxosbRT2cAL8LwYyMK7PC10/QkTWvNiOcD9zxdFYXYjF
         lMZc31X6dH9HqmOiO7Yqx0H7Iu2F32wfIRiRQNEGhfDhJTgoEPbeYwaS0go5VQWFuTQa
         fHHCUJkJ4Xj2x4Iwag48IxwTxiPPe4G5xT5QUy9KNfb3acQsEaZ3KDss+IwTacYSFc+C
         RKXH9M6tAChIWYXw4VJ7WOB08uXWOjd7fbgoSypAdoKzYUDx59f7uXtTbgam+kvN38R7
         KoV9gnJpp2nELz3qwI1rXL4lJPAQIOD62dpkDVibocadOgc5FQtM2wHPJ/15Xpc+nIG7
         1p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z34pjZEl/yAj35BmeMPeQ2AuzmLDkr4JaiqOt/ocOb0=;
        b=l3YmCGE6Gk9XaCvq42BXDALLqvw4pIVBh1IJ3RmCJLYHiGP8XHEFLUqNFIV9VwZ1NV
         rMQeUINw0aCZ4Ogvj3dWoHRViJKzK6ZSDaCx1KZU3WnumdGMxMDlPuV1bV8JibJA5Ud0
         vb5HijEMSm6FlZRzExsQI2jR93s11urqOdn421kcVnoHQrFWaIPCX6FQkP9rqbWBggn+
         YsmegO4EUHHaoWJXlZc9RbR9gfDMuqfzjm4yi79WYwOQbqdfsNIq+ptmA6lfRMQo8Nz4
         c9PxwPddCmqp/y5J+dxPNQYF+T6lf56iWXx7yqWjNxWkRgDOpiEe+QKKWUQvPRJdYDI2
         Tzqg==
X-Gm-Message-State: AOAM533ICunek2O/svCLXo9uTtjjw/ioupZ3r5b0Oz8GnkI1Htr9ClMU
        Z0hyaETJNz4nmydw4MKo5gH04//1gMhi1g==
X-Google-Smtp-Source: ABdhPJz36RkEVJGo8Lo+uuUMuw1zpTfpRfIeXeo6wreRRLSULo2sCHXOz8UUwuJxT9Iqbo+vH5Cj+w==
X-Received: by 2002:adf:fe48:: with SMTP id m8mr5978231wrs.127.1602881176869;
        Fri, 16 Oct 2020 13:46:16 -0700 (PDT)
Received: from localhost.localdomain (dh207-98-181.xnet.hr. [88.207.98.181])
        by smtp.googlemail.com with ESMTPSA id z5sm5143609wrw.37.2020.10.16.13.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 13:46:16 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, vkoul@kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH] MAINTAINERS: Add entry for Qualcomm IPQ4019 USB PHY
Date:   Fri, 16 Oct 2020 22:46:10 +0200
Message-Id: <20201016204610.2406075-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers entry for the Qualcomm IPQ4019 USB PHY driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 867157311dc8..bc05bea8dda0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14411,6 +14411,14 @@ F:	Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
 F:	drivers/mailbox/qcom-ipcc.c
 F:	include/dt-bindings/mailbox/qcom-ipcc.h
 
+QUALCOMM IPQ4019 USB PHY DRIVER
+M:	Robert Marko <robert.marko@sartura.hr>
+M:	Luka Perkov <luka.perkov@sartura.hr>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
+F:	drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c
+
 QUALCOMM RMNET DRIVER
 M:	Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
 M:	Sean Tranchetti <stranche@codeaurora.org>
-- 
2.28.0

