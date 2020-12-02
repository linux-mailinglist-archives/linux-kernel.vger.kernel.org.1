Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB17C2CC42C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389055AbgLBRpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387756AbgLBRpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:45:40 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F20C061A4B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 09:44:30 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i2so4969226wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 09:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gxPSG1/jKCExtEHHvCtcVieFeCsXRCYyFJFBc+BdEMg=;
        b=EAkad4/IyQDVuOEVtUWGNRb6tU7jCcx2PbwpCDuo2+jDE33qVg9wNhjmDnuheQ0Iwr
         ox851w381UOR9wh4QY6QKkC+I9XVkclZmkbL2q28pRlb13UwdGyPn3dZY61xJpW0Aa0+
         fDhcVd2kOqMjrCljRjACBFftcWM11u0J3v+LuR5d1oZ0NDYob7bHkhDdh4vuTLKZbDHq
         urNSKWFVVV1SSVbbDSWA306Q/5oQ2XI2M4hk3Eh71r0h2C2oYBkHoB9ljcGoei27iUml
         e6Jsra9d8wbHrcSe0T4S36C4aYdFpWQ4fttgw2neHD3wzyyP5kdRwJ8tTcCR+t35U5QC
         HQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gxPSG1/jKCExtEHHvCtcVieFeCsXRCYyFJFBc+BdEMg=;
        b=g8q8Ivqqeapr1fGsZn+XT3+pZeKfXG44gtyBGwuFNAT3E/scO5w0a6EYesBzcud68X
         /fi6o95Hba9Acsk7fjKudiCi7wN0hPX+z4WF54N/StydOfBOfYXGCaqC4xX2p/kUGBQ7
         5enaA6D55HG+4lECNnBNc3T9U+SfvGqPzwxTu5XvIkkJdwj0MHKBLtqxsYvu/6fiGIoc
         20wVl0rnbqjaEM+eFjbtvcQf3kdHe1VFYVKjc5AWqiLvMmDQ0YFYW0vnNXySjsZR98OX
         WTHaRxtIfWohqc29hZy2GR/F+FGRcyprSBYHHCiTuXs6ppzcWTdrFq3EJMBASEv3QRpJ
         ectQ==
X-Gm-Message-State: AOAM530MsikKX9M2hpzEFCoz5Yxwq6D9zq06jpZmXB93C+FcgYJYo8Yp
        7RZiXXV9isaIHxE51gSiPtRBaSK/V2pDLR+Q
X-Google-Smtp-Source: ABdhPJyP6rFAQ8WXLvl4FjskdfY6uLmqQw/N7YlH5pLf+59FEarNuMiJryaEGmn/GzrmuGwyehgVhg==
X-Received: by 2002:a5d:6046:: with SMTP id j6mr4721952wrt.317.1606931068691;
        Wed, 02 Dec 2020 09:44:28 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:15b4:c668:8f06:1b99])
        by smtp.gmail.com with ESMTPSA id q12sm2842915wrx.86.2020.12.02.09.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 09:44:27 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] MAINTAINERS: Add myself as maintainer of the Amlogic GE2D driver
Date:   Wed,  2 Dec 2020 18:44:16 +0100
Message-Id: <20201202174417.3778306-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202174417.3778306-1-narmstrong@baylibre.com>
References: <20201202174417.3778306-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 02437abc94c9..29b5ac0e7a74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11381,6 +11381,15 @@ F:	Documentation/devicetree/bindings/media/amlogic,meson-gx-ao-cec.yaml
 F:	drivers/media/cec/platform/meson/ao-cec-g12a.c
 F:	drivers/media/cec/platform/meson/ao-cec.c
 
+MESON GE2D DRIVER FOR AMLOGIC SOCS
+M:	Neil Armstrong <narmstrong@baylibre.com>
+L:	linux-media@vger.kernel.org
+L:	linux-amlogic@lists.infradead.org
+S:	Supported
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/amlogic,axg-ge2d.yaml
+F:	drivers/media/meson/ge2d/
+
 MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
 M:	Liang Yang <liang.yang@amlogic.com>
 L:	linux-mtd@lists.infradead.org
-- 
2.25.1

