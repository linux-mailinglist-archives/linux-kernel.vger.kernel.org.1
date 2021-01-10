Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB4D2F0992
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 20:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbhAJTz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 14:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbhAJTzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 14:55:55 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996C4C061786;
        Sun, 10 Jan 2021 11:55:14 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 879F122EE3;
        Sun, 10 Jan 2021 20:55:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1610308511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BnxNDk9cWXLJkAiRj7BXECOoU4H/2qZE5jw7moNWo1o=;
        b=MbGpB+tFkDtn0N1D/sMm+AMdogI7BHA3R0CbcrQ0RD/QMWhrWNomb63b9qacH1lhJjzdmR
        Z3B1LdCQncXWw9SOjWkC4L+IMpLnaazcOyyUAqyL0PlCuX8sdrcbJYkydh35jmP+lidIE7
        zG8z8zPEsT9UOBMvZ8kou8mi7y+MpS8=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] arm64: dts: freescale: sl28: enable SATA support
Date:   Sun, 10 Jan 2021 20:54:54 +0100
Message-Id: <20210110195454.27808-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210110195454.27808-1-michael@walle.cc>
References: <20210110195454.27808-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a newer bootloader SATA might be used in a mPCI slot using a mSATA
card. Enable the SATA controller on the Kontron K-Box LS-230-A which
comes with such a slot.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
index d66d8b2c3d1a..6b575efd84a7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
@@ -107,3 +107,7 @@
 	ethernet = <&enetc_port2>;
 	status = "okay";
 };
+
+&sata {
+	status = "okay";
+};
-- 
2.20.1

