Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB7D2F5874
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbhANC2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:28:20 -0500
Received: from mail-eopbgr1320054.outbound.protection.outlook.com ([40.107.132.54]:65248
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbhANC2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:28:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDsS33B2y8skmP7ISeKBw9egZRCOtlFRPEj51EO0oLgsP4aEZJZ9gX2GigFHoT6V4DwMg1AhryokVfvuWcoCmXgUekxG3Sav0zjdPkhBBLgCGnajAc4UKtkHFMLl5Tpe5AksFox+thR0N8w36bijmLGvpsa/dsFoA00HCAivMViovHS4K8oRAml2yR5308d94rT6AMb9n9Vs5ZPX71UXEF4Vct6BvLhRzn3jcGj/2aI8FydK4sxoB7p0S4Mix6rATw08QeBDBmnppOJ4KGjSyEC3HneyJgFwJUBEWLIQVfIbcCn4EBzFBte/3KVxdcWwYgK5FhQfi3PBxZdVSiGNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffJNEF6T/qXBvwcRzp5cGi+lAHbNa7n8uJ0ge3aiKN4=;
 b=lHVF9HP554Q9biq6f/ppXU4a3RdnnmTC3GT341YOoLXp9BvWyyCvz2mfrF3D4NZCZbYnSF6iIG0F0pHnumHsSnVM8AQCygIPgRCn1ZjZENwr950wIuHJw+klIryv5ubTy6bgHA7w2nThH/zjUCej4x4HCNgHWkEcGTcvZTpev8zo29E0VHTyliWpIVqMbarO06r+ldSASqxYP+xVl9PeGLgjuFqV8LKUonv+9IaJ88fKF6XGBLlouSKJ+LEOwnjivJeLgKGdVX8Hi3nKNp8QdsjEI/Sae4A/3PmDKuzkuizHriz6FO1k03S+jYMqt5iqFMUVJHpXwLd3lkqHbto25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffJNEF6T/qXBvwcRzp5cGi+lAHbNa7n8uJ0ge3aiKN4=;
 b=jd60VPXfFrLNCyGBbtXUPfB7N5GEEnVtO9vUrdDYK5cgbIgBodwZW8zj1tRnVIGGQG8Y58h+5TfURbRGuwsjvW3BIsiS2O2xRkT1lX3ub0OMp6WATFzV2WWxQhWL8HM+bHYfnx6Ohsx+2p8rqGaphoymd7CbRpkRspkWv83OV/U=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB3145.jpnprd01.prod.outlook.com (2603:1096:404:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 14 Jan
 2021 02:25:14 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::8453:2ddb:cf2b:d244]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::8453:2ddb:cf2b:d244%7]) with mapi id 15.20.3763.010; Thu, 14 Jan 2021
 02:25:14 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] mm: Fix memory_failure() handling of dax-namespace
 metadata
Thread-Topic: [PATCH v4 5/5] mm: Fix memory_failure() handling of
 dax-namespace metadata
