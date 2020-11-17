Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7559B2B5B39
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgKQIoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgKQIox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:44:53 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4F4C0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:44:51 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 1so926724wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwtNdHIPSabqM1aRDu7jm8OQIX10dof411XMNae48b0=;
        b=SazKex1e8Dpmw0wCTWs/sE3RvrSt39qvTnKOgvciTfR2KM6ODtIkjEjiEHadPqDO3w
         gIW1sSOWuZv0I5EqxfJRNuRzkehDdoh35By/7es9E8jN25NeIbwIkmRSVwgNZ5N+i4xx
         sM0qeH/Cd/5tqEK1EDL8DV5WeekkhzmO5phFKmA6EzLzZTjWtld1jqCx6VAelDipUuQT
         EVZbqLRovTKGmpD9omMqEXI6lza8GlO5eECVcxCyaLWsw9kTb1KKDntjSPOCRJLW2+S9
         01MtZ3HMu0hm3oAX9cfe3x0/AJxdiqyPrkfWtZPpyZzDsqhuop9RAQmEv033weo6aP+y
         7FNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwtNdHIPSabqM1aRDu7jm8OQIX10dof411XMNae48b0=;
        b=gG+ZGVE7ZYqEyX3dcG2t4I6PPzBo8xM7smdP6/VdZeJluDVqE7fgdp7d4rFIG0enrL
         XV1Jo/e/2vMFWtMcv5BFlRJ3YkpnUeYrG3fXuGg+bS7Tw7ESe8vjUN2i8TZRUh+QjaZc
         EnggaeFi8LGqmk/WqQgcgQTaJwJXwbw4yBm8fvzvGyYNbajVKweIvCyMyM+W1w7Lo7VC
         Vw1W2jIT9ww1ccABJZcAaFPXe0lxMjZrSRlp2pYYMuO8nGHOPdpnp/NDeuWZdoyj6NkN
         Bxb8cwfAt99rkdE73UnfGP1yBtohbsxF8ItvDqcTnMOI20ZacsxpjgZdXmR+RfY+UEc+
         VlJw==
X-Gm-Message-State: AOAM532nmkPOVGk/Szk5xpEeV+86p6iveEgCco3vsby4jBGbZdbJ8YKR
        ogdjDUQAAn8pcjaJxJH75IsgaA==
X-Google-Smtp-Source: ABdhPJyAd4+8h6Wy+fGQVwfIOyVyIO3OsEfT/liATAfN1Meh5H0R1ljGHSFXg0TujlFI1mvpl4eu0g==
X-Received: by 2002:a1c:1b12:: with SMTP id b18mr3063879wmb.119.1605602690049;
        Tue, 17 Nov 2020 00:44:50 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:1561:9f4b:5829:8e26])
        by smtp.gmail.com with ESMTPSA id s4sm25631423wro.10.2020.11.17.00.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 00:44:49 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] MAINTAINERS: Add myself as maintainer of the Amlogic GE2D driver
Date:   Tue, 17 Nov 2020 09:44:39 +0100
Message-Id: <20201117084440.578540-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117084440.578540-1-narmstrong@baylibre.com>
References: <20201117084440.578540-1-narmstrong@baylibre.com>
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
index e73636b75f29..db93156dcaba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11412,6 +11412,15 @@ F:	Documentation/devicetree/bindings/media/amlogic,meson-gx-ao-cec.yaml
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

