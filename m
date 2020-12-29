Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7584A2E6E68
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 06:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgL2F4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 00:56:43 -0500
Received: from mail-bn7nam10on2103.outbound.protection.outlook.com ([40.107.92.103]:2389
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbgL2F4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 00:56:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEDdv+xLAeRyjQgI4qKEgUNiZMg0RySyhwlLxPVPehbQWPl7zI7ni5R89XLpQWIU2k6TbVeL7+B8Suoj4jjGe+TwS8PWgT34HK+2ryQ/SyCPrvml2e5JnfKC437DRnrJD85z6KF0Ls80702XzWuQtjaWIg+TSi8L1AmLp/hGTvCsbpXkN9Z70VlqoLxsqL+I3Mos5L4wLuGuBcJXS+O5aG8aY4aOK+ZYONOa74H/BPiL31lp5csRdO/6uCL6zkZzQ2+mRdrAR+jIK266MkbOQxlQdujlmz1oK3Q5EvES4Zwek8uX5d7i/FfhH6hVghcgb6x2pVnwmdgStl4RWZH1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Y5mXq3bm2+btt43X188ydooJJmcQ77kDIx89opU+TY=;
 b=C0iZDRQKZbiUNNsCrdawPMHMvHBspliIlu/1TOzCYjZqg+g2YBPpPl0B1v/KUsie3/3EvuoLcJo/lEMEwwiH+PmssQMnMDLYCRvHbdSnjoTqzv0HEZIfUOKxUAqWLo/C+qfpTDMG/vtaLSU9b/mVhNm7Lzj/eHGhaeHwGFpdmNG05v4ruia5X31kwnBOsWqSqFDldVFac03JT8Dn/I/ncVcGIL16zP8RkRk+XkKBaysP00kpt1W0xzPoKA+dp2BSK+BCcfEMBICgQDWpMXbx7J6Stc5W/5SWME7qjvyQnp8ngfmjNO7nRNY3fquqcEITcXrqjqiiYmFnYp4BDsKGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Y5mXq3bm2+btt43X188ydooJJmcQ77kDIx89opU+TY=;
 b=xmBR1J9qjQFCZXSZU151NwTB4KMXRpZnIzrYhXIeRZ0MiO2X8j2v4+hHfgWA2bQ8KPEMIgiMTLONHTS37uXFeFsTN6RcH6GAA4W8H7ydPra5lFdWTFrykSw0OgUO9IaTSmejHoDbDio/231x0E+cuLIZIcDk9KlHdJ8ftXOVKbE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BYAPR04MB4583.namprd04.prod.outlook.com (2603:10b6:a03:5a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Tue, 29 Dec
 2020 05:55:31 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::441c:9020:2a79:3eff]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::441c:9020:2a79:3eff%6]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 05:55:31 +0000
Date:   Tue, 29 Dec 2020 13:55:21 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Rob Herring <robh@kernel.org>
Cc:     David Airlie <airlied@linux.ie>,
        Nicolas Boichat <drinkcat@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, Sheng Pan <span@analogixsemi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: drm/bridge: anx7625: add DPI flag
 and swing setting
Message-ID: <20201229055521.GA7073@pc-user>
References: <cover.1608883950.git.xji@analogixsemi.com>
 <c29b7d9fda9ce8619d1c718b077250998a8600b8.1608883950.git.xji@analogixsemi.com>
 <1609088181.493422.1338173.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1609088181.493422.1338173.nullmailer@robh.at.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [61.148.116.10]
X-ClientProxiedBy: HKAPR03CA0025.apcprd03.prod.outlook.com
 (2603:1096:203:c9::12) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-user (61.148.116.10) by HKAPR03CA0025.apcprd03.prod.outlook.com (2603:1096:203:c9::12) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.3721.12 via Frontend Transport; Tue, 29 Dec 2020 05:55:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7938974-47fd-4e25-d442-08d8abbe5a1a
