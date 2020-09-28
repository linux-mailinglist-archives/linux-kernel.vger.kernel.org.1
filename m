Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F9727AB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgI1J5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:57:39 -0400
Received: from mail-eopbgr30081.outbound.protection.outlook.com ([40.107.3.81]:38525
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbgI1J5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:57:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BurxD3t/hD83mTcGjMNj9sDDy0OYMFGPOsVPqusoKOYvjwdEE/h03vbO6Sa82q695kiyrYaCqma48AmQWqsVu4zj9in8jJD/UIqu3VnPPDdsujAhBTj8EZcVYKsUwIiIEgRywLAw1Cwa0ruoK/5bTcJ8Brn7skx30ua3R/0RZcv7A9wzrluRNa/H8SE03Y3U1MARtfs/M7Yd30Ua7howdQBgbg/N/+RTD2sydduvw3iOxXqlxwfq/Fw4yGTERpX9NYdA6TdFEnPseByCaK9HDzF2aVwSEwMQ7mCsrUoNolxrY6YhasM0uWawYJ/apMFvu1m5l54H87fpgQvQKxsrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DS+kA0E1Ad2VIKyDLJ06aTKS7O0NP9aNoQ+NxoeH3Pc=;
 b=SuU13upBhMniXR5JaAiRk7XsMLkGXuXuBjBbtyInrKiUCXQAgQYTg7ayJ0sEtEIIEFkdhFVhXRhCauz5KmeM+efaFHyzpAXF5AYl4MopINO66Nz+DNyNQSTL3W/ruwOZ1tMzIZypEBE9cWIspy35/JC/kb0trVaWx7rueU5kZb92whxteC4iL+qwj3Yd0gzUzDAtAllqlBM1pM92nUUaER1FFkkah0ZydTaGWKTe88zWjHIBVdHWKV1r/EfagLSRNr7t+O5eZhU6HfYBfYROFJCVt4xoHyHF9P2V7/j4RpwjvPZ7EXx4A1YlNEpxG9R1p1pj4oxt8bM2SNpkCqfGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DS+kA0E1Ad2VIKyDLJ06aTKS7O0NP9aNoQ+NxoeH3Pc=;
 b=K4sLAt3VIcbQ771mRZpw5UGMq6swgjXIyVONXtccFRfrS88kjdYpYamjQQopY/u6ixzzrUQa9x+EWTNLNHhrpXLLwqLSxRM2wwwm9QOOt2IKCWiXfewrY+nS2t4a+tRUdwe2kIIdYCCr1ZFWIvBVgjnkuA9zs65MV3Mmqnj8730=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB4253.eurprd04.prod.outlook.com (2603:10a6:803:3e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 09:57:36 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 09:57:35 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 4/5] misc: vop: set VIRTIO_F_ACCESS_PLATFORM for
 nocoherent platform
Thread-Topic: [PATCH 4/5] misc: vop: set VIRTIO_F_ACCESS_PLATFORM for
 nocoherent platform
Thread-Index: AQHWkw1eiKshQWh5tEeFNUo8iDoDOal6jY2AgAGUVOCAAXPPgIAAPxeA
Date:   Mon, 28 Sep 2020 09:57:35 +0000
Message-ID: <VI1PR04MB4960189DE174E393B470AAA792350@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
 <20200925072630.8157-5-sherry.sun@nxp.com>
 <20200926075123.GB18592@infradead.org>
 <VI1PR04MB49604A96195B07032826B0AA92340@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20200928060917.GB9387@infradead.org>
In-Reply-To: <20200928060917.GB9387@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 445af7de-88b6-4c8f-bd70-08d86394ed3e
x-ms-traffictypediagnostic: VI1PR04MB4253:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB42531422E0123FABB7D6ECE592350@VI1PR04MB4253.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D+kK/HSBgW3NwJMYb1z1x0JHKJfJB+ONreF6bwR/yxblHCBk0tQ3C72v+tpcW3ptm8rGuWY3qmpbMhikvpfaG0lhrgNocISTg2GwMeVOU+BLPi+YSXTsBsoyoBnT7kIbhF2+BS9baiH62S+zbz/4Kf8NJlzHYVQSSvhfmU8lYy9+FkJhVVwl1q14SFsIdQj3NCStB49oLpOmmrazEHMb0w83y6hwj0kyplWstaib353Lt6dDkbqyIDNX8fM9RNCC2dCvCNgj5a10PPyhggw/mYMpPY8aHFDrRoDCwenEwT0m6HTXoQeSYgp2wyq+BvswE5mOrgD0cKCnjaXHD4SoLTm4jVZBgOOo/50HPsLbn0qUYHfY/SsnK9KvhRryCCxR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(76116006)(6506007)(8936002)(66946007)(64756008)(66446008)(54906003)(8676002)(71200400001)(66476007)(66556008)(7696005)(5660300002)(6916009)(44832011)(2906002)(26005)(4326008)(478600001)(83380400001)(9686003)(4744005)(33656002)(316002)(86362001)(186003)(55016002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PKIRznD9+/zRTxMw1TsyTC8bSh5LlDkvgVddI7KGZ0oxUrtFWmx6nxbEabHbsek3+Ut7jw4flEGOCoLvz1L22s9uGlGSkvTTZXHq7escMcIi5OLj0riYVeXqgA+ahgMCaEVt3ftIw5tC9WuzFRmkwJtVrWEqWp8WNcWo6CVp49KDvi9mzVGDzW0EiFaxUk3yisIQ1ybAtgbqPuhANGMOtcFMD7EX5tspbsdVfTa8HBB7wfq5WoR/G67E3eCZZbhfTk30YiqoFFx3s2+Rcv8kCiTi0Xg4dqBjf4TTCvEVTeu/bLKpIGZL+rpGZ+ikX+CjtWIdvNlDQRJxgzBx4H3APxpij/KezMWku27eIUunS5JdZkFNzNEHaq88Fyivn11AiudwI7H3o7gE3gTHa9NxcPbQGpyLLhYf/SkHX0jjzroYHdwBETEn61h1w959CaqM0lGBT+6mkdyDHwgHs73AI6pjmh/hhNyxS04W7qovLzXwA8L/gBm/ZoS4HI0pbAOC+sVas3Tej9yxUPL6YGttsx5sr1vL5DNyRvN6wdfL+bPQPH96J4ifL5DmabLI03adwkAdMPlxb/s5tDIS3Pp8qpANCit9jBo//C5fqQcpARHcfSYEomGCGbTayD/LZXrZCZ11u7Ecl8fNfIljtg2xyQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445af7de-88b6-4c8f-bd70-08d86394ed3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 09:57:35.8197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNHBLwpJQA5y/SAey7G9KSqEjNHRY09zxH9lRfLBDov5USWz+pQtuZgp+oSALBHY7pxKm6CRh1BTFdNSgHbRNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4253
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

> On Sun, Sep 27, 2020 at 08:05:07AM +0000, Sherry Sun wrote:
> > Hi Christoph,
> >
> > > On Fri, Sep 25, 2020 at 03:26:29PM +0800, Sherry Sun wrote:
> > > > Set VIRTIO_F_ACCESS_PLATFORM feature for nocoherent platform,
> > > > since it needs the DMA API for virtio.
> > >
> > > Given that VOP is a plug-in PCIe card VIRTIO_F_ACCESS_PLATFORM must
> > > always be set, as the DMA mapping details are not something the
> > > virtio implementation decides on, but the host PCIe/iommu
> implementation.
> >
> > So do you mean that we should remove the check, and set
> VIRTIO_F_ACCESS_PLATFORM feature directly?
>=20
> Yes.  In a separate prep patch.

Okay, will do it in V2.

Regards
Sherry
