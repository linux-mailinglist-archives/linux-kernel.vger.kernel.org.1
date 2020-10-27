Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B0B29A55C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410177AbgJ0HQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:16:58 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:50182 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409241AbgJ0HQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:16:57 -0400
Received: by mail-pj1-f45.google.com with SMTP id p21so314109pju.0;
        Tue, 27 Oct 2020 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7yrqtj2m6vzvqinB8kQD2iAzM1ouVrPGjHgo6sSlb6s=;
        b=SCB+7dKs96wiioRl3bVZR4r2adVcmLrf+9AybuUVG+00nBaKGaTu96J6Rd99vBhXfD
         Sm9NgdEVO82Xs4AtDvwI/y1hSgKaK2Aj6/AFp+2cG7fBnGdY1frNnSKAPlqLXrRg+1AN
         mCVqAe37FvnbMtsg1GbmXeNfbUvP7nchti3F2Wtne060uF+5TR6vrBPKNkvEFgfednrU
         2tbTSVlkKWp3r4NiELLtV+7HCY8QxmAN0+HS6PKAFZYtBYIyYF83FIi9kfBPctcVJin0
         /QO/dtC+VN2tpAJvh9abN4Fw0iDI4qx4mNEQK86EauzwX8A9g7LbQWuFzBZ65nxe+2dD
         /ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7yrqtj2m6vzvqinB8kQD2iAzM1ouVrPGjHgo6sSlb6s=;
        b=XQebAXhDJjsJZ+AQ3eDlb45bEIZ2pIXfkbvIHwQCRNt64aWHwq+CVK6WQmW8I6xGbr
         APAyTF+Ov7CtCHFQ+vSK2dk3W++/BAodbtKNYnYB+HkwaW/wDWcLcSYAIxgb1RMaXpfd
         wpBg7TmDtki8b0yLct7kxANBVEljTQsOX91jmjqOB8hcy010QYl/9O/qXJLuE647eQeP
         P7M/lhh/PUyf2yN+uSBOEC6wT6IyvyoZgE7g298v/vYUZaiCXwQWbiC+tc+8sVSWUblB
         Gpor6C2qHaxQ212R70EVz138kIUAgb/d8cpXlG9NV3fdbo8vQCwXnArIqDIowH/HqJR8
         4pOw==
X-Gm-Message-State: AOAM530P+iH5ePrkgB2LAcFeaQfCoKDvN1PXzQNx0/+8Ua9RB617ZGU2
        HipNb7dQli0a8vJpKEtYJPNfFmKmNm/4gVtK
X-Google-Smtp-Source: ABdhPJzzQrPr5oMabX/0pS+moIp8eL/57vABKuW8jfm2EkcoltLpwwQq0mI4HX2r7ZOg/9R96FJJhg==
X-Received: by 2002:a17:902:d706:b029:d5:dde6:f56 with SMTP id w6-20020a170902d706b02900d5dde60f56mr1212684ply.26.1603783016856;
        Tue, 27 Oct 2020 00:16:56 -0700 (PDT)
Received: from ruantu-3.localdomain ([103.230.142.242])
        by smtp.gmail.com with ESMTPSA id u7sm1036634pfn.37.2020.10.27.00.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 00:16:56 -0700 (PDT)
From:   Yu-Tung Chang <mtwget@gmail.com>
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yu-Tung Chang <mtwget@gmail.com>
Subject: [PATCH v4 0/1] ARM: dts: sun8i: add FriendlyArm ZeroPi support
Date:   Tue, 27 Oct 2020 15:16:47 +0800
Message-Id: <20201027071648.15988-1-mtwget@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add FriendlyArm ZeroPi support.

Wiki:
http://wiki.friendlyarm.com/wiki/index.php/ZeroPi

Schematic:
http://wiki.friendlyarm.com/wiki/images/7/71/ZeroPi_20190731_Schematic.pdf

v1:
- Remove the extra spaces in description text.

v2:
- Remove the ehci0 and ohci0 device nodes.
- Remove the usbphy->usb0_id_det-gpios property.

v3:
- Enable RGMII RX/TX delay on PHY.

v4:
- Fix build error, remove useless pinctrl property.

Yu-Tung Chang (1):
  ARM: dts: sun8i: add FriendlyArm ZeroPi support

 .../devicetree/bindings/arm/sunxi.yaml        |  5 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/sun8i-h3-zeropi.dts         | 85 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-zeropi.dts

-- 
2.29.0

