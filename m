Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24892DE734
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgLRQHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:07:11 -0500
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:42459 "EHLO
        4.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgLRQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:07:10 -0500
Received: from player716.ha.ovh.net (unknown [10.108.54.59])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id 748E617FA50
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 15:11:20 +0100 (CET)
Received: from armadeus.com (lfbn-str-1-215-46.w86-243.abo.wanadoo.fr [86.243.176.46])
        (Authenticated sender: sebastien.szymanski@armadeus.com)
        by player716.ha.ovh.net (Postfix) with ESMTPSA id B281C194034C8;
        Fri, 18 Dec 2020 14:11:04 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-96R001a6eef942-fcab-4ed3-a9e4-1f900c775826,
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
Subject: [PATCH 2/3] drm: mxsfb: add alpha plane support on i.MX6UL/i.MX6ULL
Date:   Fri, 18 Dec 2020 15:10:34 +0100
Message-Id: <20201218141035.28038-2-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201218141035.28038-1-sebastien.szymanski@armadeus.com>
References: <20201218141035.28038-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13296877900587553861
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudeliedgieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhephfefhfejjeffgfeiteejhfetvdeftdekudeltedvveelleeileffgedufeefvddvnecukfhppedtrddtrddtrddtpdekiedrvdegfedrudejiedrgeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeduiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eLCDIF controller on i.MX6UL/i.MX6ULL supports the alpha plane too.
Enable it on these SoCs.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
While testing, I have noticed that the alpha plane works but
sometimes the framebuffer is shiftted to the right.
I tested with the following modetest command:

modetest -M mxsfb-drm -s 37@35:800x480 -P 33@35:800x480@AR24 -F smpte,plain

 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 6faf17b6408d..95c35333c2d1 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -306,6 +306,7 @@ static const struct drm_driver mxsfb_driver = {
 static const struct of_device_id mxsfb_dt_ids[] = {
 	{ .compatible = "fsl,imx23-lcdif", .data = &mxsfb_devdata[MXSFB_V3], },
 	{ .compatible = "fsl,imx28-lcdif", .data = &mxsfb_devdata[MXSFB_V4], },
+	{ .compatible = "fsl,imx6ul-lcdif", .data = &mxsfb_devdata[MXSFB_V6], },
 	{ .compatible = "fsl,imx6sx-lcdif", .data = &mxsfb_devdata[MXSFB_V6], },
 	{ /* sentinel */ }
 };
-- 
2.26.2

