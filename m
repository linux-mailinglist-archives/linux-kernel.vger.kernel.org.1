Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D882AA506
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 13:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgKGMdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 07:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGMdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 07:33:50 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6472DC0613CF;
        Sat,  7 Nov 2020 04:33:50 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id z2so3707701ilh.11;
        Sat, 07 Nov 2020 04:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRzeMscpwq0sNCUubfUbWF6+269i2bONNUaXfNK1Aj8=;
        b=Y1xRrdGeivblR8MqZMR6hh7KQl18lWqSXstLg1a4lsghwuFiuqeAOJT1MYbJSW10MF
         +Ucqi3a7734UiMMId+90GAKVqbV6DIAKJLLC6GnWzsDnVdqsKEVHPSGMHSQO9MBuFo7R
         Y0UAIhZ6xYeYl6CbUskidD2kbEBTg4iDMYu6O4iYO+E6lb9W9kX+z8l7fWqjA1PP36MR
         Zbosde+QGbpYc35LSgEHU7arw1w1gWtBlvJA2IdwJRczH/THc9Suh6RUj/KiQDsCOjH7
         4t9NWlSQnIl7mtXT1K595kutmATFgKGlaDXNdA+RBogj0QzWr5OvpJ6tzVDlP+h8TPhx
         6q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRzeMscpwq0sNCUubfUbWF6+269i2bONNUaXfNK1Aj8=;
        b=JZcuXr5CN9BUYugE9jdUtszKQQYdC8Mx+iSfkx7KMM3VnAtHMNyZ17hgolancAOAQp
         Ub6Sj/FwhoXu9FC/Ede97MmtKYOEtLPgnRw/+VVtPsjTETumFQnBS9LDWZ9WxvIu+cD7
         TQh29d3MpMbD3ySh2RoVGbCf+T3CGGVCEsf4BM64QGVxtgvZ3jfO720uDF5um+V6O4ME
         TbDkQ9uHnc+faT4ryOc/GP/3WKsamEFSkKerDQVDHMUFymlXNcrKOfolftqJffqUFeSW
         pfvcgKyEqE+v3q4l3JDZW6t0FmYDWQH9hB9NSJ0LbaD30yIJrE/mFbWAtXu5ray8XiLv
         Z9Wg==
X-Gm-Message-State: AOAM533/TOCo52wnD1lxvGTyeoZa/ep1TYuBfPAVRMDUXh9LfPiZ8zxC
        mRp+tU1hKBvbDxf4aOwMpEs=
X-Google-Smtp-Source: ABdhPJwWR+a5AHeQUb9Ol8fT/YzatZprXclYIAG8joHJN+TCoX2TXxxEli6/UtByskNnGgiUblJmpA==
X-Received: by 2002:a92:4b06:: with SMTP id m6mr4475581ilg.305.1604752429639;
        Sat, 07 Nov 2020 04:33:49 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5d9e:32b:1062:f8cd])
        by smtp.gmail.com with ESMTPSA id w12sm2830592ilo.63.2020.11.07.04.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 04:33:48 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, krzk@kernel.org,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/3] dt-bindings: arm: fsl: Add beacon,imx8mn-beacon-kit
Date:   Sat,  7 Nov 2020 06:33:31 -0600
Message-Id: <20201107123334.1868360-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add beacon,imx8mn-beacon-kit to list of compatible options.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  Correct Typo and move to Nano section
V2:  New to series

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 85fb24da4a02..5a2608e6bc30 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -680,6 +680,7 @@ properties:
       - description: i.MX8MN based Boards
         items:
           - enum:
+              - beacon,imx8mn-beacon-kit  # i.MX8MN Beacon Development Kit
               - fsl,imx8mn-ddr4-evk       # i.MX8MN DDR4 EVK Board
               - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
           - const: fsl,imx8mn
-- 
2.25.1

