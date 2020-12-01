Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4A32CAABF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389368AbgLASaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:30:04 -0500
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com ([40.107.244.44]:31361
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbgLASaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:30:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH8vUv8bp5KtW48+0rksXd/MsEGamzoEpGNSJmP9yTwMMi6WdOPojdJRGWu0nUWSR/j6XBSU+HNRxj9ltWp8DS7KVqp81+b/3RqJO3zyzedXqd41vueqlDy7XvHMgRKoAcJmIoTz/yeMRmXzJ4IwSBXArYjLzXCU9anD2zl13r18XyTUC5R6AhSZSftXX9wjGrBwt+y7T5tuyLHGg3xNS6xWsFOn8LJRt+cjRzGO5NImG/bDE0lxfPI4uynqVRuHHj/iQ20JTwJtyxpqbXpda0xHlZBxRtZS/qTvVCEHXEzIBqdX0rY9veUwusVRhE8E/OrNtOJua0/W0we1+3xntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9iM8h2nWONhphMaZLKNfspgeeht94KWSuUyZA+Kvfg=;
 b=MAjh8COJ0pgLtXqTRmiIoTjSNmWcxkFDNUEJcCspzYhV6FmRtbeT85FhSG0sjyvfNwNy3ZtQWLmSWAt4SzRGAJemzLS4D8sYusqVqBZLpXvFGxmSbXRIrV9d7ps8vkU6iwsiMli99zfTeAF8Gr+5aXA404EGfpktiNf+rvVTQOLw8Zc3EdVRC9D0/rpUXYfyJ5ZFkJoszyX/YIEheNpCoVqsMmi04SikafWRoz8uvlMvKq9dsM2haptKAN74uKV1PvmDZn1yQgVoSpB61SQo+rKLHWYpg00A2zw5x94+kMNwdet9uHK9iRZnBG11BuEeyiGFMGlCc88H2QdN9bfjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9iM8h2nWONhphMaZLKNfspgeeht94KWSuUyZA+Kvfg=;
 b=kL2kU9n/YKsuvTNFPYejK6uSZnfF/URTsgGaQLqW/byN2wG5k/pjzeB5j9piaXrUD42T/dxmNUB5fYZZh5OYBUYC05NzbcA4lnOm+uBbyxlHmnAnFgfAw8oDDg1BQS+alxZjrZcXagkbflYR8eIvpAya/fl2Uv/BULh/4GFM/z8=
Received: from SN4PR0201MB3472.namprd02.prod.outlook.com
 (2603:10b6:803:48::19) by SA0PR02MB7114.namprd02.prod.outlook.com
 (2603:10b6:806:e6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Tue, 1 Dec
 2020 18:29:10 +0000
Received: from SN4PR0201MB3472.namprd02.prod.outlook.com
 ([fe80::91b6:5ae:e8d5:2d5f]) by SN4PR0201MB3472.namprd02.prod.outlook.com
 ([fe80::91b6:5ae:e8d5:2d5f%6]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 18:29:10 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "adam.r.gretzinger@intel.com" <adam.r.gretzinger@intel.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH 07/22] misc: xlink-pcie: lh: Add PCIe EPF driver for Local
 Host
Thread-Topic: [PATCH 07/22] misc: xlink-pcie: lh: Add PCIe EPF driver for
 Local Host
Thread-Index: AQHWx22M99FnN0G2AEyj/DspYqPKuKniBkKAgAB+d4CAAAvHUA==
Date:   Tue, 1 Dec 2020 18:29:09 +0000
Message-ID: <SN4PR0201MB347233BE24CFA81C4E2B18E4CBF40@SN4PR0201MB3472.namprd02.prod.outlook.com>
References: <20201130230707.46351-1-mgross@linux.intel.com>
 <20201130230707.46351-8-mgross@linux.intel.com> <X8YXMVD1i90VWaPa@kroah.com>
 <20201201174542.GB56560@mtg-dev.jf.intel.com>
In-Reply-To: <20201201174542.GB56560@mtg-dev.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 667276e8-a6cc-405d-d29c-08d89626fecc
x-ms-traffictypediagnostic: SA0PR02MB7114:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR02MB7114990DFB979311FE6C03C0CBF40@SA0PR02MB7114.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9KEVmrDo7oZHiMyanpvjAgIp3AiNjQz3X0E4fU2o+VuXSc4EiRnOqi+OPNQfSfo3OQnp3W5+4BPJIdz/8Me4VkrVZKXAEZhhhHG12dZEGQC1xeWQLF0SCrYnSTs5FGyGX7rZx9S1bZyAH9jtP7rvn6k8oKDuV0PKxMoFLhEak2i+zYRELToPSGuW3jmCgv2tkGq32x4SfvAqsuQZPSztrUEd9bFeFSfRMg8WpDcE6sPFmovf+nYrAz7k4HOonmtTlkWkAuO6PVElVLz4t09zpBB6of10LMRUnS+fPywVctK+m9fIGoYxirQt9PvSb4Fv9tCaO+xUyPeO9duYySCc2h4JdYj4dqPUTg0fniP2jpJsg77LPTb16Tu9EuYz2Q+c0FPCVNtuyPBXxogY2X5KTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0201MB3472.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(53546011)(83380400001)(6506007)(8936002)(55016002)(66946007)(186003)(71200400001)(7696005)(76116006)(33656002)(9686003)(64756008)(66556008)(66446008)(2906002)(26005)(66476007)(86362001)(54906003)(110136005)(316002)(966005)(478600001)(52536014)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+6GFOEgZj/bdF+++CA6uv6IyCfp5Y4haNrV26HuzXjIzG/Z1MIduQ38FmsWj?=
 =?us-ascii?Q?Zzmttw0jiYP38Nn6+kItEkX5BMv/0snMgzZagtv7rGfalq4rTUSEuCzQn1KJ?=
 =?us-ascii?Q?SfFStz6oI/UqD/+MkSxrgNFV9Yzq8msUmhPqIfxxz6XyAk/ZcPOnmij5sSBE?=
 =?us-ascii?Q?Ldt3fqDqjqdrWIgoka9MIMsGqyvO63YtbypBNO2bllWoINg99RZaXso8bJ59?=
 =?us-ascii?Q?5BawIDfR6DXwZlc7tPe9JylbZ0eOQ8kpLIPKAtz6qfXfZh6LTiucOYqWbAYE?=
 =?us-ascii?Q?d8DLrNJYx3v1Vu6O2dz84eQu68pcXcQ7KmATf+JG//MUpAElh7MITZwlgonG?=
 =?us-ascii?Q?xBmFhcIyjkYQR9GZ9wDS2DL4x56wz1uWIX34CsYlU0qIAtDUXijPsRnXAtdn?=
 =?us-ascii?Q?IF2AYLFOtBZvFfVkZKjg6JDaQwyRwCHH3gXZRR5ym1L256F8vNTME/gxGbeF?=
 =?us-ascii?Q?iuwFHgItgdd3zbRg4gZkh91MuqzbBlWWbuePetRYl7oNgoCi0Z4mPZ6801ow?=
 =?us-ascii?Q?oH6EAw/t30zbXcw68Mk2/YMeyqUrfEV9Ld3hK2/yydFoP83OrZCvQvzHg+dn?=
 =?us-ascii?Q?pDRNy25/VPA1UpxWRSG+pktAxSkeIvK5mr6p2lnawpMGgQZB41FqttST+02F?=
 =?us-ascii?Q?RBMnGJhucVc4/p7ryNXy9NW0ynkx0HBvqxw+l24I6b6nzv3+uV3LaT/ofVKU?=
 =?us-ascii?Q?+/IIWx5waSM5i6LS4fu7p7fLreeDaadc7Usc8hN48wDE59Vtp2t7hsMYbrch?=
 =?us-ascii?Q?PrYMQ4dDAhDI/H9oAeRRMeJon1KXHMtrmQjUsJGZXHMs/SSnfYH/2RSJMI8G?=
 =?us-ascii?Q?VaV/IEGYEvcPjGuTdKhIlZpWAbJpmtH830rwJNhGwMK7KOPLwHzN1gCvWn/7?=
 =?us-ascii?Q?siqCyams/I0KA8Mxx6cgz9oxq9o/I6dqMA2+NXIJjVgSJ0q1B8TfvRvaK6aU?=
 =?us-ascii?Q?0StzQktTcP3lsBHApIX6F60GGNFwzHtCxd03Ht3Hl28=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB3472.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667276e8-a6cc-405d-d29c-08d89626fecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 18:29:09.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4AzRJEtwYRgOZVB9ln0yei35WCtTWUJLzpAEB+OqE8VUlqzkI4ndmyqbeDOlnWoW1rwFfDzEzY+6E1zRksbtpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

You should remove me and Derek Kiernan from CC list, we don't belong to thi=
s list.

Dragan


> -----Original Message-----
> From: mark gross <mgross@linux.intel.com>
> Sent: Tuesday 1 December 2020 17:46
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: mgross@linux.intel.com; linux-kernel@vger.kernel.org; markgross@kerne=
l.org; adam.r.gretzinger@intel.com; Srikanth Thokala
> <srikanth.thokala@intel.com>; Derek Kiernan <dkiernan@xilinx.com>; Dragan=
 Cvetic <draganc@xilinx.com>; Arnd Bergmann
> <arnd@arndb.de>
> Subject: Re: [PATCH 07/22] misc: xlink-pcie: lh: Add PCIe EPF driver for =
Local Host
>=20
> On Tue, Dec 01, 2020 at 11:13:05AM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Nov 30, 2020 at 03:06:52PM -0800, mgross@linux.intel.com wrote:
> > > From: Srikanth Thokala <srikanth.thokala@intel.com>
> > >
> > > Add PCIe EPF driver for local host (lh) to configure BAR's and other
> > > HW resources. Underlying PCIe HW controller is a Synopsys DWC PCIe co=
re.
> > >
> > > Cc: Derek Kiernan <derek.kiernan@xilinx.com>
> > > Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > > Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> >
> > <snip>
> >
> > Again, you sent this twice?  And it never got to lore.kernel.org nor th=
e
> > mailing lists?
> In my excitement of sorting out my MTA misconfiguration work around I act=
ually
> hit entry without including the magic fix
> "--envelope-sender=3Dmgross@linux.intel.com" in my git send-email command=
 line.
> >
> > And I can't see a 00/XX email anywhere explaining this, and I didn't ge=
t
> > the whole series?
> https://lore.kernel.org/lkml/20201130230707.46351-1-mgross@linux.intel.co=
m/
>=20
> Did I mess up on who all should get the 00/xx email?
>=20
> >
> > Something is really wrong on your end with your email client
> > configuration, please fix that up and send this so that we can actually
> > see it all, and know what the heck we are supposed to be reviewing...
>=20
> Yes, I think I have it fixed, or worked around now.
>=20
> sorry,
>=20
> --mark
