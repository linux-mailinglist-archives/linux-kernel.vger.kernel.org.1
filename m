Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595FD2DE412
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgLRObg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:31:36 -0500
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:44485 "EHLO
        7.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbgLRObf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:31:35 -0500
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Dec 2020 09:31:35 EST
Received: from player716.ha.ovh.net (unknown [10.108.35.215])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6B231235B74
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 15:12:12 +0100 (CET)
Received: from armadeus.com (lfbn-str-1-215-46.w86-243.abo.wanadoo.fr [86.243.176.46])
        (Authenticated sender: sebastien.szymanski@armadeus.com)
        by player716.ha.ovh.net (Postfix) with ESMTPSA id 7F1E0194037F5;
        Fri, 18 Dec 2020 14:11:56 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-96R001a0f67aaf-926a-48dd-a587-2bb9401b4345,
                    F4E34FAEFBBC2F77A8F65A75F5C3271EDA163614) smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 86.243.176.46
From:   =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Subject: [PATCH 3/3] dt-bindings: mxsfb: add compatible for i.MX6UL/i.MX6ULL
Date:   Fri, 18 Dec 2020 15:10:35 +0100
Message-Id: <20201218141035.28038-3-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201218141035.28038-1-sebastien.szymanski@armadeus.com>
References: <20201218141035.28038-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13311514602123383877
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudeliedgieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhephfefhfejjeffgfeiteejhfetvdeftdekudeltedvveelleeileffgedufeefvddvnecukfhppedtrddtrddtrddtpdekiedrvdegfedrudejiedrgeeinecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeduiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6UL/i.MX6ULL have eLCDIF controller, too.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 Documentation/devicetree/bindings/display/mxsfb.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mxsfb.txt b/Documentation/devicetree/bindings/display/mxsfb.txt
index c985871c46b3..6c1c4ad04b89 100644
--- a/Documentation/devicetree/bindings/display/mxsfb.txt
+++ b/Documentation/devicetree/bindings/display/mxsfb.txt
@@ -5,6 +5,7 @@ New bindings:
 Required properties:
 - compatible:	Should be "fsl,imx23-lcdif" for i.MX23.
 		Should be "fsl,imx28-lcdif" for i.MX28.
+		Should be "fsl,imx6ul-lcdif" for i.MX6UL/i.MX6ULL.
 		Should be "fsl,imx6sx-lcdif" for i.MX6SX.
 		Should be "fsl,imx8mq-lcdif" for i.MX8MQ.
 - reg:		Address and length of the register set for LCDIF
-- 
2.26.2