X-MS-TrafficTypeDiagnostic: BYAPR04MB4583:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR04MB45833194B6042E3A7E7B04CEC7D80@BYAPR04MB4583.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pPvdFZ+MHiuj7IOrKJjtGVHUrzYdIh5kkSccBqAybq1iCJd2cXYa77JLrIp7WVUEBthZmkX1VStpt1lFLhBhqQqCcnQIqEVxSXVKy1CaJQf2VroX0HhCOrM+o6ElFssUgAhMBK1Tx9BAIWwL+unjQWiAkzFaDL97g7a8PeQl48xrfY9ZwDkEZPfMwSkVroJTcT3QCOvkbD62KHUoddHqjufoZyCTpp3gJ5KvwonBwype5nOZp75DeNTFVIYKXg1a/x+pTpV2YVzmxUOMUaHR5jepJ9sDK4i67cXTMMEr6DvdKEJxOPM/uGMewIJuJp51PDsIt9hTLMh0VCHRd7epgHtKkMsXbYOyUy9rlEr7U0SHZJkcrwqkepad+AGPYWeDb+YLIXZXeWLDJZI2QOjAF2+Kw72aL0nhrLRKKssn00FNe0uX4vqXhEDlAoGM3dsXTdi55rO12Y6TqBIWlS2uEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(136003)(376002)(346002)(366004)(396003)(7416002)(66556008)(30864003)(9686003)(45080400002)(1076003)(5660300002)(16526019)(26005)(86362001)(966005)(956004)(6666004)(478600001)(186003)(2906002)(6496006)(8676002)(83380400001)(54906003)(6916009)(52116002)(4326008)(55016002)(8936002)(66946007)(66476007)(33716001)(33656002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZaKVLVYd3QLZ782+rHRDpgsBLIyoKOcV9wv335cChJkuE6LNPmYHJ1fKhs7Y?=
 =?us-ascii?Q?F1DcuxtGIMABQEkO59CPM+2kyUIvnUUi6xbPqstFHE1LrN7rNMTdNZwSWO9+?=
 =?us-ascii?Q?6v1VbI+djk9ZbKfTlhvGMkmLkn7/FLDaMP8+OJUr60JOY4R0MLHkaPkR5fic?=
 =?us-ascii?Q?rMZmppwOkAEIXmM0w6ys8shc6qd8MCoB5dzvSTHvDuRxkHVnY8Fiho9bIorV?=
 =?us-ascii?Q?SM2kzDicE5nEsLMUQMImb+KtwlYiW3tDagiDC86zcSxseVXclevP+84qQ6tp?=
 =?us-ascii?Q?YAWV+8T6LZhXzjE3GsP/+ZlAD3xqXQhuwjPPjn7bssqgLMuRlPc2TTLeukix?=
 =?us-ascii?Q?dsFOPOm2Ik2NJOG7n6yhxWRsGKenMJHCiFmFGcoM1BbcC9dNmJQQcp1i+g1o?=
 =?us-ascii?Q?bk+PpUn1dlWjZKK+wMAJBMlujo3s1ShclWYwHQSqoRYNVlJjSRS8hYAKBLmq?=
 =?us-ascii?Q?92dBKa8MrT6eW3M62zeusbNWMkbu95Lls5tMKQ+/xf2KYxSW7nVb2BGeVxQR?=
 =?us-ascii?Q?46uHl+nIVI9pDYxJniDGoD+/uEgpaUHOt1ZYzP2LY0Zx1wjNyopJbUyMx7y3?=
 =?us-ascii?Q?+ERHr8f4SjB+o6MOJ6jgyI6GWYsehx1RVvb0MEEXk7U56NbG25urIjQS8T8i?=
 =?us-ascii?Q?JeSxvRbi1sXPuPnq78+DP6Ek71+oTs6P3j+2YpofjzS/l9u4977V3q0he61y?=
 =?us-ascii?Q?jRkdJ6a8RCRwPbG2Vc9jG9wipASvbUbCFbxzkbiN6iLhoDloIzGz3QS5ooQ3?=
 =?us-ascii?Q?MixCiyQ24iVXPG6wPNA9szFI+sUcplaBjLB4PjN8vGXniydq/nBjblDCr3v4?=
 =?us-ascii?Q?gXpWhFPal81wq4LI0sRxnC8g6ApgQv6AlGmzW7B5jz1hDMqXBD8GZaVswnGk?=
 =?us-ascii?Q?cI/daLH1QKGr6cvETecEWHjFblc2CVV7B/WJlJ/dNXwgD484vXg6fJzFdlb/?=
 =?us-ascii?Q?fF3sJ/BFu8CRBhfo36MPbF65YLUHUC9UpcPOKlUe6vixmUQfzV32c/IGQQgS?=
 =?us-ascii?Q?Mxrx?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 05:55:31.6111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-Network-Message-Id: a7938974-47fd-4e25-d442-08d8abbe5a1a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ablWvyiFK/qa8qlQD3e6dPuz0QQyG2fw8n18k7WfLBZh28PjXGim2XmK0BM1uorZBFZvW5PtfR7X05RUnP3aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4583
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 09:56:21AM -0700, Rob Herring wrote:
> On Fri, 25 Dec 2020 19:01:09 +0800, Xin Ji wrote:
> > Add DPI flag for distinguish MIPI input signal type, DSI or DPI. Add
> > swing setting for adjusting DP tx PHY swing
> >=20
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  .../bindings/display/bridge/analogix,anx7625.yaml     | 19 +++++++++++=
++++++++
> >  1 file changed, 19 insertions(+)
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
Hi Rob Herring, I'll fix this issue in the next serial, thanks!
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/disp=
lay/bridge/analogix,anx7625.example.dt.yaml: encoder@58: anx,swing-setting:=
 'anyOf' conditional failed, one must be fixed:
> 	[[0, 20], [1, 84], [2, 100], [3, 116], [4, 41], [5, 123], [6, 119], [7, =
91], [8, 127], [12, 32], [13, 96], [16, 96], [18, 64], [19, 96], [20, 20], =
[21, 84], [22, 100], [23, 116], [24, 41], [25, 123], [26, 119], [27, 91], [=
28, 127], [32, 32], [33, 96], [36, 96], [38, 64], [39, 96]] is too long
> 	[0, 20] is too long
> 	[1, 84] is too long
> 	[2, 100] is too long
> 	[3, 116] is too long
> 	[4, 41] is too long
> 	[5, 123] is too long
> 	[6, 119] is too long
> 	[7, 91] is too long
> 	[8, 127] is too long
> 	[12, 32] is too long
> 	[13, 96] is too long
> 	[16, 96] is too long
> 	[18, 64] is too long
> 	[19, 96] is too long
> 	[20, 20] is too long
> 	[21, 84] is too long
> 	[22, 100] is too long
> 	[23, 116] is too long
> 	[24, 41] is too long
> 	[25, 123] is too long
> 	[26, 119] is too long
> 	[27, 91] is too long
> 	[28, 127] is too long
> 	[32, 32] is too long
> 	[33, 96] is too long
> 	[36, 96] is too long
> 	[38, 64] is too long
> 	[39, 96] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree=
/bindings/display/bridge/analogix,anx7625.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/disp=
lay/bridge/analogix,anx7625.example.dt.yaml: encoder@58: 'anx,mipi-dpi-in',=
 'anx,swing-setting' do not match any of the regexes: '^#.*', '^(at25|bm|de=
vbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio-key|gpio|gpmc|hdmi|i2c-gpio),.=
*', '^(keypad|m25p|max8952|max8997|max8998|mpmc),.*', '^(pinctrl-single|#pi=
nctrl-single|PowerPC),.*', '^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m87=
67|sdhci),.*', '^(simple-audio-card|st-plgpio|st-spics|ts),.*', '^70mai,.*'=
, '^GEFanuc,.*', '^ORCL,.*', '^SUNW,.*', '^[a-zA-Z0-9#_][a-zA-Z0-9+\\-._@]{=
0,63}$', '^[a-zA-Z0-9+\\-._]*@[0-9a-zA-Z,]*$', '^abb,.*', '^abilis,.*', '^a=
bracon,.*', '^abt,.*', '^acer,.*', '^acme,.*', '^actions,.*', '^active-semi=
,.*', '^ad,.*', '^adafruit,.*', '^adapteva,.*', '^adaptrum,.*', '^adh,.*', =
'^adi,.*', '^advantech,.*', '^aeroflexgaisler,.*', '^al,.*', '^allegro,.*',=
 '^allo,.*', '^allwinner,.*', '^alphascale,.*', '^alps,.*', '^alt,.*', '^al=
