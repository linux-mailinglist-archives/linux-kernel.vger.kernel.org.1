Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903CA2EC9B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 05:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbhAGE6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 23:58:15 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:34112 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbhAGE6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 23:58:14 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1074ogRD020334;
        Wed, 6 Jan 2021 20:57:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=rLYqgFZkJBRzDknHr4zqPXwTOJEIm3EZbkeRDcTRO7g=;
 b=K+n/0rXgk7uphKrEmNsq6Nsv6sXqELYpkOoIqOlXiqKiINYcbD7ZXQ5Mq4osSJ8vCeKB
 z4W/r6Yo5ylinhFQk/fADX9oprilg2eYE+1dRMss/LRjEa6gz7E2+RJUXdmb8z+ItPhh
 Tm5H6nIkFnYz+WKXC1+QmDFJ/bUgIQL5jpVq38/xZaiwZLCvDsTAlqGd5Wo9FNQiwRFn
 FSfCFu7/5s5vjXoK4dFDZ7UIb9tXMn0JHs4yrsg0Re4Ko5cKIBD8xpn5WYQFo/Yc5QgA
 VT0sfoY67trd1OC8jKUrouti+evLHZuOQdwvY0O6uRj9WHxuy+TdafBpP+8EyaHHnkk1 ng== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 35wqq80g4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Jan 2021 20:57:31 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 6 Jan
 2021 20:57:29 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 6 Jan
 2021 20:57:28 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 6 Jan 2021 20:57:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn6aDl4amthJVMFX3IDSMPwX3+5+PI7AEo6pZ6qY7FObFm2NfJPc51QS1U05iz91VsD+NYfouZSARcTiRGkHmF5ntHKRbT948+zocHgYq2cpPQaiJMXLyTMCY4DdPJ5Yd/4MHYC6NL1RGC38V4gxW1PqkE/B8prdkqe+l38XRzrAZ2EJHFXe8o55ox+LJ9KGlerytYVqOkYC7nQs0HtAkyXgrL74CnQ+Qjnl82F3U3TSo+OVSNr8LA869gLL05869tI0kEMmifD/2VPudOZ3dY0pXEFRuM1/5+/YIsXVXTC0Ie1clDwPtnSHFSDy+/rMeOy4ksEOwNu+OmFRYR2MWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLYqgFZkJBRzDknHr4zqPXwTOJEIm3EZbkeRDcTRO7g=;
 b=TjwPtQcHvr40KP3pL1BIZXb/ek4xpntJB0bCSo7uJ8aqDmlbe4WLBaHWfTYqtBL12APFpNyDUMCgSJ4oaKi6R8u0GodSQ6HNA/nIni4z5hBL3hgg/0J4xgRHCGb25H3klPUBwhbMbDtirgC+LNKZ+Vp8jAUy3RRX1R1x/ffp+lRbxSvg46edjZx6S8FgWiMCDWuivfAX+44MijY2stBr5D/xo09X3osRQ2PcQYzIuCyDIOX4nLRuGhZKYeWWWfAKCnLH+yA5ZCl9nh9OVpu4tcn7+PeECWwnwivBZYIihIVIWRGfr2MWjzrMkq+eEydDAy9ms2heYmt25Jlq+jexRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLYqgFZkJBRzDknHr4zqPXwTOJEIm3EZbkeRDcTRO7g=;
 b=nx0BHO+ZQF2KTJUBJ3BP/rvnYIGPBudNVAJpdjAculdOAObGfmSEHIhaE9db4nz3Itrg4EauaGgCMOrpAKRtOw5Iwj5KzdT9Hl+pC/h+fc/4p+lI56vXJ2Qw2WeFuufiKv5hRWrgrJyubx0+Hef3edYP1YPYJLkwo4F36ribq28=
