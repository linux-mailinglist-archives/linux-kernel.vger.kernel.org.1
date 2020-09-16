Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AE726CD9C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 23:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgIPVC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 17:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgIPQTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:19:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5C8C061223
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:07:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so6461942wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9nu6UrMqV2SVJMMVWIQbvvsBT41Bk/x2/rbQZZMvR5c=;
        b=RPRtBcCg7Nlj0wORAHGE/VDKI3mlLQS/qXvivUL4M7/JW5ECAKalvw72hjSbxez8Aw
         lMCZYbPq15i6bIjwQAxfIDpzMfPNPU/WZzWlPgKpy/oc+Y6L6jiGzWLpVMJB08/BtSZT
         oD2dRBEBNsclb8R+SHrzd4iEmmwYG8+TCQGsqD7GKc1k8aVkk3vybhh7XzdFgXUgO9lI
         QYDm0ol0pN3tx1rzzGaDqWMGc+wiiGj82UfSpSfbYEgpd1LIf+jsy1e4OB0MSuUMFEro
         jQSQHm/io9aXGCi5lKWqazsAZMtxawDIHKwA08vwThJ4DSoOkZZBbBDobGS4XE3i1iKb
         ItAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9nu6UrMqV2SVJMMVWIQbvvsBT41Bk/x2/rbQZZMvR5c=;
        b=rf4wLZnOAUcGtPgE12i+jEqzhBYK30raKQqOuxXzSqNq++ZlupGVeMfTw/gwS4KH4H
         O1NKaUmgBPIZGN6QKFr1htW6X6TNm4wtYmvKsFEXg4uUPo7k2rzIh3IPPqmreeBPFfVC
         Fn6SCbMkumVlEjTpe4BvO1b1P4Sz20W5qqvfr3dEEjvurAzbxd76OyIUWDgb+ZrtHKfW
         5U62qdWP33DbrO4NkXjCIeD8AAedSc5nIRb/sMPkDzbKjJOKJV1ndyX8qP7I4lhjSatm
         UpQU/3ctzhDEtapxonHDacGhJNYpAFQTAodYFSL1IPOCq+no1sPGUoN3UKSslyRuw9eB
         PS2g==
X-Gm-Message-State: AOAM532ueoK4t8IZPnSMYTKX03viCDenwDNmgb+tfjJCG7uVQfOo6Tmg
        RfJCvXOFqRj0daBQX72FgtIL1g==
X-Google-Smtp-Source: ABdhPJzs9y1RZuz1TgxiB6r0FtvUq2fsAnxRCKUrCMfPgN1zHNdHumy2WgbVHV91xEdhhPCKXoSDYQ==
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr25862069wrt.196.1600254428922;
        Wed, 16 Sep 2020 04:07:08 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id l19sm4682554wmi.8.2020.09.16.04.07.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 04:07:08 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robdclark@gmail.com, sean@poorly.run
Cc:     airlied@linux.ie, daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH] drm/msm: Remove depends on interconnect
Date:   Wed, 16 Sep 2020 14:07:06 +0300
Message-Id: <20200916110706.6671-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dependency on interconnect in the Kconfig was introduced to avoid
the case of interconnect=m and driver=y, but the interconnect framework
has been converted from tristate to bool now. Remove the dependency as
the framework can't be a module anymore.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/gpu/drm/msm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 5c55cd0ce9f9..3348969460ab 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -6,7 +6,6 @@ config DRM_MSM
 	depends on ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)
 	depends on OF && COMMON_CLK
 	depends on MMU
-	depends on INTERCONNECT || !INTERCONNECT
 	depends on QCOM_OCMEM || QCOM_OCMEM=n
 	select QCOM_MDT_LOADER if ARCH_QCOM
 	select REGULATOR
