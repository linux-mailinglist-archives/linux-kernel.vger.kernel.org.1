Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748C0291D07
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbgJRTmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 15:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbgJRTmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 15:42:32 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF6C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 12:42:31 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a72so8258128wme.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RKz/glIDgqXLsKwUH5mAwh9re1kJ1vMgTO8yUCSmg/4=;
        b=1f2Jtl85s/SyDOvTb1ZgqX2X2g3djWqoR7b7ydmDzDFSbYe6UYbXVbs1Gv7yAbg7gX
         cRme3fyaWAxycWYUVGs/431BTGMbotzOkxZYU3VHMnt3nRtfslvezYF/NE2ZrrZk+fXK
         fdEH+OuxEQnjkLicXnRKJkYyIbKF4nTCCHcwC0aBCEpQygRZYcBZxnIzqdVY16ZEYJCl
         kL2Sdo2Jcsa5FYMPPIJGvUZ0GR1whh4BVgYnkmuKpBMgYVRuOSOupld+x8k60QEVCfxF
         4uubbd7N6bA5Xe9Y+jIhZPa6Z2YP7T3bdKAqa+s5j1v5vei5nPBwrnI9yKPH0vLTLxFG
         68zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RKz/glIDgqXLsKwUH5mAwh9re1kJ1vMgTO8yUCSmg/4=;
        b=bfkm2Emh7hrh25qFrl1ibx9/phj9Eb9edSnTA8VtjUP3hmJmVsbNzUhZ6Ial/7m0O1
         NONMjB/FXsZHYFKqWwW0Sx/d2weFsE4WtbN8q9bip+m0MmxnWZavxICJ2ixjKkO0toX/
         p5ehsvuhm7LxZPBpCxKAPwnGO42RTQeFI87u4DUNae/aBo34fz65++LBeJRJZX+JrcGS
         ETjy+K2NQW8zQhF37Krj+6H32B4Syk3RIKB89jpWmxbb2MitOuQZ9Dq8UCFgXahGHfFK
         mJw0153DmQNELjqSzqVndrNy1lB5ybW+PxRSlfA6S7s50t/NRYGg7MY+fq+gKprOVUHO
         YVsg==
X-Gm-Message-State: AOAM531QubF/nmS+SqIUC4P5RExrCG4BmfoOF2aVPeoafvOzzSL/uuPn
        SYnIOr6jmVwDc8UkU/7VEGqynakezXuTvA==
X-Google-Smtp-Source: ABdhPJygp4zfPt0GTUPgI2ugSev36X1niFyJ+XGD4da4OhVKLzbK+lDKf86uxATNEWqg/QYtTRt9/A==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr14912567wmi.56.1603050150184;
        Sun, 18 Oct 2020 12:42:30 -0700 (PDT)
Received: from localhost.localdomain (124.171.185.81.rev.sfr.net. [81.185.171.124])
        by smtp.gmail.com with ESMTPSA id l11sm14253674wro.89.2020.10.18.12.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 12:42:29 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     bibby.hsieh@mediatek.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH] arm64: dts: mediatek: mt8183: fix gce incorrect mbox-cells value
Date:   Sun, 18 Oct 2020 21:42:25 +0200
Message-Id: <20201018194225.3361182-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding documentation says:
- #mbox-cells: Should be 2.
	<&phandle channel priority>
	phandle: Label name of a gce node.
	channel: Channel of mailbox. Be equal to the thread id of GCE.
	priority: Priority of GCE thread.

Fix the value of #mbox-cells.

Fixes: d3c306e31bc7 ("arm64: dts: add gce node for mt8183")
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 102105871db2..9a3cf95676e1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -352,7 +352,7 @@ gce: mailbox@10238000 {
 			compatible = "mediatek,mt8183-gce";
 			reg = <0 0x10238000 0 0x4000>;
 			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_LOW>;
-			#mbox-cells = <3>;
+			#mbox-cells = <2>;
 			clocks = <&infracfg CLK_INFRA_GCE>;
 			clock-names = "gce";
 		};
-- 
2.28.0