Received: from MWHPR18MB1520.namprd18.prod.outlook.com (2603:10b6:300:cf::10)
 by CO6PR18MB3794.namprd18.prod.outlook.com (2603:10b6:5:344::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 04:57:27 +0000
Received: from MWHPR18MB1520.namprd18.prod.outlook.com
 ([fe80::15a1:3a30:1fcf:20eb]) by MWHPR18MB1520.namprd18.prod.outlook.com
 ([fe80::15a1:3a30:1fcf:20eb%2]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 04:57:27 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sunil Kovvuri Goutham" <sgoutham@marvell.com>
Subject: RE: [EXT] Re: vfio-pci: protect remap_pfn_range() from simultaneous
 calls
Thread-Topic: [EXT] Re: vfio-pci: protect remap_pfn_range() from simultaneous
 calls
Thread-Index: AdbkRnC96D9dwqxzR0eR3ijlJSqy4gAEULUAABZm07A=
Date:   Thu, 7 Jan 2021 04:57:27 +0000
Message-ID: <MWHPR18MB15206EBFF6FAB3F306318DAAE3AF9@MWHPR18MB1520.namprd18.prod.outlook.com>
References: <MWHPR18MB152034C6BAE8CC6D503DDEBEE3D09@MWHPR18MB1520.namprd18.prod.outlook.com>
 <f33979f5-0e89-4fa2-c48e-06d353379f23@oracle.com>
In-Reply-To: <f33979f5-0e89-4fa2-c48e-06d353379f23@oracle.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [122.179.88.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc357871-25a8-422c-9e93-08d8b2c8bb18
x-ms-traffictypediagnostic: CO6PR18MB3794:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR18MB3794C855DF4593263F9A5D2AE3AF9@CO6PR18MB3794.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oIdtvSDLNfhYuQSgyL+tpqEaWlgheQBBVZeCdCLXeQ8+nk8uTbkDxEi1pFiCbA821rGDkVrVBPtz/GddUu5c9C4GUg5SNpfxsWTAgKd3SLNqPM5+tz+iZltuVDfkJusaCdbq7k72ap7pJl5Mn4v66UV5hx4hGhfPbfwpaNcD+oAuDc3psn/Qm1KXjxlXuzGNFfw0rH42iXuXzsSxR0WjcZDLZOHYZPIQDWEzfIF/fJYOKL1EG4Tfp44gasVFINJ0fTny+lvw5iiW4Sdb34UdEcs5I5hnNMPOujnJ3qzDrVfVI9soObgwAUaKff6Lq8uZ8Mmq/+U1nl0NL0I6JF4svy5SywQHdrQAEp3kWzATmn++P06wZhcXUFfouUvFECdslZXECVh0sugbzjJ2fLGeJOw8nJZZZg5IMRkk18vkuDkQVNnfbIjA2g/O7Pnvwsf+Jxqob5PiB4P8bAs9+4vaOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR18MB1520.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(316002)(478600001)(2906002)(966005)(110136005)(54906003)(66556008)(6506007)(83380400001)(8936002)(53546011)(107886003)(5660300002)(55016002)(71200400001)(9686003)(19627235002)(66446008)(86362001)(33656002)(186003)(76116006)(66476007)(64756008)(7696005)(8676002)(52536014)(26005)(66946007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Ti9yWDNhNjV2SG9KV3FFQStNVktHSlZGSDdacnNRMEZDYXNrNVc2ZUlHREhM?=
 =?utf-8?B?MkVvVDMwN3FyVTE0ZEFqdHQvME1OUVJCQ3h2SEhaR2xua2hLYjI4WE5lUXlT?=
 =?utf-8?B?S1lSZDFhbUltRThLNHlwcHZpdmMxcCtLNmJrRENxT3pIMy9LbkFJUTMvR2FW?=
 =?utf-8?B?b28rOVdvcDV4bDdmSFFDTGR2eXBZYlRNS3ZneWpGOFlMQVcwdWJtdVpsRGZw?=
 =?utf-8?B?dXo2TVU5WXkrRU9TNVE5d0h1bjNQZzMwSld0bzFEWDl2RVI4bG1Ieis2RXR4?=
 =?utf-8?B?UnNhWFRlM1dGaVE2OUFSV2JRR1VZaVRtNE80Uk1FWG5LRGxEaWc1RWdCaEJS?=
 =?utf-8?B?NVJRcTdFMmF5SjZzd1pzTWIvOWVBL3k5WTBrclFkRVF5WUZNMUdwVUNYNk9B?=
 =?utf-8?B?YlRvWVdCNWxoMmZQSU1xUFlhSUVncFY0Nk82ckFuWm1ZVlNINzFLL0xxUEsx?=
 =?utf-8?B?bzIrQ0orUG1ScDRkVjhValpiZDU5bUw5Q284RE9OeWdQTFlXci9WejZYdVBB?=
 =?utf-8?B?ZzYzTjI0d213cEdDRlZIbE9HWjZValgyM00xRWsxT3MrcDY4N003aXhxVEdK?=
 =?utf-8?B?K3hBNDk5OVN5MUxicG9FdWdheWw4QjFyK2NzVWt3T3F4dHNJaGw3bmtIelJW?=
 =?utf-8?B?ckZsVjZiNW1NK0NIMzRJZlA4bmhtc3JNWkJzbjM0TGhTU0Z2V0tNRnNybGlO?=
 =?utf-8?B?MmJxa1JCODJhYTJjdHZzeWs2OTh5TlhvcklOUktmUWxsM2hYNmJVeGJscHZN?=
 =?utf-8?B?TXMxV0dtdGJ2dVRsaE9panM4WVVWSUJMSlMzSWx3Z09ZNlpMRWRNOGpJZ1Vh?=
 =?utf-8?B?MzZlcEduNk9CRWRyVnFibGJoM2FxQkxTb3NXRWRHUVZzcXkxd2d5MUlYUGRU?=
 =?utf-8?B?S0VFNXg1V216VjdTRmM1MEs0a1J1QXFQcVI0d1I5YS9lRkN3WjIvM1J1Misr?=
 =?utf-8?B?OTRiR1RnWWxIZUJLRmdLcmtvN043aVlVb0xOdi9BTzE4V1IwOTRMM25FTFlK?=
 =?utf-8?B?ZGIxN2dTRlVENkNuTFVJYSsvOVR2V1BZUUFUVis0N2ZZR3BJeWVqelZ6OVlx?=
 =?utf-8?B?WjR4cGxqK1RoWENsN3JzT25xdGNMaEg3VTRDajNLT2RyaUdTOTV4d1dsbDZv?=
 =?utf-8?B?VGo2VTREUHNCS0dkRE9oeUFDclJmOEFMMWZwVTdBejRmQzE1cjVNcElwYUtm?=
 =?utf-8?B?NGVxZ0VHVkNnQ1RpTnNBdGZrRlpFVWtkYUM3YUp5T3I4QjJUanJQdHB3UUww?=
 =?utf-8?B?ZTNoc2VwNzFzUU9mZ05DeW05b0pSR2NFTktYQkRnU21kVE40cGkrQUZiZm8r?=
 =?utf-8?Q?e5PLBYEbgVg/A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR18MB1520.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc357871-25a8-422c-9e93-08d8b2c8bb18
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 04:57:27.1552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTnlMzKRnj0rYkEhJ6UDgobWSwMhsyqcfH7spzpWXlUmYFJqNRsP+dVgrkUkyOtCx2L4yRPwAOIMQuL5EWng6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3794
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_02:2021-01-06,2021-01-07 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5rdXIgQXJvcmEgPGFu
a3VyLmEuYXJvcmFAb3JhY2xlLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDYsIDIw
MjEgMTE6NDQgUE0NCj4gVG86IEJoYXJhdCBCaHVzaGFuIDxiYmh1c2hhbjJAbWFydmVsbC5jb20+
OyBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbQ0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgU3VuaWwgS292dnVyaSBHb3V0aGFtDQo+IDxzZ291dGhhbUBtYXJ2ZWxsLmNvbT4N
Cj4gU3ViamVjdDogW0VYVF0gUmU6IHZmaW8tcGNpOiBwcm90ZWN0IHJlbWFwX3Bmbl9yYW5nZSgp
IGZyb20gc2ltdWx0YW5lb3VzIGNhbGxzDQo+IA0KPiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiBPbiAyMDIxLTAxLTA2IDg6MTcgYS5tLiwgQmhhcmF0IEJodXNoYW4gd3Jv
dGU6DQo+ID4gSGkgQW5rdXIsDQo+ID4NCj4gPiBXZSBhcmUgb2JzZXJ2aW5nIGJlbG93IEJVR19P
TigpIHdpdGggbGF0ZXN0IGtlcm5lbA0KPiA+DQo+ID4gICAgIFsxMDAxMS4zMjE2NDVdIC0tLS0t
LS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiA+ICAgICBbMTAwMTEuMzIyMjYyXSBr
ZXJuZWwgQlVHIGF0IG1tL21lbW9yeS5jOjE4MTYhDQo+ID4gICAgIFsxMDAxMS4zMjM3OTNdIElu
dGVybmFsIGVycm9yOiBPb3BzIC0gQlVHOiAwIFsjMV0gUFJFRU1QVCBTTVANCj4gPiAgICAgWzEw
MDExLjMyNjEwOF0gQ1BVOiAyIFBJRDogMTE0NyBDb21tOiBvZHBfbDJmd2QgTm90IHRhaW50ZWQg
NS40Ljc0LTA1OTM4LQ0KPiBnYjk1OThlNDlmZTYxICMxNQ0KPiA+ICAgICBbMTAwMTEuMzI4Mjcy
XSBIYXJkd2FyZSBuYW1lOiBNYXJ2ZWxsIENOMTA2WFggYm9hcmQgKERUKQ0KPiA+ICAgICBbMTAw
MTEuMzMwMzI4XSBwc3RhdGU6IDgwNDAwMDA5IChOemN2IGRhaWYgK1BBTiAtVUFPKQ0KPiA+ICAg
ICBbMTAwMTEuMzMyNDAyXSBwYyA6IHJlbWFwX3Bmbl9yYW5nZSsweDFhNC8weDI2MA0KPiA+ICAg
ICBbMTAwMTEuMzM0MzgzXSBsciA6IHJlbWFwX3Bmbl9yYW5nZSsweDE0Yy8weDI2MA0KPiA+ICAg
ICBbMTAwMTEuMzM1OTExXSBzcCA6IGZmZmY4MDAwMTU2YWZjMTANCj4gPiAgICAgWzEwMDExLjMz
NzM2MF0geDI5OiBmZmZmODAwMDE1NmFmYzEwIHgyODogZmZmZmZmZGZmYTI0MDAwMA0KPiA+ICAg
ICBbMTAwMTEuMzM5NjcxXSB4Mjc6IGZmZmYwMDAxNGEyNDEwMDAgeDI2OiAwMDAwMDAyMTgyMDAw
MDAwDQo+ID4gICAgIFsxMDAxMS4zNDE5ODRdIHgyNTogZmZmZjAwMDE0ODlmYmUwMCB4MjQ6IDAw
MDAwMDIxODIwNDAwMDANCj4gPiAgICAgWzEwMDExLjM0NDI3OV0geDIzOiAwMDAwMDAyMTgyMDQw
MDAwIHgyMjogMDA2ODAwMDAwMDAwMGZjMw0KPiA+ICAgICBbMTAwMTEuMzQ2NTM5XSB4MjE6IDAw
MDAwMDIxODIwNDAwMDAgeDIwOiBmZmZmMDAwMTQ5ZDcwODYwDQo+ID4gICAgIFsxMDAxMS4zNDg4
NDZdIHgxOTogMDAwMDAwMDAwMDAwMDA0MSB4MTg6IDAwMDAwMDAwMDAwMDAwMDANCj4gPiAgICAg
WzEwMDExLjM1MTA2NF0geDE3OiAwMDAwMDAwMDAwMDAwMDAwIHgxNjogMDAwMDAwMDAwMDAwMDAw
MA0KPiA+ICAgICBbMTAwMTEuMzUzMzA0XSB4MTU6IDAwMDAwMDAwMDAwMDAwMDAgeDE0OiAwMDAw
MDAwMDAwMDAwMDAwDQo+ID4gICAgIFsxMDAxMS4zNTU1MTldIHgxMzogMDAwMDAwMDAwMDAwMDAw
MCB4MTI6IDAwMDAwMDAwMDAwMDAwMDANCj4gPiAgICAgWzEwMDExLjM1NzgxMl0geDExOiAwMDAw
MDAwMDAwMDAwMDAwIHgxMDogZmZmZmZmZGZmZmUwMDAwMA0KPiA+ICAgICBbMTAwMTEuMzYwMTM2
XSB4OSA6IDAwMDAwMDAwMDAwMDAwMDAgeDggOiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gICAgIFsx
MDAxMS4zNjI0MTRdIHg3IDogMDAwMDAwMDAwMDAwMDAwMCB4NiA6IDAwMDAwNDIxODIwMDAwMDAN
Cj4gPiAgICAgWzEwMDExLjM2NDc3M10geDUgOiAwMDAxMDAwMDAwMDAwMDAwIHg0IDogMDAwMDAw
MDAwMDAwMDAwMA0KPiA+ICAgICBbMTAwMTEuMzY3MTAzXSB4MyA6IGZmZmZmZmUwMDAzMjg5Mjgg
eDIgOiAwMTY4MDAwMTdjMjQwZmMzDQo+ID4gICAgIFsxMDAxMS4zNjk0NjJdIHgxIDogMDAwMDAw
MDAwMDAwMDAwMCB4MCA6IGZmZmZmZmUwMDAzMjg5MjgNCj4gPiAgICAgWzEwMDExLjM3MTY5NF0g
Q2FsbCB0cmFjZToNCj4gPiAgICAgWzEwMDExLjM3MzUxMF0gIHJlbWFwX3Bmbl9yYW5nZSsweDFh
NC8weDI2MA0KPiA+ICAgICBbMTAwMTEuMzc1Mzg2XSAgdmZpb19wY2lfbW1hcF9mYXVsdCsweDlj
LzB4MTE0DQo+ID4gICAgIFsxMDAxMS4zNzczNDZdICBfX2RvX2ZhdWx0KzB4MzgvMHgxMDANCj4g
PiAgICAgWzEwMDExLjM3OTI1M10gIF9faGFuZGxlX21tX2ZhdWx0KzB4ODFjLzB4Y2U0DQo+ID4g
ICAgIFsxMDAxMS4zODEyNDddICBoYW5kbGVfbW1fZmF1bHQrMHhiNC8weDE3Yw0KPiA+ICAgICBb
MTAwMTEuMzgzMjIwXSAgZG9fcGFnZV9mYXVsdCsweDExMC8weDQzMA0KPiA+ICAgICBbMTAwMTEu
Mzg1MTg4XSAgZG9fdHJhbnNsYXRpb25fZmF1bHQrMHg4MC8weDkwDQo+ID4gICAgIFsxMDAxMS4z
ODcwNjldICBkb19tZW1fYWJvcnQrMHgzYy8weGEwDQo+ID4gICAgIFsxMDAxMS4zODg4NTJdICBl
bDBfZGErMHgyMC8weDI0DQo+ID4gICAgIFsxMDAxMS4zOTEyMzldIENvZGU6IGViMWEwMmZmIDU0
MDAwMDgwIGY5NDAwMzYyIGI0ZmZmZTQyIChkNDIxMDAwMCkNCj4gPiAgICAgWzEwMDExLjM5MzMw
Nl0gLS0tWyBlbmQgdHJhY2UgYWU4Yjc1YjMyNDI2ZDUzYyBdLS0tDQo+ID4gICAgIFsxMDAxMS4z
OTUxNDBdIG5vdGU6IG9kcF9sMmZ3ZFsxMTQ3XSBleGl0ZWQgd2l0aCBwcmVlbXB0X2NvdW50IDIN
Cj4gPg0KPiA+IFRoaXMgaXMgb2JzZXJ2ZWQgYWZ0ZXIgcGF0Y2ggInZmaW8tcGNpOiBGYXVsdCBt
bWFwcyB0byBlbmFibGUgdm1hIHRyYWNraW5nIg0KPiB3aGVyZSBhY3R1YWwgbWFwcGluZyBkZWxh
eWVkIG9uIHBhZ2UgZmF1bHQuDQo+ID4gV2hlbiBhZGRyZXNzIG9mIHNhbWUgcGFnZSBhY2Nlc3Nl
ZCBieSBtdWx0aXBsZSB0aHJlYWRzIGF0L2Fyb3VuZCBzYW1lIHRpbWUNCj4gYnkgdGhyZWFkcyBy
dW5uaW5nIG9uIGRpZmZlcmVudCBjb3JlcyBjYXVzZXMgcGFnZSBmYXVsdCBmb3Igc2FtZSBwYWdl
IG9uIG11bHRpcGxlDQo+IGNvcmVzIGF0IHNhbWUgdGltZS4gT25lIG9mIHRoZSBmYXVsdCBoYW5k
ZXIgY3JlYXRlcyBtYXBwaW5nIHdoaWxlIHNlY29uZCBoYW5kZXINCj4gZmluZCB0aGF0IHBhZ2Ut
dGFibGUgbWFwcGluZyBhbHJlYWR5IGV4aXN0cyBhbmQgbGVhZHMgdG8gYWJvdmUga2VybmVsIEJV
R19PTigpLg0KPiANCj4gWWVhaCwgdGhhdCdzIHdoYXQgbXkgZml4IGFkZHJlc3NlZCBhcyB3ZWxs
Lg0KPiANCj4gPg0KPiA+IFdoaWxlIGFydGljbGUgIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBv
aW50LmNvbS92Mi91cmw/dT1odHRwcy0NCj4gM0FfX2x3bi5uZXRfQXJ0aWNsZXNfODI4NTM2XyZk
PUR3SUNhUSZjPW5LaldlYzJiNlIwbU95UGF6N3h0ZlEmcj1QQUFsDQo+IFdzd1BlN2Q4Z0hsR2JD
TG15MlllenlLN08zSHZfdDJoZUdub3VCdyZtPUhkd3ZkcGttckJKb1EwVlpIeHlIUw0KPiBLMFRf
NDNfbXNTeGFLRF9EbExvR1dNJnM9M0FDZWQtDQo+IF9tTDZoMkRGYkdIbDBFNVN1Y0c1dzRRRURS
b0tlTzdjeHBuS1UmZT0gIHN1Z2dlc3QgdGhhdCB5b3UgaGF2ZQ0KPiBhbHJlYWR5IGZhY2VkIGFu
ZCBmaXhlZCB0aGlzIGlzc3VlDQo+ID4gICAgICAgICAiLSB2ZmlvLXBjaTogcHJvdGVjdCByZW1h
cF9wZm5fcmFuZ2UoKSBmcm9tIHNpbXVsdGFuZW91cyBjYWxscyAoQW5rdXIgIEFyb3JhKQ0KPiBb
T3JhYnVnOiAzMTY2MzYyOF0ge0NWRS0yMDIwLTEyODg4fSB7Q1ZFLTIwMjAtMTI4ODh9Ig0KPiA+
DQo+ID4gQnV0IEkgZG8gbm90IHNlZSBhbnkgcGF0Y2ggc3VibWl0dGVkIG9yIHVuZGVyIHJldmll
dyBpbiB1cHN0cmVhbSwgaG9wZWZ1bGx5IEkgZGlkDQo+IG5vdCBtaXNzZWQgc29tZSBkaXNjdXNz
aW9uLiBQbGVhc2UgbGV0IHVzIGtub3cgaW4gY2FzZSB5b3UgYWxyZWFkeSBzdWJtaXR0ZWQgb3IN
Cj4gcGxhbm5pbmcgdG8gc3VibWl0IGZpeCBvciBzb21lb25lIGVsc2UgZml4ZWQgc2FtZS4NCj4g
DQo+IE5vIHlvdSBoYXZlbid0IG1pc3NlZCBhIGRpc2N1c3Npb24gb24gdGhpcy4gRm9yIHVwc3Ry
ZWFtIHRoaXMgd2FzIG1vcmUgb2YgYQ0KPiB0aGVvcmV0aWNhbCByYWNlIHNvIEkgZGFsbGllZCBh
IGJpdCBiZWZvcmUgc2VuZGluZyB0aGUgcGF0Y2ggdXBzdHJlYW0uDQo+IA0KPiBJJ2xsIHN1Ym1p
dCBhIHBhdGNoIHNvb24uIEFsc28sIHdvdWxkIHlvdSBtaW5kIGlmIEkgYXNrIHlvdSB0byBydW4g
dGhpcyBmYWlsaW5nIHRlc3QNCj4gYmVmb3JlIHN1Ym1pc3Npb24/DQoNClN1cmUgd2Ugd2lsbCBy
ZXZpZXcgYW5kIHRlc3QuDQoNClRoYW5rcw0KLUJoYXJhdA0KDQo+IA0KPiBUaGFua3MNCj4gQW5r
dXINCj4gDQo+ID4NCj4gPiBUaGFua3MNCj4gPiAtQmhhcmF0DQo+ID4NCg==
