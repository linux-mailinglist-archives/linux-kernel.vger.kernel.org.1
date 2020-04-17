Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE8B1ADBB8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 12:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgDQK5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 06:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729568AbgDQK5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:57:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B6AC061A0C;
        Fri, 17 Apr 2020 03:57:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a25so2581531wrd.0;
        Fri, 17 Apr 2020 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sd4wlffcDUJn6Is+ybIxeg/rBrW/CCyK3C6+QSMdYME=;
        b=gjdna/g3IzY/pyWOBItBCeNMdcUr+uO10O8QuvDpW60z5OqqNmORxi+TYBa/LRV414
         zmusD26KSyJVJnoErCLG/iKn0m/dTxT2/wtYXzyOFUk7o50ahvsYTvTut2zXF5U3CbAO
         HEV8ACDi0DY34sWlmqPb1KjNFsBOMLdBiLSsGz1DSvRyxZuU+L8Y1/HPLcZO6TMrchp6
         OqSa1uuhtnqCqQUw7TruoP92l4Cq69kJskAi73jbwbazujr7rP2mdou5e99rW2r8+tL3
         4dANdKV2bCsU23nbZDQk81Of0lMoNT/GJTWEXiEAcdKj1aaEdpRaLPN5gvgpg7rbLIuq
         yc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sd4wlffcDUJn6Is+ybIxeg/rBrW/CCyK3C6+QSMdYME=;
        b=lFXwJALV93Y0m3EA/zB32v0Ft6Kz01P00kfY2gXAi3p5CFosABKaULFqQVIK0oeYOB
         SeB+okFtoPtUgt1+vhGtRTry5YtpLtB4x3iPLa7+ycrOzz5qXmG2WuMCX53d5Ga+LdWY
         HGUd0xMutQpDjnfRf8RT1VhvtFEeUKgltbViiDNcZF6lh1fDd4PnyA5G6im+1KTq0lYV
         ieE7RHp3MDXioZLMZcho7VORersuOu/BnWGU+3cYXhHt2G82ZAQO92yxYygOKFTx7d1n
         4ISEujKcNAYMVk69DG6dqclAlrYFSef7iCmr/wdb7aY1KkW5uH72d8MAK57Jv6Jg5wr7
         vfEw==
X-Gm-Message-State: AGi0PuajW83uruMKFggya4NN+9I2H6RvDgvcfiX4sD1q7EHJlCFoWScX
        GjhMw0A3PClyThnjYbdmlKCCtDrL
X-Google-Smtp-Source: APiQypIg8WTXvGq3JpweHchn60zYamjb/Or2vqhi0jfvt7lqZWVeLMjnHZZ/4dWF9Mv3SS3R3JAZhg==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr3230178wrp.82.1587121066885;
        Fri, 17 Apr 2020 03:57:46 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i17sm21410274wru.39.2020.04.17.03.57.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 03:57:46 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] arm64: dts: rockchip: add core devicetree for rk3318
Date:   Fri, 17 Apr 2020 12:57:39 +0200
Message-Id: <20200417105739.3718-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3318 is basically a rk3328 with improved gpu,
so add a dtsi based on that.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3318.dtsi | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3318.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3318.dtsi b/arch/arm64/boot/dts/rockchip/rk3318.dtsi
new file mode 100644
index 000000000..a32f771bc
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3318.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3328.dtsi"
-- 
2.11.0

