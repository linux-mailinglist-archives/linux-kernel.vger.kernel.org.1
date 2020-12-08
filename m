Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A164F2D2818
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgLHJs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:48:57 -0500
Received: from mail-am6eur05on2071.outbound.protection.outlook.com ([40.107.22.71]:9153
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbgLHJsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:48:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dol0rZVGZ6HxlqmMt5N+YWBdYgRK03gkESIMvwRLKpOEN85E4v1LdqM9kTQcI4bEregCmbjiKnTKrZFJogA4opemMjFzKlog7hyu5Gq/0hIfpF/7u22O3f+tT46atA1fHdk2UlilseFLRxrrh5YTsxr/ejctlz+395TtzMvS4K6zFh+8uZCde2/JawZpqfNRDfNzuRZ+PDq2+A11dNjfX5jLgvyPbbOuzpzbHZi9/ykGnk8iJcIzAOPH7XOUUP/O+dhZ1huJ4lD3NMZDczwgYtOMdaa1TSJkwMfq1izmOxJR3jJZ6tnNhld0BHfdbfIP3pRxl8xx3XszxC1zE45Bdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJQ7QSY2WbDbsFizjNznAmZeC/dYm+l99COAsoZtzGQ=;
 b=ZVIQzg6kiT9553L0s4I0fWvVfCgnmEJa08woDWbUnNp8fgwurvW5VUP2RZ6hJjhJxJxUMIylYzqELIdbO+Zf9h89KSnqm51eqw3ypcVKWqQUNqGUj4qYVnapjWl+yAJnbgFcPViZlZ5fVGWLXJ+9NrLxVdwbSaiJrnGJ0kz10ak4mRVID999qI6KDJhhbEbOJN+DlC+1a73ynM1Cf24NNrWQTG4esRgR+G1h8Xqs+pC9lxGF8hYGs9wQH+RGgMkhfOrpx4erdJ+gz3vBEHKJXawG6m2PSxdDkHgw1u2gFjJMjBbPL0G1wN3f2sO0Yc1+Kt6ro7iVhjZRrmAf2G7fuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJQ7QSY2WbDbsFizjNznAmZeC/dYm+l99COAsoZtzGQ=;
 b=qWGwfeDyZtNsMj7+eIllhViFizSKfCxgdsLlJFM6XDn4s3ZV3/CjcsIw2KRlkHhuIRYAhxxAU7Mns6tFelax/haSq7NE1WzJiMjyqJPeSq9Lm2MEmhINknMPora05+/uYQrMmJ7hBKlgJmzZvWx/iE/tKMEilhMXLKDdcbdmNv4=
Authentication-Results: puri.sm; dkim=none (message not signed)
 header.d=none;puri.sm; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 09:48:06 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 09:48:06 +0000
Message-ID: <24222c64cbc9ceb1d3a48a8ed5fa74a32d9e5eee.camel@nxp.com>
Subject: Re: [PATCH 3/4] dt-bindings: phy: mixel: mipi-dsi-phy: Add Mixel
 combo PHY support for i.MX8qxp
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
Date:   Tue, 08 Dec 2020 17:46:16 +0800
In-Reply-To: <20201208090710.GC20575@bogon.m.sigxcpu.org>
References: <1607067224-15616-1-git-send-email-victor.liu@nxp.com>
         <1607067224-15616-4-git-send-email-victor.liu@nxp.com>
         <20201208090710.GC20575@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:4:7c::25) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry.ap.freescale.net (119.31.174.66) by SG2PR03CA0097.apcprd03.prod.outlook.com (2603:1096:4:7c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend Transport; Tue, 8 Dec 2020 09:48:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33037201-41fd-46c0-254c-08d89b5e5ca3
X-MS-TrafficTypeDiagnostic: VI1PR04MB7184:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB71847AAA617479F349AB9AC798CD0@VI1PR04MB7184.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1I03N8kcPG5UQVgof76yNBIrWrFYE2jUbsNV49GjqlXOBcvyZpPLLsphLQKSvt45J8XFahHFC1+g9I0jx7F3g9OEHJTNvg9E1k4Gr/2LLPm5mUAT6X2t/QbzycRLP2ScALlKQ4GhwIFE48qggFrR80Omk2arRObbjIfvLtVUhPYrnh3tyqnC5TY556Cn01AhS3nI9JSfoblT4V78OBKtpaMM0/TEXfYRW1weh/iQ9KcqPNf8S1Lp9Wfc5IgMHRzA/7AEifV42w4oeKqe2/3ZvmZJsMy6gQ2i/7zupjQfhHKHR7c+jeLFiadCjsgQ+7n+fpr5vFOOLQglhcDUuL9+Uik7i90nAJramWnk67iATAAUdeln17XwMG5flovbpoxi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(36756003)(6512007)(66574015)(83380400001)(52116002)(34490700003)(508600001)(2616005)(66946007)(186003)(956004)(7416002)(6486002)(26005)(6916009)(16526019)(5660300002)(4326008)(8936002)(86362001)(8676002)(6506007)(66556008)(2906002)(66476007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eUtjYmVLdzdLZ3JzY00vYlJpQi9qbzZxSDA5bkw0a0dNbHVVazUzU1Z4Z0V5?=
 =?utf-8?B?WTdpMFlrWlMxck02eGVjMFMxV2k0ZW5HcEY1WFJZWlY5a3FYUGpROGpxUXZq?=
 =?utf-8?B?ZmNiUDIwak93ODI4azJSWVdIZC84Mnl6S0F1ditrQzl5WmpqZXQvK2lJY3pT?=
 =?utf-8?B?TW1qVTBsUWJzdysycW55aWIzcHE4NFZ1UzNEcE9ZR1lkbW55QnNuWDRBWGU2?=
 =?utf-8?B?Q3d6R2puRDg0bXR3VHJQdGtSdU45MWFnQ0pleU5CSC93Z2hFOE12TUFJbDR1?=
 =?utf-8?B?WEVIQUdQNHNiTnNkY3F2M21BemlMQUxwZm0reHNwZlYxdUFoTE5JV0JRK2sw?=
 =?utf-8?B?VFErdkVRM29BbWVkQ21VNXBMZHVLZ3JyTGFKM0xXZFJMWU9mRnRLNjJJcENE?=
 =?utf-8?B?VFRUd3VuaWcveDZ5a2gzSjF4WThENnN0cWRHa2xRdDNlQTk5ZnNCYkRSQjJ6?=
 =?utf-8?B?ZWluZW5ZbDVPUjNDQTRlSWRwMlY3UUhnSllpL0lNZnF4VmdTdE5aTUROUFNX?=
 =?utf-8?B?RDlmaTlIRTRscm91VU1uQngrVTE1aG5HSVhNejFTOU9zcFpyOTlKTFZidEt0?=
 =?utf-8?B?VFB5TmJNQnN4dnhabGdXQnpWalA5dEkwS1RSQi95a2ZtRGd6L0x1SFVOWkRG?=
 =?utf-8?B?cHlhR0hOSExCUnZMcHkyNjZjQ3RsVkRZRnB6Mm9qQ2gydHRkV0Y0T3JOYU10?=
 =?utf-8?B?V013QXQrVlphaVRhVkphdnpHbFZQTDRVajJtSHlxVW9ockMvTkIydmtubzJo?=
 =?utf-8?B?STJzZlNrRFc3QVNDb1RlTFR1RFplaXNQc3ZxQ3d1WWlDa2lrL2hMNHZJU3Jk?=
 =?utf-8?B?YjVmaVFjZXl2ME52TXA3ci9OUVVVWkVablZmOTdkTFBOcmphS2RpZVk3TzZT?=
 =?utf-8?B?TmNuMFZVdmNpcVVEV3U4QUxkK05Jck1MRFdBTk92REZCWnBZaGNxVWY3R0FU?=
 =?utf-8?B?elMrMDYwc3UvM204V3lKelcxYjNTUHFPaVEvS1VFY3hmNU5OM2F0VmV5enJY?=
 =?utf-8?B?NXRQTGo4YXRFUThhendhWThWcm1Pais4VGhQMG53bFV6Mkl6VmhGenc3bWtn?=
 =?utf-8?B?UWFBdDRRVTQ4QWxoVTNaRzNzeHhLRHBMbXhFOFprS0k2d3RSWmdpYldHNHgy?=
 =?utf-8?B?YjJxQTFPRStiSjFzaWdzSlkzS1orNk1saHRZRTZXUXNzYU9HZDdyd2lrT1BE?=
 =?utf-8?B?ZmhPTlZ3aGV2d0FVdGEwaExYM0p2YVFmQWRxQTZnbzNlbE5jYXZ0VDhwN3lY?=
 =?utf-8?B?R1h4T3BMRWZOMU9qY1l5Q2pxeTN1Ulg2MmEyNWlLYjZkb0w4Wk04eXI5NUVl?=
 =?utf-8?Q?GXzbOxWrm73K6NlEvLf9EU5NuDqgKNUQLX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33037201-41fd-46c0-254c-08d89b5e5ca3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 09:48:05.9030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgUDaYu/cYEwYr2Is8rXyjX2HGepV6poEuz/9EyQOxXs3eEQV6y7TVagvLpqyQy/7Fz5dWY3XZORzTY2mcJ9IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-08 at 10:07 +0100, Guido Günther wrote:
> Hi Liu,
> Since we now gain optional properties validation would become even more
> useful. Could you look into converting to YAML before adding more
> values?

Yes, a YAML one would be good.
I'll try to do the conversion and then add the binding support for the
i.MX8qxp Mixel combo PHY in it.

Liu Ying

> Cheers,
>  -- Guido
> 
> On Fri, Dec 04, 2020 at 03:33:43PM +0800, Liu Ying wrote:
> > Add support for Mixel MIPI DPHY + LVDS PHY combo IP
> > as found on Freescale i.MX8qxp SoC.
> > 
> > Cc: Guido Günther <agx@sigxcpu.org>
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> > index 9b23407..0afce99 100644
> > --- a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> > +++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> > @@ -4,9 +4,13 @@ The Mixel MIPI-DSI PHY IP block is e.g. found on i.MX8 platforms (along the
> >  MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
> >  electrical signals for DSI.
> >  
> > +The Mixel PHY IP block found on i.MX8qxp is a combo PHY that can work
> > +in either MIPI-DSI PHY mode or LVDS PHY mode.
> > +
> >  Required properties:
> > -- compatible: Must be:
> > +- compatible: Should be one of:
> >    - "fsl,imx8mq-mipi-dphy"
> > +  - "fsl,imx8qxp-mipi-dphy"
> >  - clocks: Must contain an entry for each entry in clock-names.
> >  - clock-names: Must contain the following entries:
> >    - "phy_ref": phandle and specifier referring to the DPHY ref clock
> > @@ -14,6 +18,8 @@ Required properties:
> >  - #phy-cells: number of cells in PHY, as defined in
> >    Documentation/devicetree/bindings/phy/phy-bindings.txt
> >    this must be <0>
> > +- fsl,syscon: Phandle to a system controller, as required by the PHY
> > +  in i.MX8qxp SoC.
> >  
> >  Optional properties:
> >  - power-domains: phandle to power domain
> > -- 
> > 2.7.4
> > 

