Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EE82C7810
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 06:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgK2Fqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 00:46:30 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:39768 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2Fqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 00:46:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 56C442015B8C;
        Sun, 29 Nov 2020 13:45:42 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aJgsOERfWY6B; Sun, 29 Nov 2020 13:45:42 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 2D71520020FC;
        Sun, 29 Nov 2020 13:45:42 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 16650C019E2;
        Sun, 29 Nov 2020 13:45:42 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id EB050200756; Sun, 29 Nov 2020 13:45:41 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2] phy: rockchip: set pulldown for strobe line in dts
Date:   Sun, 29 Nov 2020 13:44:13 +0800
Message-Id: <20201129054416.3980-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add support to set the strobe line pulldown via dt property

2 files modified:
drivers/phy/rockchip/phy-rockchip-emmc.c
Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
v2:
- Fix issues show with checkpatch --strict
- Add patch to update the Documentation
