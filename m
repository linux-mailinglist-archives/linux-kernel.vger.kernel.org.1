Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7362DA853
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 07:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgLOG5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 01:57:08 -0500
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:62277
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbgLOG4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 01:56:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhmLCXzz+xlBDAKSYfd9P7dwQ81id3SRpiQ12P2WWgX7hbbsPP+PZISrMFrYIhpVQ71KODK7qidU+IYKSCNuvgvK5roPw4tyDGdLWU/ld2aZlXtnFJHBQrjYXH+kEuJ/Bxd9q/sG+tK2+vs9pWGhhgqQz4OII5/OzZC8dL2R1w2taKXJIz5qgISOqkm2qWS+uY8HCvh0sM6ecEQl7elCeokYq6sHO12yFB7b7m36wncUQeEsXVDeyR+Y9I1sGlGZ1+SNkHPKxyI4Q1FlN86de+P4hXbVMUoLcsq6Lwmx4uy+uXeKFpjooEqyAXISyJUL3ViDMPgtwT39YudIv+mlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oAIdKj7QxAjfb9wbpYnMr4GRG2PhWSC/0yFGdwb6kA=;
 b=ksuA6HSC1lnj5NMdpmWFshKO5UInQYV1aWiJN1lAvZCZvBtLuyFdW/Alx8gSe/9miPZJrLC2luQQEQMSCT82uepbveHQukJxbSwvYSq87tYC0xLsZBq9qVaSADVsLszebq5lLsPVEuWw1RBphKQ/ieqo60fT+vGIO4oGdCMvRhTGeaxSvXoHPM/tupywD1VjnDrU659ZtIC5yCknLxsHmZlPzcdBrXG4rbenlsbNmCsdVWEkSTdYyZsDvoDOuVKX2Qm6u5asf5rH4UX7s0oQAKG106qXu0OTs/r6OWjPcTMhZs9l7Gy1Ak2IWsIKFv9mu5OTvp8S3eU7qwYXBFyc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oAIdKj7QxAjfb9wbpYnMr4GRG2PhWSC/0yFGdwb6kA=;
 b=IiM8ns/CDWE3Wt+hLIJd9aykn7tYb0Rp290o3zngf2aEXYM01oBd7DGvOVH8010nZVu2TgOLrmHAyp3DHUfiLPyZ3bmPn9LHTwWmR7/JVuxn1Vo3rxdZA4bqd1AFIS9SLpX/hhNScBj6ZSfm87kv9ug1rAlHI+rVozTl8KM8YRU=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DBBPR04MB7787.eurprd04.prod.outlook.com (2603:10a6:10:1e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.24; Tue, 15 Dec
 2020 06:55:59 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3654.026; Tue, 15 Dec 2020
 06:55:59 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: Re: [PATCH 1/2] usb: cdnsp: Fixes for sparse warnings
Thread-Topic: [PATCH 1/2] usb: cdnsp: Fixes for sparse warnings
Thread-Index: AQHW0hE5ErykXup8f0OHrdJAnR2K6an3m6wAgAAGMgCAAAmhAIAAA1uAgAALkAA=
Date:   Tue, 15 Dec 2020 06:55:59 +0000
Message-ID: <20201215065530.GC18223@b29397-desktop>
References: <20201214120344.26344-1-pawell@cadence.com>
 <20201215050528.GB2142@b29397-desktop>
 <BYAPR07MB5381FB3C8AF9039D8C30E8AFDDC60@BYAPR07MB5381.namprd07.prod.outlook.com>
 <20201215060206.GB18223@b29397-desktop>
 <BYAPR07MB5381C42748CC8276E9D21F15DDC60@BYAPR07MB5381.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB5381C42748CC8276E9D21F15DDC60@BYAPR07MB5381.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37ab193b-83b1-402f-1cec-08d8a0c67a9f
x-ms-traffictypediagnostic: DBBPR04MB7787:
x-microsoft-antispam-prvs: <DBBPR04MB778703D14CFA0464F3863DD98BC60@DBBPR04MB7787.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: le4xcOVLa+Jw+HHK0NHd2I/55AHNDbSEWnnC420QH4ew5F9qTKfjPnr0h8Z8aveu0mOQzl5NxOWeNpxSQlUiWLruq/siro2Qnava9owe+aTj6LNLDyZ5v8FtQF0DvlTq8lAGy/11NZXstXmraKDZ09rB2OzbRy+Sa1EJvDhtpiqCH3vITvPFf5q4Z8nnUDny+nVO18RZINj3mTBj6CprFQYV4VkX7xvsXaGXNOqSxaX0X2kmyyZ7OWAqyFkKrHPPwVJrKceRR+EJzHsACOubTl4qaZ+uT4YbFOdKY4y6lMyxVcE1LQgcEyCKNT7cF+9P1ZTJ17gRCQHiUDsPVweGwRhqs5KAlrBBlB5k7t2cvoT4c184kQK2VUXQHlqAwavR5KWfa+uwsD5OaqFWLDxUeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(136003)(346002)(396003)(366004)(39860400002)(9686003)(66556008)(66446008)(66476007)(8936002)(5660300002)(64756008)(54906003)(316002)(66946007)(71200400001)(44832011)(83380400001)(26005)(53546011)(91956017)(6916009)(76116006)(2906002)(4326008)(186003)(1076003)(33716001)(478600001)(6506007)(6486002)(8676002)(86362001)(33656002)(45080400002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?huXeRCqIJgSh/tmH22kU0WhPxjJaTf2MVlER4kcEFSmMc3uNnEXEpwAPonEG?=
 =?us-ascii?Q?+N1ExxD87nyg9sq4c7o5tEVjIN3eLbS/vueKUX8O0s1Cx8/ETudEsXDrfq+b?=
 =?us-ascii?Q?5dOFoIPE/nQ/BjbHBSiupyMz6OzDtYqXou5/+1VCdvw/QRTuu+DSxu27Jw0g?=
 =?us-ascii?Q?gl5sQgVS51kEyzwvlTSKEnTO/rvTz1BRwmfRxAYA+2zjXsiwvxphLwtUKOof?=
 =?us-ascii?Q?ESS2mwlV+KmjPu8TAgmrdPATiy6lr2sdf5h02ACwCgF6asJTicYBVQRbgg+1?=
 =?us-ascii?Q?ecJJQngcrU6exuBIZA28eA9MqvLA7JKpzNdpt3Wr6lvjzAOQahRfGa6w1BBv?=
 =?us-ascii?Q?NSA+jM1A53zBo7bURKnToNTcC+Dx/wbw2lU6WRAaAb+f3+qpJ60HMyU9vYsu?=
 =?us-ascii?Q?XW2IItp8e7W7WtbKbKMrrW7z4lWRUHCIBHbSesuRsvKeXM7CdmOrnJxdsrEc?=
 =?us-ascii?Q?wTlDuJOCdVzMz0WdZGEue+H0dfnaLTEyJ2Wo540YBKPJJA8da5XXmOpAvFIv?=
 =?us-ascii?Q?jLrEO+qYwkJQMdXPQNNWKfC7wob/IfawXL3e1i+lPjvk8HuW9TMF0bgGTEjK?=
 =?us-ascii?Q?mDx8BAVSyOgQJMjLW0WHZxJvVWIoR0x8aXc1agBM17q5umwXeaXf6wBHBb5g?=
 =?us-ascii?Q?XvyFgduj4qX6+5B8pdS9w1smJR/EY1HqNwy1JVMobIV2MhcI2KPFaJppnbAW?=
 =?us-ascii?Q?X062AENbSszcoUzeJrhX/nFy2aRm2pTDJPPPkvNNrtNw1y6l53UoJbKBbuzA?=
 =?us-ascii?Q?JYG9Rai84ItWCmxhsLZP6VOV9kdBB8Yf3KY7TZKXAuaDaxp/f556Ar1TbpR7?=
 =?us-ascii?Q?uCp6Rk6xXdjgX3K+vdP5J6VZoOfw/QajQpI7AEkaK1wh8imlTN1R0Qagt7vc?=
 =?us-ascii?Q?rr9NjTPvlXb9tSnNsz5QPRtXs3DzwAdqQmeKVvm9fHgJqXo1qv1ictSg5p5q?=
 =?us-ascii?Q?yW+SPcJZzw9lhsUe3qexntWK86n9PZ6969Nluob2YGRlNpebwY72RwyMdKCq?=
 =?us-ascii?Q?LNGi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30A7C3A0F7ED8244A65862E9026232C2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ab193b-83b1-402f-1cec-08d8a0c67a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 06:55:59.3006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3iHhBwyI2mPPcjUStsuLQ8L0wD6xTsAuVrLskTkTEUVpu4N6EPIyB5/gPU4RuL9b0A9p2oqOheAGLM97P/DUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7787
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-15 06:14:07, Pawel Laszczak wrote:
> >On 20-12-15 05:27:38, Pawel Laszczak wrote:
> >> >
> >> >
> >> >On 20-12-14 13:03:44, Pawel Laszczak wrote:
> >> >> Patch fixes all sparse warnings in cdsnp driver.
> >> >>
> >> >> It fixes the following warnings:
> >> >> cdnsp-ring.c:1441: warning: incorrect type in assignment
> >> >> cdnsp-ring.c:1444: warning: restricted __le32 degrades to integer
> >> >> cdnsp-ring.c:2200: warning: dubious: x | !y
> >> >> cdnsp-gadget.c:501: warning: incorrect type in assignment
> >> >> cdnsp-gadget.c:504: warning: restricted __le32 degrades to integer
> >> >> cdnsp-gadget.c:507: warning: restricted __le32 degrades to integer
> >> >> cdnsp-gadget.c:508: warning: restricted __le32 degrades to integer
> >> >> cdnsp-gadget.c:509: warning: invalid assignment: |=3D
> >> >> cdnsp-gadget.c:510: warning: cast from restricted __le32
> >> >> cdnsp-gadget.c:558: warning: incorrect type in assignment
> >> >> cdnsp-gadget.c:561: warning: restricted __le32 degrades to integer
> >> >> cdnsp-gadget.c:570: warning: restricted __le32 degrades to integer
> >> >> cdnsp-gadget.c:1571: warning: incorrect type in argument 1
> >> >> cdnsp-gadget.c:1602: warning: restricted __le32 degrades to integer
> >> >> cdnsp-gadget.c:1760: warning: incorrect type in assignment
> >> >> cdnsp-gadget.c:1762: warning: incorrect type in assignment
> >> >> cdnsp-gadget.c:1763: warning: incorrect type in assignment
> >> >> cdnsp-gadget.c:1764: warning: incorrect type in assignment
> >> >> cdnsp-gadget.c:1765: warning: incorrect type in assignment
> >> >> cdnsp-gadget.c:1766: warning: incorrect type in assignment
> >> >> cdnsp-gadget.c:1767: warning: incorrect type in assignment
> >> >> cdnsp-gadget.c:458: warning: cast truncates bits from constant valu=
e
> >> >>                     (ffffffff07ffffff becomes 7ffffff)
> >> >> cdnsp-gadget.c:666: warning: cast truncates bits from constant valu=
e
> >> >>                     (ffffffff07ffffff becomes 7ffffff)
> >> >> cdnsp-mem.c:762: warning: incorrect type in assignment
> >> >> cdnsp-mem.c:763: warning: incorrect type in assignment
> >> >> cdnsp-mem.c:928: warning: cast from restricted __le16
> >> >> cdnsp-mem.c:1187: warning: incorrect type in assignment
> >> >> cdnsp-mem.c:1191: warning: incorrect type in assignment
> >> >> cdnsp-ep0.c:142: warning: incorrect type in assignment
> >> >> cdnsp-ep0.c:144: warning: restricted __le32 degrades to integer
> >> >> cdnsp-ep0.c:147: warning: restricted __le32 degrades to integer
> >> >> cdnsp-ep0.c:148: warning: restricted __le32 degrades to integer
> >> >> cdnsp-ep0.c:179: warning: incorrect type in argument 1
> >> >> cdnsp-ep0.c:311: warning: incorrect type in argument 1
> >> >> cdnsp-ep0.c:469: warning: incorrect type in assignment
> >> >> cdnsp-trace.h:611:1: warning: cast from restricted __le32
> >> >>
> >> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >> >> Reported-by: kernel test robot <lkp@intel.com>
> >> >
> >> >Hi Pawel,
> >> >
> >> >The Reported-by tag should be above your Sob tag, I will change it.
> >> >Except the patch reported build error by kernel test robot, I will ap=
ply
> >> >your other four patches after finishing the compile test.
> >> >
> >> >Peter
> >>
> >> Hi Peter,
> >>
> >> I'm going to fix the "usb: cdns3: Adds missing __iomem markers"  today=
.
> >> I haven't  seen any issue on ARCH=3Dparisc. Maybe it's some specific r=
iscv arch issue.
> >>
> >> I believe that:
> >> [auto build test WARNING on next-20201211]
> >> [cannot apply to peter.chen-usb/ci-for-usb-next v5.10 v5.10-rc7 v5.10-=
rc6 v5.10]
> >>
> >> is not the problem. I based on  peter.chen-usb/for-usb-next.
> >>
> >> Also I can't open the url from kernel test robot report.
> >> Maybe there is some temporary issue with server.
> >>
> >
> >Thanks for checking it, I have already pushed your other four patches.
> >Besides, there is still a build error issue for new cdns3 driver.
> >
> >https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furld=
efense.com%2Fv3%2F__https%3A%2F%2Fwww.spinics.net%2Flists%2Flinux-&amp;data=
=3D04%7C01%7Cpeter.chen%40nxp.com%7Cf036cd7630664c9e0c5c08d8a0c0a637%7C686e=
a1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637436096594708469%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C1000&amp;sdata=3DDLBFVB2px5GgA6Y%2FTU4DrfVru6z3P4RXz2x7BSpdE4o%3D&amp;rese=
rved=3D0
> >usb/msg206073.html__;!!EHscmS1ygiU1lA!X6rYk64ILtzjyHW903LAhBRjMKi9C2eyJW=
EXVlEZm0ly2BiNzY2wK46Ulq7q5w$
> >
>=20
> Did you applied: [PATCH] usb: cdnsp: Fix for undefined reference to `usb_=
hcd_is_primary_hcd' ?
>=20

Applied now.

--=20

Thanks,
Peter Chen=