tr,.*', '^amarula,.*', '^amazon,.*', '^amcc,.*', '^amd,.*', '^amediatech,.*=
', '^amlogic,.*', '^ampere,.*', '^ampire,.*', '^ams,.*', '^amstaos,.*', '^a=
nalogix,.*', '^andestech,.*', '^anvo,.*', '^apm,.*', '^aptina,.*', '^arasan=
,.*', '^archermind,.*', '^arctic,.*', '^arcx,.*', '^aries,.*', '^arm,.*', '=
^armadeus,.*', '^arrow,.*', '^artesyn,.*', '^asahi-kasei,.*', '^asc,.*', '^=
aspeed,.*', '^asus,.*', '^atlas,.*', '^atmel,.*', '^auo,.*', '^auvidea,.*',=
 '^avago,.*', '^avia,.*', '^avic,.*', '^avnet,.*', '^awinic,.*', '^axentia,=
.*', '^axis,.*', '^azoteq,.*', '^azw,.*', '^baikal,.*', '^bananapi,.*', '^b=
eacon,.*', '^beagle,.*', '^bhf,.*', '^bitmain,.*', '^boe,.*', '^bosch,.*', =
'^boundary,.*', '^brcm,.*', '^broadmobi,.*', '^bticino,.*', '^buffalo,.*', =
'^bur,.*', '^calaosystems,.*', '^calxeda,.*', '^caninos,.*', '^capella,.*',=
 '^cascoda,.*', '^catalyst,.*', '^cavium,.*', '^cdns,.*', '^cdtech,.*', '^c=
