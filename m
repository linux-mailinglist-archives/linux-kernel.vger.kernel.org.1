Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F162C9E22
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgLAJjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgLAJjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:39:48 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466CCC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 01:39:02 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k14so1618877wrn.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 01:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBnVspms6ITyeLgBYW1bwHRg1chxtx6z9CAGg8Jjp/s=;
        b=tEJABj/A1UWTXUSR1lDfKRTmIuF0Ly1sl9GF7Q+ha86FoejD8Q0Kf7lbZmNC6cY+jh
         6fIHjxnufQtydSEOv2gLFpIgrninrsFjH3uKVByPPYbkSQVbV14BRs84JhpbLWygCpC0
         JVm3ALSv5cfDezZYmy2+3yEqFgLAsa+r6zTez1lr/DFYfAavIaPDSFlrrQVHtyubR7a2
         XfSWlwmHsirRh7RnR3LYqkZZHQGDS5itWrHGYtKA9chDl23OotEv/N0hBD/KllmivTZc
         mcTjRVRP4M/8WqZIPdE4LprjozvRMTT0wj46MGZMIz7DNm9GMQRQJ5fzTr5NOPBFBrLJ
         oceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBnVspms6ITyeLgBYW1bwHRg1chxtx6z9CAGg8Jjp/s=;
        b=YBGhIwtOzyQMLe5tP/TnW4BApEiahCEC3ueeZcjU5Bj+KTeq5rmvscINBG6+3UAMdr
         RHESOxkgPhJ+BddDT5emOFh5vJ0F9IjVXmnLfjbgtaHo3WELA/rMdExL3Ac3f+HUvUI1
         /rftEwvLSOwKN/mNbYOMbDhZAxMrQjgWxwjKFjmrxztIVfBJBCrDlxwiapxxp87QWfr3
         cgIoIVdrViDEw4PkLQnEPoqyndRhmUbuGiR4h0xnafUm0N62CFd45UY6q/j91RwIIzpE
         vawJ5Ir/poJmDTfxpT3bIBlRLT8VnCacjFPzapg3GXJ7XrVhtRUYhMy1emhDpc5Rt2pC
         ajpA==
X-Gm-Message-State: AOAM533KAMWCC52u0igz1mgUz3jrsYPuvd/B0rdGDXPqi0AKto/bXOow
        YEx8dhQWENCkkwxumHYpFIwXbQ==
X-Google-Smtp-Source: ABdhPJzYxtJRzbzDy9l4T2ZpsFv3tTRZh3SqgjObX5J/iIdONB5rNzOF7Lcy2AhfhsE1CcsMgEbLlg==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr2597316wrp.339.1606815541013;
        Tue, 01 Dec 2020 01:39:01 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id a12sm2112695wrq.58.2020.12.01.01.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 01:39:00 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] slimbus: qcom-ngd-ctrl: fix SSR dependencies
Date:   Tue,  1 Dec 2020 09:38:43 +0000
Message-Id: <20201201093843.20126-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NGD should depend on QCOM_RPROC_COMMON instead of selecting it, as
this will be selected by respective remoteproc driver.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index 7d59956b5dfb..1235b7dc8496 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -22,10 +22,9 @@ config SLIM_QCOM_CTRL
 
 config SLIM_QCOM_NGD_CTRL
 	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
-	depends on HAS_IOMEM && DMA_ENGINE && NET && REMOTEPROC
+	depends on HAS_IOMEM && DMA_ENGINE && NET && QCOM_RPROC_COMMON
 	depends on ARCH_QCOM || COMPILE_TEST
 	select QCOM_QMI_HELPERS
-	select QCOM_RPROC_COMMON
 	select QCOM_PDR_HELPERS
 	help
 	  Select driver if Qualcomm's SLIMbus Satellite Non-Generic Device
-- 
2.21.0

