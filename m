Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458562F2CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392922AbhALK05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:26:57 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:44680 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbhALK04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610447215; x=1641983215;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8hgXHFVj9jdN1dC22UqNTl7v3OuT6pA5JkfJf1jf6mk=;
  b=jOTTwpLAwJq/IGep2Th146fm0PLVi2uWuFyleA5A485JoUjkLLAOoLcI
   lNCkFsSmmQ17zaM5wpO2xUurtlSijgdkFq9XY9LvfrJsXcgV9oqtGySlD
   RXeV+8sF7QYWY1d9OXypRg4kWBBpFcJUTdIX4hVHaWDA0c/K8juth1Wgi
   53ziVdu4RxK3bAEAPiNcL+w56ZKEsoCpS2bLvRQWzvoqPU1z2easKzPR9
   s/wdj5iwCufWTn5Q8ai+N5e1WTmk75y7n6HABCb22Wjw0K8WHk8QCUu05
   5U5xK/8ZWs7KLX9y2mQFfthI/NZZKipUDNB3QcPrVG8Gr91Wq6ZDZ61A7
   Q==;
IronPort-SDR: my2snvVTZ/2pewrBOKDnCtTPOoK7yWet5kvPKAGUI/7v1lx6jYX1nWkiwib2JGfst0IOvJfAtf
 EjR4AkEg+X8ftVvTSOMOR4pg/rf7LZAGWJDQaHUaBh4mFDoZiYXHFSUCfZ1X5750Qd5L2h289W
 OuYKIYlyQVHu5ZxHCva3gOApE4BZD/nUm1/AZQ0eXoYzLl3HhQIHbr9XNN0o/S4H3WC+CjfLUJ
 6Gf+kqY3LonCBIlBG8jSEJnDEVmgdhpcWuHvEj7K7OoDt290O5D2VplVNnBk9QaGCYTs4msN5r
 V/4=
