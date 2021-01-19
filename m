Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42E02FB498
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbhASIxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:53:07 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:24126 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726023AbhASIwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:52:36 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10J8oWjg030129;
        Tue, 19 Jan 2021 00:51:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=hHgVzox9187E25qK92Z6MZhq9mvKYGNAWNMxrqNfgTk=;
 b=Ap7Zr9enGxptyKlW9ju2OSc6V5oUWhUawvoFq3un2g8pTJ/C+v9bGDpiNX/H3Q9OneRr
 q1Mu/IKe1iwAk9kiom0+Ks8VTd2x/llfORkGzj/qwr9btCXDG4klVHL2oVzFYSiG7CaF
 1fBFlpNRr8Jqg/mcmzKwHzmYsR5B1uAnFpwdqXTphK1fjmghqSIEThJfeWhHul9VFyLi
 ox80HsiYqhXO6DBHDCIAIZOTmpbyV426x6IRGOMZ7SPw9afMtjpQ+ndSMxFVjdfo8D9n
 BhsQEgWNdfCqArxyksL6QyB3R3OtnWoK0hM4VgbtCR5cvDMkFp0IAizZH51huHhAy2aa Cg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 363xcue23w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Jan 2021 00:51:52 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 Jan
 2021 00:51:50 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 Jan
 2021 00:51:50 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 19 Jan 2021 00:51:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lY349I+CZot/eGTsytDVxnwHudQwm+HuyWOMEvC0yGo4VJlwnnQuZsA9DVGLw58a+ZT0C6Fw7DyvIbawP350+5/QQmLDoxZTWsCYVCVV/0zjP8CryOKOZgSVwOOWYoEnCMretfR6ZJhaLy10+VEtNzSoZzmmxx8HPSxrpKigRyk9pyfgcRqBHIN9xNyi6gShSThQ60xNVGX1w69rknr105IcPCx02jaBlwyvyAmbxmI+Eh7d0jLnxv2jjg5t9uNbcpJPU/ySfyKa3LWO5t9h0mQkMG/IiDKRPOkLGJxNoz6Q/BUESpVDyMDJgRHgwtyYmmcpe+QkAVVhbx2hydsPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHgVzox9187E25qK92Z6MZhq9mvKYGNAWNMxrqNfgTk=;
 b=YfZnuwJeyGq/ZhP2+tBs8C0HijDkpVBCdiy84vyH5MzMxjU7vLhJ4KlKWkHT7v6XoQ8vUkUZLBJdh1NOzHb8EFdNUqeVEktcs7cFqSi0XgC2xC9Ff1SM55op3LWwh3yBbDDpEzle+kRoyi8Ln+1KxwGS4VZ7DCCB34wlj1ynm3NKaB7VLwRGnZ5cjjG0gWmY9GkbukMR71ypKGmmDyVIkaN1OYDOB5qD1OPNLXH6bMR3L8ebZ8pacy5m/GO4yk0A7fUPNXLmzHM99N+e8TAt9pXDH/NeYKdDaYjBPNZJg15RsFWsql8Bely5v5w1/38p5IS2PSZexib4rcAKfOOxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHgVzox9187E25qK92Z6MZhq9mvKYGNAWNMxrqNfgTk=;
 b=dqb0zeTcTQ0Uo4ZjUvHgzAb495ukcM/f9qXUWke43ufQGU0eIFED49SWRxYhud7N+PIqRxK5lx74bw7V9X/0In+u0PKXvyrgFhvQALA7We+evBKeo5SCvGaCYdXknsEF6kec+apLvGbp0mpa5+2gkQO5isI04cHLUvdmQxdsLyI=
