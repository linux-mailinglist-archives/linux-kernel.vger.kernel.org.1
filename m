Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187301F1533
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 11:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgFHJR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 05:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbgFHJRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:17:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BB7C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 02:17:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so3397599wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80rN4Yy/llOMe52Inz2Rf3Vg/VV/GbMwITSO8biBc4M=;
        b=VKp1v8JkbAxrUOZSvdERfeYsryZbG4ZALZU7H3E+o+6qhK0KqmrwmQfvLQLKo1lxT9
         geGP1GMMeDqB7Di3ltJnV1K7KMH2gzn2kIpY+gx+PlSRNsgyXsFHllVad/i+cGbo4CsS
         27YFviT9Pmq465c4nDOupAAw+2KBKbTKPxWxipemlZfAEqrpsEAwTZbxJ+3bO/tzk72B
         5AmZlWcI/UfSCYy3xhoexs9q34DQdcb0JO7LwJT8qSKtHMDjH9D2KqJ20XT74/wpZrlN
         W2ofL5I7munj2PmfKNFVxEmI+WqmdvjHx4gsUc+FQtiawDrWNi90aEXAnvwKn5M+H1KB
         AWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80rN4Yy/llOMe52Inz2Rf3Vg/VV/GbMwITSO8biBc4M=;
        b=C0JAFOzOrT/nyQPFyWYfNvTPWbiDUl/1Ruf8kir0nC3mBQNRKO4uPMf61CvJuQtfbf
         pAFc5ee91okLiUGNk2KJRFuu+TjxkibOMo5W14Fq7tQ7MEqSmZLA6s2ZP+VGT9EOVUmV
         y/nSjZBJ++RgDkTAPX1g150rlGm3g7Cq/qOkDKX8Mzq2gEnsOeytqPfgd/BPhzzFCy9s
         IB5J67b3XZuZEFkFNt5Qvtw8XRnohiRgUsND7hD9aCuWc9AyfHPo7t/mz6c3SXwhimox
         igMk+zpbPybkcCbaD8m16xzKQIxKHILnQ/Xqn4at9fP9qiEYEQ4o8UauqX+4ZhLXiRQN
         75oA==
X-Gm-Message-State: AOAM530NwkFEMUffCjT303vELpTNrll0WBujTWfYaM+kRlRwixc7DARc
        WwRimKZvuz4FMiR7u68A3K7ylw==
X-Google-Smtp-Source: ABdhPJwJa9Vo9lkGfwDogiFZQ0nVGFlp0w7rxsYeJta8zYKqW8uewQsscYdWko6YwfV9ExZreI/2qg==
X-Received: by 2002:a1c:5411:: with SMTP id i17mr16162838wmb.137.1591607868962;
        Mon, 08 Jun 2020 02:17:48 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:22:5867:d2c6:75f4])
        by smtp.gmail.com with ESMTPSA id t7sm22732326wrq.41.2020.06.08.02.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 02:17:48 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     lee.jones@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] MAINTAINERS: add myself as maintainer for Khadas MCU drivers
Date:   Mon,  8 Jun 2020 11:17:38 +0200
Message-Id: <20200608091739.2368-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200608091739.2368-1-narmstrong@baylibre.com>
References: <20200608091739.2368-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Thermal driver along the MFD drivers and header as Maintained
by myself.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50659d76976b..29d35fe0f886 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9436,6 +9436,15 @@ F:	include/linux/kdb.h
 F:	include/linux/kgdb.h
 F:	kernel/debug/
 
+KHADAS MCU MFD DRIVER
+M:	Neil Armstrong <narmstrong@baylibre.com>
+L:	linux-amlogic@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
+F:	drivers/mfd/khadas-mcu.c
+F:	include/linux/mfd/khadas-mcu.h
+F:	drivers/thermal/khadas_mcu_fan.c
+
 KMEMLEAK
 M:	Catalin Marinas <catalin.marinas@arm.com>
 S:	Maintained
-- 
2.22.0

