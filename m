Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB20279F72
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 09:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgI0H6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 03:58:34 -0400
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:51527
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbgI0H6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 03:58:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjtYz//SK5ljY+blyB3Lt4eoEvIl7S1+nIuVmzkAsrgeMr8rAXPEjTffwpuQVIlZsaD7rsRllU7nm4rWFN4yk4Eho9RbJF+WFAPTBUTOtczUYd/eCz1siD4yBHIruMG4356Y0YtwGYfKLPTe0KAQfZokfWLtV8O7jdjGZo+wnsBn6BYB8JJVSDzOt75GC5+5bvggzkDWQyWJg1r/+SIKDMIDYuXpbC4h+8cYfZ5Unk1xDElTcbU3nQiOoxaXaPDfYIewcbdxQ8m2+O6Q4PvmC4OZ+imhXuQ4hk43c2StbnNDxOptR4yFqxOGt5g7IX9t18Ggm19E3M1WEJULLjXKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuQlMDRi1WP1wgLTBxzukZp1jHCeCfHPEMPeLFNfyVA=;
 b=RBf6NJpeLM0OoGK0XcMZK21upmMgs4+bibbaV5d/N1MIVdt2yCwe5XpeOHEEOfRGw///dBSdtavw3uiM6ENILGR5ZgAEVLuy/1SJKiKWprOsgnQ+n9x+uPfmmhuiquPfWkmEl2xPzLWlDZXv48xu+tUXhS/UOtOQHwAvR1+gr6L8PiFJ3KqeZBo18ge5vFyupI7HkDYz8aL3N2JquDPApuM1pOyIKOq8ci0Scvr/KUGGQlz37IfPjyNNg20QXpCei93l5HNaMuH7lAWDUBlR0F96xzAY3LkxYBrHslI55lpfHQnZlmnChcnufYe0HdrX+T4PAi0s/5a7hZyF5iP//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuQlMDRi1WP1wgLTBxzukZp1jHCeCfHPEMPeLFNfyVA=;
 b=DRozTGD+OIark1WbpADAt9SrKCNLBGeVEVFzAwM9oFr37e+xmkoEiRaYte2cdeI3D5TfB8OwZCiL8Yr9RLuidUNTEIFVg5EN4mYf0jYsJyhpKA5uTV4dMGUdctJoBegi81rknHaDsVj9ZJhy1saviV2ZoEoB6GiYgtTzR5maWc4=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB5392.eurprd04.prod.outlook.com (2603:10a6:803:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Sun, 27 Sep
 2020 07:58:29 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Sun, 27 Sep 2020
 07:58:29 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        "huang.zijiang@zte.com.cn" <huang.zijiang@zte.com.cn>,
        "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/5] misc: vop: change the way of allocating vring for
 noncoherent platform
Thread-Topic: [PATCH 1/5] misc: vop: change the way of allocating vring for
 noncoherent platform
Thread-Index: AQHWkw1Ua/wMKuww70uQvYAscuCr2al6jTyAgAGOkqA=
Date:   Sun, 27 Sep 2020 07:58:29 +0000
Message-ID: <VI1PR04MB4960DC1E64D65634FE76C7AA92340@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
 <20200925072630.8157-2-sherry.sun@nxp.com>
 <20200926075015.GA18592@infradead.org>
In-Reply-To: <20200926075015.GA18592@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c7fcfd8-27f1-4f9d-f5d5-08d862bb1f52
x-ms-traffictypediagnostic: VI1PR04MB5392:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5392069944135F040429D78792340@VI1PR04MB5392.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mhUpw3GHBrn8Y/GvbLrfmw1OAEuXY1w80Ac6UqAQ2dAX9aAQSPniZP+Zb58NXdXpuzhIqx6GBZl1Z2TpmjT1i2nLbLssUzYNHBdULgL+STixv+OhW1CjsoNSzyVksiqDHs3HcSf+jOst51Y5McC/xSJT7DKijt9iyIEtuPeA5jYIpDzChYlcVp9IpNO6Eua+7HwgSjImtGCfj++let8KMt0D+VzXI4OOLNCK3pgR//nt8hcxI5lr35dsbMWPnlJFzUhM2QlHxjkMCzl/RZtwjW6uJf3fk8KDFdhBLwr92y2jWwJgfgeqNgZKo9up7iA+GOojrSCJRyD4J8iwqE2XoS86+YPGU2eD07FLJw6oTLhT9cDrks0bWC5uLaxVqCZ3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39850400004)(6916009)(7416002)(55016002)(66446008)(66556008)(64756008)(8936002)(71200400001)(4744005)(86362001)(66946007)(76116006)(52536014)(5660300002)(9686003)(4326008)(33656002)(44832011)(478600001)(6506007)(26005)(7696005)(2906002)(8676002)(54906003)(186003)(66476007)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: iLyPSNVPguC4K24JsCFiUTtTHovVVOqRULDxgs6F8eZMkM7Yhnupq8T7tMff9206Lu/GDxcDi2IwtPREjCoEnwvY2DCh6H03B2p9Qc5agf3luEKZPF6cBD5Kd6pqVGnTs+cY5ZaSneHKPaCo9OqbE3ZJI3e/RubBQmonTb2Kl1jrGOZ+3fbSvHtPJSQePxcvUUYpvOfYMMKK96+iYImAynrwvu9m6l5AqNFLBzJ339c1AA/Trymjk9909TfdPMAq1iyaRXCmdpiY/slJtB6vprj0dEY1xzdMjAeujbCbKpqxpaps+qGnArIkJ2xxLGF5uVrALKWd36JTMsWarj07vX8RzjmB5B6wALZVq72KBm3umn/miSI+m2FdvZtDVlEhwP0GS+y5XXDwA56ICSOmu6cUStRGNMqhVx5ofimS+8s9R3OAdqQ8KyoubCIaFGN49KrBMZDYdZyeLWRX0ypFaM2w6vS06W54oNTKQb0GJTOalfqs7ZQti6UgZc6w9dGaEYP8UJ1rfi2gUMa9gxVQtubSCPN22mi+PxqvB8QysFINPXPd7egQffWQByuusbHSQAuYG5O8wuclHN0gyy6Hp2aYxu6W33uFjsR4DVW6qmQ+L7fwwycD0jQFq7E+hapkk44gdOEz7an+kjO4gvN32A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7fcfd8-27f1-4f9d-f5d5-08d862bb1f52
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2020 07:58:29.5173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kt1lV8VWJYnr/OYBofqp2wDrRxMer1SMaEhb9aBXZEwYHegMsQz81vCzgY9LnETuZN/+mCQ4SCQ/A4jdfv9LRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5392
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

> > +#include <linux/dma-noncoherent.h>
>=20
> This header must not be included in drivers.
>=20
> >
> > +		if (dev_is_dma_coherent(vop_dev(vdev)))
>=20
> And this API must not be used in drivers either.

Thanks for your reply.
Can you explain why we cannot use the API and header above in drivers?
And do you know if there are any APIs that could replace this to check the =
device hardware dma coherent support?

>=20
> > +			vdev->vvr[i].vrh.vring.used =3D
> > +				(void __force *)vpdev->hw_ops->remap(
>=20
> And you must not use __force casts without a comment explanation why
> they are safe.

Here is the original code, I moved the original code into the if() without =
change it.
But I think  this is because vpdev->hw_ops->remap() return type is void __i=
omem *, but vring.used need type void *.=20
Maybe this is a workaround for Intel MIC platform, as it reassigns the used=
 ring on the EP side.

Regards=20
Sherry
