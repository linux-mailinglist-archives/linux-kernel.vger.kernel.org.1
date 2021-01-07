Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839902ECED0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbhAGLgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:36:50 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:18986 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGLgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610019409; x=1641555409;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=W4/TnPfCG6x2TS6RiV/CVBJ9mPaVreIM9lR+ZnsnrtA=;
  b=WPoLge4cWyKrrLZhnGBw1uUQDFr7wr88FwrzlyHSkG3K0KUwxQtQfoPK
   Did5UyeNLsDb7PvOF7v1fwqL8wAWx3VZcmPm3EhfmKSUbEXeNjTsMQP/K
   NgGLQPJDnY6vgcOja12PRmbQ2xJE51aTFRFJfYX4+pzfmC3XKy13/GAAi
   116v/QkaQ6zKLEkI0osmLosn78f383fJeucF2rDv+FMcEzrfbFU7YEIl9
   BYpJTRkSpvXmFYpq+tsWDKE0jRVrQcJhhUiaXCFXLYa3jy4SsnN0ljGuV
   KmO8rW+FRgc6Cq8CHca2OC4o80mXl5Ug2YySEKVOmFjEbcuOBeuG8R1aD
   A==;
IronPort-SDR: lHVzvRheB1erS/vxkNc0FBTNRDEb7fKkfQP1SQfFXmv2YeMLFr9SX9h9S0lLdvNWCqdpvcC+ql
 eFhMbf9a0Xwn9UbpfeR2AUjQG+S4IyvVGA8PAzTSs9Ke/JWkSx5YUUmqkASMyU/GU620yvPkYi
 aqIIkPXrLBkEp1w9bpHVGAuLceX0VUfxahoiPkanqPZmTQWSbYiholStWQ/xlAVfkpIkB9N2xl
 4ygsmhWeMIZ7nZpmXEHGA9N31bLndvpBCUfYdaO/0VC/CdHTRe+z19v7+LUNoK8jPMoipijRxm
 QVQ=
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="99300800"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jan 2021 04:35:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 7 Jan 2021 04:35:32 -0700
Received: from daniela.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 7 Jan 2021 04:35:30 -0700
From:   <daire.mcnamara@microchip.com>
To:     <cyril.jean@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.linux.org>,
        <padmarao.begari@microchip.com>, <Atish.Patra@wdc.com>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <palmer@dabbelt.com>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v2 0/2] CLK: microchip: Add clkcfg driver for Microchip PolarFire SoC
Date:   Thu, 7 Jan 2021 11:34:58 +0000
Message-ID: <20210107113500.15642-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

This patchset adds support for the Microchip PolarFire clkcfg
hardware block.

Major changes since v1:
 * Dependency on SOC_MICROCHIP_POLARFIRE
 * All references to PFSOC/pfsoc changed to MPFS/mpfs
 * Cleaned error handling in _probe
 * Re-ordered code to place structs et al at top

Daire McNamara (2):
  dt-bindings: clk: microchip: Add Microchip PolarFire host binding
  clk: microchip: Add driver for Microchip PolarFire SoC

 .../bindings/clock/microchip,mpfs.yaml        |  73 +++
 drivers/clk/Kconfig                           |   1 +
 drivers/clk/Makefile                          |   2 +-
 drivers/clk/microchip/Kconfig                 |   7 +
 drivers/clk/microchip/Makefile                |   6 +-
 drivers/clk/microchip/clk-mpfs.c              | 443 ++++++++++++++++++
 .../dt-bindings/clock/microchip,mpfs-clock.h  |  45 ++
 7 files changed, 574 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
 create mode 100644 drivers/clk/microchip/Kconfig
 create mode 100644 drivers/clk/microchip/clk-mpfs.c
 create mode 100644 include/dt-bindings/clock/microchip,mpfs-clock.h


base-commit: f804b3159482eedbb4250b1e9248c308fb63b805
prerequisite-patch-id: 961d8e88a8979add1d563b9f841a426f0ca0061d
prerequisite-patch-id: 27e03792a5ac74127c66ecba47bd7d5b1471dfef
prerequisite-patch-id: 8c9c4f565197190f4e2ed52c3d83418133ef5a51
prerequisite-patch-id: bd73fb05ce3d6ce1226a95a1ee4ff2e8088a0d4a
prerequisite-patch-id: d33f2f1ff57076d7845af27242d3b86d5a9e8059
-- 
2.25.1

