Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA229D64C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbgJ1WNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:13:35 -0400
Received: from mail-eopbgr150057.outbound.protection.outlook.com ([40.107.15.57]:38469
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730948AbgJ1WNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:13:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmRrJWQLaLwjCfDYIWHSQpADFE9cc3bmyZx/A68uUZtRr9Ji3mb+ehf9pdiQpt7yj83N1zMaCMb/3ghonexnjL6cqlsfggR9UtHxLPaDWoG4CeStIJY/VszBHlEXEhQaA/58Ti+ixpnjXHmrfVY6T5xJbfhDDkBIX08ZDRacM6LqyLCp69PG79glamDbZXZiBZiHCOwNCD9OtmasVaTn1uw7crL0g4859/RlHXPx8m8xG85e/vMe4l+qP0MgvnaCAiIn0kStJPGKItOoOxdDb4nSVaNYuUTKINW6pjTCX5H5B9VMWSMxaIVkn1PgygakCPC9KQYR0iVCyn4fEqwiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W53cW9J774EaPVUgxlukdA7jnhKcOyo4Z7vbn/GA0DU=;
 b=XcQN9YJywuPC4mQXp+wDFnpU6Til9Y7JS/2b+zD3hq+KKxR2Ybh9AWugadxn1vWlG4U1N2DDTtue54yxuCynpDsf/Mw8sQHZPJULw7jn+PdjXxeyP4sxFZLIk0+MzXrib4b5gpW/PFEuebKutVrYoK0DQwF0eZJTJl/2T+R53PEFWa5SSn5+jI/riIPJYz0cE+zSyjAx8MoRmJOv2Sgtu/udpaDu7dnoAM7YXf7eZ9H9Y7NWJtq1vIvn+NSx3mGLtqADJY0phK+2r3M6T2Z+CLUs6O5c8b4p8f6EyPH0hxtKc5GSdzyeptddGIEh8CiR5ySLbTGWpluqKCyF4zwEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W53cW9J774EaPVUgxlukdA7jnhKcOyo4Z7vbn/GA0DU=;
 b=oJIJIy5Z/ocAoxg61PmShmF3F2U7OCJ4HmHvEdgdOz0e9fVbbigLnBeg30Xe9rph2nVQukn/3kq5VugT6m1F8A7fqD5EXJh58QIogBIWanetQZHy/gKkwoXROSCmwHlpSYrPSR0dUGJRVbw/bbvG74IRuPpaJdk3xqEx2W2upMY=
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12)
 by AM0PR04MB5698.eurprd04.prod.outlook.com (2603:10a6:208:12a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 07:35:52 +0000
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::b902:6be0:622b:26c2]) by AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::b902:6be0:622b:26c2%4]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 07:35:52 +0000
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
Thread-Index: AQHWoq98xx7XZYJdVkmeSngJp6ePZqmptLIAgAAh+NCAAQ3WQIAAid+AgAE3nRCAAApfgIAABAVA
Date:   Wed, 28 Oct 2020 07:35:52 +0000
Message-ID: <AM8PR04MB7300CE054149183918FF5C2F8B170@AM8PR04MB7300.eurprd04.prod.outlook.com>
References: <20201015045529.2022-1-pawell@cadence.com>
 <DM6PR07MB55290EA090C418457C1E293BDD190@DM6PR07MB5529.namprd07.prod.outlook.com>
 <AM8PR04MB7300C4C0BB37319ABC1680528B190@AM8PR04MB7300.eurprd04.prod.outlook.com>
 <AM8PR04MB73000CE28EC53B3402BFC5BE8B160@AM8PR04MB7300.eurprd04.prod.outlook.com>
 <DM6PR07MB552997CD8216B5AFD522104CDD160@DM6PR07MB5529.namprd07.prod.outlook.com>
 <AM8PR04MB7300DE47422D951CF74E006C8B170@AM8PR04MB7300.eurprd04.prod.outlook.com>
 <DM6PR07MB55296E10F720D4B7431663A4DD170@DM6PR07MB5529.namprd07.prod.outlook.com>
