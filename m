Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69C02DA5C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 02:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbgLOBqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 20:46:14 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:59370 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbgLOBpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 20:45:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 1734820139DE;
        Tue, 15 Dec 2020 09:44:14 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BFKITq9W7vnj; Tue, 15 Dec 2020 09:44:13 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id E9DF020139A0;
        Tue, 15 Dec 2020 09:44:13 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id E5C98C01FAD;
        Tue, 15 Dec 2020 09:44:13 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id ADFFB2000CF; Tue, 15 Dec 2020 09:44:13 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 0/2] rockchip: emmc: rk3399 add vendor prefix 
Date:   Tue, 15 Dec 2020 09:44:06 +0800
Message-Id: <20201215014409.905-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the reference in vendor-prefixes.yaml, update implementation
and documentation for the phy-rockchip-emmc.
This patchset follow up with 
commit 8b5c2b45b8f0a ("phy: rockchip: set pulldown for strobe line in dts")
commit a8cef928276bb ("phy: rockchip-emmc: output tap delay dt property")

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
v2 drop changes for ABI property driver-impedence-ohm
   no modification needed for dtsi files
   add commits follow up in commit messages

Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 10 +++++-----
drivers/phy/rockchip/phy-rockchip-emmc.c                    |  4 ++--
2 files changed, 7 insertions(+), 7 deletions(-)

