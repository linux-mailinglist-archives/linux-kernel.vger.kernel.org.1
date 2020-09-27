Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC00279F77
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 10:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbgI0IFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 04:05:11 -0400
Received: from mail-db8eur05on2063.outbound.protection.outlook.com ([40.107.20.63]:15297
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729125AbgI0IFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 04:05:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FddrAcXsKJFni2JXFpPXFd3B+RNS0hA4uItTfQQXyXa/+SpREDw5BqDqDair2ZW7IpAKPo55fYleXxaJXA8/GfEUJycGeuW1Ed/eq9hUzhC8VpOg52riegCe4n0fVsG5j0O9PcoxHkTp8oSZYcZGLSsWqYCnqTG4VILXfAd1Kbh/UdQsxUEC+mJUPpF786IGhD0blLRIABIKAG9DkJ9tVc8TrE0y9mQN8o+qgfP3Ab/yoKoM8aYTaeUOtLFxeP4epPg7QPxFUvfShWfAT3U8p0O6CnndJoXfO1+ouAXRmz9111RTY0yW97QZYu5VAFTFgW1fmzR4XR2Sq9LhGKSX7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFbhySXgN/5CnAMqG+ZcRinQ0W+tuLVpwNykA+58tF0=;
 b=lS9zX+gQZFPi9Xv1mRwMqoPcS+/+TE9RyxTNfYooggUQeoWgAT4OjVDgmas1j8j+mqt4TInMtFwes6NwXPfKekqK0OieGImQFb3b1o6Gi73PFXaBRlvXYQ+3MuAialKAYewPBdyBfArR9ISy4uXx9GwdsZbtEUwWDI20pXPgyPifU01lrur55rSNtLcWgC2ZGlbXk/w6DPj8X52XB1ZG2wD83WIOueCBo1oBqmC8BNmRrR21KVS63PaKRLa/wXFt/pox8TfVamsVYsavm1kfHH/JcFcNDCSkENulT6sSI+0Ug9oPrAUrfRFkCle2st+bP+I3W6LO3fGNi6bftr7qRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFbhySXgN/5CnAMqG+ZcRinQ0W+tuLVpwNykA+58tF0=;
 b=Wx4PL52lsnnEnON4KUjUHe48tzgKwwQEHwnKhaiwnItdjLASUyddylSOxEyoIMabqT1zc1WqQsWTiA7LVXXsKiKiDoQ8gbFmApQRvZKHn4a5aTre3KiGkNMzEgbSywDZrkz47HUs2iTWK62SY3FisqDt4/IjCVzUbD0vjW3z7TM=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Sun, 27 Sep
 2020 08:05:07 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Sun, 27 Sep 2020
 08:05:07 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 4/5] misc: vop: set VIRTIO_F_ACCESS_PLATFORM for
 nocoherent platform
Thread-Topic: [PATCH 4/5] misc: vop: set VIRTIO_F_ACCESS_PLATFORM for
 nocoherent platform
Thread-Index: AQHWkw1eiKshQWh5tEeFNUo8iDoDOal6jY2AgAGUVOA=
Date:   Sun, 27 Sep 2020 08:05:07 +0000
Message-ID: <VI1PR04MB49604A96195B07032826B0AA92340@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
 <20200925072630.8157-5-sherry.sun@nxp.com>
 <20200926075123.GB18592@infradead.org>
In-Reply-To: <20200926075123.GB18592@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18e41347-a426-460d-b56d-08d862bc0ca7
x-ms-traffictypediagnostic: VI1PR04MB6910:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB69103070E5FE4130B80E330592340@VI1PR04MB6910.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SQzN0AGkZT8ZSd3aVrErR3BV6fYNZK5dWABm8x3nFAiY5+jwHZWlQ7RwzWrV8jJXd028UBFsynz+1XczXzvDcDdLqNI+sPJmcLmWGchaBpMS8R1Oo2PniywmjPgYgGGuxzrMHwC5fCeHLvU+YRzigXJaZBalqUfUyctxtm7NpfpE4emg2t2iRckzLTodNaxkuEwL4XqhbqnRBWiGoMNUmRL0WqkPo0kqRZvpglgCuF7uQdSIbZan0TKN7BWtbT+2ftsWF/jZeXUR7pfYRkGtvCM1LoXk8KCUspEQpsW6zNAZzfbEtvLRAVXviAYPk6sPvPQhLYRxc+YKbPhEKyuKuPWRZVueyhRBXyyyynLREEWHjUu7MUOCRWiVowjVpJAv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39850400004)(366004)(376002)(396003)(33656002)(316002)(186003)(8936002)(6506007)(52536014)(478600001)(4744005)(7696005)(66946007)(26005)(5660300002)(76116006)(6916009)(55016002)(9686003)(4326008)(8676002)(54906003)(2906002)(7416002)(86362001)(83380400001)(71200400001)(44832011)(66476007)(66556008)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: I9szpZAxq/dNVIda1F61vXsBf19VmpIb3G7Jg5nPp2S2VDMxZIqmXlx6nOSBzHY1jjmo7XvQFQEKoKweAAm99yzZAhvv8Ux2Tk7kMbjw6A1OwNG2akZ7JnwB32xs+hcR0Vlxq+Fq8rzOZ+SMWJUYi/Q7LYXC4cuPb3oZWN6Ibd+hDq2DuAE/IoItOUp7NbfFcwbR8PwyvmPatlNJMRzPw9EHxngvPEdgYRmXmUr5v2GjUcu7DfLHr+BLoxsUbQuO1z68onCUYWaqsy/Sz907N6TOWTCr4DEaYFnSi2UyAg74Xo+ppqQQFP56uUtTyETKf3YKjNuzGSbx0OUf5+A2/IYICF7tz3xtSbvepyB0BkYWucJhWPPceTlB2pE7xmGgMTUTRiI4FP1MAL+RILNUUmgIUw/zkwad79Pejcd4nGbA6g/hmvwWdbVE+Rai9KstkFIZL6FJwLJ5hGD1nllGehYBFfT8EcBh8PG5iyQFZR41V9XtYNv7SP0gxnf+jucCPdRsGkc6cXJQZtnR9+OW0K7LCdZRj4xwg/j/3u3dsvaojZwqPUZCvjJMi4c+PIKVPTZp231/SxkMt8PSHo/efDCQkr9givPXiKgAvo7wGwX2AlrmNCy7XFykJS+rn8d0IVQWaKiQcpdFUW6WNM2tBQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e41347-a426-460d-b56d-08d862bc0ca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2020 08:05:07.7107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tl09y3ozUE1RRGoTHc8aNhDc+Fp0WFSrTqP/VqN5MHFWjHIRFiPqrPl2wynMWYgbpVpPisyWxwGNjg9XPd85xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

> On Fri, Sep 25, 2020 at 03:26:29PM +0800, Sherry Sun wrote:
> > Set VIRTIO_F_ACCESS_PLATFORM feature for nocoherent platform, since it
> > needs the DMA API for virtio.
>=20
> Given that VOP is a plug-in PCIe card VIRTIO_F_ACCESS_PLATFORM must
> always be set, as the DMA mapping details are not something the virtio
> implementation decides on, but the host PCIe/iommu implementation.

So do you mean that we should remove the check, and set VIRTIO_F_ACCESS_PLA=
TFORM feature directly?

Regards
Sherry=20
