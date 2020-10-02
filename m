Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A9E2814CE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbgJBOQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgJBOQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:16:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91482C0613D0;
        Fri,  2 Oct 2020 07:16:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 13so1870111wmf.0;
        Fri, 02 Oct 2020 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y59AvHknuZ7JPu5M+VZVtPAwMMTkQJ0YRDyu3cqZUqo=;
        b=AUSpHf8PfXj7qpN1VSy7IQFUfcXcQ4bnW+llmPBaBPVSwZe8klVXC4dS7JcR2++scQ
         0QL/9SLK8kts8mzJC0Hg+/5JL1K8jbHDa8GvHfst66H2MpGFVQAvHcbQHHbhv5JyYADg
         DRXq6oorUadJDHdG6TYnR3xFleF27f1+QhgxYNf7MP9OA/mQsu1gUjCU2lMBgaPnk0UA
         aL/jaBIzzqRXTKAE8T2ezUzKnHEigWzN5SOP1FPWZY1vlQfP1O+i/NAmeRq+YtqkguIW
         a5YhP66+59PDXiaGvzDFRcVwtoF32YL82H7qm8PgkYKE6w/Uk9I61lQL9AVqQfoRunbQ
         5YVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y59AvHknuZ7JPu5M+VZVtPAwMMTkQJ0YRDyu3cqZUqo=;
        b=h0zqOBcxi/mty+cD0/8KSgXsvpJ2QONDyiegBa4nfosndRZ/ZhwyktXFwupQiieOWu
         s+rcqVmRq76L3Kkf79bd3DCRkmu2x2CPfbaObfbB665NXJbKIrq7MMGDMhCSXs5MaWWx
         CUKzxnJ5AkIWMf3QPRFXdsiCYF2C9Q09L4von2sschtYCXfNIbWyYVlaP9EKJTAT/VrJ
         MZ9Ghxm6RVKSMF3A5RVqfRShAvuHycZJ1QFULypvoDDaLr8nYTgEFgSvASI/MMjsfep3
         cMUaIfRd5bsdesOcve/Qc1jyta9vsEu/BsTYqZxUEnnSTbTvc0dbtyZg/AjrJSIzsEbx
         8png==
X-Gm-Message-State: AOAM532OFu9d5kq6b9ZVRBFAkF/3ywYSVPf0s573w9k/+2IHFRBwFn8U
        to6QK4PQXmfg702jnG8S2HU=
X-Google-Smtp-Source: ABdhPJz1OABUr8GbX4Yxk3rwgQihoo4Blr4FsZ/1vOIH+3RtopswaIYecRlbTnanlx/u4SV1WdpAJA==
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr3338419wmf.13.1601648183304;
        Fri, 02 Oct 2020 07:16:23 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id j14sm2045755wrr.66.2020.10.02.07.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:16:22 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: add SM1 soundcard name to VIM3L
Date:   Fri,  2 Oct 2020 14:16:19 +0000
Message-Id: <20201002141619.14387-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIM3L now inherits the sound node from the VIM3 common dtsi but is
an SM1 device, so label it as such, and stop users blaming future
support issues on the distro/app "wrongly detecting" their device.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
index 4b517ca72059..f46f0ecc37ec 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
@@ -32,6 +32,10 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	sound {
+		model = "SM1-KHADAS-VIM3L";
+	};
 };
 
 &cpu0 {
-- 
2.17.1

