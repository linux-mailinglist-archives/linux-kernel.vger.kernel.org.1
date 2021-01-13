Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3ACE2F4D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbhAMOfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbhAMOfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:35:31 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36345C061575;
        Wed, 13 Jan 2021 06:34:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k10so1792922wmi.3;
        Wed, 13 Jan 2021 06:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NZrRlmJpZKjEgBKlGXdvljjzCJ+E8Zrv7ZKX7eaCDQw=;
        b=oUN5RjffDrgTe/s8rEZ9uxnydZTrlbRdRWweSzCNuy0IdG6XWnppYLvISq9L5BH4gQ
         UFjSHkQEcyIXmWz1dUtXJb1LJHQPulqZvvCF17xSYYXz6hBuRU9cXK0YrTXGjBxlzqNt
         Nta+PuaSE1GRYoCdqccpQkMWXOC8x7q3WRb2e6fe5UrKdOI+Run2hxIjO+Bgv2KZiwip
         GDpXzUhmWqcpZQInn9rvo1cyuelreunEnx7uI6cKBnYEoivKGzGsOJBsJJyrfeblvpJ9
         ljCVrDqm0YKNGBMsvQbfMXQ0HxoStD75KA5PQ0Dg3Ai4WmQJri56vUhn4DvBBwPtHbaU
         6shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NZrRlmJpZKjEgBKlGXdvljjzCJ+E8Zrv7ZKX7eaCDQw=;
        b=AVGRVG5EDc3xzvfft8jF8f2X9YEn1gO7N/Z1DAe43gU1rPqKs0RFyZUEy6TLksXngC
         fxREfmyENgiqy0gSq7f3T+uvtQyE3XwgMCJngbtYt38iM0ZClw2/qUhGd9ID9BhTITcr
         z27nYY0nazHDL/uXiLHMH700Re8A5XqPMwDi/aogsx2OMZOv42zPW2FSqOl8wgFhbsoB
         FPKBFdh36jzirqdq1r0SttrAW/Rg8DBk76C66MfIP8X/7Pd3uDhD04/+PfPaq0203U8X
         JIMyvbYrFwdTCHI79bZMPAPKlPCuakc27FuX5rLbPNIIXXzmSdtP56f39Vi1hGStbdFj
         nsoA==
X-Gm-Message-State: AOAM5335deiGqhxE89MqOt1hrPUE6aTkbQH3mSYnHdxfhuCoSVLVlAx4
        jNzHftlL4UqwCeDYtG/Uwrc=
X-Google-Smtp-Source: ABdhPJyDC1cnuC5m5ve4pRP9dUOtpKF9M6+NzDXUoVBoYGiNgcLs2bunNrO+Ja1oy1axQfrOSHtl0Q==
X-Received: by 2002:a1c:87:: with SMTP id 129mr2439406wma.183.1610548489843;
        Wed, 13 Jan 2021 06:34:49 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27000d88c7723353ad1a.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:d88:c772:3353:ad1a])
        by smtp.gmail.com with ESMTPSA id h13sm3720502wrm.28.2021.01.13.06.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:34:49 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 0/3] Add support for Boundary Nitrogen8M Mini SBC
Date:   Wed, 13 Jan 2021 15:34:40 +0100
Message-Id: <20210113143443.1148506-1-adrien.grassein@gmail.com>
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

Adrien Grassein (3):
  dt-bindings: arm: imx: add imx8mm nitrogen support
  arm64: dts: imx: Add i.mx8mm nitrogen8mm basic dts support
  arm64: defconfig: Enable PF8x00 as builtin

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-nitrogen8mm_rev2.dts | 364 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 4 files changed, 367 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts

-- 
2.25.1

