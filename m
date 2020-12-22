Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC592E1045
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgLVW2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgLVW2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:28:46 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB66C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 14:26:53 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h16so14382636edt.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 14:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QM3qTNIGNxG/WHeZll7yyCa9Z+1LXQcPrYea97FUIZM=;
        b=xpXcwW8quCCuPqxyQZj2SpKSrzj/zkryI+VwMag56clV+jcfZcIIFKL8soE2BoTbNL
         WylfRmHyEQP0zXxGtpirQ+q9C9LnK4fgTSoTBh/wM3QaJgPOJ+W4OERNi6qan+qhJtYU
         tfuygKi8jLoTG3UC19rsnJ0fVcb8zVnfHgo2dpApzbt52n/dq+LmQAdcQWshgnEfznSh
         hm+xkpP9/UHmB3RNy13LMIfBp/asFo+dZZXDmmUpgKyN+strf9BX2dkkq+Ss5yX6jF8f
         olQ8LSE0h3Um7/QKEG8xactGpvCwmkwhaKPtiDImEst0ro07kkAGCgCjHp8LIfJNEZSD
         smlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QM3qTNIGNxG/WHeZll7yyCa9Z+1LXQcPrYea97FUIZM=;
        b=NJ5GC9WcBSw7TfqPreYu2p092PBqKJbxVEaKlmDFFt1W9pi7buGDBxqk1gG+DKL9o9
         juDUCsG4ki3nkLiTfyk1pfdEQyo1chjTALhouUv1fsRubl+c/uaBXlyNdfA3xg5s/RBe
         Zp38eyRw6WFPf2frfoMcf+LODvJgpR31hyPqCzPlaXNBg3DdN+AekPxOnE5Srkx29fGr
         ZbJHv4PbeyzUGvEQV3+/GvMGvscL4HtpKeQ/fJVtie80PkOh06gKHPVE/oCTn+R+HdEZ
         qxp3XWqItqh+T+T3cxynigrkTyIprZItG9D8Ap8Qne8hDq+BMQEkt1JJ+OlCdUvVPpw0
         9R/Q==
X-Gm-Message-State: AOAM5301zAiQXyQlDjbQm/bQZQxqaZ84YmSrr6kfCEtHxAwxWiqAjxag
        wV7h70EesA6oAZU+2zrj7Zy+9A==
X-Google-Smtp-Source: ABdhPJySHq30/8MvKbEXin/mTMu57vy/4J8Vl2P3EGx+35Mk/rcBJce2OTlDJz7DA4LHpKHkv2/vxA==
X-Received: by 2002:aa7:cb49:: with SMTP id w9mr22911540edt.357.1608676011907;
        Tue, 22 Dec 2020 14:26:51 -0800 (PST)
Received: from localhost.localdomain (dh207-99-167.xnet.hr. [88.207.99.167])
        by smtp.googlemail.com with ESMTPSA id c23sm30515385eds.88.2020.12.22.14.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 14:26:51 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, andrew@lunn.ch, linux@armlinux.org.uk
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH 4/4] MAINTAINERS: Add entry for Qualcomm QCA807x PHY driver
Date:   Tue, 22 Dec 2020 23:26:37 +0100
Message-Id: <20201222222637.3204929-5-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201222222637.3204929-1-robert.marko@sartura.hr>
References: <20201222222637.3204929-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers entry for the Qualcomm QCA807x PHY driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 281de213ef47..a86731f86292 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14546,6 +14546,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
 F:	drivers/regulator/vqmmc-ipq4019-regulator.c
 
+QUALCOMM QCA807X PHY DRIVER
+M:	Robert Marko <robert.marko@sartura.hr>
+M:	Luka Perkov <luka.perkov@sartura.hr>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/qcom,qca807x.yaml
+F:	drivers/net/phy/qca807x.c
+F:	include/dt-bindings/net/qcom-qca807x.h
+
 QUALCOMM RMNET DRIVER
 M:	Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
 M:	Sean Tranchetti <stranche@codeaurora.org>
-- 
2.29.2

