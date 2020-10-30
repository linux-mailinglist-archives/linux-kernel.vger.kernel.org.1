Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEE42A043B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgJ3LgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3LgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F246C0613D2;
        Fri, 30 Oct 2020 04:36:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id za3so8132820ejb.5;
        Fri, 30 Oct 2020 04:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ntyqySv0dNRSUQuLSRy73nPmECP2AXw3xwCrbYmb5w=;
        b=Wh/4WyHx0BOJQFGA8uk0QwNSX1vNc4OKQcIYtrFN42Q/h0ovjKe7j5sKq8kDBZLH8v
         QeAfzFexTs5TOa5A++b1IyaLUeeFGl2Wpz+WCRcXbes9zUsPQ+8OoxFxuDYIT9BUvUPy
         Q3LCq+x6vvVh/0vz1F8MjbnarZq6/+KvrI7Lh32iOG7RU3j4ZQawrHaYVJDj1nm/30hq
         JOFW/qemGwpXeyi4m1CkbbOjQMDlxXm6hu/mJqGLRph7mbS0ztNHaHXGe0/hDoCiVLv5
         zhtc6Ng4eAZrhpQqU0rox0erbEJPAy5y9fpKkJm+x3KzK9290uHNXa60wUvF4bXCQEW3
         l6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ntyqySv0dNRSUQuLSRy73nPmECP2AXw3xwCrbYmb5w=;
        b=kl1RVdvsCEtqY/ZpWXgbEf75EmJpclNuN6ctHqEnOoHG/G24WUVDjtJETu0vjYYFSd
         vTlt5YYrUPKt9BqyMAopkN/W3DATztI9xhsCSaKGtNgEa1TwbQmzG9GyyTbPBo0Py4hc
         LrMP/mvVxGd6ZGoPprhMBIULBp+jUZOTO88jDmki6zn+u4MlRcELTtFBeGecRVZfVEuy
         GRWU/sL8EtEsLHZeCm6hVhmtMrnZViHNSfm+GHDV+3v3kjOW2RzsSnNKaxEb489sNvlD
         gpNvQEYSAWPz/EqfMFu8beI1yGbTws7gSsKX6IK3E12amnZkfkAi62FiT/EKSVgGjezU
         Mb6A==
X-Gm-Message-State: AOAM530ZTrbvxrJGB26gYH7DgdbEwK8oFAFSh8Gyj9OvJl7Llo/Ggzz+
        mcWwPNbQMLZDhsAlidGBqz8lwLEQqCEY5LGS
X-Google-Smtp-Source: ABdhPJz6fojo550yzO50CrNGrN4HLwqfWDkRftZB7slO8iNE62fBxF8XdZBQ2Yd0zCUNDctV6QDhHQ==
X-Received: by 2002:a17:906:8812:: with SMTP id zh18mr1847124ejb.361.1604057775637;
        Fri, 30 Oct 2020 04:36:15 -0700 (PDT)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id q19sm2850861ejx.118.2020.10.30.04.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:36:14 -0700 (PDT)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v5 00/11] arm64: dts: layerscape: update MAC nodes with PHY information 
Date:   Fri, 30 Oct 2020 13:35:44 +0200
Message-Id: <20201030113555.726487-1-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

This patch set aims to add the necessary DTS nodes to complete the
MAC/PCS/PHY representation on DPAA2 devices. The external MDIO bus nodes
and the PHYs found on them are added, along with the PCS MDIO internal
buses and their PCS PHYs. Also, links to these PHYs are added from the
DPMAC node.

Changes in v2:
 - documented the dpmac node into a new yaml entry
 - dropped the '0x' from some unit addresses

Changes in v3:
 - renamed dpmac@x into ethernet@x
 - renamed the new documentation file to use the same name as the
   compatible
 - marked additionalProperties as false
 - added a reference to ethernet-controller.yaml
 - added a new patch to document 10gbase-r - 2/11

Changes in v4:
 - move the phy-connection-type attribute to the ethernet node in 7,8/11
 - remove the interrupts description from 8/11 since I plan to properly
   add all interrupt lines for all platforms

Changes in v5:
 - renamed all PHY nodes to ethernet-phy@x
 - added some empty lines between nodes
 - used the reg as the unit address

Ioana Ciornei (11):
  dt-bindings: net: add the DPAA2 MAC DTS definition
  dt-bindings: net: add the 10gbase-r connection type
  arm64: dts: ls1088a: add external MDIO device nodes
  arm64: dts: ls1088ardb: add QSGMII PHY nodes
  arm64: dts: ls1088ardb: add necessary DTS nodes for DPMAC2
  arm64: dts: ls208xa: add the external MDIO nodes
  arm64: dts: ls2088ardb: add PHY nodes for the CS4340 PHYs
  arm64: dts: ls2088ardb: add PHY nodes for the AQR405 PHYs
  arm64: dts: ls208xa: add PCS MDIO and PCS PHY nodes
  arm64: dts: lx2160a: add PCS MDIO and PCS PHY nodes
  arm64: dts: lx2160ardb: add nodes for the AQR107 PHYs

 .../bindings/net/ethernet-controller.yaml     |   1 +
 .../bindings/net/fsl,qoriq-mc-dpmac.yaml      |  60 ++++
 .../boot/dts/freescale/fsl-ls1088a-rdb.dts    | 119 ++++++++
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 101 +++++-
 .../boot/dts/freescale/fsl-ls2088a-rdb.dts    | 120 ++++++++
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 274 ++++++++++++++++-
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |  32 ++
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 288 ++++++++++++++++--
 8 files changed, 951 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml

-- 
2.28.0

