Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8A2C84B3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgK3NJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:09:25 -0500
Received: from mail-eopbgr80098.outbound.protection.outlook.com ([40.107.8.98]:22948
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbgK3NJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:09:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sfuzbl8RsycQ1lmQwShesYSL9nZpkMrR6bCvMt6YxwabG1168Z8jY8n4cTIpxJRwdONioWGEWk81BkO8tMYdV/ky39LQin5V50YZbGyeRaKuzlxTI8JJq1Ztp95zPkudFita6SLupZl/hklfao9tiIKYPS2zkwyNpU6bMpC84vhCqzOmFfHQ9SF6ynAtQV1gsUKBF0g1mAv6O5jxanP5CgGuMRbhiVU16tn74BeC6C4T6krhPaNHt2oVaMAZ5WYgX+NvaBOLMBeG6sh7QEYsTxfAOXorXxFUdSCn+vYaw9VNGx38VtsueBwWXQJj1E7jkoIbW3yJ7OZEiTjVBfF47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnaEcD49T30Qd0YLShxcfIhqdo0Ea1MuEwc/QvCUV4g=;
 b=Pn+6ZDhMs0ZYa4A5RiPn36RCxXC7Pe2YXpqNBcZtP0MeMoOq76bcXB+HKYKAz/VYgBxa9xE38I4ZOe9W7LOAYzIuQdsYPXpcVEpbuTZqBgorcWKll5KcmmfHGl2uT98TRsoSVdks6ZGm8yVyOLLn9RAfwNy7X5MVLQ9L1jkKZjcg81mLGhSUmJg3Bwtp7m+gIYfh6D/gVSfeeZOmbn6qdtroZjgGh8PMPXM5lW7Pdr9UyEnLANCABZLjABOZbm1BdxQe50KxJCfKbg5bgQ11fBXZMchznRURhQIGjgzJjkoC/dPLcw2FKF9EhdN7moYeqcGKvpmFl2Ze76f6QbKAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnaEcD49T30Qd0YLShxcfIhqdo0Ea1MuEwc/QvCUV4g=;
 b=dTInXQ0kSls9H4rAwzcjpdAyI4w7APMPEwmHhQO8gmY0Re7xHt5VWqooqnTrxYYWYZqaSuMXvTM2WH5NzxmyWIuIDruBgMg60VHiHnyTsnBSv0xGuB8NyoGSHKt7wd3Qs/mM4YzFiobr90fdIf+yIlpMCCkUOqUhiyRj+/xoIso=
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:4a::29)
 by AM0PR10MB3362.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:160::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Mon, 30 Nov
 2020 13:08:36 +0000
Received: from AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887]) by AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::593f:e14c:7db4:1887%6]) with mapi id 15.20.3611.031; Mon, 30 Nov 2020
 13:08:36 +0000
From:   Michael Brunner <Michael.Brunner@kontron.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mvanyulin@dev.rtsoft.ru" <mvanyulin@dev.rtsoft.ru>
Subject: Re: [PATCH v3] mfd: kempld-core: Check for DMI definition before ACPI
Thread-Topic: [PATCH v3] mfd: kempld-core: Check for DMI definition before
 ACPI
Thread-Index: AQHWu+OkIu811TJCPUavMPQe+vS/XqnbrQMAgAUPBgA=
Date:   Mon, 30 Nov 2020 13:08:36 +0000
Message-ID: <a3da927c29198afcffd16f5cb50014b1c1d8a922.camel@kontron.com>
References: <981276386ec1b496b423b7605b7ac912884b7172.camel@kontron.com>
         <bf70506e5aeb87889b298e342f96bae0e2187102.camel@kontron.com>
         <ca31b0f1638d07f5c597c652ed887a3ce0f595aa.camel@kontron.com>
         <20201127075330.GI2455276@dell>
