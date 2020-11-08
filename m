Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DFF2AAD30
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 20:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgKHTQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 14:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgKHTQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 14:16:56 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEC4C0613CF;
        Sun,  8 Nov 2020 11:16:56 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so4601153qtp.7;
        Sun, 08 Nov 2020 11:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EivXn+6mSAXV1Iqk/3FEhrg9DeWzJHazASz9KiGUz+g=;
        b=Wlst1vffJ3OTt6NkSbCh2hox0kOSnCpJRpwUiYjtFcXpCoSd06SPWcfAgeY6iffwj4
         LvllGwuGSojr26QeRSgOnsZrZQtovVRQq+bz8IBvWG8xeM0aQYhdk6njwT0nMgKbTlGQ
         Mb3RLfbNIgjuamvwOBMVtwTqX7uoeheezvCiRgVgVywdUC/ya95/qFVD9WYBJHOr4LdC
         uBet658SeI7ckoJUVRVvFx4CYh57EOFd2hg2XZtubfQY+qytHgoBi/ivFkbNJqhGqPdJ
         ynbunO+lK/73iKZhuMs0DJ58SvQAjJbyetswC++0glu75BfJUtb5RMMjttRJ9BFtJrMA
         3LOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EivXn+6mSAXV1Iqk/3FEhrg9DeWzJHazASz9KiGUz+g=;
        b=UUEoDbWhKUk0BCKYSxyR6wVf0mdXRp+jRaMmw6IbUuAfWUUsBJ/k+U/oW4SeF/E1zZ
         niNxl2JhxvLz1BLuj3hJ1+SysM6gSGZiIIOoTwaZ8d96Ykjsw8sZIzMfKp1446yQKkJE
         wur6UjCuuUeGcnBc0n5PUXDmGmDHaP2rU/ygQ1UzS29GeOxT+i0YgRffjQWNnwi4H4yc
         6rmhoO0PcWZ3I5GhnSAOfULgxKOZWCSTs2DdrBtbEfs+QhBXmYgL86XmOJkNFXJqFvQB
         ajDGlbTPplHik7Z74LOAaXzXuqhpNbmRXEhUgaVM0JQLPCunvCOKpp4EPu71PAxZCDhP
         unHg==
X-Gm-Message-State: AOAM530HDlybBoWe7SC4gUBYpstda0XFow8PNhCohA+L2JwsU57NzKKR
        YYH5OHgUv+shjeggcPC92So=
X-Google-Smtp-Source: ABdhPJwGuGiS/dY3sF2v6i39skEpy44WblmblxnSG89Nyo1ca5Qd5XO9ZBbJUFxxljNQeqHbgLdWXg==
X-Received: by 2002:ac8:4605:: with SMTP id p5mr10278374qtn.326.1604863015281;
        Sun, 08 Nov 2020 11:16:55 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id u2sm4245782qtw.40.2020.11.08.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 11:16:54 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] arm64: dts: imx: Fix imx8mm-kontron-n801x-s.dtb target
Date:   Sun,  8 Nov 2020 12:16:15 -0700
Message-Id: <20201108191614.4062210-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108022321.2114430-1-natechancellor@gmail.com>
References: <20201108022321.2114430-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running 'make dtbs_install', the following error occurs:

make[3]: *** No rule to make target 'rootfs/freescale/imx8mm-kontron-n801x-s.dts', needed by '__dtbs_install'.

It should be .dtb, not .dts.

Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Simplify commit message and error (Krzysztof).
* Pick up Krzysztof's tag.

 arch/arm64/boot/dts/freescale/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 876bf484bbe6..6f0777ee6cd6 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -32,7 +32,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
-dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dts
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb

base-commit: 39fabe22e0f8c00334882ceac1dc70ffbd7f4871
-- 
2.29.2

