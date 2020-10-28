Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9429DCE5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbgJ1WVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:21:40 -0400
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:52450
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732057AbgJ1WT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:19:58 -0400
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12)
 by AM0PR0402MB3859.eurprd04.prod.outlook.com (2603:10a6:208:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 28 Oct
 2020 10:33:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GELYLNV/nZpykfplDctSNaIYhvrEoaIpV75qlXdQzk4fWtzkBvZWGyEyQFUqmEEBvsVOuFsuG84fZExvkO7/BbszqIVDglhpppq0/jAcFUW3VVuBsOSOG+/rJnzkt8OfvF6n+HV/s15bV1NqreOQCYdvHxhYsihF79jP6Pv2pkAX7VmU5mUzTMNIOS5CR7IKctcfH2d9vyjF1V0iBAVHrMw/B+9foq0mX07rjEdcr637FFGGArNZvvf7UbqR+zOFgOpwb8ev4iMT6z7h7LCIvy2J1FlBWdCAdllac3UGSfboC6ksHSxEdHbCZFTyNcnftptXkiVswnHC/qBH7sTtYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XILSxZlOgF36J4j2BwJl4VnHrMt9Mvyt66hFCYQbDoc=;
 b=nY53hzI1jhi1vBERwCn7vlL91vZ/J7chHtYBf4XGIzeOwbvAZ2B5DpePPY5AodaSOp50BJ7/uHA5yfJvVmGOblPf89qfL6sbK6JY5LnlWEYfwj/wNAsPofijE439AjTLa5ERGfs7V/uJlYH58KIXwoxewE5tUHbMsFosUtpOon+gtYqhLHR19WhyGvSZaHAHHy/E7Rzz0jImc9piugC7jV0T29yLSvoM/+ep94+pGQNQx592T1W00m/JjbGG5UJzr7uW4GX8mMPsblObd01dSLJz0/6UIuaYrtrN5uB8rpMM2fZaAjlmLsfowRUIQwDkdpq3tfXNmx89IPpGhFg/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XILSxZlOgF36J4j2BwJl4VnHrMt9Mvyt66hFCYQbDoc=;
 b=bAWoTOdqL/gWoK/FDLc9bPdV8aZL6Eo8E01xjL3e7uBDkmbZK9Tf+uoP3f518MA38aUcINluVq4S37wJOXqaufTQa7yJtf5nKLHaDciq5QGXD7UllEc32pf+2IRFQIKNPhmg+bI2/ii7IXp1cbEJUBOOIlslBmBHWwxuVJlfex0=
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12)
 by AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Wed, 28 Oct
 2020 06:44:41 +0000
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::b902:6be0:622b:26c2]) by AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::b902:6be0:622b:26c2%4]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 06:44:41 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v3] usb: cdns3: Variable 'length' set but not used
Thread-Topic: [PATCH v3] usb: cdns3: Variable 'length' set but not used
Thread-Index: AQHWoq98xx7XZYJdVkmeSngJp6ePZqmptLIAgAAh+NCAAQ3WQIAAid+AgAE3nRA=
Date:   Wed, 28 Oct 2020 06:44:41 +0000
Message-ID: <AM8PR04MB7300DE47422D951CF74E006C8B170@AM8PR04MB7300.eurprd04.prod.outlook.com>
References: <20201015045529.2022-1-pawell@cadence.com>
 <DM6PR07MB55290EA090C418457C1E293BDD190@DM6PR07MB5529.namprd07.prod.outlook.com>
 <AM8PR04MB7300C4C0BB37319ABC1680528B190@AM8PR04MB7300.eurprd04.prod.outlook.com>
 <AM8PR04MB73000CE28EC53B3402BFC5BE8B160@AM8PR04MB7300.eurprd04.prod.outlook.com>
 <DM6PR07MB552997CD8216B5AFD522104CDD160@DM6PR07MB5529.namprd07.prod.outlook.com>