In-Reply-To: <20201127075330.GI2455276@dell>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=kontron.com;
x-originating-ip: [195.243.149.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a4c2623-470c-4572-5e03-08d895310c11
x-ms-traffictypediagnostic: AM0PR10MB3362:
x-microsoft-antispam-prvs: <AM0PR10MB3362CFBB1CAB9DC9756D5A4CE3F50@AM0PR10MB3362.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FplEyrmH16UTaj6iMU/y+R08t/27dyXyKDu2dyhjpLAXlRY1A+QuvBxGNyX2cRZqIuRHpwBzV/PAsh8VXhhZP17e597LsnDuShgmvIb498e7HqMqwAG/ImUG0XXedPJnEKU1jT2KrJSwwH1cQV9t33XYo5DUMyJvmy4qQtNGkk9bAsabRvx+h4O0iLtBOgDu5kLzA2dkt65ItzqwpJQ25n0PWis2nPMEq+u0u4UGVxvlS8/bwR6u3zD7nsK9NIGcLYbSmNf5aN7S64vCVZem2p9P+tv8PPiyfE6AvRr/uom+H+ylQPOkPRbcED+1r7I0Cs6n/hazZgwc0zC7csSnGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(26005)(6506007)(6916009)(36756003)(8936002)(186003)(86362001)(54906003)(4326008)(6486002)(478600001)(71200400001)(2616005)(316002)(2906002)(91956017)(66476007)(66556008)(66946007)(64756008)(66446008)(76116006)(8676002)(83380400001)(4001150100001)(5660300002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-15?Q?yx0w0t4ixoAI0Pjo5/O7LuVFW1NzMGoNJ4nc6gI/re8XVdqUHzvpvWyC3?=
 =?iso-8859-15?Q?Yp1eAtJ0EExpWkYI0WN80QhdV5dnmg4Wsp5JzB6ymcsRIiUrlryhziv4b?=
 =?iso-8859-15?Q?fvotqnqFjh2W7pgaGnwSe7wo0iG8eL4ISdGMO+jjBIj2tYN5nbW59JVaQ?=
 =?iso-8859-15?Q?wR+6ZD1lzn/BpvDRDfQNYwo3s6SwHDmgyZ/Qkhfe3HC2Ox+20t6IDfDxl?=
 =?iso-8859-15?Q?vVu1S216KxDbzCXYhxDNsSt20DKH3Z0RHXF3LFrZziV/rudtB1MxpFvSf?=
 =?iso-8859-15?Q?ocS6YNh+WK3EUzoZ4YAkyKqa+sFMRyR1Naa1mcoWHHvJbgcWISYIUc6rg?=
 =?iso-8859-15?Q?XNczeKEUl64D5Rxcd3666Onzna2/HMTSYhyFs1ctjWdKTogCpQHo2CR50?=
 =?iso-8859-15?Q?AoJSC2S2CdW1gLc/xAZCTi18F6nWJ9UrbPd58I4owmUT3VspEMMO1A18L?=
 =?iso-8859-15?Q?uRataBUfzm7KFyptjbIBaIDEoaFbaNjI/Jw36dQb2PmARSx47h+Zg7J0h?=
 =?iso-8859-15?Q?4XUp4nMHT2hQGweRREn2cg2cxC49/hEBqy0m2Q8f8m3JBAH9tjxEvratX?=
 =?iso-8859-15?Q?8fZviO3g6vX7bProbEpqvVZjcN/ixO2UwlOU8KGcMqjzsni8YHdSwXKZ1?=
 =?iso-8859-15?Q?kNBlFtY5MOhFj3Hi1iw1FNLrvDT1D1XDfpMgKnNIIgIbHxxfdfMVimd8r?=
 =?iso-8859-15?Q?XU0PbtpAUKxdYPp9uFG3YVSp6jNpuFR6XhCy+LwnoL4hQ+PI/Tm2fLy7S?=
 =?iso-8859-15?Q?FfUqvK8vPM69H5QK2xyriRkTGD0x3ERjjXTObMEo33F8zeqQnW7ZUE75D?=
 =?iso-8859-15?Q?er5HZar1kuvMbDJ/A7UYj1Rt+I86PA2Mq/EvBppLX0RZdV9+HzrKeENRr?=
 =?iso-8859-15?Q?MLVomeOQxQtnjPRMUICqmtAQCzQHDWB+Kuo+8h9UdgkmAoSgi+nDlBGeA?=
 =?iso-8859-15?Q?Wl3tIZIMOfWPk1xO4G4zH4567oXp2vHQlI1BzNKTFpUYiQ1T/qwq4e8QS?=
 =?iso-8859-15?Q?us5aJV9TYpX3GTtVXIBVkh7nn/RC2FnFvkJ6sIQ7dBm54jHfxfXeMKD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <77BAAE2FCF19914796D1848806F05C99@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2098.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4c2623-470c-4572-5e03-08d895310c11
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 13:08:36.0516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kd7aEeAJcPU5XaFOYekqXlbcXz8S5He9WTLIOtXl6sxFY9a8PkBtaTH20GQnh/BQSSgpbCTxfyvjQEDgvcAk+NT8yXX/IHBKo4GC/viWcH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3362
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-27 at 07:53 +0000, Lee Jones wrote:
> On Mon, 16 Nov 2020, Michael Brunner wrote:
>=20
> > Change the detection order to priorize DMI table entries over
> > available
> > ACPI entries.
> >=20
> > This makes it more easy for product developers to patch product
> > specific
> > handling into the driver.
> > Furthermore it allows to simplify the implementation a bit and
> > especially to remove the need to force synchronous probing.
> >=20
> > Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >=20
> > v3: Cleaned up comment, added Reviewed-by
> >=20
> >  drivers/mfd/kempld-core.c | 24 +++---------------------
> >  1 file changed, 3 insertions(+), 21 deletions(-)
>=20
> Nit: Just letting you know that checkpatch.pl complains about your
> patches, since your From: address does not match your SoB one.
>=20
> Patch applied though, thanks.

Thanks!

Regarding the From - I guess it is because the upper-case letters. I
will check how to fix this for the next time. In the worst case I guess
I have to adapt the SoB.
