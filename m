Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85707230740
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 12:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgG1KED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 06:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgG1KD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:03:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15424C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so11237494pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqL6Hf6c4QekoFaLOlZu1oX0uTrAmJv+cvAaJuBUQvY=;
        b=Wv+dkdLgt5GaTHUTC/zxSY0/FqradzfyAopvOn1bQ1JvKPgFGgUAds2ZLqfsUngRTK
         1MXSX/omDXR6Qeo+mkRGjd3WqRMSDLnwV+r3o/s07aaiTR4sln2PkDtwTYPf3QolzgHS
         2wb2lh8g3wPmHx57IMN/erWNWw8kt73tMJOvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqL6Hf6c4QekoFaLOlZu1oX0uTrAmJv+cvAaJuBUQvY=;
        b=ibBRgrsgpRe3YlH458IVQTYz0mI0aSxnrpREv3bN31ZtCvuw1zSlf9aXwg4DUE0D7b
         9TRdTWT/7tckgvZzvED1EaWJg6h9hcBTfBC2p4eE7ybY+EM1Hq7Dw7A1vvhEJEwgtmdr
         XfkvFU0mAkP9bTrvvVo+64THw1ZeZGoenG0IA5FRiiHVS9tLrlEC0qjwujIsRobXQE50
         ugFHeOiw3i05dqYfFfmmkPFF3nrhdH8DCTmdC+BofFE455fnfizW2o0Mreh/g/5Pk3I6
         DzeoAkAlICU1vYQjOcYs9EauxlhTRdTgVyeB2qGrQnJo+f6/xRAM/9qOztqynMkRQPsW
         w81w==
X-Gm-Message-State: AOAM532RDNxQq5B25kK5EbCW/dFQqQM3Pb63UYFAZIP6eyy6Oi7VLaPx
        yN4Miff8N7YgGOMjMB9jAPJcEQ==
X-Google-Smtp-Source: ABdhPJwIMReWpM39kk9lbKtgYuSrVGQ0fXaPXcyqtWpE61ZnhacKeju0jsGrkiCHXZ05muiy3/Sn4A==
X-Received: by 2002:a17:90b:f16:: with SMTP id br22mr3914793pjb.170.1595930636601;
        Tue, 28 Jul 2020 03:03:56 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id u66sm17779018pfb.191.2020.07.28.03.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:03:56 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 9/9] ARM: mstar: Add reboot support
Date:   Tue, 28 Jul 2020 19:03:21 +0900
Message-Id: <20200728100321.1691745-10-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728100321.1691745-1-daniel@0x0f.com>
References: <20200728100321.1691745-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MStar v7 SoCs support reset by writing a magic value to a register
in the "pmsleep" area.

This adds a node for using the syscon reboot driver to trigger a reset.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index bb7fb3e689a7..c7458c67c4df 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -78,6 +78,13 @@ pmsleep: syscon@1c00 {
 				reg = <0x1c00 0x100>;
 			};
 
+			reboot {
+				compatible = "syscon-reboot";
+				regmap = <&pmsleep>;
+				offset = <0xb8>;
+				mask = <0x79>;
+			};
+
 			l3bridge: l3bridge@204400 {
 				compatible = "mstar,l3bridge";
 				reg = <0x204400 0x200>;
-- 
2.27.0

