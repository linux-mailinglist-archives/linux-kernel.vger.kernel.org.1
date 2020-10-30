Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E5D2A0131
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgJ3JWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:22:38 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:51381
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgJ3JWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:22:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlTOWZwEFV7TL1HohxLSvBLRbE2wHMVXcxdnR+oGKVQqyldPx0oS19dc8UtHfobeanEeNZmKE0GEnJG4xLQSfPAX3j1yNuDca9jYBT9y4GvGWzvmnf6soc8DdytzU5+ZUK4NSKTORwxPHVsbP2Il0ts7bmfd4YR6iHZCcFsunHFlVFWwlyQVRvlFUiOsaSdJSGzaHlUVjr7kDmSr5cuSr6NgwbfvuPIXI31jfsvHFm/YEF7LLaouYpQjkvVPRqt/FqZuXI3oQqbAcn0NW6FuAy9D8x8f5IGkIhY0h1lNJG7+dvbVFJFAnPsxOOBzLqN6qp6J1jH3yy1hbLY4dCZsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II7icuHba+vR/928JCkPy8mZfhAvgGmud9BJKR/LfB4=;
 b=RKKW5k7DyRn8REJHHafD1bO5bAtOJnws5jGqHHz42Akumzcrl9PXbVNbh+euUlP+MNRBOjlq0T/TQ3ke7RIHM725ecDBdpLAzJAnnAk+H7QcVG3xeJrZHjqJtleTWmfCxr19qn3yBMFnG9eDuGEN1RQKbS99H4ygKkOnbUITGkGWkyYvJWhbdSIhf3ZJc8M8O7QkKkcDi5EkaGTq5Pjq/b1qmeux/N7Lq79lUhCO0GzeyMjenzAIZOeNck3m0nqXQECpKP+xHMnFQVHPfAW4uVKfsGh0p6MdyeN7eBV29ri+V/Qx4rsTY3Y6nucVeFgLnGOdh6IptK/9GG2CcYj0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II7icuHba+vR/928JCkPy8mZfhAvgGmud9BJKR/LfB4=;
 b=ZsdY1Siqus9EZA8kW/SgQVlMLFziDTUznIBjAPAGVkpiMYbtUVYk5wBVu27KktY0sYI6LFBb+Ju86yq3/Nj0F0O8E6+6AUWZh4KVRm6MPTANj5SbqUE9b1pQJ313LMkbiNbHhTrqSsrGlK3V1n4I5W+bU9gSgLyJ0/UaFcucLZQ=
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 (2603:10a6:803:16::14) by VI1PR04MB5567.eurprd04.prod.outlook.com
 (2603:10a6:803:d5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Fri, 30 Oct
 2020 09:22:35 +0000
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::607d:cbc4:9191:b324]) by VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::607d:cbc4:9191:b324%5]) with mapi id 15.20.3499.029; Fri, 30 Oct 2020
 09:22:35 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/11] arm64: dts: ls1088a: add external MDIO device
 nodes
Thread-Topic: [PATCH v4 03/11] arm64: dts: ls1088a: add external MDIO device
 nodes
Thread-Index: AQHWq7KPgPLchCf2i0mGrv1L3kt/jqmv0oCAgAASgQA=
Date:   Fri, 30 Oct 2020 09:22:34 +0000
Message-ID: <20201030091942.t2h6f4rdp4uhcaqa@skbuf>
References: <20201026161005.5421-1-ioana.ciornei@nxp.com>
 <20201026161005.5421-4-ioana.ciornei@nxp.com> <20201030081617.GM28755@dragon>
