Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CEF2F402B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732983AbhALXRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 18:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbhALXRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:17:04 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DF1C0617A2;
        Tue, 12 Jan 2021 15:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=llurKzs4SLWbCLfqwzW/yVsJA8mBlupdF0jizP/V73s=; b=MBN5ZxnsVXgXlcSlHpgse5LWuB
        XyCIc939AWcQV1aRAdw/+0oS5gl46YOYZysdDUE72Ce0QRlVyivny13RDh5ZVoaTAbCV3RHBc4h4Q
        UR96rkk4TdnUtxbcEMKL3/oTca7zfvHNitaDW9NNKhBIXnqGgVrT5OKywBj5nDeIQ/+4=;
Received: from p200300ccff1586001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff15:8600:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kzStT-0005TX-1m; Wed, 13 Jan 2021 00:16:07 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1kzStS-0007oC-Q0; Wed, 13 Jan 2021 00:16:06 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 3/4] ARM: dts: imx6sl-tolino-shine3: correct console uart pinmux
Date:   Wed, 13 Jan 2021 00:15:48 +0100
Message-Id: <20210112231549.29957-5-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210112231549.29957-1-andreas@kemnade.info>
References: <20210112231549.29957-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configuration was correct enough to work with the pre-configuration done by
uboot. While at it, also document the location.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/imx6sl-tolino-shine3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
index 27143ea0f0f1..62d2ebda04ff 100644
--- a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
+++ b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
@@ -156,7 +156,7 @@
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
-			MX6SL_PAD_UART1_RXD__UART1_TX_DATA 0x1b0b1
+			MX6SL_PAD_UART1_RXD__UART1_RX_DATA 0x1b0b1
 		>;
 	};
 
-- 
2.20.1

