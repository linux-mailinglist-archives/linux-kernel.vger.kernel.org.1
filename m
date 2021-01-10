Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEE22F0991
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 20:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbhAJTzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 14:55:54 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:40353 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbhAJTzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 14:55:53 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CDFED22900;
        Sun, 10 Jan 2021 20:55:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1610308511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKp2FFng+sYcD1/poDRTqLE9ZUyLJTqGkeVdUUMSKmY=;
        b=ARhGvqOG4MVBHQYC9OOygg5bsWGkMiUznDA8h38ajuj4TzBpqDxwDTpfq7IpXmV83M66vV
        rmxrn3oKA3i7Z9IeVuWEjMYse5OOU53WEGM0+pvZsM+hlpIjjlY+W4JM2zJKkiDXoTw5z3
        UAIi0bNdd6sf4VdUvqSwIUW/SimNkkw=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] arm64: defconfig: Enable Broadcom BCM54140 PHY
Date:   Sun, 10 Jan 2021 20:54:53 +0100
Message-Id: <20210110195454.27808-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210110195454.27808-1-michael@walle.cc>
References: <20210110195454.27808-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for the QuadPHY on the Kontron K-Box A-230-LS. Enable
the driver as a module.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3ca9d03d5cb3..feb3e8bfd1be 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -351,6 +351,7 @@ CONFIG_QCOM_IPA=m
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
 CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
 CONFIG_AQUANTIA_PHY=y
+CONFIG_BCM54140_PHY=m
 CONFIG_MARVELL_PHY=m
 CONFIG_MARVELL_10G_PHY=m
 CONFIG_MESON_GXL_PHY=m
-- 
2.20.1

