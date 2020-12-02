Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B6C2CB70F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgLBI0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:26:07 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:49078 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLBI0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:26:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 27B24200E247;
        Wed,  2 Dec 2020 16:25:20 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8BPaiDQhezmZ; Wed,  2 Dec 2020 16:25:20 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 0E8E9200E233;
        Wed,  2 Dec 2020 16:25:20 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id F3D9FC019F3;
        Wed,  2 Dec 2020 16:25:19 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id CDABD200756; Wed,  2 Dec 2020 16:25:19 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 0/2] phy: rockchip: set otapdlysec for in dts
Date:   Wed,  2 Dec 2020 16:25:05 +0800
Message-Id: <20201202082507.3536-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add support to set output-tapdelay-selec via dt property

2 files modified:
drivers/phy/rockchip/phy-rockchip-emmc.c
Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
