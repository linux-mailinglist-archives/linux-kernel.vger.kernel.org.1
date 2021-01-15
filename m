Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9522F8714
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbhAOVCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388420AbhAOVCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:02:01 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3892C06179E;
        Fri, 15 Jan 2021 13:01:30 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a12so10579508wrv.8;
        Fri, 15 Jan 2021 13:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LEzohCRsK+Jzaxz+SANVOLWTAoH1HEg4LQDGbyq7c0o=;
        b=VD+rTQiNM6uXyQBYmwDXV81j7ywhaUNtBqPfiq4Op2JgxB+14ghSpxI0EViBf7rHVs
         LVNVhhlFOZWfVAnIptmVJbM7DuC2G9q4tUdYQmWo2++y+7rUdKfBwK1o/Dih9ObssR3k
         uEE81VtxzZ0M429oyptd/ZIWWb072RzKUIPkPu9UBcsvpa5aYPRwg4yBtgnYKawd/LyM
         ErgqFRP9PWnuWIiGHisCucF/WmW/BxqobQRvcf9zwZSHbXhoinOpgzRi6uZFd+wXTRNk
         50hzFPC0ily05UUGxu/UlXhaoxNWa4xRnUKSIxNUGFokVkVBQqc9ebyrIgUV0165RegF
         MJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LEzohCRsK+Jzaxz+SANVOLWTAoH1HEg4LQDGbyq7c0o=;
        b=rWyVbPYBkjt6Oe8u+ztaSKibEOaRb0EN6TJgEeaZvDwR7hchwRSbFY4z/TgVOWVbcD
         xVHwfBKDRQb5XI3sNGYVd8xIy8dVArMzLzo9AgjcLkQe52kJ2Qx/WYhQPgzmNPJXOnxi
         Fd4cgCpPS0OevwA+RocsDZvIWcaq7wHm/5UPbsQthVrrMerPvTryfbBS+0yLm3W6iEm2
         rJXtKXzvqerxhLzDWst8PUzcWj7Anm97LZFQX/AAzhvM7LRgv29ikejBnd4srgjukSHi
         dsSxSITnrUPfpKTYAksTmAHR9caF4XQsT+3hey69LiWr3oPJxhaXL+BJIi71oL1WV/zV
         3p0w==
X-Gm-Message-State: AOAM530Kpz9eWGDHf0SK0cGSguDVFKHLv4hBJRHsZ0r9y9bHMkLu5x0e
        CcdhDMBuZr3MiBNLK6pGTHY=
X-Google-Smtp-Source: ABdhPJzYao0HWnOejl6JP2t3R52ey+WuKckBJelKydLHQMjZyHCZNwYZUPLNN4fOW8w8O86NpX9RdQ==
X-Received: by 2002:a5d:4a09:: with SMTP id m9mr15201327wrq.359.1610744489776;
        Fri, 15 Jan 2021 13:01:29 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd270090311bc0a820c7e4.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:9031:1bc0:a820:c7e4])
        by smtp.gmail.com with ESMTPSA id l7sm13414853wme.4.2021.01.15.13.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 13:01:29 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 3/3] arm64: defconfig: Enable PF8x00 as builtin
Date:   Fri, 15 Jan 2021 22:01:24 +0100
Message-Id: <20210115210124.507282-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115210124.507282-1-adrien.grassein@gmail.com>
References: <20210115210124.507282-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is mandatory for the nitrogen8m mini board
when booting from the sdcard slot.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9957b6669eb1..de90f42419a3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -606,6 +606,7 @@ CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MP8859=y
 CONFIG_REGULATOR_PCA9450=y
+CONFIG_REGULATOR_PF8X00=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_RPMH=y
-- 
2.25.1

