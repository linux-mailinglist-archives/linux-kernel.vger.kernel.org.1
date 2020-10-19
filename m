Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C40329290A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgJSOKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbgJSOK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:10:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2657C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:10:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r10so1265008plx.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1yRFSCl/mRcUkS6OvmVba08bS0ib90mEnvumV93631A=;
        b=PpbzUn3bSYybM/B+P67kwVSTJcSculclJ5cYp+qp02sY9e/t2qzNdkZoyBhy1uYr/G
         ihQHQwNUe/HNv99lgh72wXRgzmFk0PD3Jaxkj4mdBrs6csNqGxPob+KkU30UKCpyayu4
         HFSlbcGJutFyRy5lWg97w43r3cIY7W+gesEZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1yRFSCl/mRcUkS6OvmVba08bS0ib90mEnvumV93631A=;
        b=jZPz9is44rBGcad333ip+LvW8voJaM8ff15wZiUQQv5DX2Nt2/JSA+HOkA70JpaRWd
         H3uFgvrQYeMTMeLs9E/k9KzBbnL4JL4e5rNg9Wyd6KvUlIqILTcMCW4829/L5VhSmxE1
         +lOfgz2w+7C/l+5i/AC9R/qpqLNP9xTuJrCIg3ffnfy3pL372ZtbZcYN7aDo37IrHMKL
         iM/EBjf1plINhLy/aS1nGTVTRw2Knxs026p0qbMhy6xOuP/Epk3U7V99R9n3ORBF7zIX
         VABZ+kHph8ywNbpP4G6fLZv2z0NOKSh6rpAJ0F5+GIwDD4okmWLtX9A9P3r1VLkz72ys
         klsg==
X-Gm-Message-State: AOAM532fbLwXB/cSt8C5yhx3LqDnepMJGByAxDfD7LLQuKzh1zj9JGnL
        qT4s7dpx9vjTAG0OV9rgIHZpIQ==
X-Google-Smtp-Source: ABdhPJyICwRj7p9WMfp/BM1uvsfQPI+SYkKUzGl5TcvdYBXqf14o3hbbIsviNl3qL3r4B3WvD+HnFQ==
X-Received: by 2002:a17:90a:3e4a:: with SMTP id t10mr17389449pjm.151.1603116628488;
        Mon, 19 Oct 2020 07:10:28 -0700 (PDT)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id 131sm78999pfy.5.2020.10.19.07.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 07:10:27 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 5/5] ARM: mstar: Fill in GPIO controller properties for infinity
Date:   Mon, 19 Oct 2020 23:10:08 +0900
Message-Id: <20201019141008.871177-6-daniel@0x0f.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019141008.871177-1-daniel@0x0f.com>
References: <20201019141008.871177-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fill in the properties needed to use the GPIO controller
in the infinity and infinity3 chips.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity.dtsi b/arch/arm/boot/dts/mstar-infinity.dtsi
index cd911adef014..0bee517797f4 100644
--- a/arch/arm/boot/dts/mstar-infinity.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity.dtsi
@@ -6,6 +6,13 @@
 
 #include "mstar-v7.dtsi"
 
+#include <dt-bindings/gpio/msc313-gpio.h>
+
 &imi {
 	reg = <0xa0000000 0x16000>;
 };
+
+&gpio {
+	compatible = "mstar,msc313-gpio";
+	status = "okay";
+};
-- 
2.28.0

