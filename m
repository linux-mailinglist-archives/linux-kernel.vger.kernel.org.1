Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEFC2F513B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbhAMRjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbhAMRjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:39:39 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FF2C061575;
        Wed, 13 Jan 2021 09:38:59 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r3so3032577wrt.2;
        Wed, 13 Jan 2021 09:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBNPlAKB2NWZbiNd5NT4ykLdnGxCY+M9Q+QpLlu9ROg=;
        b=Z9vk7GlZsfmUWclyViA0BjeYkpLttHjL2gtF/oitgLRBowSvvmGFCi3QcYaYmziof2
         4GAxTO6UI1J1zCfF9VqQ2OkS0a+e92/po6ZsfdBqXvC9+b1tuqE5i5wNtqTgOEXTSGXu
         AUdtxeeibchK4+ta84GhXhRo6VfdpEn39ygy+FAcCoxxCrDBJpcCI3Nl9XWU5HN6Lss+
         Fc+uRh5IPoBOw1BdVFg3FaCWLv7Tqd5EraHg61L98vbURh08x6Wh/EH7OZtwM+BRYh2R
         AQRgkEn05Ow44akexI1ieni/xXV7vR4FiGJiErwx3+qBMFPqJZisvqjOrzAfFk+r2ce6
         fiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBNPlAKB2NWZbiNd5NT4ykLdnGxCY+M9Q+QpLlu9ROg=;
        b=ncnkY5MPSL0Zz2O2XcpbASgMvnxyGkvuJFuqEwva9wRANNywK/dD7uPA64lVOUPy0M
         uC1buBpDWeK7bPSJH32PHG+4bZ/JBcJ5MfyqPDhgMMeW3azfHFdBFM+h+9LaTLRyw3Ez
         rSZLe1RKHLHr999PW/rKXhrsWqgOZHRxuvl/REWVzgop4YtWkBaGGjPR+uFDSAQpzyjm
         5WSg2gLnHvQkMy65bDXT6DNsembGqKK+OBAq4uz7jQ6cjgehV5kguJ2LmHe04eyZjZbh
         /uI7tC2FqUCOkOFWixTMi26xXHvh6dPVKtzDdjOTWKiklvM1ZZhwuJ2biZMfHZC+EU/f
         Mh0g==
X-Gm-Message-State: AOAM533CZU76hrmNpQD5wBD9LuQhHaIIVubBF+0i/hMVcThE7SSJUOuB
        pB6qp5ytxyJjo8VJuB6XaEY=
X-Google-Smtp-Source: ABdhPJz5s22jrgZxtmgPIH+nibYorY1kAoixe/+LV1AZlK1HAnpz9V4f5/FQVwKnMGIr9Z2QVrSq6Q==
X-Received: by 2002:a5d:660b:: with SMTP id n11mr3746879wru.407.1610559537767;
        Wed, 13 Jan 2021 09:38:57 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27000d88c7723353ad1a.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:d88:c772:3353:ad1a])
        by smtp.gmail.com with ESMTPSA id w21sm3743843wmi.45.2021.01.13.09.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 09:38:57 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 0/3] Add support for Boundary Nitrogen8M Mini SBC
Date:   Wed, 13 Jan 2021 18:38:52 +0100
Message-Id: <20210113173855.1509417-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch set aims is to add the support of the Nitrogen8M Mini SBC
from Boundary Devices.

Thanks,

Update in v2:
  - Rewrite the dts (Remove the unused wlan and audio);
  - Remove useless definition;
  - Take in account review.

Update in v3:
  - Take in account review.

Adrien Grassein (3):
  dt-bindings: arm: imx: add imx8mm nitrogen support
  arm64: dts: imx: Add i.mx8mm nitrogen8mm basic dts support
  arm64: defconfig: Enable PF8x00 as builtin

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-nitrogen8mm_rev2.dts | 417 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 4 files changed, 420 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts

-- 
2.25.1

