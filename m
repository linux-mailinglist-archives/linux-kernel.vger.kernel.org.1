Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA43D300DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbhAVUfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:35:46 -0500
Received: from alln-iport-2.cisco.com ([173.37.142.89]:45837 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbhAVUd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1293; q=dns/txt; s=iport;
  t=1611347607; x=1612557207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tx0xwUXfPkQnqxp4jHNy4TQ8O2VlOEJcdLEfzzww1hU=;
  b=hB2ryvQYuvoKlz7thX0/YL13ge4Ye55Ixuy+xLXiWqL4DwhHu3hp/x9p
   BKTvYgMVcCg2g1nbqT5APxDVgbMgWqY+UsQq7sOvEgrHvXhmozjVQfmbA
   aGqDRg6u12Dp6z81QEcyP18gGaXgSXUz7bFYDcWyEDJjxAlN4WIHyzaNB
   c=;
X-IPAS-Result: =?us-ascii?q?A0BJAAABNQtgkIsNJK1iHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYFSUX1bLy8Kh34Di3SCGo9wFoZOgkOBLoElA1QLAQEBDQEBHw4CB?=
 =?us-ascii?q?AEBg0t/AoF4AiU1CA4CAwEBAQMCAwEBAQEFAQEBAgEGBBQBAQEBAQGGOAyFc?=
 =?us-ascii?q?wEBAQMBOgYBATcBDwIBCBgeEBQeJwQOBYMmAYJVAw4gAQ6oKQKKJXSBNIMFA?=
 =?us-ascii?q?QEGgTMBg1cYghEDBhSBJAGCdoptG4FBP4QqPoQ+hXmCSYEOASsigW+5CQqCd?=
 =?us-ascii?q?4kwkiwxD6JlnEqCcpY1AgQCBAUCDgEBBoFYAzOBWXAVgyQfMRcCDY4hDA4Jg?=
 =?us-ascii?q?06FFIVEdDcCBgoBAQMJfIoIAYEQAQE?=
IronPort-PHdr: =?us-ascii?q?9a23=3AM/Zh5RR8y1r+A0NfAZ+t4dL0zdpsv++ubAcI9p?=
 =?us-ascii?q?oqja5Pea2//pPkeVbS/uhpkESQBNuJ+/NAiuzG9avnXD9I7ZWAtSUEd5pBH1?=
 =?us-ascii?q?8AhN4NlgMtSMiCFQXgLfHsYiB7eaYKVFJs83yhd0QAHsH4ag7Co3mz6y5UER?=
 =?us-ascii?q?L6ZkJ5I+3vEdvUiMK6n+m555zUZVBOgzywKbN/JRm7t0PfrM4T1IBjMa02jB?=
 =?us-ascii?q?DOpyhF?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.79,367,1602547200"; 
   d="scan'208";a="656296344"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 22 Jan 2021 20:32:45 +0000
Received: from XCH-ALN-001.cisco.com (xch-aln-001.cisco.com [173.36.7.11])
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 10MKWjXZ016710
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 22 Jan 2021 20:32:45 GMT
Received: from xhs-rcd-001.cisco.com (173.37.227.246) by XCH-ALN-001.cisco.com
 (173.36.7.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Jan
 2021 14:32:44 -0600
Received: from xhs-aln-003.cisco.com (173.37.135.120) by xhs-rcd-001.cisco.com
 (173.37.227.246) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Jan
 2021 14:32:44 -0600
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (173.37.151.57)
 by xhs-aln-003.cisco.com (173.37.135.120) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 22 Jan 2021 14:32:44 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ume8460MJN88VqQD6m/8y031Ppyt9lv0D2cDxor1dM9+eoL8qC9oqIdDyOytyY6SYjuiBoTRFrDDad+EC80oo7fjRJ0U5b2fXljRJmF+hAaxw4cOVB0rlG4Y9J03xBlHIbNzeLjDXLpSu0E5TylXoV82MPH8uau6J2v3qcevJPQrdZkycUSQFto0+U3yVOO2qPI3fYOdKvTZf0Ae3KJxGLxV86NLc/kh6q5tN1yZ5/KFNINq66uudjBkYNU9k2Y5NmGF0NtGvUgQmZhnqVOSp2UteZNwKLTx4zTUEiueYoCo9P+Rh4HDJ/y9R9bDJofiGEVwgHHOJqM0if8ly86bzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcqSz9vqyEj9h0Lvvlm3LY/3/FpUZTEXOWcc+N4P7ss=;
 b=FIWrUptn2ijeDj5/33DcKdEtaE8A9HH8rWGEvIa2vD9eTQ5P/Bv6WlOV9WAkMJD0Un/TBr7qw3kAisn6sCa/80BZjHQkZ1dzPf8HXVStckaESmQMH8wqckgss3scZSCox+poqjwHT5oLtveb7YuZeswaAVmatt5LpNGdkTi+VOpLA20TElR36G2ZkQDSxIcAxjyOCY2bf8Ias1veMW8owia+SGhpyl5q9lFB2Y6uD6mm+yKsHqZuIYixk4Ai+AIFhNX0g7Ij4JrdxjUSGv0JtlZOHHN5Gp+SMd0Tgzh1plojqx+PUK5sATC+5XDovdg1/ZfU9P+yojC2C1wmoS0dMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcqSz9vqyEj9h0Lvvlm3LY/3/FpUZTEXOWcc+N4P7ss=;
 b=lGdglXxvvMC40THf9Qrp5KgmT0Tb1fhlpminC/sE1cE1l/3B3gfnN/bCMXgjo7UEHGQ42OAOhKgW0FigHhWPxQhSX7DEi2Z3yEULat2GrCMROenUIYMUHZTjuhhG05eEe4/tvEpeSDCdKKWfXf4UXu12D+sv4fX6p5exw/QNJgA=
Received: from SJ0PR11MB5037.namprd11.prod.outlook.com (2603:10b6:a03:2ac::21)
 by BY5PR11MB3861.namprd11.prod.outlook.com (2603:10b6:a03:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 22 Jan
 2021 20:32:41 +0000
Received: from SJ0PR11MB5037.namprd11.prod.outlook.com
 ([fe80::f5b5:4b05:475a:f82c]) by SJ0PR11MB5037.namprd11.prod.outlook.com
 ([fe80::f5b5:4b05:475a:f82c%7]) with mapi id 15.20.3763.014; Fri, 22 Jan 2021
 20:32:41 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     Michal Simek <michal.simek@xilinx.com>
CC:     Daniel Walker <dwalker@fifo99.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: boot: dts: add new dts for hellcat & petra
Thread-Topic: [PATCH 1/2] arm64: boot: dts: add new dts for hellcat & petra
Thread-Index: AQHW8P27mGDl3zHar0GeD3nuSvVt0w==
Date:   Fri, 22 Jan 2021 20:32:41 +0000
Message-ID: <20210122203240.GS3710@zorba>
References: <20210121231237.30664-1-danielwa@cisco.com>
 <185100f4-67f1-140b-ad01-9997891e68da@xilinx.com>
In-Reply-To: <185100f4-67f1-140b-ad01-9997891e68da@xilinx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [128.107.241.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43ace85b-9ed4-41ec-f5ca-08d8bf14ddeb
x-ms-traffictypediagnostic: BY5PR11MB3861:
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB386111388652016B32F5B09BDDA00@BY5PR11MB3861.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /tzuhmjAchgz1ce+ozQceMC6WebU0HnUFcy9lxE+fpWq/rhU4yRu640Ox0A/BkC/Vrw4rweDAp/snMjQBL8+q9X1r5hohVYlpzlSynDstEgYRA283CLiioTCJo5tmkTyYWlXw/HdkuZ93caj33hjE1Xff/oQLbk15YURfgJkZYk0bWM7ffH9cPJzctPPdAak1cHDvi9+YoRNfIHMVf64u78gpwwzWVFysj9TnwEpv0MUUCIYb4T+0j8mb6sTjVnuaEJdi2M+eD+Aoz+5sFHlD0zUAVts3QV+Uaf7VSCX+MzNKAsnhIFoBG93+Iqv2Bth0KvW6ZqakBJKMOZyN/8i+Z6uleNYz4g5IhWccA+AUIaGoiVLO3HraQU6hQmblEhuvoAwQpHkQJkNukClZy4bscSvyKp6PI4Ly2tzseAYda9XXf5MS/ml7q/t9Z765+UAXPZJCMb3eTYIFtgUGArC215znrUHNXw9HOm+aGbOodrofk6ae8SPPDqkWGt+5R/hB4uuvZC5Ft7c9enpGP9k6F524ZgPCfjGeJoFcqAxHaeBVuLTUnwtD6jaulFXFJOuK4JOlSEGjXruDXNOtZ647yzIwEppvWuuxAkGrjfixH8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5037.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(346002)(39860400002)(376002)(136003)(396003)(366004)(86362001)(966005)(53546011)(5660300002)(478600001)(76116006)(1076003)(33716001)(6512007)(6486002)(8676002)(26005)(66476007)(6506007)(54906003)(4326008)(2906002)(66556008)(316002)(8936002)(66446008)(186003)(66946007)(64756008)(71200400001)(9686003)(33656002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?efbqk/5HRQBF9T8432useV01PJ7xF2txqBvsth7aAWMJD+fhkZOmnaYNRhHw?=
 =?us-ascii?Q?9udeDoNU0QctAQc+8hJgaRi3lbYBPhCfPgZt1yhPBJ9OgqJoClpSozeunD51?=
 =?us-ascii?Q?Tu07yRqbgWa3s1ezhG9W7jQdyw32kOh9r+L2wWMP7gtn+YYkZ4rI4lmmjm1K?=
 =?us-ascii?Q?5cchGPmk2G1q5xO9MDG/QSF3fYaULUyeFk518WM0IKJcrAmIG8gHmAHMI1Ss?=
 =?us-ascii?Q?LFwOup3BdjDp7Eky55F2eIvrbeFstz2l8p13rQ3e70BwV4H2LL4Ih50hbAMH?=
 =?us-ascii?Q?MegQUCd/MxprhWemFU/+7JiYsq/mVXW0Mjig2cN5U+TfbxEg+M/saehl8frb?=
 =?us-ascii?Q?/b3fXANlDlVxuKCZzZ2LdgUQ9VjOerkikwcwUfzDyTwDb3btTKOpd1tWg4La?=
 =?us-ascii?Q?7hEZj5IV/J8SEqUq6eo4wcDP3Gp3rA1mbfbqw04Y2r8cbydEfxyxzjG/9bsZ?=
 =?us-ascii?Q?7rGIiy+pvKhaLf0yaLngJA7USG1aPE3+hPta3DFIK8dfMaio0PSwfQEqnOCm?=
 =?us-ascii?Q?0CbfWNM068VEtGOpdBhD6xIE/c+L4VyX8kMNmzhqqdizaoHTHp6Oe9BAd4Ff?=
 =?us-ascii?Q?11zYQi+zrOG0Gqqeckg6Y5kmW+WpuUeHhWbufoUrhcsr0Hco13bQIzdzAzM2?=
 =?us-ascii?Q?RYzbbbRcqU4i6eoDGkHRuUnJJ7MVDDN6Iv98UgAq2+xu/3PcakCUqCAeiY9P?=
 =?us-ascii?Q?2o1CbF1JcDB6D1to7P7iPl8hwrGVvV0NaK2FVNyTlHCMH5lVj7BZlVQfAZCV?=
 =?us-ascii?Q?Fnt1pE6lkO77M/DpxbMIBKRDZI+YLu04GcMkrocR4JiHRDpvuxl1SpMdBZ+8?=
 =?us-ascii?Q?QkijpkrAkhsCH97v3ZOb//gJaItLXu+Qa42jwir9UfXjY/jiCTOydxINwah6?=
 =?us-ascii?Q?vleSZm8guQBe31EBoQKDD9R7p0BUAfTittPTor6mgVku2vItWX6bBnxlXXaW?=
 =?us-ascii?Q?DSAMqwEjflgl2Ph77o+ZmP9cOqAvMvaYAWsv4m1kYzWqFtvP9Lxb77gKuIH1?=
 =?us-ascii?Q?wX2dgVIr26ZNRCa3UwAYfru6EL64srqlgaqF+CsSq9AkV4Ok1rbHI60HR0s4?=
 =?us-ascii?Q?AkAe1l3kKlAbCpyvNxJ/N1O8bi3DSw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5B214B43DCF8D64D8D385437719CD234@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5037.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ace85b-9ed4-41ec-f5ca-08d8bf14ddeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 20:32:41.5140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nSKK+cV7ETy19fqPdV2bRPEprflhkZANv0TRnH5ezBTi5q/F0Oig6qyG2leasKs4D0CvNBj4Uo2zN+NvWqgi9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3861
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.11, xch-aln-001.cisco.com
X-Outbound-Node: alln-core-6.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 09:48:53AM +0100, Michal Simek wrote:
> Hi Daniel,
>=20
> On 1/22/21 12:12 AM, Daniel Walker wrote:
> > Add Petra and Hellcat dts file. These platforms are based on
> > the Xilinx Zynqmp platform.
> >=20
> > Signed-off-by: Daniel Walker <dwalker@fifo99.com>
> > Cc: xe-linux-external@cisco.com
> > ---
> >  arch/arm64/boot/dts/xilinx/Makefile           |   2 +
> >  .../boot/dts/xilinx/zynqmp-petra-hellcat.dts  | 856 ++++++++++++++++++
> >  arch/arm64/boot/dts/xilinx/zynqmp-petra.dts   | 847 +++++++++++++++++
> >  3 files changed, 1705 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-petra-hellcat.dts
> >  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-petra.dts
>=20
> First of all I can't see 2/2.
=20
It wasn't being submitted to you. But here it is if you care to look at it.

https://lkml.org/lkml/2021/1/21/1468

>=20
> Long time ago we said that we are not going to push any PL related
> configurations. It means all below can't be merged.
> And there are also coding style issues.

You'll need to explain this more. It's likely this was added at the suggest=
ion of
Xilinx. If it can't be upstreamed what should we replace it with ?

I will review your other comments and re-submit.

Daniel=