In-Reply-To: <DM6PR07MB55296E10F720D4B7431663A4DD170@DM6PR07MB5529.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [180.164.158.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 251815f7-6339-40f5-efcc-08d87b141901
x-ms-traffictypediagnostic: AM0PR04MB5698:
x-microsoft-antispam-prvs: <AM0PR04MB569812E62CF6B02ABD5069728B170@AM0PR04MB5698.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UACneNX7sOCcY0E6u3sa/23rDkg/S350Fmjbdrvvgd2ZtYBfh75szN4p5/U4QL76Wu/3FXFrjESsSu3M8QF9QfJ9BObui9msp4U+rPP8YzS9xJ4pVSFEBBGvgatjwlLDPT9elk5kmGKX9JU79cz33K92Ahj/8aoMmuwhX92uj36DTJXr8dKUL355gUqk8lIpQiPn/8XAyuDhRPmAWk/Lgf1dsGIVq4zchOVfHjbAtqbFKZWhEqyNQcZlfJdY2dKiSNO3+fI1hj/DPNNg8zUeAHxNQ4aU6pa4sLrO4dM4AV9q+xAsRsAYbD4pD5jlSTeDVB81sbNGSJEfumZQxSyRRB9dpUKPLxt4Z/zjRVJzxrpg9gxUiZRdDyO96N51xrIMJNU+lJLhmH15b00nTSd9Lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7300.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(186003)(2906002)(6916009)(54906003)(7696005)(83380400001)(71200400001)(52536014)(478600001)(5660300002)(6506007)(86362001)(45080400002)(9686003)(76116006)(8936002)(8676002)(316002)(966005)(55016002)(33656002)(66946007)(66476007)(26005)(44832011)(66556008)(4326008)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XdSuo3UYapn38m8DA4z1iI7jx/VIKNGvgcXSc3hLyuTVHRdf5vuQK/r6nJe8yXx6R65PyUIZ7px69h37QfC/6waXWoiemapiHa4D7fLRNER4Cj65/6hxzdLzxd7j4rvsP4eHleBCCxRhpQkCK6fMdf6/zRPTp/odPpecNQxrCGw+I/v88KonojGpVT59FVR+UXEpE7mxV6wCb8fCxhBoTaZPVl9xJd9lq1Z8VzjyZGPI6WqfUw73clVjPwPDu2vLOFQhBXwkvg7Vo8p9nCIWK/YMoJGv5mGIEr9eM4gbmehJO0Iqq3dUU7co+LC/KokOi8hff4gMRuJsiM9hHQ8ndIHQtBnT7ZPoK36EOZvyvgqc5DcPgh0Hy//A8CFjgB7k7I6ir9eaP/hQPuDQAF3eBozFiaEZFFdlbMyX+nRy1Rg2iMXyzpZFw2whq2GF6WGTzVSpmKQblm5gr52qPLPfkaVUTuMBHzz9XySP1Lb6kxjTOMpsrwpX/iCXD5D3RexuaCqIAtWIKFiFbgUVDM5du8zebtDr0W8Cf8VdkkYqZo0yDQDliq7dVvhpdWKmTcQm0r4RTCwlKqCogybJO6F/EDQZweP4PQgvPPm5oINP9KxlXnqp3A0zLuseiHq1/wXWCn0SmAjGI+3J5pXCrqr4Qg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7300.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251815f7-6339-40f5-efcc-08d87b141901
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 07:35:52.1497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eWdUA9beaQZZoKo6gl/Y8kTiTFfTTkPwIaDcYmcHbOjfGk6TRRBWPUITK9DVXs/2f1/P0CRmMIS3vpoZQBRUcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5698
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> >
> >> Peter,
> >>
> >> It looks like you missed the " [PATCH v3] usb: cdns3: Variable
> >> 'length' set but not used"
> >>
> >> It's quite important because compiler complains for this when I use W=
=3D1.
> >>
> >
> >Pawel, it is the bug-fix, and located at branch: for-usb-fixes.
>=20
> But I can't see it in this branch:
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ern
> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fpeter.chen%2Fusb.git%2Flo
> g%2F%3Fh%3Dfor-usb-fixes%26qt%3Dgrep%26q%3Dcdns3&amp;data=3D04%7C
> 01%7Cpeter.chen%40nxp.com%7Cc49c80ded3ec4bae70aa08d87b120467%7C
> 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637394664604902329%7
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
> iI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DjtcT0U8ZptlBSwST00%2B
> bMtCQDZDr%2B3PNMm69RrZWgDs%3D&amp;reserved=3D0
>=20
> I can see there only: usb: cdns3: Rids of duplicate error message.
>=20

Thanks for notifying it, I have updated it.

Peter

> >
> >> Thanks,
> >> Pawel
> >>
> >> >> >
> >> >> > A gentle ping.
> >> >> >
> >> >> > I assume that you should add this and the rest overdue cdsn3
> >> >> > patches as first to you ci-for-usb-next branch.
> >> >> > Am I right?
> >> >> >
> >> >>
> >> >> Hi Pawel,
> >> >>
> >> >> I queued them locally, and I waited for v5.10-rc1 which was out
> >> >> yesterday, then I will apply them, and add cdns3 patches to my
> >> >> kernel.org branch. Will update you these two days.
> >> >>
> >> >> Peter
> >> >
> >> >Hi Pawel,
> >> >
> >> >The cdns3 -next patches pushed to: for-usb-next; cdns3 -fixes
> >> >patches pushed
> >> to: for-usb-fixes.
> >> >The git is:
> >> >git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
> >> >
> >> >Currently, I only pushed three of your patches, would you please
> >> >review my
> >> patches, thanks.
> >> >
> >> >Peter
