Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29CB2FFE9E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbhAVIqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:46:42 -0500
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:26318 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbhAVIqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:46:04 -0500
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jan 2021 03:46:01 EST
IronPort-SDR: f/eg88RkLeSrim/VTdboKpiSt93OrSdoTLN/jN84RJ+3nD+adpL0GXhjt36uP2tTRpuOUMzeo5
 7VjTFtnBvOdot1eghhUXRDFCmT+T5v6oLJKxKlrT6T1ny7y9qV1Pw1gZWT//g0rB7NmeF01DCY
 pNLXGLLX0cKuysbjV/56Ej/4iY3dZsnSVM3V7GJAxZsEcKyVyaK1TpOeyNPOaaE0p8ehq7ziuz
 +bRg6nTo5mgwCNyg1Rh9xQ7/iow6eAOfVywbkeK9mcFYZ2OAmLwY3aizVKgOD3J0cgPgs1pRGq
 PRw=
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="32917906"
X-IronPort-AV: E=Sophos;i="5.79,366,1602514800"; 
   d="scan'208";a="32917906"
Received: from mail-ty1jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 17:35:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KE9uHnmHDldLsQhCoUkCHeJz+/MERXhsgzxFXYW4EdMDGMOijwST/S6dsZr1AuvbaShdtUkjIgGnlN9OuPnntXQHxLKc3Hu7oRswqHLq+wXfs3CQdonWTyPfHHcXbG5VKofnI3EalpRYIkEMA4Rsq/E+xkos+qbiN8IiOcb+OQuFP5BnLHHqgLSA6EvqdfdC9YadOXy4N5FErrRm8AaLfUVSY1SY8DTB9mUGW5X/Q1VkzDtZ6fuqqaHPkV4iAL9aggQHdF+ZZv1fpw5IKSMQGCkUC+o0wkdLbj0N0mNIBs+p3DegVPHgNBMp4ldwgutysmSQd2zma8e1gUWYCZJRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIGJZp6GQ/RkrF0ho4CMneGbtb1u8xVykB/x4EpMwUk=;
 b=K6KIgoRgVAGGN1c71z48pCO7I0hV6mgeoSlS8b79iw5opplMpaijGltJPvTg/sjC5jYHHDmaRH5E/CrzXQcQbaoueR+rVI9dRUYgX96Eio/ExZAl7sIUc83jQj+MlmkvCipDlJCX7QNHDKIh8TXqOtDnSjjghR7JaV695eP45wPFqw0Xh7jjz0x+2WJRhcwu6PJC8XlSLWFXvrgH3b/imyR6yHRdA/9ok7P452KIqoDKQya9MxPLWvI+APqS93vsk99m9TH/VVnHnh2tBwteOXbAVMbiBGZUVSEtyyX26qgJuZ1vjRziUAlzU4H7wPE71cAoiY1CCCbs/YvtZeCB5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIGJZp6GQ/RkrF0ho4CMneGbtb1u8xVykB/x4EpMwUk=;
 b=hotJZPBOgzuQJ1DDZEuPtxgv4NNmQOb87LOAO/ZTCDqcgfyWvDRM7FuT4Djtg1IIKQ7q+2jnozMKO8L+O8Pw96DFZPwJa2zz4XFkkMqAKuTW4LV/c9uk6Q42UlnQpbdGkMLOvKIu6aea7YAHn7TSTezM6H095D58AXIIiK7HMlI=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OS0PR01MB5425.jpnprd01.prod.outlook.com (2603:1096:604:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 08:35:52 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 08:35:52 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     'John Garry' <john.garry@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
CC:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 1/3] perf vendor events: Add cache refill and DCZVA
 events
Thread-Topic: [PATCH v2 1/3] perf vendor events: Add cache refill and DCZVA
 events
