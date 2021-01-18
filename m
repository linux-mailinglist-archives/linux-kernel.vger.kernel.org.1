Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE462F9A19
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbhARGqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:46:36 -0500
Received: from mail-vi1eur05on2050.outbound.protection.outlook.com ([40.107.21.50]:2714
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbhARGqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:46:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP7gGbQaeMZsfUCKEMbI8Lau/cdK9twd/NLWStOpD/JSfOFzis6ZE/pHtqxQSyEyyBG0LH6gsxuQP2SRxslT6cT1n6DDgoi45VowhbPrO/8F9GkITZ9HZC6iH8zvV5qcdCccZdp1EnVXXmJ4JcPBhuzVVRBuTqQq71D/yVuXsTxUf8BUBuvgdrPsVkMo075zgfvsZJk0FpLL4BmEeVC3dSGBc/BUewOVB8UlkRLWO3Ama1jfXwdsL2T7AdxCcRLOrczuHDSCfRkYIRnL3/hKPeOYIKQEYT0ZYQ/TYdDsKfBSxs/9W22bVrSME9ZxmibWFnqF5PXI1hqEudX5NJzAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDFGOX/kGzLSJGehpX65jU+jLuUm9fpkqZ4UunLeIOE=;
 b=U2h4W+a10FMzWFg3ljiYQew1oa2fcNZmt/degHhXzWTqkisLiOqSyU1u7iztDkTSXcURbeVWHKno02SM10zHgfYejgoQvur7zu0HRN7YHaZuWEE6cU2Yd4MYIikakNuHxvBtSTjq4skMZfvbA/uk+rHJQhzv6/jc/iQsHjL6Kov2T2WR0PBG7BnM+jHeGO1VhuRm3B7ecpW9BfMlvDCJddRhPYLd6C4Z3pwsOYfrgUpTdU/G/xulxEDLcbJSdb1qpHaT3ESbvU/ggs3kfoMFxwYnsaigmpfoeyu72pAq+/Y1UoLlSn+jcYjhl6+9arhriktKjgBGJA61WBG2rwq48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDFGOX/kGzLSJGehpX65jU+jLuUm9fpkqZ4UunLeIOE=;
 b=plUI6/UidGMONChDNW5G2yozW+KYBBDsb3QRXO88V5eZFivz/Vfq+lRYf6M5gyWJoOIcIcOveVzyvXisUF3+ptiCxKDqKUt6gkNBl3Z21QNVryxC/pBK8szR53T8a7A1e0CY4VsATsDY/nvNcxlqi92Bh3Ai9ReYmfboKcQyQHw=
Received: from VI1PR0401MB2542.eurprd04.prod.outlook.com
 (2603:10a6:800:55::19) by VI1PR0401MB2270.eurprd04.prod.outlook.com
 (2603:10a6:800:28::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Mon, 18 Jan
 2021 06:45:24 +0000
Received: from VI1PR0401MB2542.eurprd04.prod.outlook.com
 ([fe80::183f:daa7:b8bc:ecd8]) by VI1PR0401MB2542.eurprd04.prod.outlook.com
 ([fe80::183f:daa7:b8bc:ecd8%4]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 06:45:24 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/3] arm64: dts: lx2160a: Add flexcan support
Thread-Topic: [EXT] Re: [PATCH 1/3] arm64: dts: lx2160a: Add flexcan support
Thread-Index: AQHW5+zZYNDCCUN5SkueGHbkb58uWKospS8AgABVEVA=
Date:   Mon, 18 Jan 2021 06:45:23 +0000
Message-ID: <VI1PR0401MB2542294C7649253BE7FC6933E0A40@VI1PR0401MB2542.eurprd04.prod.outlook.com>
References: <1610350729-21287-1-git-send-email-kuldeep.singh@nxp.com>
 <1610350729-21287-2-git-send-email-kuldeep.singh@nxp.com>
 <20210118013744.GG28365@dragon>
In-Reply-To: <20210118013744.GG28365@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [182.69.109.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fdd7215-7fb6-43e0-6bba-08d8bb7ca212
x-ms-traffictypediagnostic: VI1PR0401MB2270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB227089FCDBE3A162832B625BE0A40@VI1PR0401MB2270.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o+9M0x70Zb27tmL2rd+/TQEpiH7Ykht0Bzj1nmmjtZlI7xXjDPLYyOwWazhFqxr+jjIjpzu1EekiO9Xcj1+IM050261HjQ0Enahx4GvW7xyuO56+BFMvpaZOYgLM+qRs+0uNFp+hki4r1vp1sRpN1fUq2Z35fbANNtlY1o1fH9jPBZkLXLxwGQ5vDz3NmbXXYugjezQyHAqcAlPeJDmp4kUG2TXPq7GwRvc15nqR+4L8YSdVHjZHdaBjTyorW96WY5lyUTjoYPF6iXMA0lF0ggFeoEhXJXVX1xcPNxsfYn0fkdaqwWmZ/j4UM3eMGrMuoSuc8uqicg9AtsczWUiGsSj1jU3x9IwfOr33YmjKKiZa2Ra2l6Yt/8YPpQ046Ba70DEkCeKpj9vDT0KZLIrsL1QHFZ2tmhZPlUvB7g/iiCQRdpMKsjiTOud0ewuHlddb9N0c81AmmFf9oVtyPWJKHin+k/ryrvR7vCjctUCg0EVKRUsiR1Dx2YdM+Zya3QOGvX5iJuh+lR2q2o8VVMTm+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2542.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(4744005)(86362001)(76116006)(71200400001)(7696005)(52536014)(9686003)(5660300002)(55016002)(478600001)(54906003)(33656002)(316002)(6916009)(83380400001)(44832011)(6506007)(8676002)(2906002)(4326008)(66556008)(66946007)(66476007)(8936002)(64756008)(66446008)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?55/2nkf+eBZQJM0OjpRcEOlFIZcfrkI3a7e1HIJFm19e7JG8XzAvPZjUA3ou?=
 =?us-ascii?Q?d0Xj5ogZf6xzWCqK9S3N0V2YTdOPczasM8yvCJN570UyVKDn33hJyAaiTqSO?=
 =?us-ascii?Q?RcxazK/YPuUIUlmKViJKnfJghFvBWzydVe1pYbIPeRzwNm+GXtZ5WLRgW4Hi?=
 =?us-ascii?Q?/K+00sC4/OEWuOmPJlGzH+wrv1rD2Lbma/dcJNZ3550iAvh7+aNKenp/orpd?=
 =?us-ascii?Q?EV2wkjZ/yh+oE/sdLshP4BoD9Cl28y2AfdQG6GVk0HX7yz8WQvtjbeGojBbp?=
 =?us-ascii?Q?HuvRcRsh8pMiXuEkZizLPJwj0DlCfJqdf5SOtY8ji+VL856j/EGOwY1uK+xP?=
 =?us-ascii?Q?0X1ZAC23RV749tCCZOXhjOkwZRJYBXOUNAbuPaWmaijMS3WnAp2d0MWagnjd?=
 =?us-ascii?Q?tm2bHlCdbVBtlBNzZR9RTpbijTAxwaiAx5egmZlil1leJBTFKWJP0JWYICgY?=
 =?us-ascii?Q?brl3KL31rnV3E52Vi/CHQdTclR9gh3Ht0pSyExtucO83n7qQaU5CPHBqUIoo?=
 =?us-ascii?Q?ca+zfWWtHzVOj7iZfDL/PyVThKBeonYcuTjNXDKdfp4RMCFGcCV38MV5XT0K?=
 =?us-ascii?Q?DQ5rfzyrEvrXJXHTqVaGDP2WRR/x8Pzl0T125Q9UH1OYFv4Bn1iB2US9E3Dz?=
 =?us-ascii?Q?bJ6fyA37nWJjaL1S2OzR2LqqSJiNTNM2a2Q6pNNcQh9vTyaig6IC5RQmT7Wz?=
 =?us-ascii?Q?a5RMvUQrF3tEhWyC+F5w0G8FD9UQnI+uOB7bM6vlS3mIzy4V61TBaxo+j19F?=
 =?us-ascii?Q?BAQrpXy7+0NMnWn7Xhq8EGDpaaoQvq+FLBliLx10UYIXIBIyQfs+pVpHoAXd?=
 =?us-ascii?Q?XZr+0/3qWaex7Ud3vwzkQOBcM6bnn27Jt2WJyMvCTNcq4z/7o9J8NJnnDine?=
 =?us-ascii?Q?/oBQux05em+OomNyvprzTpXEWe0hpD3moeRfuPclgcdHRvSE55rcyhaNtlp8?=
 =?us-ascii?Q?q3UK4ctvwvLH5a0f7PWBhkIwjVwvIU7/J8ju67hkjVE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2542.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdd7215-7fb6-43e0-6bba-08d8bb7ca212
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 06:45:24.0900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aB8fs8CewUNsKrvj0zChNbRhstFsTzFDYgysitHjAzkzR7KqlPaztoDIl9EmrZ2t3pyIC7EpUCoYsMziMdVIQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2270
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> > +             can0: can@2180000 {
> > +                     compatible =3D "fsl,lx2160ar1-flexcan";
> > +                     reg =3D <0x0 0x2180000 0x0 0x10000>;
> > +                     interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks =3D <&clockgen 4 7>, <&sysclk>;
>=20
> Can defines in dt-bindings/clock/fsl,qoriq-clockgen.h be useful?

Sure, I will update the constants with qoriq-clockgen defines.
Actually, the time I posted the patch, those series of patches were not acc=
epted.
I will update and resend the series.

Thanks
Kuldeep