Thread-Index: AQHW6g5QoGBA4uCuj0q8fctl6YAQ5aomZN2A
Date:   Thu, 14 Jan 2021 02:25:13 +0000
Message-ID: <20210114022513.GB16873@hori.linux.bs1.fc.nec.co.jp>
References: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161058501758.1840162.4239831989762604527.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161058501758.1840162.4239831989762604527.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61664edf-f746-4f5e-2b39-08d8b833a00a
x-ms-traffictypediagnostic: TY2PR01MB3145:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB3145E35C038FD22C72EB9892E7A80@TY2PR01MB3145.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pnuM96uB2RjkTzJ/VmP1wH6kZkLJMroMNCLfbWdXXDRk6xjrpuoupZ1x8Nbw/dwU/P7JN7ndCSKxFyUV9G3p0gYNEXUQIJo488d+xjEoCowPGUGdbs3py+7m/wgvaO5uTQGSB8GwetSg5eIJFy8bZTdr3XhCeM1/0IvnzBWWZSOz9LMiZka+UNnPBQrAdvnVSSMwcliGv5kFsW3mzO/0gr9ecF4KrSglHu4Etpms1fiVh8YemXxliZy9WnhVhJ6hj5arcu+MWVXpkS/A7vGYZE+V5eQ9DPm+ua0/7jjidw74873qoM1TiHeMbZt5jNPT50JjGMI2bpQjA9r19apL/YTjamubF/+gGafvCjEA85QtG+dJc1qbQ5evY4xLQjKy++yEy0Vf26a5x8l79VbOBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(6916009)(8936002)(316002)(64756008)(33656002)(66476007)(66946007)(83380400001)(2906002)(1076003)(54906003)(85182001)(66556008)(4326008)(66446008)(55236004)(76116006)(9686003)(4744005)(5660300002)(6506007)(478600001)(8676002)(6486002)(26005)(186003)(71200400001)(86362001)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?akFXeGxiM1lxS2UySk12S21rWmVuemx6Q1FjYkM0Q1BGbSs2QVcxZVRQ?=
 =?iso-2022-jp?B?OXhqaEc2RTREQlI2anFGNEZzQWFaYks1c2NGOW9GcWo0YXUvVi9UZDJN?=
 =?iso-2022-jp?B?YmE1V1d3cXJJVXEwanp2MEhuMjB6SFJEeUJrOGtPa3FMLzFURlh1NHlH?=
 =?iso-2022-jp?B?OGMrUmticGpheDcwRFZlTGFWNU5wLzlBM2hkaG5menI1elpaL1lTZUhu?=
 =?iso-2022-jp?B?MHBBZVBZUlJoanNCUnJVVHFoZW9pZVA4R3d2allRSENjUE1IMkRFZnA2?=
 =?iso-2022-jp?B?ckMxaFU0S3dRRHVjbDBNaGtpV2tBRHhTbTlwVDNtc0x1ZTFBZ0RjMmZo?=
 =?iso-2022-jp?B?UmtOaVdLZ1FMOWw4WnlzajBmaUMvSzU0dlRwTk5XbmxGUGFqczNmV0VO?=
 =?iso-2022-jp?B?Ti9VNFluMFNYSURzR2hQc3FObmlFQW9tNzF2Wm9aOVJ2dE81b3QwOHF5?=
 =?iso-2022-jp?B?Y3NxU2JXWTZsTHJwd2xmOHRnekV3ZEJKdUNiNVZFdUdwUjdOekd6Tm9J?=
 =?iso-2022-jp?B?N0Z0Y0JkWlNwQUlnK3BzamEyQWpGeVgvVVUvRHhVZ1l5UVlSWW1RaUtP?=
 =?iso-2022-jp?B?QnllUExFV1VWYXZMRjdyWld1TkJmdGJZVWZ2ZXNZUDRCWjVndGZ3aDQw?=
 =?iso-2022-jp?B?QUZHcXRXTWtEa1RmRDcxd0h1ZmtLdk5weG5wMjVOTEsrT2ZhQXJCb1VF?=
 =?iso-2022-jp?B?dHNFdUYwaFkyN0RHYTdENmJ3UlAzTXhtOTZZaWNlc2EzMjhlb0J3ZEJt?=
 =?iso-2022-jp?B?amFxR0llYkhXbU9SR05pQXNQVGNhaXpnRk4yTlVZcE1LcTdUaUwwVGxo?=
 =?iso-2022-jp?B?MDJ0VitJVnhka2tuL0Zud3F4VHR6REVvTFRPY2NFUEF0akNXQmFoRE1H?=
 =?iso-2022-jp?B?dXhUVFk1VEwwakdaT3RhanNSR1hSdDFia3c2eVgvbkx5UWRCd3FPS2w5?=
 =?iso-2022-jp?B?bGgvYjdzS1N2MysremtXWTVncFhCQ2FLWkZKR0hFRVhYYUNqLzYxNGhr?=
 =?iso-2022-jp?B?UGxZam9TY0ZtODRIbko2dk9pUEVhZG1QQWxKVktpd0ZMSnpGeGpYR09I?=
 =?iso-2022-jp?B?SFlPQ1ZvL2Z5U2Vsa0UyOU5ZdlNvSVBtNVRqUEE5T3R2dU54SncvbVVm?=
 =?iso-2022-jp?B?K254NFBsWUlTRERBc05Pb0JlckN0SExVT0Jaa2hkaTZkVnY2RUZnTUVY?=
 =?iso-2022-jp?B?d2pBaTVpRDkxMmYvK1VzREJRNlpnclFuTk52NUJkM25oNGpqSkgzTlJv?=
 =?iso-2022-jp?B?MEs0RVhpTGgrenUvQU5IM0tUUVVDLzlxOEFRNUQvN2d1SUMxbXhkRjhv?=
 =?iso-2022-jp?B?TmI3T1lUK1c1ekhNMExydnppckExM1ZzWVArb1VPcVhTdWUyckIzbEMw?=
 =?iso-2022-jp?B?ckxrOWkyOWFNTWtIelJkUXN1TitxY2d3TGp5K25ZeFVsVzhmZ3ZHaUxW?=
 =?iso-2022-jp?B?NWlnQy9WODJ5elZGWm1OQw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <72F2596AEFC7B74AA8DFA159589A0421@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61664edf-f746-4f5e-2b39-08d8b833a00a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 02:25:14.0029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SAJfhkYLaJGOuAI40QDi8gnI+YEyO1D8jmJE9MR1WgZmPDFhD9GdABhlkbwfiRLqt9CSDfAJebNloJlGgRKFdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 04:43:37PM -0800, Dan Williams wrote:
> Given 'struct dev_pagemap' spans both data pages and metadata pages be
> careful to consult the altmap if present to delineate metadata. In fact
> the pfn_first() helper already identifies the first valid data pfn, so
> export that helper for other code paths via pgmap_pfn_valid().
>=20
> Other usage of get_dev_pagemap() are not a concern because those are
> operating on known data pfns having been looked up by get_user_pages().
> I.e. metadata pfns are never user mapped.
>=20
> Fixes: 6100e34b2526 ("mm, memory_failure: Teach memory_failure() about de=
v_pagemap pages")
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks fine to me.

Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
