Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABB829D726
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbgJ1WVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:21:33 -0400
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:12928
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732012AbgJ1WTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:19:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdGb9WjeczGMgtl/ER60J8SyIjcqtJH4bDwGmM94UWDYyXOnVNFSclwzHck+SJwRWMtOBZLBozoOAd9A3AXdTXyVVpfvUEhMnLtGmMY33LVSIhId+oBluwWtYwHrLu4zPKZtLt+4TSXWYPGh2unIk5nNCwvSMDF27C0xSAc4hEBBDinmkWa3iq3emC0uZGrL/f6Yfb1lG5L61uj7mPGOxtBDeB4xP6ch4ULR6ky/XowDYjpQxkMYd1+769BwHB4Kbsi1e++sPBxXeLzo+Ueuj2Caf5R3lAmPXiWZjMgAA/NjpLGjRGW48IhkAYuZ2vtcEakg8wKrw2huKkGVAZY8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67uVQxhZ5lisUuckPxoLry1EtuQnyIl6/RxkZqJw15I=;
 b=Lc2en8ynehF0rwcOYoalcXRcRCEzIQ6p4epBxdVOrPe7obNYX8h7ZN2y1AFac6m53R/ENJu167RAXH8ZW0hC675zYVgquoLyQodG+u/RyBWkcXink8KAPWKGzNW076AAVZ7QFtjRl479pUv7F6hOW7R3VzJQ65KFsC3uuC/hIib84dTribDRZ0EX2W6aDR+8g94dy9GRgLwamBoQKisdSpPiRDpEcBBg2X0Gu76r2NGZcWgelIC6LUWSI1F85hRZDvunSFd1NvUwHgLJYh2tPLvwkXw1y6XQ7zvbQYd7RHBI9kxJM0piEdm6GYTL4bZtxyDi2pHwicxt+79cBfyqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67uVQxhZ5lisUuckPxoLry1EtuQnyIl6/RxkZqJw15I=;
 b=C8Uzg94B6rNl19AOD6NuajZqeh32v/pVTuJ0dLfClO7hB5F70aocVNykB/QHyHZ+Gxup25oFNFhpPauI093CINoKEpgDSPMmOx2XxC7lP+FVzxrynp8JaBsuKxjDI09z0Wf++NcWiLkH27S53nqpO8vdLMdP2/aAk6S5+FdNhi0=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR0401MB2575.eurprd04.prod.outlook.com (2603:10a6:800:51::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 01:47:49 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 01:47:49 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Thread-Topic: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Thread-Index: AQHWqDFSEBaTQE/ZZ0S8iz1mc9AwNqmk7OMAgARJc3CAAc3rAIAABx/AgACLBgCAAK8V0A==
Date:   Wed, 28 Oct 2020 01:47:49 +0000
Message-ID: <VI1PR04MB49603783EF3FD3F3635FCDAF92170@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
 <20201022050638.29641-3-sherry.sun@nxp.com>
 <20201023092650.GB29066@infradead.org>
 <VI1PR04MB4960E9ECD7310B8CA1E053DC92190@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027062802.GC207971@kroah.com>
 <VI1PR04MB4960C0E76374B2775D99A82192160@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027151106.e4skr6dsbwvo4al6@axis.com>
In-Reply-To: <20201027151106.e4skr6dsbwvo4al6@axis.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: axis.com; dkim=none (message not signed)
 header.d=none;axis.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 916ca4be-923f-4982-77e5-08d87ae379d2
x-ms-traffictypediagnostic: VI1PR0401MB2575:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2575D2865BC1B345FC6E863492170@VI1PR0401MB2575.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fwJfjI8EWXypZcnWT9lLOJIqocohWnDzOYlUVDZMOoyJ8vaDzBxzqw7BgOXikiy/9vDMrOdLh3p7lG2dSNJpbfxmX1+eV75/H9ohgvhWfWXpfpkxCmSt36vnPytFN4U3KZX1OcOLjp2yRffY059XUm1PK8NVMf0NsbUhEYeg6hb2YG1ULkKM1g+7iDcV4GRCh3WWsUloOe/1II6++/311YTRObYeDgog6Zwn+qbVFa9JMGee3Xul9OlV8V6GViukT/Vp7UWS8EVxfGLfDlfES8TISfJu8UoPcBAFR2O1MGqMp5P3aaCbS9GVUmF8wAAZmTmClSuNJJ5DnTJddjvZ8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(4326008)(66946007)(66476007)(9686003)(66446008)(66556008)(478600001)(64756008)(4744005)(8676002)(54906003)(7696005)(6916009)(2906002)(8936002)(5660300002)(52536014)(76116006)(186003)(55016002)(83380400001)(71200400001)(33656002)(26005)(316002)(44832011)(86362001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: m+Eikg9BGJNXj1IhLb2jbdKST8lII7udu8gTbAhAV4tW0ZVQhCJnweuNpX2cPEexwiXLi+fqZh9stbY5qXEGyEc8KrzhuVqrG+9g3ZUMH756DLYoHYUpJVgrQkX8B7fvz37g2pd6yv1q62d6uYj2EGD8uBc9Z2eBHqkeILg59cyWmFnRbZ1L9NaHctEbT8tDn0lndIZgXIgCEAHh+cmhRyfQ+VZSpZj0scgMX3KIfhoa1Z2UqgbSM1u2QOvLiTaeLB0FDXKCDWMiOKBUq5y51Z5ebpaKCrdO/vgeT5S83pLgikykEnryP/XKZ28xgOQzdhXr4U+5j/yWe+gcTKDyZd+iHo3Leb3m3X7agvmZqAf4P/k0NXFCVDML19F0WUzNVHSj3Z3nJlOdgbwNM8+9UGyrC+UPd3+w/HEOHOiIk5XeU1unx3KlrThMJSw/2QKiv9CTHTlF7LZakKtDDUKEgP+7SExNjFMgkPsftMQJwZHVDDIwViVz6qDMBYy2x77LlA8VKt1rhmQaZbatK+xzh6OamECuZh1JYKSCMh9xmGjsrj8OXwPjw7RZa9D14ygNCixNLxmrZXgQbBwqTC9rH6/UX33oniMC+DvVEMcRwx3nl83jCGVbdhbw22QoazuDW8CtBBWgjcU/AX2U1nYzxg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916ca4be-923f-4982-77e5-08d87ae379d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 01:47:49.1687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmhgR0sqVUlGPaMa7oj93t+bJupjtc4qfMJR4BHBgzqLjHAZ9V5QYmeds7IQL/lo7iq3wKkgvIw8dt9tcEUhtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2575
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

> Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the u=
sed
> ring
>=20
> On Tue, Oct 27, 2020 at 08:05:43AM +0100, Sherry Sun wrote:
> > Can you help test the patch about removing the codes of reassign used
> > ring, and comment on the impact for Intel MIC platform?  Thanks for
> > any help.
>=20
> I don't have access to MIC hardware myself, either.
>=20
> But this patch is quite certainly going to break it since guests using a =
kernel
> without the patch will not work with hosts with a kernel with the patch.

Thanks for your reply.
This patch can be used by both guests and hosts.
I have tested it on imx8qm platform(both guest and host are ARM64 architect=
ure), and it works well.
So I guess Intel MIC won't meet big problems when both guest and host apply=
 this patch. But it is best if it can be tested.

Best regards
Sherry
