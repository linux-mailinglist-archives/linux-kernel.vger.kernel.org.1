Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E422D3F67
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgLIJ7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:59:46 -0500
Received: from mail-eopbgr1410041.outbound.protection.outlook.com ([40.107.141.41]:44278
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729211AbgLIJ7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:59:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7wGI0dG1/oXBUZELfmt+NjRFynku8gTfMI5mJGgwoG5hJT7ZLAuITUEPPhSbY7fWMOEhMUM0djstItG1prboU1zyFRuo5tMXc4119Y3ISmwca8AFSLu3DN9ytUTDcmiaiXZkD1NfD7FQ1V6zIyO5zUAzHJ2J4sRlkZzI8Y2Fzhj1HjwPMQt/Fd59BmXmZKfhbch3wuWCMhz6M1XbUHJek5THxY/wvx1NoAgN2Yj5Y2qL2DPcFpwZtjGP+D2F0rHgbJspOxqMNgNmJW8Mm2xEOpXkpH9eCLyWVNCKQi6TqOiPtRqE7R9UpdFulQZrKgtGRoIERR/lR4RdLAp5Qo+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhCckU8xo4Ex9APxvs5kmKM/7QrlSmuZzDuZyYdcVCk=;
 b=fJ+3La4VjTDyxfVGCJRl6oSKGQeTp3hPeBaTLAai7nJpJha7tCRGTcM1SEEd0MaDgydre4IBWmcSaaLegLfNkxTQF1LPbz3kA82fAcaVoTOzB/6svq49U9Y95u3TE4PJtxKHls2Y6Fc48F/KnyUhE4T9WsOMWC47T9/gJY8pTrHzNJbnKw809WcfAj9nx6E5Xd9EPqUpE1g6XhRfDeqqBTq2lnT3jpTJMIwKNULKRylggMMlF+ZKW+j7bRPhrTYVXo0lITzanIh2HxKb9GvrS/XoH0LyEc1pSkBGJb4uLY3m6Uhz4qTzuRIy2+QJr7xPuOxkqBYAGN+RWnDEeI8e+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhCckU8xo4Ex9APxvs5kmKM/7QrlSmuZzDuZyYdcVCk=;
 b=tTe88rNihbam/9Tr+zVmg2HQQ3fFW7uc7EaXa7s0aeouP3T1FEpzdjA2pD1xWi529VthWRWwRr9wLFGQp8wmKO+Di4g8seo4ZTE+kxVhACem7hYV8LhbqBbEngXqav9bVreCJCwfeFHdjSrTZomqD8qBqDrWZE3+90DX39wTAfw=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYBPR01MB5373.jpnprd01.prod.outlook.com (2603:1096:404:801f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 09:57:22 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::8453:2ddb:cf2b:d244]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::8453:2ddb:cf2b:d244%7]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 09:57:22 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,hwpoison: Return -EBUSY when migration fails
Thread-Topic: [PATCH] mm,hwpoison: Return -EBUSY when migration fails
Thread-Index: AQHWzg2sNArUmf7c2EugXD6uE14QRanuh0UA
Date:   Wed, 9 Dec 2020 09:57:22 +0000
Message-ID: <20201209095722.GA24928@hori.linux.bs1.fc.nec.co.jp>
References: <20201209092818.30417-1-osalvador@suse.de>
In-Reply-To: <20201209092818.30417-1-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2e51b35-ecd2-43d0-c9a1-08d89c28d33b
x-ms-traffictypediagnostic: TYBPR01MB5373:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYBPR01MB5373CCE246A71EA16220AD49E7CC0@TYBPR01MB5373.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mIyxraAab8GEY/MXhdtgPeT6mRpitEZDxb0wL+ZhMN5gayIqyJYgvIBvDXKtp7L7RjjhYoOWAcDBszZYmCRPsjbfr9o/efdtyMKDxneU2unDSa8Bzx0A36jEcl/z+NaB9VKuCnb1MDjQ63BAT+w9Jc44eM8GGmKQPct2qcXPdkbdf4PAY/ZQzBLXuuZrm8tMk+9NlHhz69p8gD7hxmTLkxQ2n+aradNRGxeAJx3EuYL4MDqTfxaAeAiQtFcJA3HUxFkEvXAztSnqF9hYocqJy+3lg5K3DM5on3DTSXUolUq3p8YK5583PeW444pellENdjuxWWcgZ1MzTUjZI0Z+pQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(66446008)(86362001)(1076003)(9686003)(33656002)(5660300002)(8676002)(4744005)(2906002)(8936002)(6512007)(85182001)(66476007)(64756008)(71200400001)(66946007)(76116006)(6486002)(478600001)(55236004)(4326008)(6506007)(186003)(316002)(83380400001)(26005)(6916009)(54906003)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7COBPUznqRhPvmKljXezecxx9T8+WFerylFRL4q2zr9i3yZGuEeU0zccaoTMmQt7DyhqzljRcQSEqdFU0V5tZWWno1TR909vs9551zAx0s4Zh7LoorDLfmCT3sqie8osaCZcjGPuOLgopjMrm4q3brzVRz0M2EZq+bWXL0D5VNllcSsWaaA+gmGfknMCdV9GSR0pCfWYFuD8xw7U08Gdj3lJExnhbTKpuMvBDWu/4qyc4ad4kQya7HsFiFr3OdSlJSkcI0E9z+yZBMzmGJxxZ6IUykTnuR5/W5Q3LFrndHQ6kMuzsT0gRnhyCk+dCxt/1AuRN0L+v7YUZ8pHDkJVem69pHG9tXUcEgkhW4YWeJZh/DBigLFmF9rEYU4UkvuAIIu5J5pKsX7I+OWMgQS89w==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <81BD22A132507641A10BB735E4B74152@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e51b35-ecd2-43d0-c9a1-08d89c28d33b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 09:57:22.8921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rXWJ7577SlyKfeOJL5LZgumFjLFn+Jc1OzUA6e4WShgCEUADH2O8moxAGhW6Gx+RNSWl1UfFGOwu9p6GfreCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5373
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 10:28:18AM +0100, Oscar Salvador wrote:
> Currently, we return -EIO when we fail to migrate the page.
>=20
> Migrations' failures are rather transient as they can happen due to
> several reasons, e.g: high page refcount bump, mapping->migrate_page
> failing etc.
> All meaning that at that time the page could not be migrated, but
> that has nothing to do with an EIO error.
>=20
> Let us return -EBUSY instead, as we do in case we failed to isolate
> the page.
>=20
> While are it, let us remove the "ret" print as its value does not change.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