ellwise,.*', '^ceva,.*', '^checkpoint,.*', '^chefree,.*', '^chipidea,.*', '=
^chipone,.*', '^chipspark,.*', '^chrontel,.*', '^chrp,.*', '^chunghwa,.*', =
'^chuwi,.*', '^ciaa,.*', '^cirrus,.*', '^cloudengines,.*', '^cnm,.*', '^cnx=
t,.*', '^colorfly,.*', '^compulab,.*', '^coreriver,.*', '^corpro,.*', '^cor=
tina,.*', '^cosmic,.*', '^crane,.*', '^creative,.*', '^crystalfontz,.*', '^=
csky,.*', '^csq,.*', '^cubietech,.*', '^cypress,.*', '^cznic,.*', '^dallas,=
.*', '^dataimage,.*', '^davicom,.*', '^dell,.*', '^delta,.*', '^denx,.*', '=
^devantech,.*', '^dfi,.*', '^dh,.*', '^difrnce,.*', '^digi,.*', '^digilent,=
.*', '^dioo,.*', '^dlc,.*', '^dlg,.*', '^dlink,.*', '^dmo,.*', '^domintech,=
.*', '^dongwoon,.*', '^dptechnics,.*', '^dragino,.*', '^dserve,.*', '^dynai=
mage,.*', '^ea,.*', '^ebs-systart,.*', '^ebv,.*', '^eckelmann,.*', '^edt,.*=
', '^eeti,.*', '^einfochips,.*', '^elan,.*', '^element14,.*', '^elgin,.*', =
'^elida,.*', '^elimo,.*', '^embest,.*', '^emlid,.*', '^emmicro,.*', '^empir=
e-electronix,.*', '^emtrion,.*', '^endless,.*', '^ene,.*', '^energymicro,.*=
', '^engicam,.*', '^epcos,.*', '^epfl,.*', '^epson,.*', '^esp,.*', '^est,.*=
', '^ettus,.*', '^eukrea,.*', '^everest,.*', '^everspin,.*', '^evervision,.=
*', '^exar,.*', '^excito,.*', '^ezchip,.*', '^facebook,.*', '^fairphone,.*'=
, '^faraday,.*', '^fastrax,.*', '^fcs,.*', '^feixin,.*', '^feiyang,.*', '^f=
ii,.*', '^firefly,.*', '^focaltech,.*', '^frida,.*', '^friendlyarm,.*', '^f=
sl,.*', '^fujitsu,.*', '^gardena,.*', '^gateworks,.*', '^gcw,.*', '^ge,.*',=
 '^geekbuying,.*', '^gef,.*', '^gemei,.*', '^geniatech,.*', '^giantec,.*', =
