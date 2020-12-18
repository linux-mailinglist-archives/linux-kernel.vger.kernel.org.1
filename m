Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5570B2DE883
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgLRRsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:48:10 -0500
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:37674 "EHLO
        7.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgLRRsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:48:09 -0500
X-Greylist: delayed 12598 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Dec 2020 12:48:08 EST
Received: from player716.ha.ovh.net (unknown [10.108.35.158])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 0CD0914AD9C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 15:11:02 +0100 (CET)
Received: from armadeus.com (lfbn-str-1-215-46.w86-243.abo.wanadoo.fr [86.243.176.46])
        (Authenticated sender: sebastien.szymanski@armadeus.com)
        by player716.ha.ovh.net (Postfix) with ESMTPSA id D9C2119403322;
        Fri, 18 Dec 2020 14:10:46 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-96R001af125cce-d46d-4306-a7ed-f76bb11df2ae,
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
Subject: [PATCH 1/3] drm: mxsfb: add i.MX6UL/i.MX6ULL to the list of supported SoCs in Kconfig
Date:   Fri, 18 Dec 2020 15:10:33 +0100
Message-Id: <20201218141035.28038-1-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13291811352116679749
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudeliedgieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhepgfdtffdvfeetfedttdfgkeegkeekgfefueegffekvddvuddtfeeuheehhfeiteejnecuffhomhgrihhnpehmgiekmhdrihhfmhenucfkpheptddrtddrtddrtddpkeeirddvgeefrddujeeirdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eLCDIF controller is also present on i.MX6UL/i.MX6ULL SoCs so add
them in the Kconfig option description.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 drivers/gpu/drm/mxsfb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/Kconfig b/drivers/gpu/drm/mxsfb/Kconfig
index 0143d539f8f8..a3730f52e6fa 100644
--- a/drivers/gpu/drm/mxsfb/Kconfig
+++ b/drivers/gpu/drm/mxsfb/Kconfig
@@ -17,6 +17,6 @@ config DRM_MXSFB
 	help
 	  Choose this option if you have an LCDIF or eLCDIF LCD controller.
 	  Those devices are found in various i.MX SoC (including i.MX23,
-	  i.MX28, i.MX6SX, i.MX7 and i.MX8M).
+	  i.MX28, i.MX6UL/i.MX6ULL, i.MX6SX, i.MX7 and i.MX8M).
 
 	  If M is selected the module will be called mxsfb.
-- 
2.26.2

