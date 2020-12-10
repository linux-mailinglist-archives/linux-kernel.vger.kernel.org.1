Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616282D572E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388913AbgLJJak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732626AbgLJJaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:30:39 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB75C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 01:29:59 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id t8so3490836pfg.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 01:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TMM7FRlCD8YfgT9nH5Pw055Xkr0/ntfYTn3LIAtEXLA=;
        b=UT8Yn+ik/8OWESdJcSvQ/Oc8zrhhg1LljtviMYjdMXDqGlQ9DwKBFOq6Gr5Wf5Hsu3
         KFppzMrnbNOMyXCQU5t5v+cSwf3X5aMjaHNy8SUnqgDILPdTI5Eoi+1cS+9V2/dMiXNW
         zaQJleuvkgMUonmEypT42bkCn2dvQt52PYq/AhT3O5K/jxpPER2//darWwHoiE/D/GDE
         AE9D5Art9xT5mWuP/nKCSwKYHpSg64fKSpiIKvA0lkM29NQbg5Zyy2T+zMhyppSHfvYz
         9Wq1OVfQbix0ilhtIdMza6O2sVIjDJg7oadGRaNFb+XDPs6HQcYJLsGjjU+e+OR/sB/v
         y+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TMM7FRlCD8YfgT9nH5Pw055Xkr0/ntfYTn3LIAtEXLA=;
        b=hvfToF5lDqKAhRIdSHZmg39DBd1U8wkr7UeFvQmQwjEIgTA6M2cS8We9kk9y08FUTn
         fQQRNoqd9m70tOHIGhAmonywKV1NQ5sk7LLwoENF5iY+TA18579CemsNBjlGSbc0O3oJ
         sEj38Uhg8QkwKcaUnRBnw7+umck2MrfHZHqqTZ3Vp24Nq0gpUp7BqXSRPXc4VtWtn/mJ
         Zh7pGBNUnrPsi2dkAFq+yG8uyDxTw2ZJtp+KBvantHAzdu50Rvjz+a0+jS99ZmEYCLJW
         jitj0BqGsk4vO+WZcQ7lqgUU9wINMX6ldowO+Rpvj62G09f4AGBFMnsiwtgPQyYmELhy
         Zw+A==
X-Gm-Message-State: AOAM531aMYN0sDH0NgNLoTMowYJHNTs8VfQt3YzBfZVtLOZNd4eKjvTV
        KUi7OxIFZnPAh098gIQympN0aelsNJhxnAvu
X-Google-Smtp-Source: ABdhPJy8KpNbujB4HGwPSYMJgHDpj9HX6rLYorgHAPHsIdk2p+WnoHKcC4d0hLX7b73wbH1fPychpA==
X-Received: by 2002:a17:90a:d0c2:: with SMTP id y2mr6583100pjw.183.1607592599227;
        Thu, 10 Dec 2020 01:29:59 -0800 (PST)
Received: from localhost ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id q23sm5726461pfg.18.2020.12.10.01.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 01:29:58 -0800 (PST)
From:   John Wang <wangzhiqiang.bj@bytedance.com>
To:     openbmc@lists.ozlabs.org, xuxiaohan@bytedance.com,
        yulei.sh@bytedance.com
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE
        SUPPORT),
        linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE
        SUPPORT), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] ARM: dts: aspeed: Add uart-routing node
Date:   Thu, 10 Dec 2020 17:29:55 +0800
Message-Id: <20201210092955.358-1-wangzhiqiang.bj@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 6 ++++++
 arch/arm/boot/dts/aspeed-g6.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 30bbf7452b90..bf40e8960244 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -523,6 +523,12 @@ sio_regs: regs {
 						compatible = "aspeed,bmc-misc";
 					};
 				};
+
+				uart_routing: uart_routing@9c {
+					compatible = "aspeed,ast2500-uart-routing";
+					reg = <0x9c 0x4>;
+					status = "disabled";
+				};
 			};
 
 			peci: bus@1e78b000 {
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 4b1013870fb1..8b37182e8f36 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -311,6 +311,12 @@ pinctrl: pinctrl {
 					compatible = "aspeed,ast2600-pinctrl";
 				};
 
+				uart_routing: uart_routing@9c {
+					compatible = "aspeed,ast2500-uart-routing";
+					reg = <0x9c 0x4>;
+					status = "disabled";
+				};
+
 				smp-memram@180 {
 					compatible = "aspeed,ast2600-smpmem";
 					reg = <0x180 0x40>;
-- 
2.25.1

