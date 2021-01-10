Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB232F098F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 20:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbhAJTzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 14:55:53 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:33175 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbhAJTzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 14:55:52 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 81AA422173;
        Sun, 10 Jan 2021 20:55:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1610308510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xxgr1U2SPitktG1AOG/i/NYvIJpQy1DOR0GalCHtc/E=;
        b=liAJRdhLENn7CI+/y2c9vewRC2wF2QsN1bYf97JPlfNrUH98KZiHaxM1xAa6CR06/NjbQ5
        aIxaD4uTFC6z3aUEvGSNLn84JfLW5RcLbvR2Ti7UH8qZL+tV+Yquk9+Db/FXqb1MGYvql0
        p/3evR0nqhVr5pZ0poENWvzYidu57j4=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michael Walle <michael@walle.cc>
Subject: [PATCH 0/2] arm64: small Kontron K-Box A-230-LS fixes
Date:   Sun, 10 Jan 2021 20:54:52 +0100
Message-Id: <20210110195454.27808-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will enable the driver for the PHY found on this board as well as
add SATA support.

Michael Walle (2):
  arm64: defconfig: Enable Broadcom BCM54140 PHY
  arm64: dts: freescale: sl28: enable SATA support

 .../boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts  | 4 ++++
 arch/arm64/configs/defconfig                                  | 1 +
 2 files changed, 5 insertions(+)

-- 
2.20.1