Thread-Index: AQHW7+SfZlbnwAdjkk2qmbTsu5bGU6ox9FMAgABlzYCAANpbYA==
Date:   Fri, 22 Jan 2021 08:35:52 +0000
Message-ID: <OSBPR01MB4600DCC22FFE8BA6A6BB2897F7A00@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210121105425.2695843-1-nakamura.shun@jp.fujitsu.com>
 <20210121105425.2695843-2-nakamura.shun@jp.fujitsu.com>
 <b00bf252-e31f-b0eb-d0aa-0a62bcaee22e@hisilicon.com>
 <0be33a5d-98a1-d2e1-704e-83334063888d@huawei.com>
In-Reply-To: <0be33a5d-98a1-d2e1-704e-83334063888d@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: e65b491330dc4890a689f3b62a2fd220
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa8c7cc3-60b4-45c1-8312-08d8beb0ba48
x-ms-traffictypediagnostic: OS0PR01MB5425:
x-microsoft-antispam-prvs: <OS0PR01MB5425582E591E2499E9815F54F7A00@OS0PR01MB5425.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7L1F2WnlC2/4O8W44fd4c8sZQ0GB6CXkvYVpcyAfw35OYZ96kYKkatQH7UwRI2culNTC3IA0FHkm+Yx8aIeTugLpK8ziD6I4RziCOwTYHwYhBFVZoFq0elxS5I3yCuUMNAsJbdyheKMSmgfkVQqmEpM41Jge9GkSJHp70j0rN+0y4IcTKTg4Jzto6K7SlCheqQuG3kg1ZpJDQmd//rv7P4PPLoCts8iynmpG1wMoNDmmEe3NPJZpFTxIBSkIJ07g2NUcQlI/vDLj7MeYzPmTMLIQrDJ4cWSyi64hM7lp+Cj6X9Z4NwZDLXQ//KAqeO/CJIWWEVL3qm0h1x5EI1as6smK3ppvt8ZIvWtsM+GY000tQOHZkxM9Y2zC8Ucp6p6cvcUvRfanLs5sch1C/ty+qRta7Lm/AA2j4aMoJGjOzMoCZWnCvNC3Gx9PioZyaDfW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(53546011)(26005)(83380400001)(6506007)(66946007)(76116006)(66476007)(64756008)(66446008)(85182001)(66556008)(86362001)(8936002)(4326008)(186003)(55016002)(9686003)(110136005)(54906003)(2906002)(316002)(71200400001)(52536014)(7696005)(8676002)(478600001)(33656002)(5660300002)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?WkpBdE82WTlTT2JpWmx5YkxKVW1OL3N3N0tuaWt1SGYxbG1nTGppUkhi?=
 =?iso-2022-jp?B?MEFISkdRVG8vaVFFWlRZY2JtNTc0M016enFOQWlNMEhSY3c5aUxyaWZq?=
 =?iso-2022-jp?B?R1grNzJlb0tFMmJSOW5OMjNGNFl2ZDRyU3BaWGp3R0IzZ0Z6U2RjRUtK?=
 =?iso-2022-jp?B?RW1nTUI1amhJTmNGaE5UM2IzVGdEamZrNWwrRm9veERUdUIzWTRUNEtL?=
 =?iso-2022-jp?B?UTRCdXBhd0pvUjJRQTdNRk5OUmJMOVlNYUFRWUdMUkJMcGxrWThKaHBv?=
 =?iso-2022-jp?B?L1k1bktjajB1YmNzQm5YVlVLYzZKM1BDYmEwdjY5TmxncnpTZjBYV05t?=
 =?iso-2022-jp?B?U1RUYS9Xb0NoSmpHeTJrWVBiK0YvQlZ1OVgxMTU5dGxmVDFZK2FVR1o3?=
 =?iso-2022-jp?B?ZXRFTFBxU3R3RFZZWXVEaE1oY05YaEllYjNSbHJsNTdWek1TK25LaWNC?=
 =?iso-2022-jp?B?alByTUkzaFFyb2JwY0lPblFVRGJSMVBXWWdKdVRPRzhSeEt1KzBlNnM5?=
 =?iso-2022-jp?B?b2pZR0xPVm5OTmxmS09STEw0dVMvMXN2RHV1a0kvakE1WHJ1TXhzb2Vp?=
 =?iso-2022-jp?B?ZVpFc3A4TS8zSEJ5K0c4NjR4U2pta3VOSS9ybE5wZ09zYjFvMFIyM040?=
 =?iso-2022-jp?B?TnpyQzd4VnBXYzlya0xMVytHN2NoUUxrYmt3NEt1ckx4bEhueUZqRzRr?=
 =?iso-2022-jp?B?cE9VRGxFZE9ER2krMDN6UnFnSXRNbG1KM2FVYUZWeWR3MnNZTnQzOFlj?=
 =?iso-2022-jp?B?NlpSRFRkT0Noc3p4OFJNSm9hTWI5SDY2TWlRWGxOclRUeC8zWkIyOSs2?=
 =?iso-2022-jp?B?TmcraDdqRTNYUEM1ZmZ5ellySnFkckEycE9UbXh1NVY0eUxGUGlrQUUv?=
 =?iso-2022-jp?B?ZCt4ek1laXJla0pWbXlvcERobU9uVHFnZTBQQzhKSWRlM1NnQjgwU20w?=
 =?iso-2022-jp?B?dEU4a3p0UkJ6SUM5aWxJRUZILzkwQXBuTkdlRW1sMG5IcmlkUFkyNlNE?=
 =?iso-2022-jp?B?eDAvTzJ1dENmMXcxMG1TR1oybjVOK0JvWDZzMEZMTHA0RzBNMzJudTlP?=
 =?iso-2022-jp?B?RXhMdzVYWldmK1dmMHQ3d1pnY1ZlZnNiUDFPQXNpV2VTdGlVZHlLVEo0?=
 =?iso-2022-jp?B?NjAxZXEzMlczcUhQb2ZmRjc3bG9telZvcDNjajlReng0Sm5ySmtZSXRL?=
 =?iso-2022-jp?B?NStqS1MyV1llcmtGNTh0MmdNOWZGMWpGWnhQRDhveGs2czZPVCtJd1N0?=
 =?iso-2022-jp?B?cVNZZkczOG9veUhoMFUzdE1PbVVUVU9oZk5PMTZIZjUyTG5PSGxpNjla?=
 =?iso-2022-jp?B?cVhyeVdkb25UaThnd2ZvSUJQeEdGR25uWlh3SVBwVWpyOHlTbGk1Y3Qv?=
 =?iso-2022-jp?B?UmgwbHMzbXdaR3I5NWVIUm5PdW9DenlMRXcrNWJIdmhVZWVtdz0=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8c7cc3-60b4-45c1-8312-08d8beb0ba48
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 08:35:52.0931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PqRPeKCc4Z1IA+W3w4tuIb5UQDg74YPrB0Mu4GxPR5VZg+quUWscTaIodeN7/lC6b+D6mxwSa5V3jLA3UIPpg6V5lsTDsMhtUSwr88pfC9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5425
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  John, Shaokun

