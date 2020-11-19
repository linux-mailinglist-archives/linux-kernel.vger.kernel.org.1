Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9D2B9EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgKSX4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgKSX4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:56:36 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB79EC0613CF;
        Thu, 19 Nov 2020 15:56:35 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cf17so4135398edb.2;
        Thu, 19 Nov 2020 15:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XtBrpmcjYgHZT+r61DoHC6KOvBMlUESR9xIbxhZu6HI=;
        b=grWfRQHWP8B7uSLQ+V1VKgZgs5smlkynXS3g/JL2pYuhOouf63fILV6eUy2cO8bAUS
         /I3FfuKYL5ldRNcf+IBriSk9PRLFQEw9gmBwVep2WThA+PTQjAfTE4SCEieTHNQpOjqf
         8qAqOC87vtLUc90/HMDY7BI0arkZ+HM3+5zFDBxVFWZoXKJ7KilbehULsKDUoI+yd7S6
         H6CMDX0gbIgqVeRm/uR+yhWbBa24k71T+iTfPHm4SAerLo893iyVeubJi+8SLGAbMX1J
         gDbYUMdcKo2KvyJL+v8mOrHsORLmrzjyZXUSHx2wwr3GgSFz7C7O4BbK5QASa16fG4PW
         JhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XtBrpmcjYgHZT+r61DoHC6KOvBMlUESR9xIbxhZu6HI=;
        b=R6k5fAC/SrA6XtGPBNjf9lmU2ZJh3gF92Wt9UNsAUWrZ2cqeRy4Aez8pMsTjqBrWAJ
         Mp9/XOHDxYgdNRbV9qntUUUQt/HcuyK6+v2HdnSO1K7hLO4j7k/JIq95tjsbuV7aJffw
         EV1ysT3SXp5Ch8ehNxwIingKyS4qRH83AOb6eVw5oANNnWC5UB3VrN3hgdOXHnyQFske
         Drz89D7tu3LMWG/bsdKGNsVYqwKRaDBpnpWZCP7ufDkLWe+RczXnjN+KR7wO+5hkIs7z
         bI/6BLdj9jhQg2wxjMeRlxpk51kt1NkyjJ12HaC7PjxR0upO2GGNpJsIgT4uulY+y/wM
         Nahg==
X-Gm-Message-State: AOAM530NnEpfqTQAl4wAk3o2I6czahR8ZZ5llak5XLsg9PCOGB9GVsMB
        6t1wgED1hnCuIXVbZ3L1c4s=
X-Google-Smtp-Source: ABdhPJyHNsfwaB9S5VFLotm79bU11EsT5tzA/eK6qBnfiyt3lCHQ1XLsaS28Bo4PhKLeAYh00VlEBg==
X-Received: by 2002:aa7:d888:: with SMTP id u8mr33870431edq.210.1605830194375;
        Thu, 19 Nov 2020 15:56:34 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id i3sm452987ejh.80.2020.11.19.15.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:56:33 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/18] arm: dts: owl-s500: Add SIRQ controller
Date:   Fri, 20 Nov 2020 01:56:08 +0200
Message-Id: <db464acca3e30bfe5beaa3eb395c0664e2e7f3ad.1605823502.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SIRQ controller node for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 55f8b8c2e149..cd635f222d26 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -233,6 +233,16 @@ i2c3: i2c@b017c000 {
 			status = "disabled";
 		};
 
+		sirq: interrupt-controller@b01b0200 {
+			compatible = "actions,s500-sirq";
+			reg = <0xb01b0200 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>, /* SIRQ0 */
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>, /* SIRQ1 */
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>; /* SIRQ2 */
+		};
+
 		timer: timer@b0168000 {
 			compatible = "actions,s500-timer";
 			reg = <0xb0168000 0x8000>;
-- 
2.29.2

