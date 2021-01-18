Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DBD2F9DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390196AbhARLVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390019AbhARLQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:16:18 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D704C0613CF;
        Mon, 18 Jan 2021 03:15:38 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id u14so9231633wmq.4;
        Mon, 18 Jan 2021 03:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJ72bt177B4DIMVzaTLLlUkw9fRM650S/6lWEQAT6dM=;
        b=t53hjN4JoCR8pQXbKACwBx0R7gMAx4R8cOmcGcfNoNgpG41hB5EVRA/emJyIMHFzAo
         eSeZEX/USZ7CK7x6IrCf83xz3p9tHKxrNK9EgkhKOp8w/fz9GxtTQK3ApBLxJgT2oztc
         zn9U1fhcOZD16wkCFminFqYSLoYasdn2UpcKSeeyX18lXpyNm/YDE2/bG5Ik9SEoWf5Y
         ulc0dHt685IlDo7VZoPvh5mLk2v3nX2Z/wzC6xNzKKuO3rqD31FBhFH3o6A9e8lV44Yd
         yqqu8cyXITMaxb/RH6n/qa7ILdgf5CoIGwCC5VmYC3z5AZ6zzL6HUZMxRs2EClQG1aUv
         ig3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJ72bt177B4DIMVzaTLLlUkw9fRM650S/6lWEQAT6dM=;
        b=XjLtqGPbh8GrIzrjliz9dWJ/XmDNvbT0syoXzktVoCW8Sy6I9xy5DgfLIn90TL2mf8
         Azg7pvg3IAlbYHTcrB+bjpESbXD55w6aBEoBDym1bTpyWH3zuADUhkXYTJYB+UYEBx60
         qAXYud8Vujyhxza50zBGAXryP9JsGlvzR+6Jh9GV/gJQr7Q1H9T/FhVpZS3d6bverph2
         6SiD/l9mJGVot+V5najXRp0eF8pcV1smUDVckLkaT8Jjy61hczgzvOJJMXDrEfcJux8/
         u2uxPOKS525dE6E36HOiclQ6PstsdCNIfBImVDsneq0mrkgfoE3G1Mpa4tYDX5nOxzt1
         UXHA==
X-Gm-Message-State: AOAM532DBe1tJoZOL5q1HObOtbYsww95e82HCJUrz4V1Fh4IdBJdksB4
        IAaZnO25fmiJUvky/fi/hmg=
X-Google-Smtp-Source: ABdhPJzwosWeCGnN/uC2PxZQ5Yjn6dpYgRUOTyxZTbeAfcVlAGKdJ8ij6bnUx89R22ZgDrfy2/92FA==
X-Received: by 2002:a05:600c:4417:: with SMTP id u23mr20620115wmn.100.1610968536790;
        Mon, 18 Jan 2021 03:15:36 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd2700989047bbcea0de57.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:9890:47bb:cea0:de57])
        by smtp.gmail.com with ESMTPSA id b132sm26778440wmh.21.2021.01.18.03.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 03:15:36 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     shawnguo@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v5 0/3] Add support for Boundary Nitrogen8M Mini SBC
Date:   Mon, 18 Jan 2021 12:15:28 +0100
Message-Id: <20210118111531.903154-1-adrien.grassein@gmail.com>
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

Update in v4:
  - Reorder definition in pmic

Update in v5:
  - Take in account review.
  - Remove useless i2c groups

Adrien Grassein (3):
  dt-bindings: arm: imx: add imx8mm nitrogen support
  arm64: dts: imx: Add i.mx8mm nitrogen8mm basic dts support
  arm64: defconfig: Enable PF8x00 as builtin

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-nitrogen8mm_rev2.dts | 395 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 4 files changed, 398 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts

-- 
2.25.1

