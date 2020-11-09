Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771DE2AC34D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgKISKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbgKISKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:10:49 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444C7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:10:47 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id h6so7827516pgk.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wxKM9OJFbbgGll1Azt3O4g68tLbE1pRW8jbL6x9JVdk=;
        b=qFJxvCT4TrhfaJc/Kq5S+yGbXMuHAGrfYOEU9Rv6qRNOtm5VVWVdmcDJrSEUsIH9Wj
         XfzYThBUODapTlzJFb/W/Mer3E9+dRUehN5L5/lsqFA8krikRSaI0YOmMLZplyC4p5Lp
         0QQFZr0xpZbb5wrpU2+IlGuKM8ICWZ0inAQTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wxKM9OJFbbgGll1Azt3O4g68tLbE1pRW8jbL6x9JVdk=;
        b=sqkbZ9l1Zu3eqDZgYHTS2FUM2bmv1MctonInu4RqY4PRKT84jymEyACYLodZHqzYN9
         XcQHoUKEI3qWiJ94/w/X7zWIC9FtBQUR2zR6JxtuT8j5tcYYYdpSRiVQnyq+lY2Sd0uH
         nDt6A6xHT9wh0nD07kPhNU0wTY2p2EiNGS18dwOIFTBLYIZl+ycfRoiE7WPOsYw+MHEC
         N8HaeBd209HHUHR8poc8QtO5cHg2v6V8ffH5USU1Fy7ldSdzvTICfdOpIc8UhnmGccmM
         /LLpI3r+gi1F+GsQ3PyBS6T4PvZzbxQGPGLbrPUOoie2xLjPujcD0DQinc0+mCw6XNcA
         BEmw==
X-Gm-Message-State: AOAM533Zlc1CZ3GIZQBvzYjFqOH+qvZXkIlax8MCJ4mkns308yVLNH1C
        TvSwv8EOunqTeqXCzD2AMELPAA==
X-Google-Smtp-Source: ABdhPJw2v3k35gloDwQXwwQ1imtIvDGd5xSjMeYWbxRQym9kRDubJ4A+9jzjnF0zIyhIyH2HalnP8w==
X-Received: by 2002:a17:90b:a51:: with SMTP id gw17mr390261pjb.218.1604945446746;
        Mon, 09 Nov 2020 10:10:46 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7a4:c0f0:b8ab:4687:594d])
        by smtp.gmail.com with ESMTPSA id 136sm12027685pfa.132.2020.11.09.10.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:10:46 -0800 (PST)
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
Subject: [PATCH 1/9] arm64: dts: rockchip: px30-enagicam: Enable USB Host, OTG
Date:   Mon,  9 Nov 2020 23:40:09 +0530
Message-Id: <20201109181017.206834-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109181017.206834-1-jagan@amarulasolutions.com>
References: <20201109181017.206834-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Engicam EDIMM2.2 and C.Touch 2.0 Kits support USB Host
and OTG ports.

Add support to enable USB on these kits while mounting
px30-core SOM.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../dts/rockchip/px30-engicam-common.dtsi     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
index bd5bde989e8d..fbbdbb0a40af 100644
--- a/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
@@ -33,7 +33,31 @@ &sdmmc {
 	status = "okay";
 };
 
+&u2phy {
+	status = "okay";
+
+	u2phy_host: host-port {
+		status = "okay";
+	};
+
+	u2phy_otg: otg-port {
+		status = "okay";
+	};
+};
+
 &uart2 {
 	pinctrl-0 = <&uart2m1_xfer>;
 	status = "okay";
 };
+
+&usb20_otg {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
-- 
2.25.1

