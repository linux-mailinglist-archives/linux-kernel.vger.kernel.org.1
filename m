Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C50C2AC35E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbgKISLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730846AbgKISLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:11:17 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCA1C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:11:16 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 10so8912397pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zY9fGaYD8ZpsvIIwOgaSJHvbW+1SnTw/6B/N3m0LlHc=;
        b=C2ZIkRfVq4H3EPtbgYH0dTM2/adYGtQpVSbrcupq08OM6VoJT0UeXT79ptY1HxzZR9
         GzZi5Gww2Xxz9YG0IK0EeeRAinL2cDfRzJrwS7kMrQ7xd4kyeKmFh6Qg7j0roGh/0pDd
         t3D0aRfsfnOhzcKMlWKYPTPIREe1mAz2s0rtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zY9fGaYD8ZpsvIIwOgaSJHvbW+1SnTw/6B/N3m0LlHc=;
        b=aQD/CKDbUJgONWmaeHeYOfntU3oAd4szXmM/9nw2j2mhbA69+hOjF1rJfyq5rsAnq0
         ng6nTxLf+vDqrh4p11l6ceLVky0p1RLLT/AtU9NRF027QQ+KNdldUwiMx6Y0BtyM1uW8
         mgQ4fRqxFvjkIj3c1C9OTA+tZO8dKj2DWBFCPRiUveNIz4uyC3P4k5/vrFj0YfE6n0Kr
         Ytzh6IikcAuutFzdUmX2JzvMXg5in8LpAm9OuwcGpnbHWzjaCkl7zK6gL1hExl+1addE
         KWOqPyedo70qKq/H29gpdLUu1T948d65lyiloY1wsDash9uT5WCC/BMsQBCB9Wj8L4f+
         0AiA==
X-Gm-Message-State: AOAM531TS/UqGCNsz+O4EP71+ERv5CoEgf8+Jnamq2eF/fQdgT89bAAl
        Q829G2hRnzCGyY7H/jd37F8qIg==
X-Google-Smtp-Source: ABdhPJxocp/yN7pU9O9NbxO9ycOqHvuu/mSywhTSFVGHP9k7XyV9x5tm1kRUQSdUg//VPY5X7l/pqQ==
X-Received: by 2002:a17:90a:f0c7:: with SMTP id fa7mr424710pjb.3.1604945476261;
        Mon, 09 Nov 2020 10:11:16 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7a4:c0f0:b8ab:4687:594d])
        by smtp.gmail.com with ESMTPSA id 136sm12027685pfa.132.2020.11.09.10.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:11:15 -0800 (PST)
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
Subject: [PATCH 8/9] arm64: defconfig: Enable PHY_ROCKCHIP_INNO_DSIDPHY
Date:   Mon,  9 Nov 2020 23:40:16 +0530
Message-Id: <20201109181017.206834-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109181017.206834-1-jagan@amarulasolutions.com>
References: <20201109181017.206834-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to work LDVS, DSI in mainline tree for Rockchip based
hardware platforms, the associated PHY driver has to enable
in default defconfig.

Enable rockchip DSI phy driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 947e14d6ecae..8d205f0a3a0a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1018,6 +1018,7 @@ CONFIG_PHY_RCAR_GEN3_USB3=m
 CONFIG_PHY_ROCKCHIP_EMMC=y
 CONFIG_PHY_ROCKCHIP_INNO_HDMI=m
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=m
 CONFIG_PHY_ROCKCHIP_PCIE=m
 CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PHY_UNIPHIER_USB2=y
-- 
2.25.1

