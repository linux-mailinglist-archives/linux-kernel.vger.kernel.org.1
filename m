Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF11B26FAEE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgIRKuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIRKuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:50:02 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28EEC061788
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:50:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q4so2955919pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kzXjI15ZtttHCXeQ3n0cYLMP2xI/9tBvTIvB8MmIIvU=;
        b=cltSYL9Kp5OpJFjDICGd+/2mu+5pmjD0yP3/WFLAMnhQ1BkMva5IDY0Ib1s5RDyz+j
         FzydGBg2dPxPJt63s5he+g/ZZIe2iPfkg4nYQoGQ05Mj+oGYJ3j7PrAPP5scKfV1A92J
         urK7ALIXF9MPDRv8Fxo3YSm9W8O2qN/vXkEGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kzXjI15ZtttHCXeQ3n0cYLMP2xI/9tBvTIvB8MmIIvU=;
        b=m1bcb4RpoFyHcF3FIjeqibiuzyxkzeBBGuJwea6ASY/LAJiulFN8YZlkK+i6wn04O/
         uk7/yzSvcRrz7iaGEmSi9NwDa11iynVOcvzD8P5WfiJswv1vj/9/9sxjTxyNXzL/1hQ7
         aWZyhWft8QbDC2zScu2mkzAzG5fLibHV3gl2XALG4nc7Tr3cBo7B125KrZCVAIgOb7lE
         vyeW7Gd6zK+jXqyp+YTkUzr7GHuPn/wVBck6VaiXJ+I1ivzdh22K9md+ndIzFg4zpNup
         aKi0QCTcSQKR0WwK3Szq1QTBEdNV6o365cUI4ODFHfn9XZurZi+K53/8JFbRNnp0Hmdc
         6s5w==
X-Gm-Message-State: AOAM532Phh9kiDQGUwQjqZxKkxMSKJmDoD62wpiKZh5C3r8zolPh1fhA
        gq1SgwGIIV+U33naPhd2WFnE3g==
X-Google-Smtp-Source: ABdhPJxc3lT4Yd65/moY9HH8UgfN+MHB/mKWxx8tmHBFJqRh4B7jLhlnT0Bx2j21nIfMFSAZIXyeuA==
X-Received: by 2002:a17:90b:88d:: with SMTP id bj13mr12394060pjb.80.1600426201478;
        Fri, 18 Sep 2020 03:50:01 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id 131sm2857634pfy.5.2020.09.18.03.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 03:50:00 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, mark-pk.tsai@mediatek.com,
        arnd@arndb.de, maz@kernel.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 2/3] ARM: mstar: Add interrupt controller to base dtsi
Date:   Fri, 18 Sep 2020 19:49:48 +0900
Message-Id: <20200918104949.3260823-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918104949.3260823-1-daniel@0x0f.com>
References: <20200918104949.3260823-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the IRQ and FIQ intc instances to the base MStar/SigmaStar v7
dtsi. All of the known SoCs have both and at the same place with
their common IPs using the same interrupt lines.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 3b7b9b793736..aec841b52ca4 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -85,6 +85,25 @@ reboot {
 				mask = <0x79>;
 			};
 
+			intc_fiq: interrupt-controller@201310 {
+				compatible = "mstar,mst-intc";
+				reg = <0x201310 0x40>;
+				#interrupt-cells = <3>;
+				interrupt-controller;
+				interrupt-parent = <&gic>;
+				mstar,irqs-map-range = <96 127>;
+			};
+
+			intc_irq: interrupt-controller@201350 {
+				compatible = "mstar,mst-intc";
+				reg = <0x201350 0x40>;
+				#interrupt-cells = <3>;
+				interrupt-controller;
+				interrupt-parent = <&gic>;
+				mstar,irqs-map-range = <32 95>;
+				mstar,intc-no-eoi;
+			};
+
 			l3bridge: l3bridge@204400 {
 				compatible = "mstar,l3bridge";
 				reg = <0x204400 0x200>;
-- 
2.27.0

