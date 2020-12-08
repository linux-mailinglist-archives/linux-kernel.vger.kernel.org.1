Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AEF2D27FE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgLHJn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:43:26 -0500
Received: from mail-vi1eur05on2089.outbound.protection.outlook.com ([40.107.21.89]:62689
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727543AbgLHJnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:43:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FibKigI+sWRX4miD59JPq7T0avuwf9jyZfLwk2SwGTW3OC1ZzIfcmcMzdkIZpDNkEf8Ng37x+uScMV7tNCOUAnSWoEdyy2gKNFUHrQufO7HFqQGrepKCJ3BTHzaiPDUXHpxsZv4gjAHFGau18hNuGLB1zp9KkLBDTN/EO64pQVW88jc8Sk8SoLNW5VxsGvpsrqQ7RI0WdiWtv1n/JGme3ZbvgQ1BNkmDQr1Sogu9Ijs6X/ljtNIk7fSqiX8tFT0XvFHzBc+jnnD47EEvMLa7KG9ws4c2wEpdnkjUuishdG/HPGLywdyyPZGsfUlB5JXaeHA/I9zVgSnlULeY5+K7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3ueHpTTM+++UnnmPCAo4hCE7YGyirjYjgIBawjVl/Q=;
 b=Q3tB6pr8+m887sCg/GN37TY6N9VhLsljwr5Y5EXAJhqDHNwX77BC0ubwgLoSHkvh3AO+PKe84fNSPlK+LaKvGclgDUVMUGZB2iQjtOlwXzVZ/GvLUypSVsD+yEMuh4M+EAbBIZJRdR5wii7aPoxJQnCCh4K2qXRQoevXHrMdL6jKrQONB1EWMvVeGZmWZvPVbQOk/YOy/ReRSr5GTVz1zCoSgJB5p0QPY3Ysi9SA/Wzy4RO/KeFAc7yR8Sk1jgVkyJW/U/Hd6HsqWWglUrAtjMsPglde7sv6B4FZk58IHSw9YT/Q9hNjWkMR9RIqO0bOLTJaX9HJOqvJyernrlx/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3ueHpTTM+++UnnmPCAo4hCE7YGyirjYjgIBawjVl/Q=;
 b=mHjpAq0YZNCzUDsCiyrQzaLQ9KQgrVhZJ89k2+reHUDuLfIeFhnwD6xCBy1BX9PffDROeN1T5Eh3WeVCNWFeNalMqRB7SO92OFoiqtFNv9yOl1raTzhVuadYVYUaJZQkC9U/QslFqfzMD/O/5IYVGcS4ZpiQ0HNCuLO7sNqyWqo=
Authentication-Results: puri.sm; dkim=none (message not signed)
 header.d=none;puri.sm; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 09:42:35 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 09:42:35 +0000
Message-ID: <bda6bff4a5740a352832a1d1b8cf7608b02ccd00.camel@nxp.com>
Subject: Re: [PATCH 0/4] phy: phy-fsl-imx8-mipi-dphy: Add i.MX8qxp LVDS PHY
 mode support
From:   Liu Ying <victor.liu@nxp.com>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm
Date:   Tue, 08 Dec 2020 17:40:43 +0800
In-Reply-To: <20201208090244.GA20575@bogon.m.sigxcpu.org>
References: <1607067224-15616-1-git-send-email-victor.liu@nxp.com>
         <20201208090244.GA20575@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry.ap.freescale.net (119.31.174.66) by SG2PR06CA0247.apcprd06.prod.outlook.com (2603:1096:4:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 09:42:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7123f8c7-ab07-4dcd-a92a-08d89b5d97a8
X-MS-TrafficTypeDiagnostic: VI1PR04MB7184:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB71841212D06F1F64A5E747D798CD0@VI1PR04MB7184.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LF8BEuH9NKBcgBT3r4SUIPo/MzEASevjk0TPRI0eeiiECMica5oJJLnw7rXfb8E4bZcCvNGj3JUCu9w6BoPmj4hpahPE8NDkfbMaSLzDPGQNJup6tEiiHheNM7+Bu7TNlPzWom5syp0MDjupI79bXmzbLDOYWCYgEV4MdpO3mWWdDZgXOkmQDiJJCPSIfDuq1lkzbXzu/mlSLC0VgU34HHqRGdHCVGXoBX9grcxlHahNXI6Jbq+8PvX+rKjQphI/ijXNi67Nbuvl8D3y83Ahj5OKtW4fDLvY/V3OO0UnhF3HCulY9B0Lm6+RzUBPLcCdLILoT4YDBOggespD42OD7xzKf9prFL4uDCAK+siXMVT3IFksFnzZ2DryPmbKMUxva035+5HfKIG2tjWAcKnan9+BDCY7hRfdhLoZVXnjkSlCezJG6brKSDPH7jPTl59je2ADTY28OIyn5AGub0lqsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(36756003)(6512007)(83380400001)(52116002)(34490700003)(508600001)(966005)(2616005)(66946007)(186003)(956004)(7416002)(6486002)(26005)(6916009)(16526019)(5660300002)(4326008)(8936002)(86362001)(8676002)(6506007)(66556008)(2906002)(66476007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V2JuTktBNnJuQllUdlVHSnlHdFNJUFB6cGhyaGh3NVYrS3l2cE1nZXdzdnJ2?=
 =?utf-8?B?Y2h5Uks5OEFkV0dFOGtnTVd1M3hic2ZtTDZqYUYwcTVJSkc4VHA0bEFXbW5n?=
 =?utf-8?B?cUF6Z3JFb2RGTWNhVXR0Y0JiaFk2RXZKbDI0ZnNrMTdpL0RDOFFFTnhscTZp?=
 =?utf-8?B?aHUzaU5QaEtqVHRuWGV3VkUwZlpFb2lzdDFKTUpoOGpxNCtuTWVORzNaWGNO?=
 =?utf-8?B?aVMwNlI0Q2N6TmdSVHNIajlMQ0tNampoYzdDdXdMSU83QXRDZ3gzdklESTNN?=
 =?utf-8?B?aFRoQW0rcTNudGdhV2YvNW1UVlJPaEFVL0tzSG9IM0E4ZG1MY0gwKzY1TnVY?=
 =?utf-8?B?NktZM1VLcXRMNjVMaHFPL0JXV2NjTy9KMVpzUXd0czdIMUdkemFQNEQzTGQx?=
 =?utf-8?B?VEs3RmtLbnRDSkx0bWprMmpoeTlIQU92TE1TMmw2MnRWVTd1YXFLdVpiM2Vo?=
 =?utf-8?B?MWJBcVN5aUNWdXpuSkZyVXFLWFp1WUYrT0d5d3V3a2xOV1UzditNandLTnF2?=
 =?utf-8?B?RVhDZUNFTWFzZ2d1SXNmMjdrTWN4amRQMmtIaEloTDJNdUhHQmd1emYxKzZG?=
 =?utf-8?B?ZWEwbUlMRDkweDhqK21OMy9WaG1seHd3SkZOaTlXNXVGSkpZSXV1azhmUmpa?=
 =?utf-8?B?Y3hSVGFjOWpSS2gwdGpTbXZWblJjdEYvUmF4T3NNTThYZE9MQU9henRKaXZO?=
 =?utf-8?B?TVErRTNiazE3ZTVTdzN4cHVia0hZZURVbSt4cFpQTTRReFhyWjBNeEhmMDV3?=
 =?utf-8?B?NEt4VGFVVU1nTnhISExKRFZWSnRWeVRVeGk4VjBpOUZKUmR3UTF3cnR5ZFJN?=
 =?utf-8?B?UXJOUUEvTko0Rld5RUU0SFlHSWNPbjRybGwzdGVaZWRCRDRLZFFNN2xhTXNN?=
 =?utf-8?B?ZVlvV3hYbTc1emRhc2IzazU1MTUrQjEvRXNBVDNUTjdqVmY3QkRTSTMzYWhX?=
 =?utf-8?B?a1N6YU9IRFJDODF5SGNhbjBEMVR4SHRHTnY5VFFRYlZ1dit5YmErUzNHclZ5?=
 =?utf-8?B?NDY4S05GaWZ0Z0FFaGZyQmJHVFkwREwwdXdIZDFUb2R4SC9UOERtcVJMZWlt?=
 =?utf-8?B?QnNpUGhLeDR1VzlnUFd4dmdNcnhldkVneVdSYTlTNktjMElidDJlajl4QWpL?=
 =?utf-8?B?cDU5MEl1eFF0bFpvYjM4MTFETFFFaHpZMEdmRjRWdTNnMlphSVZMR2t2aTJH?=
 =?utf-8?B?eTlienRCbDdCV1JUQ0VXYjFKY2E1eTJqeDUycXVLSFlUZUpKYmhqTmxKazJr?=
 =?utf-8?B?dFBUb2xvcHlVMWU1b0theHJ1R3puRUNITUhuT1JkMVJLZ3FBNmpRTk4wQXJy?=
 =?utf-8?Q?oLfoLhHGgNIgRFuHPokqJ7cfwAZRr0e0g1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7123f8c7-ab07-4dcd-a92a-08d89b5d97a8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 09:42:35.6788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqAXLuuLnFS8rJ9/OHHLwCMxkCb4I2YYcWUcJhcTtWD0V25k9hqxq23eCjJi0cmL/Ifp1zR3EWmK7LNU2y5zHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Tue, 2020-12-08 at 10:02 +0100, Guido Günther wrote:
> Hi Liu,
> On Fri, Dec 04, 2020 at 03:33:40PM +0800, Liu Ying wrote:
> > Hi,
> > 
> > This series adds i.MX8qxp LVDS PHY mode support for the Mixel PHY in the
> > Freescale i.MX8qxp SoC.
> 
> This looks good to me from the NWL and actual phy driver part. I'll
> comment in the individual patches but leave comments on the extension
> of the generic phy struct to someone knowledgeable with that part.

Thank you for the review.

> 
> What display controllers do you intend to drive that with?

The display controller DPU embedded in i.MX8qxp SoC would drive the
MIPI DSI display or the LVDS display through the Mixel combo PHY.

I've sent out a series to add DPU DRM driver support(KMS part only so
far) for review:
https://www.spinics.net/lists/kernel/msg3762462.html

I can Cc you when I send the next version for it.

Regards,
Liu Ying

> Cheers,
>  -- Guido
> 
> > The Mixel PHY is MIPI DPHY + LVDS PHY combo, which can works in either
> > MIPI DPHY mode or LVDS PHY mode.  The PHY mode is controlled by i.MX8qxp
> > SCU firmware.  The PHY driver would call a SCU function to configure the
> > mode.
> > 
> > The PHY driver is already supporting the Mixel MIPI DPHY in i.MX8mq SoC,
> > where it appears to be a single MIPI DPHY.
> > 
> > 
> > Patch 1/4 sets PHY mode in the Northwest Logic MIPI DSI host controller
> > bridge driver, since i.MX8qxp SoC embeds this controller IP to support
> > MIPI DSI displays together with the Mixel PHY.
> > 
> > Patch 2/4 allows LVDS PHYs to be configured through the generic PHY functions
> > and through a custom structure added to the generic PHY configuration union.
> > 
> > Patch 3/4 adds dt binding support for the Mixel combo PHY in i.MX8qxp SoC.
> > 
> > Patch 4/4 adds the i.MX8qxp LVDS PHY mode support in the Mixel PHY driver.
> > 
> > 
> > Welcome comments, thanks.
> > 
> > 
> > Liu Ying (4):
> >   drm/bridge: nwl-dsi: Set PHY mode in nwl_dsi_enable()
> >   phy: Add LVDS configuration options
> >   dt-bindings: phy: mixel: mipi-dsi-phy: Add Mixel combo PHY support for
> >     i.MX8qxp
> >   phy: freescale: phy-fsl-imx8-mipi-dphy: Add i.MX8qxp LVDS PHY mode
> >     support
> > 
> >  .../devicetree/bindings/phy/mixel,mipi-dsi-phy.txt |   8 +-
> >  drivers/gpu/drm/bridge/nwl-dsi.c                   |   6 +
> >  drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c     | 266 ++++++++++++++++++++-
> >  include/linux/phy/phy-lvds.h                       |  48 ++++
> >  include/linux/phy/phy.h                            |   4 +
> >  5 files changed, 320 insertions(+), 12 deletions(-)
> >  create mode 100644 include/linux/phy/phy-lvds.h
> > 
> > -- 
> > 2.7.4
> > 

