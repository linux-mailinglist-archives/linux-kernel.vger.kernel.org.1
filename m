Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB59421A1B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgGIODo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgGIODl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:03:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454D2C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:03:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z13so2509375wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dcu4SndGV5Tss4rBZKTNWEr/Y8nrFq0nn6EDq7ivZDo=;
        b=JeUNWsNgXbbHWdzNwV8DR/fxWrHOaJhAiPJovG4vKr8ythoAoJ08L4/HJE3vSZoGyg
         miP1i8jMb3TBa58bPs9dzrAL9BNc6hdx6URpUvU0/V1NZ2L/Oe513SIgicQydG031DpV
         CpZ/mSDZmlpHwRlXHzfAjVcVivLZVX5XZupXuQvFwXbR8jYz39D/si/Vl6GhLR5NVJ8G
         9y7GrslfmI9yzpEXDIYyQWBcqlGPkHBHT28bFXixZuEA4fuUeYFvJgOqoPP6DvC6ylhG
         FW9SymR3OTCJ69ldpO8It/zlgwY1BnZlDZS8IQzxxEmfWM7qVnjiJlTOUzOhugB1jhO6
         BFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dcu4SndGV5Tss4rBZKTNWEr/Y8nrFq0nn6EDq7ivZDo=;
        b=FPVUDJuW2O0wwp+8+rIb9383+O/ZArouCYQ0HfNa5noU1EPqouWYHWrDCXpn/4x2yO
         pAH1BkzVWRe6hYHZssyWUleCcT5sj8Sg5htM6OScZHvThSTSwXoqX5hBzYDu5zfX/QcH
         GhO+SVbhE5MJW1s6QYQK+krSIPPcvcbf/1pHv4hEwe9uCQnZPSkvcxvbbBsPyO6LLfTD
         BW6LbMPcU2NerMOHcgGZqBR4LgkieJGa3/YJ90+45n9YLpOPDOx0tKrXQD3DN/j4mQp7
         Ey9YBVIZl2YbrJEmTZcle05Kyxd539TJpwZTrv6WS25DP/LgkjV1t93uye8sm82UoPFP
         6PhA==
X-Gm-Message-State: AOAM53396TgeoE5skXey8u9kxYm4sr5Z8eAcJcob6t19WeSeEeLasXxP
        XuL5xFXZLvS8eOisvnlwZ2n66PHCycc=
X-Google-Smtp-Source: ABdhPJzpkoGDkREmIoP1jIdxUD7tsYkEzzBcGj/mODktAXM4oPSJ2LpVO3mDm+oHE19inD4vm1bLzg==
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr52588436wrw.244.1594303419826;
        Thu, 09 Jul 2020 07:03:39 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s8sm5545256wru.38.2020.07.09.07.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:03:39 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 11/14] arm64: defconfig: Enable devfreq cooling device
Date:   Thu,  9 Jul 2020 16:03:19 +0200
Message-Id: <20200709140322.131320-12-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709140322.131320-1-peron.clem@gmail.com>
References: <20200709140322.131320-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devfreq cooling device framework is used in Panfrost
to throttle GPU in order to regulate its temperature.

Enable this driver for ARM64 SoC.

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 883e8bace3ed..1b7f9ffdc314 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -501,6 +501,7 @@ CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
+CONFIG_DEVFREQ_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_QORIQ_THERMAL=m
 CONFIG_SUN8I_THERMAL=y
-- 
2.25.1

