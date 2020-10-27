Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CA029A533
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507299AbgJ0HFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:05:49 -0400
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:19778
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2507293AbgJ0HFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:05:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7OscWJIA7/zDdaX/UP5zRZXg47jGZO53dEv+MSYVEWbS3xP2UhiUOXjE+HslS5cVpxMVq4aghzQ1pIDqz4vpar8yS7nhxQmu0XRXlmYAjZ2HTWX620WyZ/vR2COBAhExgSfFsd9CxftMFAVCbwT1JA9lTvD0Y2rzzzL52fuI4tlxh0xsa+CtKOPI0b95B+LtJWuM1FDyRBuYv/DlZloTR/81GgA0VReEobgXJoMd/BhczBEh/Tb+leGMUfbmpkFxW3wSmEOBmlL0RqYqtSl79rYykrQnnc0gMu0DEL3SgNKMtuzMTUZNw4BgTn0EfivzOaP7Fa1Cv/wEkik2PndaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTVw6oRVE2EOK3NEif2d52Pb8ZmvcirACiQk21VVBy8=;
 b=mU8X8CpcuOs0sTHrTze7Q9Gv6ZJyRxaUYZPTCumYWSE5Wh66Ia1460j14UjKdS/RVVCwWoR0RnwZZfz42zOM8Gc1Q0eaLxa3SDyXAFfQpAbeJzcl5rBCkXTpt1S53Kxr39G8wym5YACLOYMoQZk6KAhDE8g1dkF16S+s/Oz0uFeYY5LvZKUgDRx/b1TU8onVMkNKNwH30JVrXTSda68ZoRxzU+4howWRjwPUMSVjXPJzqajT/PdFFczHgI8J23MEx1hYsBrQlp9BAjJrEQW2/5rXgcP8eiAFJW3TZfifagwDG+tMTVupCjEYs5l4Ds1dxvWmL3wz3Tn30jM5HeenUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTVw6oRVE2EOK3NEif2d52Pb8ZmvcirACiQk21VVBy8=;
 b=IeLeUR6r5TtSIkxznMMnnXYuD4S56vRyVDTsKCFap+dHn1OS4vCwdlAiNxzlfizF94/ksbssz1AIhLcq04Avv4PcLWpnzbUQroerAvZNgd54Smc3z6UPXZTwCvEsrf1LPe27qC8YIQkEDu18txrXD7ISaqrqM6lpN+oHj1FW1V8=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB4173.eurprd04.prod.outlook.com (2603:10a6:803:47::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 07:05:43 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 07:05:43 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Thread-Topic: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Thread-Index: AQHWqDFSEBaTQE/ZZ0S8iz1mc9AwNqmk7OMAgARJc3CAAc3rAIAABx/A
Date:   Tue, 27 Oct 2020 07:05:43 +0000
Message-ID: <VI1PR04MB4960C0E76374B2775D99A82192160@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
 <20201022050638.29641-3-sherry.sun@nxp.com>
 <20201023092650.GB29066@infradead.org>
 <VI1PR04MB4960E9ECD7310B8CA1E053DC92190@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027062802.GC207971@kroah.com>
In-Reply-To: <20201027062802.GC207971@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3727b57d-d34d-47c9-880e-08d87a46b8ab
x-ms-traffictypediagnostic: VI1PR04MB4173:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4173FEF7B1CBF8F3EED2E81692160@VI1PR04MB4173.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0kyme5TP6nj4TUvQc0j/dIAmJTk5Vdv0swgRc6iFQ8V7I16dzIT56cr5R1zlBsEPotX2fEBuXWO8kvrdq8v5RjsDvoxB3xJ6AAiLFG9+iHF8aGoQROmjKci8TbUMR+Mt0irZoM6630foZ6DtdEnIXwT5g3tv1AFdY4nPaqNzEX1ZygDHdazmcyI14p2k5P+SsUZIKx9DRqje4LjaLirf8Uh9idIIqvj5YRHcqrikBwhHRIkbOOAZUw1141hhUqRKxVrxnkwpE1AMisXpqaJFFN+xli90fdDFrpRcBd6lcwgr9ffG61VKDXYhl1Vrf5brwDHbTRM7ru11ha8b9rxNTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(110136005)(5660300002)(64756008)(66476007)(66946007)(44832011)(86362001)(4326008)(66446008)(9686003)(2906002)(26005)(54906003)(7696005)(52536014)(33656002)(186003)(6506007)(55016002)(316002)(66556008)(76116006)(71200400001)(8936002)(478600001)(83380400001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: e6WaSCtYSzVgJ2ApEt+ecArNCXMC+rAx4tT6se3St4DcWzchuG3H3dJZN4bfKlkl+fvWQCTmb15Avp7yOECG/SjB2y51zx7LJ/3H3mvQDcD8HY0spvLQZAYQsq7CiPlfSORhys99xyvVAU5VR9S1ZTCqRpeRR+khqsdWES7hvOHUQ9htm3BwovP6bNHSjq0eYTO3KdQFfeCqvqDcLuzmQNGCdwHmD6+v6ND4LhdPqKKRU1k4zfO9fMl2Myb0lOd/PkV2bP/ththVt0J3uITimM8Mf9mrrEnG5JXqvVtYaYI7nzTYFdfOk2fpmq+jBcq67rm12VNLTX/D07sGhy91yZ1DL/Cg9GC/iPi48wGBbbUhUmxBLy5BVjtkERkZtCPREXnzY1VE5t1pY/FmbyYeKJNVfQTyk7dHn73fa80gejpLES6G9SIkEzzZOcr6H88ls8fV/RS2duvKVmyeEGM6EofDqSOvrP51YYQP8KacWuwaHLrgp2qScxya7SQVeYbt5qt75t7Ku3yeNwaCjNS7gk/88NK+gryYcKO9z+QQtGyDBsCYrWk0BsKnIMMFROFu6207VgvEp4eMDeN7XcD4Wq2H+6iB2/og67WPiDntyU785rlYyIrMYMStX+WAcKQdClP189IQq+X/JRX/nJFJ0w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3727b57d-d34d-47c9-880e-08d87a46b8ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 07:05:43.6764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNVvaCKRpCd+FrsLa7NVTxeWQFvIX9sFjVE1TqQdUvIlT2TOUbHZr/EY4dT85erK+ybArizjXGNXJ8X+8T9aXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4173
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep & Ashutosh & Vincent,

Can you help test the patch about removing the codes of reassign used ring,=
 and comment on the impact for Intel MIC platform?
Thanks for any help.

Best regards
Sherry

> Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the u=
sed
> ring
>=20
> On Mon, Oct 26, 2020 at 03:04:45AM +0000, Sherry Sun wrote:
> > Hi Greg & Christoph,
> >
> > > Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign
> > > the used ring
> > >
> > > On Thu, Oct 22, 2020 at 01:06:36PM +0800, Sherry Sun wrote:
> > > > We don't need to allocate and reassign the used ring here and
> > > > remove the used_address_updated flag.Since RC has allocated the
> > > > entire vring, including the used ring. Simply add the
> > > > corresponding offset can get the used ring address.
> > >
> > > Someone needs to verify this vs the existing intel implementations.
> >
> > Hi Greg, @gregkh@linuxfoundation.org, sorry I don't have the Intel MIC
> devices so cannot test it, do you know anyone who can help test this patc=
h
> changes on the Intel MIC platform? Thanks.
>=20
> Why not ask the authors/maintainers of that code?
>=20
> greg k-h
