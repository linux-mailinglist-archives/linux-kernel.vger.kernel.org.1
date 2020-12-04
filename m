Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2AE2CE543
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgLDBno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:43:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9101 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgLDBnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:43:43 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CnFnY6Gr5zM0BR;
        Fri,  4 Dec 2020 09:42:25 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 09:42:55 +0800
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
Subject: [PATCH v2 0/3] dt-bindings: reset: convert Hisilicon reset controller bindings to json-schema
Date:   Fri, 4 Dec 2020 09:42:33 +0800
Message-ID: <20201204014236.1158-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 --> v2:
Merge the driver and DT modification(correct vendor prefix hisi to hisilicon) into one patch.

v1:
Patch 1-3 change the vendor prefix from "hisi" to "hisilicon", to eliminate below warnings:
  crg_rst_controller: 'hisi,rst-syscon' does not match any of the regexes: '^#.*', ... , '^hisilicon,.*', ...
  From schema: /root/leizhen/linux-next/Documentation/devicetree/bindings/vendor-prefixes.yaml

Patch 4 does the json-schema conversion.

Zhen Lei (3):
  reset: hisilicon: correct vendor prefix
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