In-Reply-To: <DM6PR07MB552997CD8216B5AFD522104CDD160@DM6PR07MB5529.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [180.164.158.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb91fe56-5c77-43b5-ab14-08d87b0cf2c3
x-ms-traffictypediagnostic: AM8PR04MB7300:|AM0PR0402MB3859:
x-microsoft-antispam-prvs: <AM8PR04MB73007990A2EC41F71DBEED1D8B170@AM8PR04MB7300.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yqwqU5iF3Rub9kVmkPIso4wxd9Ub6grf2Cf8UhlcENFDT5d8htrllrFP637WPZYgfnhS0fZzDtqUg2Ramut+H4RxMljwXd0ce3mY8wDYH9KkKwY7yMvLefYMxzwhEv5XrN3Hvcmlt7tLpLAvgawUa4bpDc1oRJDEIB5oue3yLNDVC/XakBFqRE1QDfMMIgVUb2gO5C4cCwhMEi8aQZXGvMi/cz3QLhUjB7il4PSWDd2/5ttcGshdw/7+IBMLYiIKhlzSzai3jrRjPJ8mbnF4UBr6dP6426ogr74XA6hi1RKLdz+2HOQdmxnlNo11c2iYudcljy6flVd6ZTDEb+nV9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7300.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(316002)(4326008)(66446008)(76116006)(44832011)(478600001)(8676002)(6916009)(186003)(86362001)(9686003)(54906003)(8936002)(7696005)(55016002)(2906002)(83380400001)(71200400001)(33656002)(26005)(52536014)(6506007)(66476007)(64756008)(66556008)(5660300002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: sAqGXxYwRVOOluys3nqcThUHQu+tss+S8Evgjg7Fll+USTVbt7Sr89mEfUXvUPrnyLEIAe1pOoBlee0GbduHIVN02l1Q5XCdyJUpr0bGvN39eJG80d5zccugQHm8VRHtl9lOM7BjcYSQfK57CPkz0qMXUfo4Ws1Ddj2OiTb1YYkcP8lxcoBtmyLpxALnbRj1mW64p0paJK0Yowgc5YzUvpkQNkjJXVecNIHawgVA2r+gcUFJURQ7YMeocxW7t+B8XXIEVWlwHLiC7MmFn8sso2/R/3+nDFjDJaw553s/C7YamZCxaLDMsa+2K7H8v4ugCcTCTQQp3TJzcVFa425Nsni/jYfVACS16MasImfl50lEte1WBbCLl7qGO8ve18qjfYoA+mo+TNmSWutM2VhlSaRIWOG1sbSIGqTDmI74cJ3Thx5EFBEat5BeEI/b4BfBWYbeAepwbfCHmxK1bO0IOnlGF/Ra1FsXSau6x2jXs3iF1V0ujNsDbQacAFm8OhIpbZerCrsNug5d/Deg3Rm7LiWlc05PgHdXgFhu9dFYL0zjfPXED7SPkCnd0ad36oXjrA1g9ZzgIDCwVita/N3EKCxVT9X7j1b7Jd9n2eTs74ugwSnnD9bWooBrojbwXDOEiQs4/3rGiW/vv/4Jt5eJQw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7300.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb91fe56-5c77-43b5-ab14-08d87b0cf2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 06:44:41.5160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19MOSkQesyM9o3fzf8E5gotrlazwcADIjBVm9KMB/7Qr1aye3UZ3sp78tmVMHLyzdqbF3R0pxFKm+FO4UZBNPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7300
X-OriginatorOrg: nxp.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> Peter,
>=20
> It looks like you missed the " [PATCH v3] usb: cdns3: Variable 'length' s=
et but
> not used"
>=20
> It's quite important because compiler complains for this when I use W=3D1=
.
>=20

Pawel, it is the bug-fix, and located at branch: for-usb-fixes.

> Thanks,
> Pawel
>=20
> >> >
> >> > A gentle ping.
> >> >
> >> > I assume that you should add this and the rest overdue cdsn3
> >> > patches as first to you ci-for-usb-next branch.
> >> > Am I right?
> >> >
> >>
> >> Hi Pawel,
> >>
> >> I queued them locally, and I waited for v5.10-rc1 which was out
> >> yesterday, then I will apply them, and add cdns3 patches to my
> >> kernel.org branch. Will update you these two days.
> >>
> >> Peter
> >
> >Hi Pawel,
> >
> >The cdns3 -next patches pushed to: for-usb-next; cdns3 -fixes patches pu=
shed
> to: for-usb-fixes.
> >The git is:
> >git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
> >
> >Currently, I only pushed three of your patches, would you please review =
my
> patches, thanks.
> >
> >Peter
