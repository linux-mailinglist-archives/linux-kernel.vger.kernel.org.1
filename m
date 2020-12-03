Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9DA2CD517
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbgLCMDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:03:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8235 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgLCMDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:03:36 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CmvbB4fj4zkWrV;
        Thu,  3 Dec 2020 20:02:14 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Dec 2020 20:02:43 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/4] dt-bindings: reset: convert Hisilicon reset controller bindings to json-schema
Date:   Thu, 3 Dec 2020 20:02:08 +0800
Message-ID: <20201203120212.1105-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1-3 change the vendor prefix from "hisi" to "hisilicon", to eliminate below warnings:
  crg_rst_controller: 'hisi,rst-syscon' does not match any of the regexes: '^#.*', ... , '^hisilicon,.*', ...
  From schema: /root/leizhen/linux-next/Documentation/devicetree/bindings/vendor-prefixes.yaml

Patch 4 does the json-schema conversion.


Zhen Lei (4):
  reset: hisilicon: correct vendor prefix
  arm64: dts: correct vendor prefix hisi to hisilicon
  dt-bindings: reset: correct vendor prefix hisi to hisilicon
  dt-bindings: reset: convert Hisilicon reset controller bindings to
    json-schema

 .../bindings/reset/hisilicon,hi3660-reset.txt      | 44 -------------
 .../bindings/reset/hisilicon,hi3660-reset.yaml     | 77 ++++++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  4 +-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi          |  2 +-
 drivers/reset/hisilicon/reset-hi3660.c             |  2 +-
 5 files changed, 81 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml

-- 
1.8.3