In-Reply-To: <20201030081617.GM28755@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.2.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6efa5542-20c4-4db5-1f2f-08d87cb55637
x-ms-traffictypediagnostic: VI1PR04MB5567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5567EE559FF369634909733BE0150@VI1PR04MB5567.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2dlrdNpJVZntZB3JZkwyyC7w3aj9sOm47DNT7kr418ipzbZXwPRxRhupo1eC/hFjXqPoxump1F19dUP5aYSzzraF5r5QuZQCEAiNh0WkS4Nexpl4tze0JLaU9DK6xyz+ck4bqNPufR50yO0+/g/dbDNzq/YbliSw/SLTwzVm6mZJLzp5ejN8+85/S/FIifI3H90q8JARrsxEPUcRSnvb4joUByQl5+/eZ9m3sdmQB+E3Jn7PkXi2hAQx4WYODggn86oe1icWjXGeQ6V1K9i8dN8shpP/1eNiRpDw8uojGKZY3byS9pj61heytf3b9zaZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3871.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(396003)(346002)(376002)(39850400004)(366004)(44832011)(33716001)(186003)(2906002)(316002)(54906003)(6916009)(4326008)(26005)(71200400001)(1076003)(5660300002)(6506007)(8936002)(76116006)(478600001)(6486002)(9686003)(66946007)(6512007)(66446008)(64756008)(66556008)(66476007)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: pSVzuz9tyxW+y5MR/43dbBUbH3xzSmwZeL9YwSr57PE+VW0URii8eeQMz/JXcqOygx47qq3IPjRQ8qbBQ+y0GUvBiVYlg1Jfav7fMw1TDYDuAiFwvO3z/THE+Uxt3ng7NI1bFgZEoW4T3R1jFRHzssz1LMA8TfTZ8Mw+nESt/SS3h+1k9ShlR7Uvntxjg2U6PjuLeWXIlkjrUHDf/yhalT9J6Ik3Yo6ugaiFoMUYtzPxBUQq23E52C3GqIVWyvLR/XKdf1lVyLCZto3kalvOa3ImJ+RcCxE+EkHqqw03IMItrJTOOfpqC+GZao1bd+Pl7Ylbz0R0yMLkMU7K3NOk1DQsb+JPFMV9mhI1mRYzUgMi2b0dBD830MwrIGeympjhlZhfzskBkFONYMpPrQDh/XIabbQw7frBdG5hxlCEKn7a4+oCkBxgEwZ+JitHS3qiR4GPMqgiXHcXFuLvt2P/ZcHLtDJ87R7BrdTfbixy65EL+M9rBpT7rqwT6jw3PoZw91RkBqaKjn8cwtVUOYbiv20mUyaG4Do+aFwEk0qyI3yWVcXoS1N8vzYcFS1ddO8kwYdg8C+aFZCqk+mfqnQfTpTjFcfoFjuVJpimOd1rS6RnN/912UNUsS0pkONWRTe/Xebd316g55aBN8M2cfnYVA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <94BF6A89714E3646A254893FFFF69BCA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3871.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efa5542-20c4-4db5-1f2f-08d87cb55637
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 09:22:34.9823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v50xOMmJB1J/Z0haSOhi6mqzFfqmdxu/VbSmyo+nDUvt6aIdP4VQHMP/nJVWQchu2kZjq2b0SSrorq7xZKyB2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5567
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 04:16:21PM +0800, Shawn Guo wrote:
> On Mon, Oct 26, 2020 at 06:09:57PM +0200, Ioana Ciornei wrote:
> > Add the external MDIO device nodes found in the WRIOP global memory
> > region. This is needed for management of external PHYs.
> >=20
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> > Changes in v2:
> >  - removed the 0x from the unit addresses
> > Changes in v3:
> >  - none
> > Changes in v4:
> >  - none
> >=20
> >  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm6=
4/boot/dts/freescale/fsl-ls1088a.dtsi
> > index ff5805206a28..aea42e9e947f 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > @@ -672,6 +672,24 @@ ptp-timer@8b95000 {
> >  			fsl,extts-fifo;
> >  		};
> > =20
> > +		emdio1: mdio@8b96000 {
> > +			compatible =3D "fsl,fman-memac-mdio";
> > +			reg =3D <0x0 0x8B96000 0x0 0x1000>;
>=20
> Use lowercase for hex values.
>=20

Sure, will change in next version.

Ioana=
