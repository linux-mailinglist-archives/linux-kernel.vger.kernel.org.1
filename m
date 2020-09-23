Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FCA27587D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgIWNOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWNOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:14:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC070C0613CE;
        Wed, 23 Sep 2020 06:14:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id v14so3146502pjd.4;
        Wed, 23 Sep 2020 06:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UnZ1othxt40JVdFDvzcd0FUgCJIb6rGQXftesSvbrIE=;
        b=Dimn8cZO0G9jRKSwUZVQBHEsIpLOFpJeSd116xZIV23irxt9hsOD+KL1j1QEbevLal
         EiD8MvE3ZzTDIRnpjEoWCjg2XyRi58qGeh7pYguGXkAzKfn72l8Axas2kAL5ncQXZ19L
         XUMMmz8smijkd0LYnuAGRAb2jOzYAm0Y+1Lfd+nbL5gOlUtTDL9chyBBjVcvrd4dd/sf
         6B5GvDKlVw3aiwRKQrEESBAKs6PAlw0DGjZS6GEjUzBOzPShb5sSqC7jmx8JHKpvZV9W
         IHNQOksZHDxF3rxh4QEMDTzOtCB1uI6RIB1m9lXmeSUfO68fPznf0atT7FsU1L+DHy/U
         83Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UnZ1othxt40JVdFDvzcd0FUgCJIb6rGQXftesSvbrIE=;
        b=I21BGjNHHbce40+B1ZQd4s3AfkqWKnRWK3fGS8Nxjnijkgu0BEb6tRPwofQPluHf4e
         Sv7V2VwDiZ8VQ4MU6k+qGBP5Xfbzh0nh7JL7pqWz1knpZDo4WY6BrfDDvYjzKYtGEUV4
         diL0ayRv8PQrq9xr2f0kO7xsL9nZrbwXmyR4f8Xo0XzIUaJbOmgJ/bnQANO/JDXNmnFF
         i/TGOn9WWVjhlYQ6sfqLQczyMg9DVTjL3OA8NUHjdtwjfnkXvWzBrf6cB3BobhTkH35W
         zvxFEHk+X9jwYYFSlCoax5NBZ9Uf68sgGU9N2ugnVfXKCUGpifyXG6sqhp+rcMO0n8RH
         4R9A==
X-Gm-Message-State: AOAM533mFTQcycTuYEEpv13qiavhHlnImCw3xLGCQalg80aNTS4vI3Pb
        A7zR9PQMYsvhzJLF5HbmmEa+fWtpIezys0Te
X-Google-Smtp-Source: ABdhPJySX9Xpk7fbiMXc666EQ0Oz/r5bQdZ6Hiu+48kRs1ALTOHNSz19Ra9KrQMv1Rac4mvfhmLSKg==
X-Received: by 2002:a17:90a:ea08:: with SMTP id w8mr8463084pjy.124.1600866891335;
        Wed, 23 Sep 2020 06:14:51 -0700 (PDT)
Received: from universe.lan (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id kf10sm5045280pjb.2.2020.09.23.06.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 06:14:50 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, art@khadas.com, jbx6244@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        nick@khadas.com, gouwa@khadas.com
Subject: [PATCH v2 1/2] arm64: dts: rockchip: add spiflash node to rk3399-khadas-edge
Date:   Wed, 23 Sep 2020 21:14:23 +0800
Message-Id: <20200923131424.1612960-2-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200923131424.1612960-1-art@khadas.com>
References: <20200923131424.1612960-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Khadas Edge Boards uses winbond - w25q128 spi flash with 104Mhz

Signed-off-by: Artem Lapkin <art@khadas.com>
Tested-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
index e36837c04dc..c67420578fa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -690,6 +690,16 @@ &sdhci {
 	status = "okay";
 };
 
+&spi1 {
+	status = "okay";
+
+	spiflash: flash@0 {
+		compatible = "winbond,w25q128fw", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <104000000>;
+	};
+};
+
 &tcphy0 {
 	status = "okay";
 };
-- 
2.25.1

