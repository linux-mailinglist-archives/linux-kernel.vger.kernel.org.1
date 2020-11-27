Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D009A2C6365
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgK0Ktm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgK0Ktl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:49:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCAAC0617A7;
        Fri, 27 Nov 2020 02:49:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 084C11F4616F
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] arm64: dts: mediatek: Add dsi and display support for MT8183 based boards
Date:   Fri, 27 Nov 2020 11:49:27 +0100
Message-Id: <20201127104930.1981497-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

The following patches add the required nodes to enable dsi and display
support for MT8183 based boards. The patches were tested on a Lenovo
Ideapad Duet with an out-of-tree patch that enables the display for that
board.

The patches depends on [1].

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=374013

Enric Balletbo i Serra (2):
  arm64: dts: mt8183: Add iommu and larb nodes
  arm64: dts: mt8183: Add display nodes for MT8183

Jitao Shi (1):
  arm64: dts: mt8183: Add dsi node

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 224 +++++++++++++++++++++++
 1 file changed, 224 insertions(+)

-- 
2.29.2

