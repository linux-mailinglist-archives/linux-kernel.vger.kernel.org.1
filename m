Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BA72D91F2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 04:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438204AbgLNDAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 22:00:47 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:54524 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgLNDAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 22:00:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id C9C16235557A;
        Mon, 14 Dec 2020 10:59:59 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 71OkMwPJucgl; Mon, 14 Dec 2020 10:59:59 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id AFD5D2355574;
        Mon, 14 Dec 2020 10:59:59 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id B2F8BC01FAD;
        Mon, 14 Dec 2020 10:59:59 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 861C82000CF; Mon, 14 Dec 2020 10:59:59 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v1 0/4] rockchip: emmc: rk3399 add vendor prefix 
Date:   Mon, 14 Dec 2020 10:59:41 +0800
Message-Id: <20201214025946.25753-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset follow up with commit 8b5c2b45b8f0a and a8cef928276bb
Following the reference in vendor-prefixes.yaml, update implementation,
devicetree binding dtsi and documentation for the phy-rockchip-emmc.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 19 ++++++++++---------
arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi               |  2 +-
arch/arm64/boot/dts/rockchip/rk3399.dtsi                    |  2 +-
drivers/phy/rockchip/phy-rockchip-emmc.c                    |  6 +++---
4 files changed, 15 insertions(+), 14 deletions(-)