'^giantplus,.*', '^globalscale,.*', '^globaltop,.*', '^gmt,.*', '^goodix,.*=
', '^google,.*', '^grinn,.*', '^grmn,.*', '^gumstix,.*', '^gw,.*', '^hannst=
ar,.*', '^haoyu,.*', '^hardkernel,.*', '^hideep,.*', '^himax,.*', '^hirschm=
ann,.*', '^hisilicon,.*', '^hit,.*', '^hitex,.*', '^holt,.*', '^holtek,.*',=
 '^honestar,.*', '^honeywell,.*', '^hoperun,.*', '^hp,.*', '^hsg,.*', '^hug=
sun,.*', '^hwacom,.*', '^hydis,.*', '^hyundai,.*', '^i2se,.*', '^ibm,.*', '=
^icplus,.*', '^idt,.*', '^ifi,.*', '^ilitek,.*', '^img,.*', '^imi,.*', '^in=
circuit,.*', '^inet-tek,.*', '^infineon,.*', '^inforce,.*', '^ingenic,.*', =
'^innolux,.*', '^inside-secure,.*', '^inspur,.*', '^intel,.*', '^intercontr=
ol,.*', '^invensense,.*', '^inversepath,.*', '^iom,.*', '^isee,.*', '^isil,=
.*', '^issi,.*', '^ite,.*', '^itead,.*', '^ivo,.*', '^iwave,.*', '^jdi,.*',=
 '^jedec,.*', '^jesurun,.*', '^jianda,.*', '^kam,.*', '^karo,.*', '^keithko=
ep,.*', '^keymile,.*', '^khadas,.*', '^kiebackpeter,.*', '^kinetic,.*', '^k=
ingdisplay,.*', '^kingnovel,.*', '^kionix,.*', '^kobo,.*', '^kobol,.*', '^k=
oe,.*', '^kontron,.*', '^kosagi,.*', '^kyo,.*', '^lacie,.*', '^laird,.*', '=
^lamobo,.*', '^lantiq,.*', '^lattice,.*', '^leadtek,.*', '^leez,.*', '^lego=
,.*', '^lemaker,.*', '^lenovo,.*', '^lg,.*', '^lgphilips,.*', '^libretech,.=
*', '^licheepi,.*', '^linaro,.*', '^linksprite,.*', '^linksys,.*', '^linutr=
onix,.*', '^linux,.*', '^linx,.*', '^litex,.*', '^lltc,.*', '^logicpd,.*', =
'^logictechno,.*', '^longcheer,.*', '^lontium,.*', '^loongson,.*', '^lsi,.*=
', '^lwn,.*', '^lxa,.*', '^macnica,.*', '^mantix,.*', '^mapleboard,.*', '^m=
arvell,.*', '^maxbotix,.*', '^maxim,.*', '^mbvl,.*', '^mcube,.*', '^meas,.*=
', '^mecer,.*', '^mediatek,.*', '^megachips,.*', '^mele,.*', '^melexis,.*',=
 '^melfas,.*', '^mellanox,.*', '^memsic,.*', '^menlo,.*', '^mentor,.*', '^m=
eraki,.*', '^merrii,.*', '^micrel,.*', '^microchip,.*', '^microcrystal,.*',=
 '^micron,.*', '^microsoft,.*', '^microsys,.*', '^mikroe,.*', '^mikrotik,.*=
