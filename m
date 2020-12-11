Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247DB2D6DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394967AbgLKB4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:56:48 -0500
Received: from mail-db8eur05on2086.outbound.protection.outlook.com ([40.107.20.86]:24640
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391241AbgLKB4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:56:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TU6syKgUCRG19ZNZch7tCUcwVhvXGhmCL+F3nhzXpZduvkc+HmrGMF3PslgS2YNM2ePKB5Mura3Tl3WElpmLPKoKGEXzsFWW7U0CO+c6xV7zZ3B6sz7fj1uikzisSdBXPSNHczpuwJ/sTxpmQhkRb/taZKnBXy9GUpfED7wPtjhasO/xw03teoheVZ5GGLEP9/+mXst/2+Xz60cBzhHp+A0xMFCNnI29nwHFzfITsV8Mj9+tkFk51zdW4nw/5zNU0apjCmftrcKnDQd9xd4PCm+rc5Se/1k72gVOCG7xe0bIdhlIS6WODr2vY/UR+xZWN+A2vrlmeIVXuHqOn7dngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7JCMEc2TvZTAAQajmMNmgCYyH/TNXyB8QG4yF7Olg8=;
 b=OEmVrt0eINLSWY3nbtPtJ4RZY6CsxFSaQCV3q2VmcWga79Y9eQMVixkQv8ZNGw61duER4YAJqUQnxFE0ToSBPEPwHIGxAvx2WG1GNUztldJbrSddrIQUjdISQ+qAlONNQ571GF0yWSJ+3tI6L31lODzKRPcweKUb9UciVGwsxyvB1BEFNwOlPZBarsWfprYtFON4oV8JsR9Y9cCVh2J11TENgO5eGOSGTu32t9Kk8WgTpxZBTH/5uHvSdlUx+x/nVG0UZHLYqtrUeDyYNnNNGEexVmg2t/PXF/c8nXeNPRj2gXu1ep4Pw/eKCU9Vs+dfYyKr+7rN7hz11HQsrwHr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7JCMEc2TvZTAAQajmMNmgCYyH/TNXyB8QG4yF7Olg8=;
 b=XH+DIHrh2wefqYV2uyHiJMlBHigg5nbluj6N535iWAnhS05noRSUDtKWPV/PY9T7kTReI8aVQukZEy5P+aw28MpDjwX9d0emOaThR95oHquQhMmngLAVMxbP0DmwO5Gr3Lj9/kVG6WmcWGx0K8vfza3YA9TB0Q7+0cnwJ0Dj2V4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR0402MB3952.eurprd04.prod.outlook.com (2603:10a6:803:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 01:54:48 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3632.023; Fri, 11 Dec 2020
 01:54:48 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agx@sigxcpu.org,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm
Subject: [PATCH v3 1/5] drm/bridge: nwl-dsi: Set PHY mode in nwl_dsi_enable()
Date:   Fri, 11 Dec 2020 09:46:18 +0800
Message-Id: <1607651182-12307-2-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607651182-12307-1-git-send-email-victor.liu@nxp.com>
References: <1607651182-12307-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3676.5 via Frontend Transport; Fri, 11 Dec 2020 01:54:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc22d55c-db69-412b-3f22-08d89d77bdaa
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3952:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3952992F080F6F5CBC90014598CA0@VI1PR0402MB3952.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YawtK11IMTjcTjvC1VXb+ZtgHyfVT6PktdNPo9O0Ud4iS/5LQukSrpVHMrlZEhS1LJS9juuruQEzvpv2IAX3M4dAzc/mp3bwPCnc8BixbkzLOGgk9C0Px5dpPLAaOMEX2Z7yOuHY+/+VIE71gFPH81Ij4W49aM2yeB/8GZZgq92OYLoHoZJ56K1JXmloeZWaS8FomfZ2wKPXWfrC6+H0PGhfiGHK0vBjr0rixfGoMlbBa23ZneDrRGZNC51lhccsNBNuwQIceeddDe0Jbip2w7u5R6nr5XdPM6tO8FDAmimZOe5YtYdlXgP62Q37J+XaFgE7Yv3gDRmO3+SN6o4K9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(52116002)(316002)(956004)(2616005)(5660300002)(66556008)(4326008)(66476007)(2906002)(66946007)(6512007)(7416002)(8676002)(16526019)(26005)(186003)(8936002)(6486002)(36756003)(478600001)(86362001)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K2thcWJqTlFESVQ5b250aTJPVEFaeG5MRzZhbk5DVkk0UG96eTdpYUhGYUV1?=
 =?utf-8?B?YnFwNVVna3RUVkNyNzBsbWVOZmNyWFVacDVXbDEzWnkzVUI0R2t0OTJQdVlF?=
 =?utf-8?B?T1A5MHFhbm4xYTk1UFA3M3BhQk1jd3dYYmFEa05LTHFPa1gxVEFWd3lpcFFt?=
 =?utf-8?B?a1JmaFZsV1dlSEFhQktxSXpEcWFVQUVoZWUvSkRacng0OHdJTzhIN2VxOWRB?=
 =?utf-8?B?MmljUE12SVlxTGEvaEpzdFcraW5TSlp6d1FKa2pjUVZCN3g5aXRHU1RVZDhI?=
 =?utf-8?B?WXJJaFVQN2VpODFPamROaE1UbHFTQ2tJNTlnaEF2cHhiUHNTWFRxUGRlQTRt?=
 =?utf-8?B?djN2R2UxUHN0MVZwMGhWTzhyV0dDaGNOZ1BqRGlxQU5rMTZZbUFUajk4NFp3?=
 =?utf-8?B?dkVEYkpmY0FqMUZMc2RIT0ovQU5IMW5VenpzR0JMVjdqQWZqR1orL0VmVVJP?=
 =?utf-8?B?WjN2U2lNb3NiZmU1TXZZUUUzWnJXVWlrNytMWFZTTS8zc3E4a1FWL2VoV3cx?=
 =?utf-8?B?dVowMDVDcHZSMzZRVTI5SmU0VExxdEQrVHM1RUJQWmVheUIwMG1NdDNPbVdi?=
 =?utf-8?B?djlEelZYalFlRGNzNG1RMlRDWXFtb09nQWFldEJCMWRBSHJza1d5aVNudzBm?=
 =?utf-8?B?a1JZSGw1K3grQjF5SzZTck43Y1FCcVJqNjdlWll3bjFvTmVDS0VqeHhRSnFw?=
 =?utf-8?B?eU9QWlNMTUJrMVl5NHNDS0FJUTJxRmhlbFlwTDZDVW1OaG05UzJhME5TckVj?=
 =?utf-8?B?RGR5OTBreVJabVh1T2g5VzdXbkI1WkZRYVZrUTBYUEMxMzBZN3F1TlUyZXl4?=
 =?utf-8?B?b1NYcHlBYWpjeEtRNFJxQkRBOXVJSyswdzNYaXpPRUxIZHJtRGc0eE84bFdX?=
 =?utf-8?B?N0ZqS0tzVlNYcEF6aW1yZTlhcm05NmhVT0FpSjZhOWI5ekcxa0FWbmRmc3I4?=
 =?utf-8?B?ZGZzR2VrK0xTQ3BYVkRFWXNQUjYwdG5IeWRUU2Z2VHJtUlJpRGVMNklnblVB?=
 =?utf-8?B?ck9oYnFjM0JrSW5pMVdDdGdiajk0eURZSUh5SVZGeXIyUlFaandyVUJUem84?=
 =?utf-8?B?TFlzTE1UakNSTUtiMVFhaEdSUzFES2lVVXgvaTUyelZxa2QrT2I1WFpHNmNx?=
 =?utf-8?B?NVMzNG5xT2tiN1M5MjN6TThXOVZtdE81RHJuY0FnUHFacXV0bzJML1cxcmU1?=
 =?utf-8?B?VjlUbmJNNDRvTUN0YlJFcG5QU1JXUFNMbUNHVW9WOXFmWjJwa0NGczVsb1dB?=
 =?utf-8?B?b2U3eDZqWUJkZTU0dFo0dGliQ1R2SkZXVXpPcitoR0EvSG9ocTExdVI3Ujg3?=
 =?utf-8?Q?cxg076Lc9WZHX8DqWhR7fzrgDWcWwLJL01?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 01:54:47.8846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: bc22d55c-db69-412b-3f22-08d89d77bdaa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4Ft0Plr/xtyJRrxoICZ2Z2hTPmf2fhUWDkpSwdc0gLjH5tVHSw1RZLCjVLmzPz2b104fnRoNqpmV0EIauOJxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3952
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Northwest Logic MIPI DSI host controller embedded in i.MX8qxp
works with a Mixel MIPI DPHY + LVDS PHY combo to support either
a MIPI DSI display or a LVDS display.  So, this patch calls
phy_set_mode() from nwl_dsi_enable() to set PHY mode to MIPI DPHY
explicitly.

Cc: Guido Günther <agx@sigxcpu.org>
Cc: Robert Chiras <robert.chiras@nxp.com>
Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: NXP Linux Team <linux-imx@nxp.com>
Reviewed-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2->v3:
* No change.

v1->v2:
* Add Guido's R-b tag.

 drivers/gpu/drm/bridge/nwl-dsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 66b6740..be6bfc5 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -678,6 +678,12 @@ static int nwl_dsi_enable(struct nwl_dsi *dsi)
 		return ret;
 	}
 
+	ret = phy_set_mode(dsi->phy, PHY_MODE_MIPI_DPHY);
+	if (ret < 0) {
+		DRM_DEV_ERROR(dev, "Failed to set DSI phy mode: %d\n", ret);
+		goto uninit_phy;
+	}
+
 	ret = phy_configure(dsi->phy, phy_cfg);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dev, "Failed to configure DSI phy: %d\n", ret);
-- 
2.7.4