Received: from MWHPR18MB1520.namprd18.prod.outlook.com (2603:10b6:300:cf::10)
 by CO6PR18MB3954.namprd18.prod.outlook.com (2603:10b6:5:34d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 08:51:48 +0000
Received: from MWHPR18MB1520.namprd18.prod.outlook.com
 ([fe80::15a1:3a30:1fcf:20eb]) by MWHPR18MB1520.namprd18.prod.outlook.com
 ([fe80::15a1:3a30:1fcf:20eb%2]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 08:51:48 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sunil Kovvuri Goutham" <sgoutham@marvell.com>
Subject: RE: [EXT] Re: vfio-pci: protect remap_pfn_range() from simultaneous
 calls
Thread-Topic: [EXT] Re: vfio-pci: protect remap_pfn_range() from simultaneous
 calls
Thread-Index: AdbkRnC96D9dwqxzR0eR3ijlJSqy4gAEULUAAnocGfA=
Date:   Tue, 19 Jan 2021 08:51:48 +0000
Message-ID: <MWHPR18MB1520D43B19368D8D84360248E3A31@MWHPR18MB1520.namprd18.prod.outlook.com>
References: <MWHPR18MB152034C6BAE8CC6D503DDEBEE3D09@MWHPR18MB1520.namprd18.prod.outlook.com>
 <f33979f5-0e89-4fa2-c48e-06d353379f23@oracle.com>
In-Reply-To: <f33979f5-0e89-4fa2-c48e-06d353379f23@oracle.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [122.179.17.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a494c08-ac5a-4ac5-d52b-08d8bc5774fc
x-ms-traffictypediagnostic: CO6PR18MB3954:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR18MB3954364A175C0ABE797A69ECE3A31@CO6PR18MB3954.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wKiq/fYowUbzja9QA83KCjIR5wKU8Zga+/WSwunHSDJOpZUH0CBGhuxl9hOhqd8IMFIBx/+s3Y82YDW/3bhCi9J20cUci71RKIvHEB1a6pUdL6J2FdNv5UaD/Qu2ydz6hmBOyQUFN1jLf4VL3nkMd4dR0pJaGicCS8GrUeZMXfEbp9s6kmRMJ1CB9RmoOKxekv5JnfQzT140jcDq/tF4L4TMaICKExcSxmncIUgjvlfS2+GFOYhxUTgTVI/gfUf3KhAi/qU9L3UZwWJzc2iT3ieBHZ1EONbLp+9VtQVZ2/89ZPSW/Lz1/bbSMae2UNbsnJ85dY8dYVYsu9HTtCSwJabzATBraPjB04sNLZqNutm1OUsFrctjbgQKJZJwqB0T4KIZbApJtnCVlfTapaDdJ9oPNshpUoQKw0n/tlt73wXhVvlywKc7gTuFq/jzEDv8YrwhKM6GXizKRvfaPrWCUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR18MB1520.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(54906003)(86362001)(186003)(76116006)(19627235002)(5660300002)(110136005)(9686003)(2906002)(66446008)(55016002)(33656002)(6506007)(8936002)(83380400001)(478600001)(66476007)(26005)(316002)(53546011)(7696005)(52536014)(66946007)(8676002)(4326008)(966005)(71200400001)(64756008)(66556008)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MXJSYkRxelVqRm5hTUVrNXdSNXZrQkNOcmNZRVFydTFVUWVXanV4Y1R1TWhR?=
 =?utf-8?B?RXlVdWxMeGNjQkhJYWxhRmJRVzlVc3V6Sk94LzJGbjJ6N3BTOXBkMUI2TWgx?=
 =?utf-8?B?NzlXWUxHQmpHanpwZ0MxTCs3YVNrdkxCQW96WjRHRlN1WENDdEpycG5YcU53?=
 =?utf-8?B?Zy85L2JnR2Q3cnBCQzFiems4NEdneUxieEdxS05vbjN2czN5bC9xcEp0WWNF?=
 =?utf-8?B?aXJacjk5TFBERitxTGxiTDlZVmRZbU1YdFpyNXFUbXFDYmZpaXhaTjdZb1Fl?=
 =?utf-8?B?SDAyWk03eXIyNVNPTEdKNk8vT3Z2YjduMTladURwYTV4OXY1OVFweHh5UXEv?=
 =?utf-8?B?S1V3TFlleHhlV3EvTmdFUG1mOXpZRngreGZFZFlnN05tOUcvenI5Rm45SHFh?=
 =?utf-8?B?N0RxUExHUmpnQ0hHMW90RG9lZFlPWE1jMzQvZVlaL3N4NUpGdWFIdGJYUmtC?=
 =?utf-8?B?WDZycnBpSTZxLzFhZ2JsMnBOUE14aWI4NFRNM0M2N0h4enVDNkFMVlJCNmcz?=
 =?utf-8?B?dlVlNVhhM0t3SUEwTXlJQk1UOGlhT2lnV2NHdVlkMUk1Y1cvbTZ0L0QrL3lY?=
 =?utf-8?B?dnhKNzZYU1FDbmZkNjFIR2RnSkhobjNheCtkM2ZTOGhEY3VmbmpsZmQwNm53?=
 =?utf-8?B?aU1zWThKb29McnBHc1RtbStjN091VTF0SXBwOGJWbU4wWDNUdFZ3QlhldHJq?=
 =?utf-8?B?Z2NTMHVVbmpsYTltbk1SK3dpVHZsNUlZYjVYaGJ3VlUyU1I5emtyWFY5V0cy?=
 =?utf-8?B?enVucXVsbzZ4WEhZLzZQdE55WHlaeDEwWHRGZWh2bHRtZSt6dnV5VG5scElP?=
 =?utf-8?B?dzc2Z1hsUEp1MXltK3NuN2R2VkRNVjNaKzBQU0cyRC9CTzYxZEFJMVRrMmM5?=
 =?utf-8?B?SjAzNmxTbHlZaU5rdDRRVFVMVjlCYTN5MWdMTnV5SHlaUGFvajRDWE9VUytt?=
 =?utf-8?B?VENZMk9hK0kwOGRpUTY0VnJPRGgyVm83Zkd4K1hHZEQ5RUFaRWg4cXJrZkxC?=
 =?utf-8?B?K0NaSjRTOVlmV3RDTC9oNENBeE5wVjNRamJib1NpV2N3eXZPK1VhKzNVVk12?=
 =?utf-8?B?a2JNQWxPRGl1cnBCUHh5QWNuQlZOL0lyTThEVHpYYVdSbXIwcFVkMVpGWVVv?=
 =?utf-8?B?TnhydGRHRGlqejlHcWVLRDlRUjZLSWpDQlhldFZCaGliYmd3MTdZN3dBMXRt?=
 =?utf-8?B?UmlOOHhWNDN6c3J4dUxzTHJQWWZQR1AyVnM5UFc1M2RaRFBhMStzT1phZE1U?=
 =?utf-8?B?R21NQ2NVcmVKa1I3amEreStCT0UvK1RUNG1vNnZOaTZUa0lnMTQ2UWswL3Rp?=
 =?utf-8?Q?aiB2gM/0smOKg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR18MB1520.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a494c08-ac5a-4ac5-d52b-08d8bc5774fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 08:51:48.2059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZM/uXJZvgxK4Q/OPQ1mJoxKrJRnWHQDH5ezAQgy559Kju5kG+j952KuDMmQNHSJfca1Y8p83NoEvyvXFpPHSyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3954
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-19_02:2021-01-18,2021-01-19 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5rdXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5rdXIg
QXJvcmEgPGFua3VyLmEuYXJvcmFAb3JhY2xlLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51
YXJ5IDYsIDIwMjEgMTE6NDQgUE0NCj4gVG86IEJoYXJhdCBCaHVzaGFuIDxiYmh1c2hhbjJAbWFy
dmVsbC5jb20+OyBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbQ0KPiBDYzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgU3VuaWwgS292dnVyaSBHb3V0aGFtDQo+IDxzZ291dGhhbUBtYXJ2
ZWxsLmNvbT4NCj4gU3ViamVjdDogW0VYVF0gUmU6IHZmaW8tcGNpOiBwcm90ZWN0IHJlbWFwX3Bm
bl9yYW5nZSgpIGZyb20gc2ltdWx0YW5lb3VzIGNhbGxzDQo+IA0KPiBFeHRlcm5hbCBFbWFpbA0K
PiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBPbiAyMDIxLTAxLTA2IDg6MTcgYS5tLiwgQmhhcmF0IEJo
dXNoYW4gd3JvdGU6DQo+ID4gSGkgQW5rdXIsDQo+ID4NCj4gPiBXZSBhcmUgb2JzZXJ2aW5nIGJl
bG93IEJVR19PTigpIHdpdGggbGF0ZXN0IGtlcm5lbA0KPiA+DQo+ID4gICAgIFsxMDAxMS4zMjE2
NDVdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiA+ICAgICBbMTAwMTEu
MzIyMjYyXSBrZXJuZWwgQlVHIGF0IG1tL21lbW9yeS5jOjE4MTYhDQo+ID4gICAgIFsxMDAxMS4z
MjM3OTNdIEludGVybmFsIGVycm9yOiBPb3BzIC0gQlVHOiAwIFsjMV0gUFJFRU1QVCBTTVANCj4g
PiAgICAgWzEwMDExLjMyNjEwOF0gQ1BVOiAyIFBJRDogMTE0NyBDb21tOiBvZHBfbDJmd2QgTm90
IHRhaW50ZWQgNS40Ljc0LTA1OTM4LQ0KPiBnYjk1OThlNDlmZTYxICMxNQ0KPiA+ICAgICBbMTAw
MTEuMzI4MjcyXSBIYXJkd2FyZSBuYW1lOiBNYXJ2ZWxsIENOMTA2WFggYm9hcmQgKERUKQ0KPiA+
ICAgICBbMTAwMTEuMzMwMzI4XSBwc3RhdGU6IDgwNDAwMDA5IChOemN2IGRhaWYgK1BBTiAtVUFP
KQ0KPiA+ICAgICBbMTAwMTEuMzMyNDAyXSBwYyA6IHJlbWFwX3Bmbl9yYW5nZSsweDFhNC8weDI2
MA0KPiA+ICAgICBbMTAwMTEuMzM0MzgzXSBsciA6IHJlbWFwX3Bmbl9yYW5nZSsweDE0Yy8weDI2
MA0KPiA+ICAgICBbMTAwMTEuMzM1OTExXSBzcCA6IGZmZmY4MDAwMTU2YWZjMTANCj4gPiAgICAg
WzEwMDExLjMzNzM2MF0geDI5OiBmZmZmODAwMDE1NmFmYzEwIHgyODogZmZmZmZmZGZmYTI0MDAw
MA0KPiA+ICAgICBbMTAwMTEuMzM5NjcxXSB4Mjc6IGZmZmYwMDAxNGEyNDEwMDAgeDI2OiAwMDAw
MDAyMTgyMDAwMDAwDQo+ID4gICAgIFsxMDAxMS4zNDE5ODRdIHgyNTogZmZmZjAwMDE0ODlmYmUw
MCB4MjQ6IDAwMDAwMDIxODIwNDAwMDANCj4gPiAgICAgWzEwMDExLjM0NDI3OV0geDIzOiAwMDAw
MDAyMTgyMDQwMDAwIHgyMjogMDA2ODAwMDAwMDAwMGZjMw0KPiA+ICAgICBbMTAwMTEuMzQ2NTM5
XSB4MjE6IDAwMDAwMDIxODIwNDAwMDAgeDIwOiBmZmZmMDAwMTQ5ZDcwODYwDQo+ID4gICAgIFsx
MDAxMS4zNDg4NDZdIHgxOTogMDAwMDAwMDAwMDAwMDA0MSB4MTg6IDAwMDAwMDAwMDAwMDAwMDAN
Cj4gPiAgICAgWzEwMDExLjM1MTA2NF0geDE3OiAwMDAwMDAwMDAwMDAwMDAwIHgxNjogMDAwMDAw
MDAwMDAwMDAwMA0KPiA+ICAgICBbMTAwMTEuMzUzMzA0XSB4MTU6IDAwMDAwMDAwMDAwMDAwMDAg
eDE0OiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gICAgIFsxMDAxMS4zNTU1MTldIHgxMzogMDAwMDAw
MDAwMDAwMDAwMCB4MTI6IDAwMDAwMDAwMDAwMDAwMDANCj4gPiAgICAgWzEwMDExLjM1NzgxMl0g
eDExOiAwMDAwMDAwMDAwMDAwMDAwIHgxMDogZmZmZmZmZGZmZmUwMDAwMA0KPiA+ICAgICBbMTAw
MTEuMzYwMTM2XSB4OSA6IDAwMDAwMDAwMDAwMDAwMDAgeDggOiAwMDAwMDAwMDAwMDAwMDAwDQo+
ID4gICAgIFsxMDAxMS4zNjI0MTRdIHg3IDogMDAwMDAwMDAwMDAwMDAwMCB4NiA6IDAwMDAwNDIx
ODIwMDAwMDANCj4gPiAgICAgWzEwMDExLjM2NDc3M10geDUgOiAwMDAxMDAwMDAwMDAwMDAwIHg0
IDogMDAwMDAwMDAwMDAwMDAwMA0KPiA+ICAgICBbMTAwMTEuMzY3MTAzXSB4MyA6IGZmZmZmZmUw
MDAzMjg5MjggeDIgOiAwMTY4MDAwMTdjMjQwZmMzDQo+ID4gICAgIFsxMDAxMS4zNjk0NjJdIHgx
IDogMDAwMDAwMDAwMDAwMDAwMCB4MCA6IGZmZmZmZmUwMDAzMjg5MjgNCj4gPiAgICAgWzEwMDEx
LjM3MTY5NF0gQ2FsbCB0cmFjZToNCj4gPiAgICAgWzEwMDExLjM3MzUxMF0gIHJlbWFwX3Bmbl9y
YW5nZSsweDFhNC8weDI2MA0KPiA+ICAgICBbMTAwMTEuMzc1Mzg2XSAgdmZpb19wY2lfbW1hcF9m
YXVsdCsweDljLzB4MTE0DQo+ID4gICAgIFsxMDAxMS4zNzczNDZdICBfX2RvX2ZhdWx0KzB4Mzgv
MHgxMDANCj4gPiAgICAgWzEwMDExLjM3OTI1M10gIF9faGFuZGxlX21tX2ZhdWx0KzB4ODFjLzB4
Y2U0DQo+ID4gICAgIFsxMDAxMS4zODEyNDddICBoYW5kbGVfbW1fZmF1bHQrMHhiNC8weDE3Yw0K
PiA+ICAgICBbMTAwMTEuMzgzMjIwXSAgZG9fcGFnZV9mYXVsdCsweDExMC8weDQzMA0KPiA+ICAg
ICBbMTAwMTEuMzg1MTg4XSAgZG9fdHJhbnNsYXRpb25fZmF1bHQrMHg4MC8weDkwDQo+ID4gICAg
IFsxMDAxMS4zODcwNjldICBkb19tZW1fYWJvcnQrMHgzYy8weGEwDQo+ID4gICAgIFsxMDAxMS4z
ODg4NTJdICBlbDBfZGErMHgyMC8weDI0DQo+ID4gICAgIFsxMDAxMS4zOTEyMzldIENvZGU6IGVi
MWEwMmZmIDU0MDAwMDgwIGY5NDAwMzYyIGI0ZmZmZTQyIChkNDIxMDAwMCkNCj4gPiAgICAgWzEw
MDExLjM5MzMwNl0gLS0tWyBlbmQgdHJhY2UgYWU4Yjc1YjMyNDI2ZDUzYyBdLS0tDQo+ID4gICAg
IFsxMDAxMS4zOTUxNDBdIG5vdGU6IG9kcF9sMmZ3ZFsxMTQ3XSBleGl0ZWQgd2l0aCBwcmVlbXB0
X2NvdW50IDINCj4gPg0KPiA+IFRoaXMgaXMgb2JzZXJ2ZWQgYWZ0ZXIgcGF0Y2ggInZmaW8tcGNp
OiBGYXVsdCBtbWFwcyB0byBlbmFibGUgdm1hIHRyYWNraW5nIg0KPiB3aGVyZSBhY3R1YWwgbWFw
cGluZyBkZWxheWVkIG9uIHBhZ2UgZmF1bHQuDQo+ID4gV2hlbiBhZGRyZXNzIG9mIHNhbWUgcGFn
ZSBhY2Nlc3NlZCBieSBtdWx0aXBsZSB0aHJlYWRzIGF0L2Fyb3VuZCBzYW1lIHRpbWUNCj4gYnkg
dGhyZWFkcyBydW5uaW5nIG9uIGRpZmZlcmVudCBjb3JlcyBjYXVzZXMgcGFnZSBmYXVsdCBmb3Ig
c2FtZSBwYWdlIG9uIG11bHRpcGxlDQo+IGNvcmVzIGF0IHNhbWUgdGltZS4gT25lIG9mIHRoZSBm
YXVsdCBoYW5kZXIgY3JlYXRlcyBtYXBwaW5nIHdoaWxlIHNlY29uZCBoYW5kZXINCj4gZmluZCB0
aGF0IHBhZ2UtdGFibGUgbWFwcGluZyBhbHJlYWR5IGV4aXN0cyBhbmQgbGVhZHMgdG8gYWJvdmUg
a2VybmVsIEJVR19PTigpLg0KPiANCj4gWWVhaCwgdGhhdCdzIHdoYXQgbXkgZml4IGFkZHJlc3Nl
ZCBhcyB3ZWxsLg0KPiANCj4gPg0KPiA+IFdoaWxlIGFydGljbGUgIGh0dHBzOi8vdXJsZGVmZW5z
ZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0NCj4gM0FfX2x3bi5uZXRfQXJ0aWNsZXNf
ODI4NTM2XyZkPUR3SUNhUSZjPW5LaldlYzJiNlIwbU95UGF6N3h0ZlEmcj1QQUFsDQo+IFdzd1Bl
N2Q4Z0hsR2JDTG15MlllenlLN08zSHZfdDJoZUdub3VCdyZtPUhkd3ZkcGttckJKb1EwVlpIeHlI
Uw0KPiBLMFRfNDNfbXNTeGFLRF9EbExvR1dNJnM9M0FDZWQtDQo+IF9tTDZoMkRGYkdIbDBFNVN1
Y0c1dzRRRURSb0tlTzdjeHBuS1UmZT0gIHN1Z2dlc3QgdGhhdCB5b3UgaGF2ZQ0KPiBhbHJlYWR5
IGZhY2VkIGFuZCBmaXhlZCB0aGlzIGlzc3VlDQo+ID4gICAgICAgICAiLSB2ZmlvLXBjaTogcHJv
dGVjdCByZW1hcF9wZm5fcmFuZ2UoKSBmcm9tIHNpbXVsdGFuZW91cyBjYWxscyAoQW5rdXIgIEFy
b3JhKQ0KPiBbT3JhYnVnOiAzMTY2MzYyOF0ge0NWRS0yMDIwLTEyODg4fSB7Q1ZFLTIwMjAtMTI4
ODh9Ig0KPiA+DQo+ID4gQnV0IEkgZG8gbm90IHNlZSBhbnkgcGF0Y2ggc3VibWl0dGVkIG9yIHVu
ZGVyIHJldmlldyBpbiB1cHN0cmVhbSwgaG9wZWZ1bGx5IEkgZGlkDQo+IG5vdCBtaXNzZWQgc29t
ZSBkaXNjdXNzaW9uLiBQbGVhc2UgbGV0IHVzIGtub3cgaW4gY2FzZSB5b3UgYWxyZWFkeSBzdWJt
aXR0ZWQgb3INCj4gcGxhbm5pbmcgdG8gc3VibWl0IGZpeCBvciBzb21lb25lIGVsc2UgZml4ZWQg
c2FtZS4NCj4gDQo+IE5vIHlvdSBoYXZlbid0IG1pc3NlZCBhIGRpc2N1c3Npb24gb24gdGhpcy4g
Rm9yIHVwc3RyZWFtIHRoaXMgd2FzIG1vcmUgb2YgYQ0KPiB0aGVvcmV0aWNhbCByYWNlIHNvIEkg
ZGFsbGllZCBhIGJpdCBiZWZvcmUgc2VuZGluZyB0aGUgcGF0Y2ggdXBzdHJlYW0uDQo+IA0KPiBJ
J2xsIHN1Ym1pdCBhIHBhdGNoIHNvb24uIEFsc28sIHdvdWxkIHlvdSBtaW5kIGlmIEkgYXNrIHlv
dSB0byBydW4gdGhpcyBmYWlsaW5nIHRlc3QNCj4gYmVmb3JlIHN1Ym1pc3Npb24/DQoNCkNoZWNr
aW5nIGluIGNhc2UgZml4IHNlbnQgZm9yIHJldmlldywgZGlkIEkgbWlzc2VkIHNvbWV0aGluZz8N
Cg0KVGhhbmtzDQotQmhhcmF0DQoNCj4gDQo+IFRoYW5rcw0KPiBBbmt1cg0KPiANCj4gPg0KPiA+
IFRoYW5rcw0KPiA+IC1CaGFyYXQNCj4gPg0K