', '^miniand,.*', '^minix,.*', '^miramems,.*', '^mitsubishi,.*', '^modtroni=
x,.*', '^mosaixtech,.*', '^motorola,.*', '^moxa,.*', '^mpl,.*', '^mps,.*', =
'^mqmaker,.*', '^mrvl,.*', '^mscc,.*', '^msi,.*', '^mstar,.*', '^mti,.*', '=
^multi-inno,.*', '^mundoreader,.*', '^murata,.*', '^mxicy,.*', '^myir,.*', =
'^national,.*', '^nec,.*', '^neonode,.*', '^netgear,.*', '^netlogic,.*', '^=
netron-dy,.*', '^netxeon,.*', '^neweast,.*', '^newhaven,.*', '^nexbox,.*', =
'^nextthing,.*', '^ni,.*', '^nintendo,.*', '^nlt,.*', '^nokia,.*', '^nordic=
,.*', '^novtech,.*', '^nutsboard,.*', '^nuvoton,.*', '^nvd,.*', '^nvidia,.*=
', '^nxp,.*', '^oceanic,.*', '^oct,.*', '^okaya,.*', '^oki,.*', '^olimex,.*=
', '^olpc,.*', '^onion,.*', '^onnn,.*', '^ontat,.*', '^opalkelly,.*', '^ope=
ncores,.*', '^openrisc,.*', '^option,.*', '^oranth,.*', '^orisetech,.*', '^=
ortustech,.*', '^osddisplays,.*', '^ouya,.*', '^overkiz,.*', '^ovti,.*', '^=
oxsemi,.*', '^ozzmaker,.*', '^panasonic,.*', '^parade,.*', '^parallax,.*', =
'^pda,.*', '^pericom,.*', '^pervasive,.*', '^phicomm,.*', '^phytec,.*', '^p=
icochip,.*', '^pine64,.*', '^pineriver,.*', '^pixcir,.*', '^plantower,.*', =
'^plathome,.*', '^plda,.*', '^plx,.*', '^pni,.*', '^pocketbook,.*', '^polar=
oid,.*', '^portwell,.*', '^poslab,.*', '^pov,.*', '^powertip,.*', '^powervr=
,.*', '^primux,.*', '^probox2,.*', '^prt,.*', '^pulsedlight,.*', '^purism,.=
*', '^qca,.*', '^qcom,.*', '^qemu,.*', '^qi,.*', '^qiaodian,.*', '^qihua,.*=
', '^qnap,.*', '^radxa,.*', '^raidsonic,.*', '^ralink,.*', '^ramtron,.*', '=
^raspberrypi,.*', '^raydium,.*', '^rda,.*', '^realtek,.*', '^renesas,.*', '=
^rervision,.*', '^revotics,.*', '^rex,.*', '^richtek,.*', '^ricoh,.*', '^ri=
komagic,.*', '^riot,.*', '^riscv,.*', '^rockchip,.*', '^rocktech,.*', '^roh=
m,.*', '^ronbo,.*', '^roofull,.*', '^roseapplepi,.*', '^samsung,.*', '^samt=
ec,.*', '^sancloud,.*', '^sandisk,.*', '^satoz,.*', '^sbs,.*', '^schindler,=
.*', '^seagate,.*', '^seeed,.*', '^seirobotics,.*', '^semtech,.*', '^sensir=
ion,.*', '^sensortek,.*', '^sff,.*', '^sgd,.*', '^sgmicro,.*', '^sgx,.*', '=
^sharp,.*', '^shimafuji,.*', '^shiratech,.*', '^si-en,.*', '^si-linux,.*', =
'^sifive,.*', '^sigma,.*', '^sii,.*', '^sil,.*', '^silabs,.*', '^silead,.*'=
, '^silergy,.*', '^silex-insight,.*', '^siliconmitus,.*', '^simtek,.*', '^s=
inlinx,.*', '^sinovoip,.*', '^sipeed,.*', '^sirf,.*', '^sis,.*', '^sitronix=
,.*', '^skyworks,.*', '^smartlabs,.*', '^smsc,.*', '^snps,.*', '^sochip,.*'=
, '^socionext,.*', '^solidrun,.*', '^solomon,.*', '^sony,.*', '^spansion,.*=
', '^sprd,.*', '^sst,.*', '^sstar,.*', '^st,.*', '^st-ericsson,.*', '^starr=
y,.*', '^startek,.*', '^ste,.*', '^stericsson,.*', '^summit,.*', '^sunchip,=
.*', '^swir,.*', '^syna,.*', '^synology,.*', '^tbs,.*', '^tbs-biometrics,.*=
', '^tcg,.*', '^tcl,.*', '^tdo,.*', '^technexion,.*', '^technologic,.*', '^=
techstar,.*', '^te
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree=
/bindings/vendor-prefixes.yaml
>=20
> See https://patchwork.ozlabs.org/patch/1420616
>=20
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.