X-IronPort-AV: E=Sophos;i="5.79,341,1602518400"; 
   d="scan'208";a="157229841"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 18:25:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4o3YkIJ9kO/Kh0tJaInwYtrzh3KAx6OK9D9WcuS7M/nHcxxzHvHLcWbuOOO4wByQKHnNWQm9k/Nh1Ja1OEpBaBIhU8mMqPzVH/a9DcegITQW07sZjLK71Ek3SoJfjptTYcZbCniAyXDNkxdkFRaOKnEO4rnWgD7T/lOthlw4GEYust29tY2LuDsBaJsMpVSoJCntmu/fte6k8cOm2WK6ewfgCd+Fh/uIKGglRAgg2TgEuj/utMSm0uJ8i0CRrsF7qbUFvhAEgWADG+eHz4qlyBmaY4L/us5Rv0r181Vfaq/8xlqlNNrvDbhMY73sEwvbPFGqKju+0UvgzBmnApB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrtoN2WZT+uQ1K4FDJ+581/CRvWQfvhwSsDwsTQN16I=;
 b=itehv52b+Qn73zxvuh4m1v6sfLXPxVkBHMcLr/81j/d0BpuTOfA5Qe+z1VocUU8y5vnr7e6KbmV7x8TvTIb+p+r7rEFIQW3Fx2ithIZ++vRipv/iON8xc6Xq3pkp9IqSFJkCr2A89PhfXOK/GZly1Vfw5i708iCsUCWFKx3UIAD3iyvFImPAkjD7prr0OQe5IYUpzfnJ/7uIXl3lF2Xpx+BTeXfisXIXWp+xPWTK4sgh93ZnHt2RXAXic8CvHRSDwvKTdXtDosE/3GQdu7j/gISpVreq4PJwq9/mgHolblECznwSuGPewcIU1HumV2Jjf7HidoIz5KP/TL+pQO4edw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrtoN2WZT+uQ1K4FDJ+581/CRvWQfvhwSsDwsTQN16I=;
 b=PCFQQed+vY2Nr/WvO2owvBHqxj4IMcvAt5F2Ily7SfdKqBBBLS5UrjPRezJk8Qy1sM+8bdG/Q03/W+qXpt4jhOQ0AjICwPjdG3an9Khjxay93k5PTtlcxZ+owt2Cf6F4LMm5qi6wF56lqtG2EPFTVozSl6FQ10aea4NxWuhB0iw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2317.namprd04.prod.outlook.com
 (2603:10b6:804:6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.10; Tue, 12 Jan
 2021 10:25:47 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 10:25:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Duerr <Hannes.Duerr@duagon.com>
Subject: Re: [PATCH] Documentation: document dma device use for mcb
Thread-Topic: [PATCH] Documentation: document dma device use for mcb
Thread-Index: AQHW1VNtJdHAqbA+GUiBSPaNCFHmVg==
Date:   Tue, 12 Jan 2021 10:25:47 +0000
Message-ID: <SN4PR0401MB3598BF89CE42A243113DFCA49BAA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <3bdc8f76b30c2b0e2a2bfab06c2e73797ddc9384.1608305690.git.johannes.thumshirn@wdc.com>
 <SN4PR0401MB35985663FE8EFD62AD7B42B69BAB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210111132659.1b1543a0@lwn.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lwn.net; dkim=none (message not signed)
 header.d=none;lwn.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:480d:3d08:9ab6:e110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5051e6a5-daab-4b88-c43b-08d8b6e46d54
x-ms-traffictypediagnostic: SN2PR04MB2317:
x-microsoft-antispam-prvs: <SN2PR04MB2317A294EC95979DF1638FDB9BAA0@SN2PR04MB2317.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5kAMMIF5FJotHtAueDTQA+zq2Eb2UAudBKEmMv5o6+kg0bF42jbhn3QQKPvKCuUZkYPEYfshKNjZDLUhnDwQrApMl7AGT0KqOZS8NB+Md3EYDLAgKdQcSleBGU7NS54ce44VBkUGw2M/zT+8xHaMIfy+vp38dEMsrIz4Z8zTY0GxkERbQUTu6f7wQBlX4QicVih6NISbRYkvoJtRmzT0S+A8ykOnXjY4985t/s7aADUKIM7g5iijUCI+0buLqd+0kJfaoxjV9dofQ2dbrP0TlnQ15u2nSaTj6l0DQEB8xBeDjsEgUnbfeRqGzB8TAz6MKAsawLjRtu6T6wjCI+ZVBbU7h6fUJ6BKscQKYd3+Y3zXo0JsoVKFwOdW9UyEeK4oG4OcxCBaRpJQnizHUvqixQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(498600001)(64756008)(6916009)(8676002)(66946007)(55016002)(7696005)(66476007)(186003)(66556008)(91956017)(71200400001)(66446008)(86362001)(52536014)(54906003)(2906002)(9686003)(558084003)(6506007)(76116006)(5660300002)(53546011)(33656002)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lopxXe/i2+ViAdaEBQ9AJ3QPcWp5gpRxB2nYgDaWg4zR0qQ+WZYzQ8hwnbzp?=
 =?us-ascii?Q?lJi8qrWVBY8ahG7Usq+gHb+seG2jQ/GsBGTarkGnyOmjWuIYe2v9qywco2xN?=
 =?us-ascii?Q?/gzMMRwCSSrhZwbjq4krCZOoBrZrhzjiMVvZsIbXzWQL4Rl7rt2Kt4qgQ56C?=
 =?us-ascii?Q?aLPDb4PGEz61Fa8dIyCZgz2dLjNE6lKnbkTRfedb5UeOAaD+R312Wz1BC8W1?=
 =?us-ascii?Q?4mLvTE2XJ1eCK8OisSeh0xzkYZhGmw8LzqK8qvA13C1y7NIyivlIm36uqaFi?=
 =?us-ascii?Q?/TiuLbEqoYw+xtUM1Z6nfBxWSl66MqgGaKX4ZqRa0+SFuHVlLi81VP5+776l?=
 =?us-ascii?Q?O796GpniHvQIUxCkk+sQ2R7cRBV2+ATlIk7JwKRKBisk7Qp3/9Ig31cj2OTe?=
 =?us-ascii?Q?nsECWVuBI15Cm2SMR/KfNmGOAHUMlNLHBqVudrXtIttgiq2v1+6MCRvF32gA?=
 =?us-ascii?Q?kM128KX9KB0DT29yllyI0CiYu3TxidYNQy0YPAexYu9Oi14Gk2Follqk3NFn?=
 =?us-ascii?Q?YXtMNNkHHa353CZLGRPxom/YBzxfd5R1kJO5bdaM5Xp6P0xzKTd/syrFukYQ?=
 =?us-ascii?Q?k7jcYMEVnrpY4Udt19TOubo+eUhr9kGmYWIoWbke/3IcHHtl8fD3ZvEIZ0a6?=
 =?us-ascii?Q?2MH9jub5ufH2phElakE5MmQvyPMS42sty64NuvGkIJLk6oQbTBqy1GNJWqtH?=
 =?us-ascii?Q?7r4zyCRAJqBc2roA0z3EiJfn6BpFrzA7ic8IBT5YHePiR9Athe4N8gfzELdX?=
 =?us-ascii?Q?e3/TlEFwsFrb8fwlSsilku/HTe7q5zXRzDKogMSVdGKoalxKivki7aouyNEx?=
 =?us-ascii?Q?5bWaPXTKd9kbGqgGMJmXIwJ2TgtMVe0ZYB9SEhRfMyE1bLMMGGG34PR+6j8q?=
 =?us-ascii?Q?kGSi1le0DYoJf/4D/396CDm4B5HxveA7TzTgq8SkeMfe8dKU83u9JWe58cJC?=
 =?us-ascii?Q?c5EzjglOE0XV0Or+2SaDaNHX58LubpRiGZVWo3TYKNHiOVQ8ba9LA9z89aKf?=
 =?us-ascii?Q?Su7BSjLSBLLcnvHaTM3cVD8n2KiTK3R0SAzSwAs4xroAnXcFqb3dsyUmu/Vu?=
 =?us-ascii?Q?It+fuv4p?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5051e6a5-daab-4b88-c43b-08d8b6e46d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 10:25:47.5226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGi0X5QngurtTWMG3MPbikZxZ74bpupdMkGJ5vdIwmOS3FwLf2AnROVKZgs8Xl1fvtXYQ7LKZGYB+IVf77EklZ8pAjJz3kk0xorujRR5qQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2317
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2021 21:27, Jonathan Corbet wrote:=0A=
> Sorry, I've been distracted by holidays, merge window, network issues, an=
d=0A=
> generally watching the news in horror.  The patch is applied now, thanks.=
=0A=
=0A=
Thanks Jon=0A=
