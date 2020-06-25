Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF212099F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 08:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390123AbgFYGq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 02:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390098AbgFYGqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:46:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37959C061795
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f18so4738763wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bd+lgz3kjTKvgNR4P6qCbaJPIOylexTivHrAPmy2slQ=;
        b=CQpjtAeUs9tpxi/DFdVhV7absTIYqPpnDyK7RXF9pu1rkwLzneDyakWcCdHPogG8rn
         I1ZozMNlu5QnjYF6skQptFYOz6+57Jx67LbDWluSTZaO9HEQLqNI5MQezYiMd8/iHvo+
         Lc7F0W/vbj/Kov7LpWJyNaBhMFk5NHAVSUAGehxYXgLtVKEP2YPPSxKFQB2S+Xuiy6RF
         N19NraUiO7nVRkZqwE3A0Kaw23/5NMzOqN0TVpnlrgfmRZKQNAuNzWljTb+nZlnVdCfG
         kImSSWzvhXj8Cy5qkIMb69GLSncRyvcHbfsjaRfPFlVag+E1SN2JO5KlTnC7LPv3lpYX
         zp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bd+lgz3kjTKvgNR4P6qCbaJPIOylexTivHrAPmy2slQ=;
        b=WQaGA0NH9uw9iqVK7pnla84SdEmdNLC1g4xm/a05vHKZRvfZv7rLdI2NkivEQIlZ9p
         MKjfZQNmYrx5pvW9bQcMl5kma2oZpxA2sTQR3ocGn9Mt0EPl8FvaarDP6o3Meg2RJRgb
         a3Sc1R4AfX8B4peABkaz0oFtfrF181FsKkO5bt/XayKR7Kq1vWQTM6IzfiQePFecBY/P
         5HZaaGyD+Jlwh30GpE8j7JwUU8a25ltYKz/5xxALD4nxBIZ+yTiV0smUdYif73W8jT0f
         bNPDbHc3ya6ZOY6AMyLJqnVi4Lmn+P0J2JYCUu5/q8T2usmE1Yuavi6IsHYPv9+FI+8c
         +bXw==
X-Gm-Message-State: AOAM530wVsuTRPE4R9qIM8Pu1Y48Te6wh87uZDrpwUPUYbdvfRjwGxRd
        5uEs9CDrHMLMIGi23THLdXL5ISEkybI=
X-Google-Smtp-Source: ABdhPJxyK/Z8rwiLCunJoRA/5kCyJeebbE8cpPLOPedbLWY3D/+fAvgpoSQmT207s856mFLvjli5Mw==
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr1605274wme.159.1593067582792;
        Wed, 24 Jun 2020 23:46:22 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id c20sm27235363wrb.65.2020.06.24.23.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:46:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] Fix a bunch more W=1 warnings in MFD
Date:   Thu, 25 Jun 2020 07:46:09 +0100
Message-Id: <20200625064619.2775707-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to clean-up W=1 kernel builds, which are currently
overwhelmingly riddled with niggly little warnings.

Lee Jones (10):
  mfd: wm8350-core: Supply description wm8350_reg_{un}lock args
  mfd: mfd-core: Complete kerneldoc header for devm_mfd_add_devices()
  mfd: db8500-prcmu: Add description for 'reset_reason' in kerneldoc
  mfd: db8500-prcmu: Remove incorrect function header from .probe()
    function
  mfd: omap-usb-host: Remove invalid use of kerneldoc syntax
  mfd: omap-usb-host: Provide description for 'pdev' argument to
    .probe()
  mfd: omap-usb-tll: Provide description for 'pdev' argument to .probe()
  mfd: atmel-smc: Silence comparison of unsigned expression < 0 is
    always false warning (W=1)
  mfd: atmel-smc: Add missing colon(s) for 'conf' arguments
  mfd: altera-sysmgr: Supply descriptions for 'np' and 'property'
    function args

 drivers/mfd/altera-sysmgr.c |  3 +++
 drivers/mfd/atmel-smc.c     |  8 ++++----
 drivers/mfd/db8500-prcmu.c  |  6 ++----
 drivers/mfd/mfd-core.c      | 10 ++++++++++
 drivers/mfd/omap-usb-host.c |  4 +++-
 drivers/mfd/omap-usb-tll.c  |  2 ++
 drivers/mfd/wm8350-core.c   |  4 ++++
 7 files changed, 28 insertions(+), 9 deletions(-)

-- 
2.25.1