> > =1B$B:_=1B(B 2021/1/21 18:54, Shunsuke Nakamura =1B$B<LF;=1B(B:
> >> Adds L1 data cache refill prefetch, L2 data cache refill prefetch,
> >> and DCZVA instruction events.
> >
> > A silly question, Does Arm define these events? I checked Arm ARM
> > document(DDI0487Fc) that these event numbers are reserved. Or maybe I
> > miss something.
>=20
> For events which are reserved (see k3-1), like 0x9f, prob should not be p=
utting in
> this file, but rather the CPU JSON.

I missed the reservation area for ARM recommended events.
I will fix the patch as you pointed out.

Best Regards

> -----Original Message-----
> From: John Garry <john.garry@huawei.com>
> Sent: Friday, January 22, 2021 2:44 AM
> To: Shaokun Zhang <zhangshaokun@hisilicon.com>; Nakamura, Shunsuke/=1B$BC=
fB<=1B(B
> =1B$B=3DS2p=1B(B <nakamura.shun@fujitsu.com>
> Cc: mathieu.poirier@linaro.org; linux-kernel@vger.kernel.org;
> leo.yan@linaro.org; will@kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2 1/3] perf vendor events: Add cache refill and DCZV=
A
> events
>=20
> On 21/01/2021 11:39, Shaokun Zhang wrote:
> > Hi,
> >
> > =1B$B:_=1B(B 2021/1/21 18:54, Shunsuke Nakamura =1B$B<LF;=1B(B:
> >> Adds L1 data cache refill prefetch, L2 data cache refill prefetch,
> >> and DCZVA instruction events.
> >
> > A silly question, Does Arm define these events? I checked Arm ARM
> > document(DDI0487Fc) that these event numbers are reserved. Or maybe I
> > miss something.
>=20
> For events which are reserved (see k3-1), like 0x9f, prob should not be p=
utting in
> this file, but rather the CPU JSON.
>=20
> Cheers,
> John
>=20
> >
> >>
> >> Signed-off-by: Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
> >> ---
> >>   .../perf/pmu-events/arch/arm64/armv8-recommended.json  | 18
> ++++++++++++++++++
> >>   1 file changed, 18 insertions(+)
> >>
> >> diff --git a/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
> >> b/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
> >> index d0a1986..ee0e67d 100644
> >> --- a/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
> >> +++ b/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
> >> @@ -54,6 +54,12 @@
> >>           "BriefDescription": "L1D cache invalidate"
> >>       },
> >>       {
> >> +        "PublicDescription": "This event counts L1D_CACHE_REFILL
> caused by software or hardware prefetch.",
> >> +        "EventCode": "0x49",
> >> +        "EventName": "L1D_CACHE_REFILL_PRF",
> >> +        "BriefDescription": "This event counts L1D_CACHE_REFILL cause=
d
> by software or hardware prefetch."
> >> +    },
> >> +    {
> >>           "PublicDescription": "Attributable Level 1 data TLB refill, =
read",
> >>           "EventCode": "0x4C",
> >>           "EventName": "L1D_TLB_REFILL_RD", @@ -120,6 +126,12 @@
> >>           "BriefDescription": "L2D cache invalidate"
> >>       },
> >>       {
> >> +        "PublicDescription": "This event counts L2D_CACHE_REFILL
> caused by software or hardware prefetch.",
> >> +        "EventCode": "0x59",
> >> +        "EventName": "L2D_CACHE_REFILL_PRF",
> >> +        "BriefDescription": "This event counts L2D_CACHE_REFILL cause=
d
> by software or hardware prefetch."
> >> +    },
> >> +    {
> >>           "PublicDescription": "Attributable Level 2 data or unified T=
LB refill,
> read",
> >>           "EventCode": "0x5c",
> >>           "EventName": "L2D_TLB_REFILL_RD", @@ -408,6 +420,12 @@
> >>           "BriefDescription": "Release consistency operation speculati=
vely
> executed, Store-Release"
> >>      },
> >>      {
> >> +         "PublicDescription": "This event counts architecturally exec=
uted
> zero blocking operations due to the 'DC ZVA' instruction.",
> >> +         "EventCode": "0x9f",
> >> +         "EventName": "DCZVA_SPEC",
> >> +         "BriefDescription": "This event counts architecturally execu=
ted
> zero blocking operations due to the 'DC ZVA' instruction."
> >> +   },
> >> +   {
> >>           "PublicDescription": "Attributable Level 3 data or unified c=
ache
> access, read",
> >>           "EventCode": "0xa0",
> >>           "EventName": "L3D_CACHE_RD",
> >>
> > .
> >

