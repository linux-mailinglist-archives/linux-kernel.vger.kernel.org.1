Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E65F2AC35D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbgKISLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbgKISLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:11:13 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D643C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:11:12 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id j5so5125627plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Wi2P83Jb204DIcDLXf3G0hLo+h16KrWc6/oNDiRIWM=;
        b=e/3Qcflqj8WpcHXRk85POM3kwPWhaNhDO0HTZ3EMHKpgSXHPnlaASr6hhKA4AXIy6d
         HNKULCOCRPHOTp45u2/B7IV9xx9wVTO+PibgZDGoDireqJPSHXGrzzCZURF9UnDtWux/
         8DbPOg1a5Od+RfesatDsk8PO20DPdlGeKfMSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Wi2P83Jb204DIcDLXf3G0hLo+h16KrWc6/oNDiRIWM=;
        b=ugtC8+IwM56ldkZJ7ZumMzXbS1TPgV8z6Qy+p/mIqaQ1DsJV9rSPXBfCLOnnBd6hgu
         8iv/1qBMwdFYZfqqDviLaFE3NjKPBhn+S7tMw7fulFkQx/s5gGDW+Eoo4cxged9owCVa
         TP9ZG4wAJSwwH3Rs4CubyX6HY6G9FNIO29lHjs/kPpGBmTiSoeQOFWODR07lpbkxWo5y
         pcSI2JpZ9ZjU2ZpwQAHy+L9RqO4xPFw5SNRpMQrCepE139JjwzJo9+DhIwyhZCOQwTTY
         cvSZP2nakBVlbNVQUNFrqX1NyaTUfX9sW9FG46xMZXUpbnIduOTOEk6f4taSk89WpLmq
         bwNw==
X-Gm-Message-State: AOAM533JJeV0vrhy3PsLrZKykTY5pVULsHzWchi5K+3j0rH/qbtBwSzB
        MDf6OQ1ZfEusRZD6ztN1IYv/tg==
X-Google-Smtp-Source: ABdhPJwtfwPKKNpRqM/11pdqJKuTkwqWxWoQlgkWxc6SVtOZvoPI8csyvrJ2Ek2zZYr7A5ZU8uCQWg==
X-Received: by 2002:a17:902:204:b029:d3:9c43:3715 with SMTP id 4-20020a1709020204b02900d39c433715mr12970131plc.74.1604945472192;
        Mon, 09 Nov 2020 10:11:12 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7a4:c0f0:b8ab:4687:594d])
        by smtp.gmail.com with ESMTPSA id 136sm12027685pfa.132.2020.11.09.10.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:11:11 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 7/9] arm64: defconfig: Enable ROCKCHIP_LVDS
Date:   Mon,  9 Nov 2020 23:40:15 +0530
Message-Id: <20201109181017.206834-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109181017.206834-1-jagan@amarulasolutions.com>
References: <20201109181017.206834-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, some of the rockchip hardware platforms do enable
lvds in mainline tree.

So, enable Rockchip LVDS driver via default defconfig.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a17d84ad517a..947e14d6ecae 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -646,6 +646,7 @@ CONFIG_ROCKCHIP_CDN_DP=y
 CONFIG_ROCKCHIP_DW_HDMI=y
 CONFIG_ROCKCHIP_DW_MIPI_DSI=y
 CONFIG_ROCKCHIP_INNO_HDMI=y
+CONFIG_ROCKCHIP_LVDS=y
 CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_RCAR_DW_HDMI=m
 CONFIG_DRM_SUN4I=m
-- 
2.25.1

