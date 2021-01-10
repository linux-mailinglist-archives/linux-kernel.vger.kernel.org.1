Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AF72F0A61
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 00:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbhAJXY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 18:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbhAJXY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 18:24:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C58C061786;
        Sun, 10 Jan 2021 15:24:17 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w5so14550572wrm.11;
        Sun, 10 Jan 2021 15:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eRV+tTZsokJBmC4k80B5YRBHZdMT1XvGOuhlbjJDpTQ=;
        b=DONpPGQSGTn2BYYxRpi3nsL3xsF1cHfUl/NZ/hpZiae+jTLdwZkpM5fD1swiW0L1nM
         +n7zcmRYO+5xtIROArafLV/cOpdMwPYye3uLVnthxfYcRmXHsIlXvWt1mPtATKI2mBSo
         oKyDTcZVaLwVFGreMAXYsY/8b2AqI8Pf/jQpbKn9VV3LpwKByZAD9UnnbWuJ6XVOiKof
         i6X6vhG1L+i2ZDF+X5W7Jv2veHL17F8GqglVNsF4TWMDihC2XW5ZiqbyqgUjm/OT9WoC
         Daf1QOxqTNvf+m7mN42/YXKFl1xKHBx7SoSPRQzmjJfj+9UFL3I0te0rEqYlgil4MnYB
         tj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eRV+tTZsokJBmC4k80B5YRBHZdMT1XvGOuhlbjJDpTQ=;
        b=TR0n1WGjNbxd2AubpL2lD19x12KmDkvN+37i0ojGM5sSS0cCNo7Z2nyCjFhFmXn6Pn
         imFealFLyLDjfbgiU8cB2AP4y4fkT8ToROcu3IoT44ku/mwvnxXMw2OAMEDvZ7QOXBLz
         DwEoFnmCF9P+MX3qAQy8MHa6cdQ9OmWSnT0+aVS7DgFblcas/lSZQkcYVtlEtxhoGvhU
         B+0ZXvDKuzWOQxG6UjDKROO4HASY5knK+Dp2i7QlQE+0B8T3P/jhQyUOaE3LtZ/47TMC
         pVZQWNgD40Oyp3F68rjpusD8d9IG90v6bJ3TGY6PdwUQjolQnG3Xyxyz3Zx8MupGPUUY
         d0kQ==
X-Gm-Message-State: AOAM5333HuxcjU2NTljR8N9M+5O32WiI4Bb4QFy3c5lreuaK0bYfVLNw
        ToNrgSJdz4T7+juNxT32KEm8VHJjm18=
X-Google-Smtp-Source: ABdhPJyUNN10Os95AKcQvRBspamDtsfo4gneUiWbtg9odxRx6M0RYoyLwae46b/aOmlTbU7PBogjMg==
X-Received: by 2002:a5d:58fb:: with SMTP id f27mr13324479wrd.22.1610321056705;
        Sun, 10 Jan 2021 15:24:16 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270029536a450755141e.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:2953:6a45:755:141e])
        by smtp.gmail.com with ESMTPSA id a12sm23426104wrh.71.2021.01.10.15.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 15:24:15 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 0/3] Add support for Boundary Nitrogen8M Mini SBC
Date:   Mon, 11 Jan 2021 00:24:04 +0100
Message-Id: <20210110232407.1666059-1-adrien.grassein@gmail.com>
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

Adrien Grassein (3):
  dt-bindings: arm: imx: add imx8mm nitrogen support
  arm64: dts: imx: Add i.mx8mm nitrogen8mm basic dts support
  arm64: defconfig: Enable PF8x00 as builtin

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-nitrogen8mm_rev2.dts | 657 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 4 files changed, 660 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts

-- 
2.25.1

