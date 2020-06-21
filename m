Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6EF202B31
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 16:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgFUO5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 10:57:20 -0400
Received: from inva020.nxp.com ([92.121.34.13]:53600 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730257AbgFUO5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:57:19 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BD8D21A074D;
        Sun, 21 Jun 2020 16:57:16 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B0BBE1A0744;
        Sun, 21 Jun 2020 16:57:16 +0200 (CEST)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 092BF203C2;
        Sun, 21 Jun 2020 16:57:16 +0200 (CEST)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: rng: add RNGB compatibles for i.MX6 SoCs
Date:   Sun, 21 Jun 2020 17:56:54 +0300
Message-Id: <20200621145658.12528-2-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200621145658.12528-1-horia.geanta@nxp.com>
References: <20200621145658.12528-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RNGB block is found in some i.MX6 SoCs - 6SL, 6SLL, 6ULL, 6ULZ.
Add corresponding compatible strings.

Note:

Several NXP SoC from QorIQ family (P1010, P1023, P4080, P3041, P5020)
also have a RNGB, however it's part of the CAAM
(Cryptograhic Accelerator and Assurance Module) crypto accelerator.
In this case, RNGB is managed in the caam driver
(drivers/crypto/caam/), since it's tightly related to
the caam "job ring" interface, not to mention CAAM internally relying on
RNGB as source of randomness.

On the other hand, the i.MX6 SoCs with RNGB have a DCP
(Data Co-Processor) crypto accelerator and this block and RNGB
are independent.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 Documentation/devicetree/bindings/rng/imx-rng.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/rng/imx-rng.txt b/Documentation/devicetree/bindings/rng/imx-rng.txt
index 405c2b00ccb0..eb227db9e684 100644
--- a/Documentation/devicetree/bindings/rng/imx-rng.txt
+++ b/Documentation/devicetree/bindings/rng/imx-rng.txt
@@ -5,6 +5,9 @@ Required properties:
                "fsl,imx21-rnga"
                "fsl,imx31-rnga" (backward compatible with "fsl,imx21-rnga")
                "fsl,imx25-rngb"
+               "fsl,imx6sl-rngb"
+               "fsl,imx6sll-rngb"
+               "fsl,imx6ull-rngb"
                "fsl,imx35-rngc"
 - reg : offset and length of the register set of this block
 - interrupts : the interrupt number for the RNG block
-- 
2.17.1

